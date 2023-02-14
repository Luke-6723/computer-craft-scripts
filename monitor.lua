os.loadAPI("/touchpoint.lua")

local t = touchpoint.new("back")
t:add("Spawners", nil, 2, 2, 38, 4, colors.red, colors.lime)
t:add("Fans", nil, 2, 6, 38, 8, colors.red, colors.lime)
t:add("Mashers", nil, 2, 10, 38, 12, colors.red, colors.lime)
t:add("Maintenance Hatch", nil, 2, 16, 38, 18, colors.blue, colors.red)

t:draw()

while true do
    local event, p1 = t:handleEvents(os.pullEvent())
    if event == "button_click" then
        if p1 == "Spawners" then
            t:toggleButton("Spawners")
            rs.setOutput("left", t.buttonList["Spawners"].active)
        end

        if p1 == "Mashers" then
            t:toggleButton("Mashers")
            rs.setOutput("right", t.buttonList["Mashers"].active)
        end

        if p1 == "Fans" then
            t:toggleButton("Fans")
            rs.setOutput("bottom", t.buttonList["Fans"].active)
        end

        if (p1 == "Maintenance Hatch") then
            if t.buttonList["Spawners"].active then
                -- Disable the spawners
                rs.setOutput("left", t.buttonList["Spawners"].active)
                t:toggleButton("Spawners")

                -- 15s timeout to let the rest of the mobs die
                for i = 1, 15, 1 do
                    os.sleep(1)
                    t:rename("Maintenance Hatch", "Maintenance Hatch ( " .. i .. "s )")
                end
                -- Toggle buttons
                rs.setOutput("bottom", t.buttonList["Fans"].active)
                t:toggleButton("Fans")
                rs.setOutput("right", t.buttonList["Mashers"].active)
                t:toggleButton("Mashers")
            else
                t:toggleButton("Mashers")
            end
        end
    end
end
