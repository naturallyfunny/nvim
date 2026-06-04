local M = {}
local uv = vim.uv or vim.loop

-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Config                                                                     │
-- ╰──────────────────────────────────────────────────────────────────────────╯

-- ASCII arts to cycle through. Add more entries freely — they're auto-normalized
-- to a common grid (vertically centered, space-padded), so they don't need to
-- match in size and the layout won't jump when swapping. stylua: ignore
local arts = {
  [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  [[
             ,,,,,,
         o#'9MMHb':'-,o,
      .oH":HH$' "' ' -*R&o,
     dMMM*""'`'      .oM"HM?.
   ,MMM'          "HLbd< ?&H\
  .:MH ."\          ` MM  MM&b
 . "*H    -        &MMMMMMMMMH:
 .    dboo        MMMMMMMMMMMM.
 .   dMMMMMMb      *MMMMMMMMMP.
 .    MMMMMMMP        *MMMMMP .
      `#MMMMM           MM6P ,
  '    `MMMP"           HM*`,
   '    :MM             .- ,
    '.   `#?..  .       ..'
       -.   .         .-
         ''-.oo,oo.-'']],
  [[
 █████╗ ██████╗ ██████╗ ██╗ █████╗ ███╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗████╗  ██║
███████║██████╔╝██║  ██║██║███████║██╔██╗ ██║
██╔══██║██╔══██╗██║  ██║██║██╔══██║██║╚██╗██║
██║  ██║██║  ██║██████╔╝██║██║  ██║██║ ╚████║
╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝]],
    [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⠄⠀⡐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠳⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡈⣀⡴⢧⣀⠀⠀⣀⣠⠤⠤⠤⠤⣄⣀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⠏⢀⡴⠊⠁⠀⠄⠀⠀⠀⠀⠈⠙⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠘⢶⣶⣒⡶⠦⣠⣀⠀
⠀⠀⠀⠀⠀⠀⢀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠈⣟⠲⡎⠙⢦⠈⢧
⠀⠀⠀⣠⢴⡾⢟⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡰⢃⡠⠋⣠⠋
⠐⠀⠞⣱⠋⢰⠁⢿⠀⠀⠀⠀⠄⢂⠀⠀⠀⠀⠀⣀⣠⠠⢖⣋⡥⢖⣩⠔⠊⠀⠀
⠈⠠⡀⠹⢤⣈⣙⠚⠶⠤⠤⠤⠴⠶⣒⣒⣚⣨⠭⢵⣒⣩⠬⢖⠏⠁⢀⣀⠀⠀⠀
⠀⠀⠈⠓⠒⠦⠍⠭⠭⣭⠭⠭⠭⠭⡿⡓⠒⠛⠉⠉⠀⠀⣠⠇⠀⠀⠘⠞⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢤⣀⠀⠁⠀⠀⠀⠀⣀⡤⠞⠁⠀⣰⣆⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠿⠀⠀⠀⠀⠀⠉⠉⠙⠒⠒⠚⠉⠁⠀⠀⠀⠁⢣⡎⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ]],
}

-- glyphs randomly stamped over the art during a glitch transition
local glitch_chars = { "█", "▓", "▒", "░", "╳", "#", "@", "%", "&", "╬", "■", "/", "\\", "*", "·", "¦" }

local HOLD_MIN, HOLD_MAX = 1000, 9000 -- ms a clean art stays on screen
local GLITCH_FRAMES = 7 -- glitch steps per transition
local GLITCH_MS = 50 -- ms between glitch steps
local MAX_INTENSITY = 0.55 -- starting glitch probability (ramps to 0)

M.enabled = true

-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Frame normalization                                                        │
-- ╰──────────────────────────────────────────────────────────────────────────╯

-- frames[i] = a grid of rows, each a list of utf-8 chars. Each frame keeps its
-- own natural height; every row is padded to that art's own width so the block
-- is a tight rectangle that centers cleanly.
local frames = {}

-- split a string into a list of utf-8 chars (box-drawing glyphs are multibyte)
local function chars(s)
  return vim.fn.split(s, "\\zs")
end

local function is_blank(line)
  return line:match("^%s*$") ~= nil
end

