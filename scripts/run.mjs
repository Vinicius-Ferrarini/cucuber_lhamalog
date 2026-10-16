import { spawnSync } from 'node:child_process';
import { mkdirSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
const requested = process.argv[2] || 'exemplo';
const profiles = new Set(['exemplo', 'exemplo-red', 'planos', 'inventario', 'front', 'integracao', 'api']);
if (!profiles.has(requested)) throw new Error('Perfil desconhecido');
mkdirSync('reports', { recursive: true });
const cli = fileURLToPath(new URL('../node_modules/@cucumber/cucumber/bin/cucumber.js', import.meta.url));
const env = { ...process.env };
if (requested === 'exemplo-red') env.DEMO_PHASE = 'red';
else if (requested === 'exemplo') env.DEMO_PHASE = 'green';
// Red tem perfil próprio: não sobrescreve a evidência Green.
const result = spawnSync(process.execPath, [cli, '--profile', requested, ...process.argv.slice(3)], { stdio: 'inherit', env });
if (result.error) throw result.error;
process.exit(result.status ?? 1);
