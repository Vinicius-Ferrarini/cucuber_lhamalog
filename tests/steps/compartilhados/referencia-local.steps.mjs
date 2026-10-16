import { Given, When, Then } from '@cucumber/cucumber';
import { chromium } from 'playwright';
import { readFileSync } from 'node:fs';
import assert from 'node:assert/strict';
import { paginaDeReferencia } from '../../fixtures/referencia-local.mjs';
Given('que a página local de referência mostra duas Ocorrências fictícias', async function () {
  const registros = JSON.parse(readFileSync(new URL('../../fixtures/ocorrencias.json', import.meta.url), 'utf8'));
  const channel = process.env.BROWSER_CHANNEL || undefined;
  this.browser = await chromium.launch({ headless: process.env.HEADLESS !== 'false', ...(channel ? { channel } : {}) });
  this.context = await this.browser.newContext({ locale: 'pt-BR' });
  this.page = await this.context.newPage();
  await this.page.setContent(paginaDeReferencia(registros, process.env.DEMO_PHASE || 'green'));
});
When('seleciono na demonstração a Ocorrência {string}', async function (id) {
  // Identificador vem da fixture local, não é um seletor presumido da aplicação real.
  await this.page.locator(`button[data-id="${id}"]`).click();
});
Then('o detalhe local deve identificar {string} e {string}', async function (id, titulo) {
  const panel = this.page.getByRole('region', { name: 'Detalhe da Ocorrência' });
  await panel.waitFor({ state: 'visible' });
  assert.equal(await panel.getByTestId('identificador').textContent(), id);
  assert.equal(await panel.getByRole('heading', { level: 2 }).textContent(), titulo);
});
