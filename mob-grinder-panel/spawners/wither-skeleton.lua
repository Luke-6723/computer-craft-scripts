rednet.open("front")
shell.run('label set WitherSkeleton')
print("Waiting for Signal")
print("Spawner: Wither Skeleton")
 
local redstoneActive = true
 
while true do
    local id,message = rednet.receive()
    print(message)
    if message == "WSkeleton_ON" then
      redstone.setOutput("top", true)
    elseif message == "WSkeleton_OFF" then
      redstone.setOutput("top", false)
    end
    
    if message == "reset" then
      redstone.setOutput("top", false)
    end
end