local isAtStart = redstone.getInput("left")
local isAtEnd = redstone.getInput("top")

local currentSpeed = 0
local motor = peripheral.find("electric_motor")
motor.setSpeed(currentSpeed)

if isAtStart then print("Current Position: Start") end

if isAtEnd then print("Current Position: End") end

if not isAtEnd and not isAtStart then
    print("Current Position: Unknown")
    print("Bringing back to start.")

    while not redstone.getInput("left") do motor.setSpeed(-48) end

    motor.setSpeed(0)
    print("Done.")
end

while true do
    print("Beginning gantry movements...")
    isAtStart = redstone.getInput("left")
    isAtEnd = redstone.getInput("top")

    if isAtStart then
        motor.setSpeed(48)
        while not redstone.getInput("top") do
            print("Gantry not arrived... waiting...")
            os.sleep(5)
        end
        print("Gantry arrived... giving 10 seconds to offload.")
        os.sleep(10)
    end
    if isAtEnd then
        motor.setSpeed(-48)
        while not redstone.getInput("left") do
            print("Gantry not arrived... waiting...")
            os.sleep(5)
        end
        print("Gantry arrived... giving 10 seconds to offload.")
        os.sleep(10)
    end
end
