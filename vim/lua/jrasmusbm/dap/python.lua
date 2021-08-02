local M = {}

local utils = require("jrasmusbm.utils")

local function end_debugging()
    if vim.g.debug_job_id then vim.fn.jobstop(vim.g.debug_job_id) end
end

M.docker_attach_python_debugger = function(args)
    local host = args[1]
    local port = tonumber(args[2])

    local config = {
        type = "python",
        request = "attach",
        connect = {host = host, port = port},
        mode = "remote",
        name = "Remote Attached Debugger",
        cwd = vim.fn.getcwd(),
        pathMappings = {
            {
                localRoot = vim.fn.getcwd(), -- Wherever your Python code lives locally.
                remoteRoot = "/usr/src/app" -- Wherever your Python code lives in the container.
            }
        }
    }

    -- Attach to the connector
    local session = require('dap').attach(host, port, config)
    if session == nil then
        end_debugging()
        utils.echo_error('Error connecting to the debugger.')
    else
        utils.echo_success('Debugging on ' .. host .. ':' .. port ..
                               ' with Job ID ' .. vim.g.debug_job_id .. '.')
    end

    return true
end

M.debug_python_test = function(host, port)
    local debug_host = host or '0.0.0.0'
    local debug_port = port or 5678

    utils.echo_info('Waiting for debugger to attach...')

    if not vim.g.debug_job_id then
        -- Get the name of the test which will trigger the debugging
        local test_method = fn['test#python#pytest#build_position']('nearest', {
            file = fn['expand']('%'),
            line = fn['line']('.'),
            col = fn['col']('.')
        })

        -- Pass the test name to pytest via debugpy
        local pytest_cmd =
            'docker-compose -f "./docker-compose.yml" exec -T -w /usr/src/app debug python -m debugpy --listen ' ..
                debug_host .. ':' .. debug_port ..
                ' --wait-for-client -m pytest ' .. test_method[1]

        -- Start the job and use the on_event callback to capture output
        vim.g.debug_job_id = fn.jobstart(pytest_cmd, {
            on_stderr = on_event,
            on_stdout = on_event,
            on_exit = on_event,
            stdout_buffered = true,
            stderr_buffered = true
        })
        -- As we're using a Docker container, it's neccessary to wait for the
        -- cmd to be initiated before we attach the debugger
        utils.wait(2)
        load_python_debugger(debug_host, debug_port)
    else
        load_python_debugger(debug_host, debug_port)
    end
end

return M
