import { test } from 'node:test';
import assert from 'node:assert/strict';
import { selecionarDetalhe, paginaDeReferencia } from '../fixtures/referencia-local.mjs';
const rows = [{ id: '1', titulo: 'Primeiro' }, { id: '2', titulo: 'Segundo' }];
test('cada seleção encontra seu registro, inclusive depois do primeiro', () => {
  assert.equal(selecionarDetalhe(rows, '2').id, '2');
  assert.equal(selecionarDetalhe(rows, '1').id, '1');
});
test('a variante Red reproduz um defeito de comportamento, não de configuração', () => {
  assert.notEqual(selecionarDetalhe(rows, '2', 'red').id, '2');
});
test('texto de fixture é escapado na página local', () => {
  const page = paginaDeReferencia([{ id: '1', titulo: '<img src=x onerror=alert(1)>' }]);
  assert.ok(!page.includes('<img src=x'));
  assert.ok(page.includes('&lt;img'));
});
