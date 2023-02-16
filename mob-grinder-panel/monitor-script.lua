os.loadAPI("/touchpoint.lua")
rednet.open("left")
rs.setOutput("top", false)
rs.setOutput("left", false)
rs.setOutput("right", false)
rs.setOutput("bottom", false)
rednet.broadcast("reset")

local t = touchpoint.new("back")
local maintenanceHatchName = "Maintenance Hatch"

t:add("Slime", nil, 2, 2, 12, 6, colors.red, colors.lime)
t:add("Slime (M)", nil, 15, 2, 25, 6, colors.red, colors.lime)
t:add("Skeleton", nil, 28, 2, 38, 6, colors.red, colors.lime)

t:add("Spider", nil, 2, 8, 12, 12, colors.red, colors.lime)
t:add("Blaze", nil, 15, 8, 25, 12, colors.red, colors.lime)
t:add("WSkeleton", nil, 28, 8, 38, 12, colors.red, colors.lime)

t:add("Fans", nil, 2, 15, 38, 17, colors.red, colors.lime)
t:add("Mashers", nil, 2, 19, 38, 21, colors.red, colors.lime)
t:add(maintenanceHatchName, nil, 2, 23, 38, 25, colors.blue, colors.cyan)

t:draw()

while true do
    local event, p1 = t:handleEvents(os.pullEvent())
    if event == "button_click" then
        if p1 == "Mashers" then
            t:toggleButton("Mashers")
            rs.setOutput("right", t.buttonList["Mashers"].active)

        elseif p1 == "Fans" then
            t:toggleButton("Fans")
            rs.setOutput("bottom", t.buttonList["Fans"].active)

        elseif (p1 == "Maintenance Hatch") then
            if t.buttonList[maintenanceHatchName].active then
                t:toggleButton(maintenanceHatchName)
                rs.setOutput("top", false)
            else
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
                rednet.broadcast("reset")
                for k, v in pairs(t.buttonList) do
                    if (k == "Mashers") then
                    elseif (k == "Fans") then
                    elseif t.buttonList[k].active then
                        t:toggleButton(k)
                    end
                end
                os.sleep(1)

                -- 15s timeout to let the rest of the mobs die
                for i = 14, 1, -1 do
                    t:rename(maintenanceHatchName,
                             "Maintenance Hatch ( " .. i .. "s )")
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
            end
        else
            t:toggleButton(p1)
            extraMessage = ""
            if t.buttonList[p1].active then
                extraMessage = "_ON"
            else
                extraMessage = "_OFF"
            end
            rednet.broadcast(p1 .. extraMessage)
        end
    end
end
