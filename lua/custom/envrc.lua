-- Pure Lua .envrc parser and runner
-- Cross-platform helper for reading .envrc files and running applications

local M = {}

--- Parse a .envrc file and return a table of environment variables
---@param path string|nil Path to .envrc file (defaults to cwd/.envrc)
---@return table<string, string> env Environment variables
---@return string|nil error Error message if file not found
function M.parse(path)
  local cwd = vim.fn.getcwd()
  path = path or (cwd .. "/.envrc")

  if vim.fn.filereadable(path) == 0 then
    return {}, "No .envrc file found at: " .. path
  end

  local env = {}
  local lines = vim.fn.readfile(path)

  for _, line in ipairs(lines) do
    -- Match: export VAR=value or VAR=value (VAR can contain underscores)
    local var, value = line:match("^%s*export%s+([%w_]+)%s*=%s*(.+)$")
    if not var then
      var, value = line:match("^%s*([%w_]+)%s*=%s*(.+)$")
    end

    if var and value then
      -- Remove surrounding quotes and trim whitespace
      value = value:gsub("^%s+", ""):gsub("%s+$", "")
      value = value:gsub("^['\"]", ""):gsub("['\"]$", "")
      env[var] = value
    end
  end

  return env, nil
end

--- Get a specific variable from .envrc
---@param var_name string Variable name to look for
---@param path string|nil Path to .envrc file
---@return string|nil value The value or nil if not found
---@return string|nil error Error message
function M.get(var_name, path)
  local env, err = M.parse(path)
  if err then
    return nil, err
  end

  local value = env[var_name]
  if not value then
    return nil, var_name .. " not defined in .envrc"
  end

  return value, nil
end

--- Normalize path separators for the current platform
---@param path string
---@return string
local function normalize_path(path)
  local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  if is_windows then
    return path:gsub("/", "\\")
  else
    return path:gsub("\\", "/")
  end
end

--- Run an application defined in .envrc
--- Looks for APPLICATION variable, errors if not found
---@param opts table|nil Options: { envrc_path, on_exit, on_stdout, on_stderr }
function M.run_application(opts)
  opts = opts or {}
  local cwd = vim.fn.getcwd()
  local env, parse_err = M.parse(opts.envrc_path)

  if parse_err then
    vim.notify(parse_err .. "\n\nCreate a .envrc file with:\nexport APPLICATION=path/to/your/app", vim.log.levels.ERROR)
    return
  end

  local app = env.APPLICATION
  if not app then
    vim.notify(
      "APPLICATION not defined in .envrc\n\nAdd to your .envrc:\nexport APPLICATION=path/to/your/executable",
      vim.log.levels.ERROR
    )
    return
  end

  -- Determine launch directory first (optional - defaults to cwd)
  local launch_dir = cwd
  if env.LAUNCH_DIR then
    local dir = env.LAUNCH_DIR
    if not dir:match("^[/\\]") and not dir:match("^%a:") then
      launch_dir = normalize_path(cwd .. "/" .. dir)
    else
      launch_dir = normalize_path(dir)
    end
  end

  -- APPLICATION is relative to LAUNCH_DIR, construct full path for existence check
  local app_path = app
  if not app:match("^[/\\]") and not app:match("^%a:") then
    app_path = launch_dir .. "/" .. app
  end
  app_path = normalize_path(app_path)

  -- Check if application exists
  if vim.fn.filereadable(app_path) == 0 and vim.fn.executable(app_path) == 0 then
    vim.notify("Application not found: " .. app_path, vim.log.levels.ERROR)
    return
  end

  -- Get the application command as defined in .envrc (relative path)
  local app_cmd = env.APPLICATION
  local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

  -- Handle batch files on Windows - wrap with cmd.exe /c
  local final_cmd = app_cmd
  if is_windows and (app_cmd:match("%.bat$") or app_cmd:match("%.cmd$")) then
    final_cmd = 'cmd.exe /c "' .. app_path .. '"'
  end

  vim.notify("Running: " .. app_cmd .. " (from: " .. launch_dir .. ")", vim.log.levels.INFO)

  -- Use toggleterm with correct working directory
  local Terminal = require("toggleterm.terminal").Terminal

  local run_term = Terminal:new({
    dir = launch_dir,
    cmd = final_cmd,
    direction = "float",
    close_on_exit = false,
    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.9),
      height = math.floor(vim.o.lines * 0.8),
    },
  })
  run_term:toggle()
end

--- Run a build script defined in .envrc or use platform default
---@param script_var string Variable name (e.g., "BUILD_SCRIPT", "POST_BUILD_SCRIPT")
---@param default_name string|nil Default script name if not in .envrc (nil = require .envrc)
function M.run_script(script_var, default_name)
  local cwd = vim.fn.getcwd()
  local env, parse_err = M.parse()
  local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

  local script = nil
  if not parse_err then
    script = env[script_var]
  end

  -- If no script defined and no default, show error
  if not script and not default_name then
    vim.notify(
      script_var .. " not defined in .envrc\n\nAdd to your .envrc:\nexport " .. script_var .. "=path/to/script",
      vim.log.levels.ERROR
    )
    return
  end

  -- Use default if not defined
  if not script then
    if is_windows then
      script = default_name .. ".bat"
    else
      script = default_name .. ".sh"
    end
  end

  local script_path = normalize_path(cwd .. "/" .. script)

  if vim.fn.filereadable(script_path) == 0 then
    vim.notify("Script not found: " .. script_path, vim.log.levels.ERROR)
    return
  end

  vim.notify("Running: " .. script_path, vim.log.levels.INFO)

  -- Determine how to run the script
  local cmd

  if script:match("%.ps1$") then
    cmd = { "powershell.exe", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", script_path }
  elseif script:match("%.bat$") or script:match("%.cmd$") then
    cmd = { "cmd.exe", "/c", script_path }
  elseif is_windows then
    -- Try to run with cmd on Windows for other extensions
    cmd = { "cmd.exe", "/c", script_path }
  else
    cmd = { "bash", script_path }
  end

  vim.fn.jobstart(cmd, {
    cwd = cwd,
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        if exit_code == 0 then
          vim.notify(script_var .. " completed successfully!", vim.log.levels.INFO)
        else
          vim.notify(script_var .. " failed with exit code: " .. exit_code, vim.log.levels.ERROR)
        end
      end)
    end,
    on_stdout = function(_, data)
      if data and #data > 0 and data[1] ~= "" then
        vim.schedule(function()
          print(table.concat(data, "\n"))
        end)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 and data[1] ~= "" then
        vim.schedule(function()
          vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
        end)
      end
    end,
  })
end

return M
