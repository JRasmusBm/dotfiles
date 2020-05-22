let test#python#project_root = "./tests"
let test#strategy = "vtr"

let test#go#gotest#options = "-cover"
let g:test#runner_commands = ['ReactScripts']
let test#javascript#runner = 'reactscripts'
let test#enabled_runners = [
      \"python#pytest", 
      \"javascript#reactscripts",
      \"javascript#jest",
      \]
let test#javascript#reactscripts#options = "--coverage --watchAll=false"
let test#javascript#jest#options = "--runInBand"
nmap <silent> <localleader>dn :TestNearest<CR>
nmap <silent> <localleader>df :TestFile<CR>
nmap <silent> <localleader>ds :TestSuite<CR>
nmap <silent> <localleader>dp :TestLast<CR>
nmap <silent> <localleader>dv :TestVisit<CR>
