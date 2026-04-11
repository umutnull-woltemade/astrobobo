/**
 * Tone-pack bootstrap. Imported once from ProShell so each Pro page
 * automatically has the full multi-locale copy registry ready on mount.
 */

import { registerLocalePack } from "../copy-registry";
import { trTonePack } from "./tr";

let installed = false;

export function installTonePacks() {
  if (installed) return;
  installed = true;
  registerLocalePack("tr", trTonePack);
}
