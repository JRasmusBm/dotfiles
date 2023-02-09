local M = {}

require "hs.ipc"

hs.ipc.cliUninstall()
hs.ipc.cliInstall()

return M
