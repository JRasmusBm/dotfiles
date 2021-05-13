" ServiceWorker {{{
" File {{{
inoremap <buffer> <leader>sf "use strict";
      \const version = <++>;
      \self.addEventListener("install", onInstall);
      \self.addEventListener("activate", onActivate);
      \main().catch(console.error);
      \/* ***************************** */
      \async function main() {
      \console.log(`Service Worker (${version}) starting...`);
      \}
      \async function onInstall(event) {
      \console.log(`Service Worker (${version}) installed...`);
      \self.skipWaiting();
      \}
      \function onActivate(event) {
      \event.waitUntil(handleActivation());
      \}
      \async function handleActivation() {
      \await clients.claim();
      \console.log(`Service Worker (${version}) activated...`);
      \}:call bushels#backward_marker(1)
" }}}
" }}}
