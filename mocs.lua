--[[
    ZLIB License. Copyright (c) 2020 Nelson "darltrash" Lopez.
    MÖCS: A CSS-inspired data format for Lua.

    This software is provided 'as-is', without any express or implied warranty. In no event will 
    the authors be held liable for any damages arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose, including 
    commercial applications, and to alter it and redistribute it freely, subject to the following 
    restrictions:

        1.  The origin of this software must not be misrepresented; 
            you must not claim that you wrote the original software. 
            If you use this software in a product, an acknowledgment 
            in the product documentation would be appreciated but is not required.

        2.  Altered source versions must be plainly marked as such, 
            and must not be misrepresented as being the original software.

        3.  This notice may not be removed or altered from any source distribution.
]]

local reserved = {
    ["{"] = true,
    ["}"] = true,
    [";"] = true,
    ["("] = true,
    [")"] = true,
    ["["] = true,
    ["]"] = true,
    [","] = true,
}

local exclude = {
    ["{"] = true
}

return function (str)
    local items     = {}
    local _instring = false
    local instring  = false
    local incomment = false
    local capturing = ""
    local luacode   = ""

    for char in str:gmatch(".") do
        if char == "$" and not instring then
            incomment = true
        end

        if char == "\n" and incomment then
            incomment = false
        end

        if not incomment then
            if char == "'" or char == '"' then
                if not instring then instring = char else
                    _instring = (instring == char)
                end
            end

            if reserved[char] and not instring then
                if #capturing > 0 then
                    table.insert(items, capturing)
                    capturing = ""
                end
                table.insert(items, char)
            elseif char:gsub("%s", "") == "" and not instring then
                if #capturing > 0 then
                    table.insert(items, capturing)
                    capturing = ""
                end
            else
                capturing = capturing .. char
            end
            if _instring then instring = false; _instring = false end
        end
    end

    for k, v in ipairs(items) do
        local last, next = items[k-1] or "", items[k+1] or ""

        if v:sub(#v) == ":" then
            if not tonumber(v:sub(1, #v-1)) then
                luacode = luacode .. "['" .. v:sub(1, #v-1) .. "']" .. "="
            else
                luacode = luacode .. "[" .. v:sub(1, #v-1) .. "]" .. "="
            end
        end
        if reserved[v] and not exclude[v] then
            luacode = luacode .. v
        end
        if last:sub(#last) == ":" or last == "," then 
            if tonumber(v:sub(1, #v-1)) and v:sub(#v) == "%" then 
                v = tonumber(v:sub(1, #v-1))/100 
            end
            luacode = luacode .. v
        end
        if v == "}" then luacode = luacode .. ";" end
    end
    local fn, err = loadstring("return {" .. luacode .. "}")
    assert(fn, err)
    return fn()
end