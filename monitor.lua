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
            if maintenanceCountdownRunning then
                for i = 1, 3, 1 do
                    t:flash(maintenanceHatchName)
                end
            else
                t:toggleButton("Spawners")
                rs.setOutput("left", t.buttonList["Spawners"].active)
            end
        end

        if p1 == "Mashers" then
            if maintenanceCountdownRunning then
                for i = 1, 3, 1 do
                    t:flash(maintenanceHatchName)
                end
            else
                t:toggleButton("Mashers")
                rs.setOutput("right", t.buttonList["Mashers"].active)
            end
        end

        if p1 == "Fans" then
            if maintenanceCountdownRunning then
                for i = 1, 3, 1 do
                    t:flash(maintenanceHatchName)
                end
            else
                t:toggleButton("Fans")
                rs.setOutput("bottom", t.buttonList["Fans"].active)
            end
        end

        if (p1 == "Maintenance Hatch") then
            if t.buttonList["Spawners"].active then
                t:rename("Maintenance Hatch", "Maintenance Hatch ( 15s )")
                maintenanceHatchName = "Maintenance Hatch ( 15s )"
                -- Disable the spawners
                rs.setOutput("left", t.buttonList["Spawners"].active)
                t:toggleButton("Spawners")
                os.sleep(1)

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

                -- 15s timeout to let the rest of the mobs die
                for i = 14, 1, -1 do
                    t:rename(maintenanceHatchName, "Maintenance Hatch ( " .. i .. "s )")
                    maintenanceHatchName = "Maintenance Hatch ( " .. i .. "s )"
                    os.sleep(1)
                end
                -- Toggle buttons
                if t.buttonList["Fans"].active then
                    rs.setOutput("bottom", t.buttonList["Fans"].active)
                    t:toggleButton("Fans")
                end

                if t.buttonList["Mashers"].active then
                    rs.setOutput("right", t.buttonList["Mashers"].active)
                    t:toggleButton("Mashers")
                end

                t:rename(maintenanceHatchName, "Maintenance Hatch")
                maintenanceHatchName = "Maintenance Hatch"
                t:toggleButton(maintenanceHatchName)
            else
                t:toggleButton("Maintenance Hatch")
            end
        end
    end
end
