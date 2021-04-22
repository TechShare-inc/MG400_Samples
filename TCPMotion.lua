
function Go_xyzr(x,y,z,r)

	P = {}
	P["tool"] = 0
	P["armOrientation"]=right
	P["load"]=0.000000 
	P["coordinate"]={x, y, z, r, 0.000000, 0.000000 }
	P["user"]=0.000000

	-- SYNC=1が重要,ロボットが移動終了するのを待機
	Go(P,"Speed=100 SYNC=1")
	
end

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
local port=6001
local err=0
local socket=0 

err, socket = TCPCreate(true, ip, port)

if err == 0 then
	err = TCPStart(socket, 0)
	if err == 0 then
		local buf
		while true do
			print("test")
			err, buf = TCPRead(socket, 0)
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
				
				local px = bytes_to_float(x)
				local py = bytes_to_float(y)
				local pz = bytes_to_float(z)
				
				print("x:",px)
				print("y:",py)
				print("z:",pz)	
			
				Go_xyzr(px,py,pz,0)
							
				TCPWrite(socket, "finish motion!")
			else
				print("Read error ".. err)
				break
			end
		end
	else
		print("Create failed ".. err)
	end
	TCPDestroy(socket)
else
  print("Create failed ".. err)
end