-- parse an art into a list of char-rows, dropping blank top/bottom lines
local function parse_art(art)
  local lines = vim.split(art, "\n", { plain = true })
  local s, e = 1, #lines
  while s <= e and is_blank(lines[s]) do
    s = s + 1
  end
  while e >= s and is_blank(lines[e]) do
    e = e - 1
  end
  local rows = {}
  for i = s, e do
    rows[#rows + 1] = chars(lines[i])
  end
  return rows
end

-- pad each row to the art's own max width, so the block is a tight rectangle
local function normalize(rows)
  local w = 0
  for _, row in ipairs(rows) do
    w = math.max(w, #row)
  end
  for _, row in ipairs(rows) do
    for i = #row + 1, w do
      row[i] = " "
    end
  end
  return rows
end

local function build_frames()
  if #frames > 0 then
    return
  end
  for _, art in ipairs(arts) do
    frames[#frames + 1] = normalize(parse_art(art))
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Rendering                                                                  │
-- ╰──────────────────────────────────────────────────────────────────────────╯

-- render a frame to a string, glitching each row with probability `p` (0 = clean)
local function render(grid, p)
  local w = #grid[1] -- every row of a frame shares the art's width
  local lines = {}
  for _, row in ipairs(grid) do
    local shift = (p > 0 and math.random() < p * 0.4) and math.random(-2, 2) or 0
    local cells = {}
    for i = 1, w do
      local src = i - shift
      local ch = (src >= 1 and src <= w) and row[src] or " "
      if p > 0 and ch ~= " " and math.random() < p then
        ch = (math.random() < 0.25) and " " or glitch_chars[math.random(#glitch_chars)]
      end
      cells[i] = ch
    end
    lines[#lines + 1] = table.concat(cells)
  end
  return table.concat(lines, "\n")
end

build_frames()
local cur = math.random(#frames)
-- consumed by lua/plugins/ui.lua for the first (pre-animation) paint
M.header = render(frames[cur], 0)

-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Animation loop                                                             │
-- ╰──────────────────────────────────────────────────────────────────────────╯

local timer = nil

local function stop()
  if timer then
    timer:stop()
    if not timer:is_closing() then
      timer:close()
    end
    timer = nil
  end
end
M.stop = stop

-- true only while a valid dashboard buffer is the focused buffer; stops otherwise
local function alive()
  local d = M._dash
  if not (timer and d and d.buf and vim.api.nvim_buf_is_valid(d.buf)) then
    return false
  end
  if vim.api.nvim_get_current_buf() ~= d.buf then
    stop()
    return false
  end
  return true
end

-- swap the header string and re-render the dashboard
local function paint(str)
  local d = M._dash
  if not (d and d.buf and vim.api.nvim_buf_is_valid(d.buf)) then
    stop()
    return
  end
  d.opts.preset = d.opts.preset or {}
  d.opts.preset.header = str
  pcall(function()
    d:update()
  end)
end

local function later(delay, fn)
  if timer then
    timer:start(delay, 0, vim.schedule_wrap(fn))
  end
end

-- glitch `cur` into a different frame, then settle and schedule the next transition
local transition -- forward declaration (glitch_to and transition are mutually recursive)

-- glitch into `target` over GLITCH_FRAMES steps (intensity ramping to 0),
-- then rest on it and schedule the next transition
local function glitch_to(target)
  local function step(k)
    if not alive() then
      return
    end
    if k > GLITCH_FRAMES then -- transition done: rest on the clean frame
      cur = target
      paint(render(frames[cur], 0))
      later(math.random(HOLD_MIN, HOLD_MAX), transition)
      return
    end
    local p = MAX_INTENSITY * (1 - (k - 1) / GLITCH_FRAMES) -- ramp intensity down
    paint(render(frames[target], p))
    later(GLITCH_MS, function()
      step(k + 1)
    end)
  end
  step(1)
end

-- pick a different frame and glitch into it
transition = function()
  if not alive() then
    return
  end
  local nxt = cur
  if #frames > 1 then
    while nxt == cur do
      nxt = math.random(#frames)
    end
  end
  glitch_to(nxt)
end

function M.start()
  if not M.enabled or #frames < 2 then
    return
  end
  stop()
  timer = uv.new_timer()
  paint(render(frames[cur], 0))
  later(math.random(HOLD_MIN, HOLD_MAX), transition)
end

function M.toggle()
  M.enabled = not M.enabled
  if M.enabled then
    M.start()
  else
    stop()
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Wiring                                                                     │
-- ╰──────────────────────────────────────────────────────────────────────────╯

-- Wrap Snacks.dashboard.open to capture the live instance and kick off
-- animation. Snacks opens the dashboard from M.open() on UIEnter, so the wrap
-- MUST be in place before then — and there's no registry to grab an
-- already-open instance from. Requiring snacks here is safe (it only creates
-- the lazy global + sets highlights), and this runs at spec-read time, well
-- before UIEnter.
function M.install()
  if M._installed then
    return
  end
  require("snacks")
  local ok, D = pcall(require, "snacks.dashboard")
  if not ok then
    return
  end
  M._installed = true
  local orig = D.open
  D.open = function(opts)
    local self = orig(opts)
    M._dash = self
    M.start()
    return self
  end
end

M.install()

vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardClosed",
  callback = stop,
})

-- restart when returning to an existing dashboard buffer
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    if M._dash and ev.buf == M._dash.buf and not timer then
      M.start()
    end
  end,
})

return M
