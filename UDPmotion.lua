function bytes_to_float(x)
    
  	local b1 = x[1]
	local b2 = x[2]
	local b3 = x[3]
	local b4 = x[4]
    
    --正負
    local sign = b4 <= 127 and 1 or -1
    
    --尾数
    local mantissa = b3 % 128 
    mantissa = mantissa * 256 + b2
    mantissa = mantissa * 256 + b1
    mantissa = math.ldexp(mantissa, -23) + 1

    --指数
    local exponent = b4 % 128 * 2 + math.floor(b3 / 128)
    if exponent == 0 then
        return 0 
    end

    --浮点数
    local f = math.ldexp(mantissa * sign, exponent - 127)
    return f
end

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
		
			data = buf["buf"]
			size = buf["size"]
			print("data:",data)
			print("size:",size)
			
			local x = {}
			local y = {}
			local z = {}
			
			for i=1,size do

				if i <= 4 then
					x[i] = data[i]
				elseif i <=8 then
					y[i - 4] = data[i]
				elseif i <= 12 then
					z[i - 8] = data[i]
				end
				
			end
			
			print("x:",bytes_to_float(x))
			print("y:",bytes_to_float(y))
			print("z:",bytes_to_float(z))	
			
			
		else
			print("Read error ".. err)
			break
		end
	end
else
  print("Create failed ".. err)
end
