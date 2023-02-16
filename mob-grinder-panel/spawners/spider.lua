rednet.open("front")
shell.run('label set Spider')
print("Waiting for Signal")
print("Spawner: Spider")
 
local redstoneActive = true
 
while true do
    local id,message = rednet.receive()
    print(message)
    if message == "Spider_ON" then
      redstone.setOutput("top", true)
    elseif message == "Spider_OFF" then
      redstone.setOutput("top", false)
    end
    
    if message == "reset" then
      redstone.setOutput("top", false)
    end
end