--Some stuff opencomputers need
local robot_api = require("robot")
local component = require("component")
local event = require("event")
--open the robot for messages
component.modem.open(1337)
function getMessage()
	--Pull message and unserialize and print what we got from the modem component
	_, _, _, _, _, serialized_message = event.pull("modem_message")
	received_table = require("serialization").unserialize(serialized_message)
	print("recieved", received_table.action, received_table.times)
	return received_table
end


function moveUp(times)
	--Format the amount of movements we want to do to an integer
	local number = tonumber(received_table.times)
	local i = 0
	while i < number do
		--Detect if there is a block in the way and if there is break it (works best if you got a tool in the bots hand)
		if robot_api.detectUp() then
			robot_api.swingUp()
		end
		--move it
		robot_api.up()
		i = i + 1
	end
end

function moveDown(times)
	local number = tonumber(received_table.times)
	local i = 0
	while i < number do
		if robot_api.detectDown() then
			robot_api.swingDown()
		end

		robot_api.down()
		i = i + 1
	end
end

function moveRight(times)
	local number = tonumber(received_table.times)
	local i = 0
	--we turn the robot to the right and it just moves forward
	robot_api.turnRight()
	while i < number do
		if robot_api.detect() then
			robot_api.swing()
		end

		robot_api.forward()
		i = i + 1
	end
end

function moveLeft(times)
	local number = tonumber(received_table.times)
	local i = 0
	--Turn it to the left
	robot_api.turnLeft()
	while i < number do
		if robot_api.detect() then
			robot_api.swing()
		end

		robot_api.forward()
		i = i + 1
	end
end

function moveForward(times)
	local number = tonumber(received_table.times)
	local i = 0
	while i < number do
		if robot_api.detect() then
			robot_api.swing()
		end

		robot_api.forward()
		i = i + 1
	end
end

function moveBack(times)
	local number = tonumber(received_table.times)
	local i = 0
	robot_api.turnAround()
	while i < number do
		if robot_api.detect() then
			robot_api.swing()
		end

		robot_api.forward()
		i = i + 1
	end
end

function main()
	while true do
		received_table = getMessage()
		--We check what message we got and what the action we need to take is
		if received_table.action == "up" then
			moveUp(received_table.times)
		end
		if received_table.action == "down" then
			moveDown(received_table.times)
		end
		if received_table.action == "right" then
			moveRight(received_table.times)
		end
		if received_table.action == "left" then
			moveLeft(received_table.times)
		end
		if received_table.action == "forward" then
			moveForward(received_table.times)
		end
		if received_table.action == "back" then
			moveBack(received_table.times)
		end
	end
end
--RUN DA SHIT
main()