rednet.open("front")
shell.run('label set MagmaSlime')
print("Waiting for Signal")
print("Spawner: Magma Slime")
 
local redstoneActive = true
 
while true do
    local id,message = rednet.receive()
    print(message)
    if message == "Slime (M)_ON" then
      redstone.setOutput("top", true)
    elseif message == "Slime (M)_OFF" then
      redstone.setOutput("top", false)
    end
    
    if message == "reset" then
      redstone.setOutput("top", false)
    end
end