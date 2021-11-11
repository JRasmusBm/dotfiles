vim.cmd [[
packadd! vim-signature
]]

vim.g.SignatureMarkTextHL = "Function"
vim.g.SignatureMap = {
  Leader = "m",
  ToggleMarkAtLine = "m,",
  PurgeMarks = "m<Space>",
  GotoNextLineAlpha = "[<Left>",
  GotoPrevLineAlpha = "]<Left>",
  GotoNextSpotAlpha = "[<Right>",
  GotoPrevSpotAlpha = "]<Right>",
  ListBufferMarks = "ml",
  PlaceNextMark = "",
  PurgeMarksAtLine = "",
  DeleteMark = "",
  PurgeMarkers = "",
  GotoNextLineByPos = "",
  GotoPrevLineByPos = "",
  GotoNextSpotByPos = "",
  GotoPrevSpotByPos = "",
  GotoNextMarker = "",
  GotoPrevMarker = "",
  GotoNextMarkerAny = "",
  GotoPrevMarkerAny = "",
  ListBufferMarkers = "",
}
