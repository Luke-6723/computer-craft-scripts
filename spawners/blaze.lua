rednet.open("front")
shell.run('label set Blaze')
print("Waiting for Signal")
print("Spawner: Blaze")
 
local redstoneActive = true
 
while true do
    local id,message = rednet.receive()
    print(message)
    if message == "Blaze_ON" then
      redstone.setOutput("top", true)
    elseif message == "Blaze_OFF" then
      redstone.setOutput("top", false)
    end
    
    if message == "reset" then
      redstone.setOutput("top", false)
    end
end