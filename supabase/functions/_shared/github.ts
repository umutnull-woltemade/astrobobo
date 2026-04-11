// GitHub Contents API — commit a single file to main
// Requires env: GITHUB_TOKEN, GITHUB_REPO (e.g. "umutnull/astrobobo"), GITHUB_BRANCH (default "main")

const GH = 'https://api.github.com';

interface CommitFileArgs {
  path: string;        // "content/tr/ruyada-yilan.md"
  content: string;     // raw file body
  message: string;     // commit message
  branch?: string;
  author?: { name: string; email: string };
}

interface CommitResult {
  sha: string;
  commit_url: string;
  html_url: string;
}

export async function commitFile(args: CommitFileArgs): Promise<CommitResult> {
  const token = Deno.env.get('GITHUB_TOKEN');
  const repo  = Deno.env.get('GITHUB_REPO');
  const branch = args.branch || Deno.env.get('GITHUB_BRANCH') || 'main';
  if (!token || !repo) throw new Error('GITHUB_TOKEN and GITHUB_REPO required');

  // 1. check if file exists to get sha (needed for update)
  const getUrl = `${GH}/repos/${repo}/contents/${encodeURIComponent(args.path)}?ref=${branch}`;
  const existing = await fetch(getUrl, {
    headers: {
      Authorization: `Bearer ${token}`,
      Accept: 'application/vnd.github+json',
      'User-Agent': 'astrobobo-seo-bot',
    },
  });

  let existingSha: string | undefined;
  if (existing.status === 200) {
    const data = await existing.json();
    existingSha = data.sha;
  } else if (existing.status !== 404) {
    const body = await existing.text();
    throw new Error(`GitHub GET ${existing.status}: ${body}`);
  }

  // 2. PUT contents
  const putUrl = `${GH}/repos/${repo}/contents/${encodeURIComponent(args.path)}`;
  const body = {
    message: args.message,
    content: btoa(unescape(encodeURIComponent(args.content))),
    branch,
    sha: existingSha,
    committer: args.author || {
      name: 'astrobobo-seo-bot',
      email: 'seo-bot@astrobobo.com',
    },
  };

  const res = await fetch(putUrl, {
    method: 'PUT',
    headers: {
      Authorization: `Bearer ${token}`,
      Accept: 'application/vnd.github+json',
      'Content-Type': 'application/json',
      'User-Agent': 'astrobobo-seo-bot',
    },
    body: JSON.stringify(body),
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`GitHub PUT ${res.status}: ${text}`);
  }

  const data = await res.json();
  return {
    sha: data.commit.sha,
    commit_url: data.commit.url,
    html_url: data.commit.html_url,
  };
}

export async function commitFiles(files: CommitFileArgs[], batchMessage: string): Promise<CommitResult[]> {
  // Simple sequential commits (Contents API = one file per commit).
  // For true atomic multi-file commits use git Trees API — overkill for Phase 1.
  const results: CommitResult[] = [];
  for (const f of files) {
    results.push(await commitFile({ ...f, message: f.message || batchMessage }));
  }
  return results;
}
