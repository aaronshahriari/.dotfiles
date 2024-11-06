local file = io.open("/tmp/setup_display", "r")

-- reading & setting the font-size
local mode = file and file:read("*line") or ""

-- close the file if it was successfully opened
if file then file:close() end

mode = mode:gsub("\n", "")   -- this specifically removes newline characters
mode = mode:gsub("%s+$", "") -- this removes any trailing whitespace (including spaces)

-- check for specific values
if mode == "home-two" then
    print(mode)
    print("font_size = 14")
elseif mode == "laptop" then
    print(mode)
    print("font_size = 10")
else
    print(mode)
    print("font_size = 12")
end
