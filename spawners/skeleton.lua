rednet.open("front")
shell.run('label set Skeleton')
print("Waiting for Signal")
print("Spawner: Wither Skeleton")
 
local redstoneActive = true
 
while true do
    local id,message = rednet.receive()
    print(message)
    if message == "Skeleton_ON" then
      redstone.setOutput("top", true)
    elseif message == "Skeleton_OFF" then
      redstone.setOutput("top", false)
    end
    
    if message == "reset" then
      redstone.setOutput("top", false)
    end
end