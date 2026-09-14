-- Lombok boilerplate above the enclosing type declaration, plus its imports.
--   :Dban  (or :dban via the abbreviation below — user commands must start uppercase)
local annotations = { "@Data", "@Builder", "@AllArgsConstructor", "@NoArgsConstructor" }
local imports = {
    "import lombok.AllArgsConstructor;",
    "import lombok.Builder;",
    "import lombok.Data;",
    "import lombok.NoArgsConstructor;",
}

local function is_type_decl(line)
    for _, kw in ipairs({ "class", "interface", "record", "enum" }) do
        if line:match("^%s*.-%f[%a]" .. kw .. "%f[%A]") then
            return true
        end
    end
    return false
end

local function insert_import(text)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local first, last, package
    for i, line in ipairs(lines) do
        if line == text then
            return
        elseif line:match("^import ") then
            first = first or i
            last = i
        elseif line:match("^package ") then
            package = i
        end
    end

    if first then
        local at = last
        for i = first, last do
            if lines[i]:match("^import %S") and lines[i] > text then
                at = i - 1
                break
            end
        end
        vim.api.nvim_buf_set_lines(0, at, at, false, { text })
        return
    end

    local block = { "", text }
    if lines[(package or 0) + 1] ~= "" then
        table.insert(block, "")
    end
    vim.api.nvim_buf_set_lines(0, package or 0, package or 0, false, package and block or { text, "" })
end

vim.api.nvim_buf_create_user_command(0, "Dban", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local cur = vim.fn.line(".")

    local target
    for i = cur, 1, -1 do
        if is_type_decl(lines[i]) then
            target = i
            break
        end
    end
    for i = cur + 1, #lines do
        if target then
            break
        end
        if is_type_decl(lines[i]) then
            target = i
        end
    end
    if not target then
        vim.notify("Dban: no class/interface/record/enum declaration found", vim.log.levels.WARN)
        return
    end

    local present = {}
    for i = target - 1, 1, -1 do
        local annotation = lines[i]:match("^%s*(@%w+)")
        if not annotation then
            break
        end
        present[annotation] = true
    end

    local indent = lines[target]:match("^%s*")
    local insert = {}
    for _, a in ipairs(annotations) do
        if not present[a] then
            table.insert(insert, indent .. a)
        end
    end
    vim.api.nvim_buf_set_lines(0, target - 1, target - 1, false, insert)

    for _, text in ipairs(imports) do
        insert_import(text)
    end
end, { desc = "Insert Lombok @Data/@Builder/@AllArgsConstructor/@NoArgsConstructor + imports" })

vim.keymap.set("ca", "dban", function()
    return (vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "dban") and "Dban" or "dban"
end, { buffer = true, expr = true })
