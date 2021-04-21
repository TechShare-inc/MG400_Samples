local ip="192.168.2.6" 
local port=6200
local err=0
local socket=0 

err, socket = UDPCreate(true, ip, port)
if err == 0 then
	local buf
	while true do
		err, buf = UDPRead(socket, 0)
		
		if err == 0 then
			print("")
			print("buf:",buf)
		else
			print("Read error ".. err)
			break
		end
	end
else
  print("Create failed ".. err)
end
