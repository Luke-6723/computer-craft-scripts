rednet.open("front")
shell.run('label set Slime')
print("Waiting for Signal")
print("Spawner: Slime")
 
local redstoneActive = true
 
while true do
    local id,message = rednet.receive()
    print(message)
    if message == "Slime_ON" then
      redstone.setOutput("top", true)
    elseif message == "Slime_OFF" then
      redstone.setOutput("top", false)
    end
    
    if message == "reset" then
      redstone.setOutput("top", false)
    end
end