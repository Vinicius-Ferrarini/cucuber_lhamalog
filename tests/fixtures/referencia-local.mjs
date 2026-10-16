const escape = value => String(value).replace(/[&<>"']/g, char => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char]));
export function selecionarDetalhe(registros, id, fase = 'green') {
  // Defeito deliberado somente na demonstração Red: sempre seleciona o primeiro item.
  return fase === 'red' ? registros[0] : registros.find(item => item.id === id);
}
export function paginaDeReferencia(registros, fase = 'green') {
  const actions = Object.fromEntries(registros.map(item => [item.id, selecionarDetalhe(registros, item.id, fase)]));
  const serialized = JSON.stringify(actions).replace(/</g, '\\u003c');
  return `<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Demonstração local de teste</title>
  <h1>Ocorrências fictícias</h1><p>Esta página é uma fixture de teste, não é o LhamaLog.</p>
  <ul>${registros.map(item => `<li><button data-id="${escape(item.id)}">${escape(item.titulo)}</button></li>`).join('')}</ul>
  <section aria-label="Detalhe da Ocorrência" hidden><h2></h2><p data-testid="identificador"></p></section>
  <script>const actions = ${serialized};
  document.querySelectorAll('button[data-id]').forEach(button => button.addEventListener('click', () => {
    const item = actions[button.dataset.id]; const panel = document.querySelector('section');
    panel.hidden = false; panel.querySelector('h2').textContent = item.titulo;
    panel.querySelector('[data-testid="identificador"]').textContent = item.id;
  }));</script></html>`;
}
