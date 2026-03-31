"use client";

interface LanguageSwitcherProps {
  isEn: boolean;
  small?: boolean;
}

export default function LanguageSwitcher({ isEn, small }: LanguageSwitcherProps) {
  const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    e.preventDefault();
    const path = window.location.pathname;

    let newPath: string;
    if (isEn) {
      // EN -> TR: prepend /tr to current path
      newPath = `/tr${path}`;
    } else {
      // TR -> EN: remove /tr prefix
      newPath = path.replace(/^\/tr(\/|$)/, "/");
    }

    window.location.href = newPath;
  };

  return (
    <a
      href={isEn ? "/tr" : "/"}
      onClick={handleClick}
      className={`text-cosmic-muted hover:text-cosmic-accent transition-colors border border-cosmic-border rounded-md px-2 py-1 ${
        small ? "text-xs" : "text-sm"
      }`}
    >
      {isEn ? "TR" : "EN"}
    </a>
  );
}
