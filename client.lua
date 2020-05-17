local shell = require("shell")
local component = require("component")
--parse the arguments we got from the tablet/computer
local args, ops = shell.parse(...)

--format the table
table_to_send = {action = arg[1], times = arg[2]}

--Send da shit on port 1337 LEETNESS!
message_to_send = require("serialization").serialize(table_to_send)
component.modem.open(1337)
component.modem.broadcast(1337, message_to_send)