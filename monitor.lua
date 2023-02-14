os.loadAPI("/touchpoint.lua")

local t = touchpoint.new("back")
local maintenanceHatchName = "Maintenance Hatch"
t:add("Spawners", nil, 2, 2, 38, 4, colors.red, colors.lime)
t:add("Fans", nil, 2, 6, 38, 8, colors.red, colors.lime)
t:add("Mashers", nil, 2, 10, 38, 12, colors.red, colors.lime)
t:add(maintenanceHatchName, nil, 2, 16, 38, 18, colors.blue, colors.cyan)

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

                -- Enable the fans and mashers if they aren't already. 
                -- Just to ensure the area is clear.
                if not t.buttonList["Fans"].active then
                    rs.setOutput("bottom", true)
                    t:toggleButton("Fans")
                end

                if not t.buttonList["Mashers"].active then
                    rs.setOutput("right", true)
                    t:toggleButton("Mashers")
                end

                t:rename("Maintenance Hatch", "Maintenance Hatch ( 15s )")
                maintenanceHatchName = "Maintenance Hatch ( 15s )"
                -- Disable the spawners
                rs.setOutput("left", false)
                t:toggleButton("Spawners")
                os.sleep(1)

                -- 15s timeout to let the rest of the mobs die
                for i = 14, 1, -1 do
                    t:rename(maintenanceHatchName, "Maintenance Hatch ( " .. i .. "s )")
                    maintenanceHatchName = "Maintenance Hatch ( " .. i .. "s )"
                    os.sleep(1)
                end

                -- Toggle buttons
                if t.buttonList["Fans"].active then
                    t:toggleButton("Fans")
                    rs.setOutput("bottom", false)
                end

                if t.buttonList["Mashers"].active then
                    t:toggleButton("Mashers")
                    rs.setOutput("right", false)
                end

                t:rename(maintenanceHatchName, "Maintenance Hatch")
                maintenanceHatchName = "Maintenance Hatch"
                t:toggleButton(maintenanceHatchName)
                rs.setOutput("top", true)
                rs.setOutput("bottom", false)
                rs.setOutput("right", false)
            else
                t:toggleButton("Maintenance Hatch")
                rs.setOutput("top", t.buttonList[maintenanceHatchName].active)
            end
        end
    end
end
