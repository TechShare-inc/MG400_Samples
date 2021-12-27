-- Version: Lua 5.4.1
-- Copyright © 2021 TechShare Inc. All Rights Reserved.
--0.ライブラリのインポートと関数定義
--[[
	data[] = [ id   |     data     ]
	id : 4bytes
	data : 8~16bytes

	id = 1 : dataは座標
	data : 4bytesでfloatの値を示しており、データ長は(x,y,z,r)の4つの座標値で16bytes

	id = 2 : エアポンプ制御信号
	data : 4bytesでfloatの値を示しており、データ長はPWR,DIRの2つの制御信号で8bytes

--]]

--移動の関数を定義
function MovL_xyzr(x,y,z,r)

	P = {}
	P["tool"] = 0
	P["armOrientation"]=right
	P["load"]=0.000000 
	P["coordinate"]={x, y, z, r, 0.000000, 0.000000 }
	P["user"]=0.000000

	-- SYNC=1が重要,ロボットが移動終了するのを待機
	MovL(P,"Speed=100 SYNC=1")
	
end

--送られてきたデータ4byteからfloat型に変換する関数を定義
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

--1.ソケットオブジェクトの作成
err, socket = TCPCreate(true, ip, port)

--メイン開始
--2.クライアントに接続
if err == 0 then
	err = TCPStart(socket, 0)	--通信開始
	if err == 0 then		--通信が確立したら
		local buf
		while true do
			print("test")
			--3.データを受信する
			err, buf = TCPRead(socket, 0)	--ソケットから座標読み取り
			if err == 0 then		--うまくデータを受け取れたら保存
        
				data = buf["buf"]
				size = buf["size"]
				print("data:",data)
				print("size:",size)
        
        		local id = 0
        		local id_data = {}
        
        		for i=1,4 do
          			id_data[i] = data[i]
          		end
        
        		local id = bytes_to_float(id_data)
			
			--4.id=1のとき、データを座標に変換して移動
			if id == 1 then
				
					local x = {}
					local y = {}
					local z = {}
          			local r = {}
			
					for i=4,size do		--最初の4bytesはID用
						if i <= 8 then	--4bytesごとに一つの座標値
							x[i - 4] = data[i]
						elseif i <=12 then
							y[i - 8] = data[i]
						elseif i <= 16 then
							z[i - 12] = data[i]
						elseif i <= 20 then
							r[i - 16] = data[i]
						end
					end
				
					local px = bytes_to_float(x)
					local py = bytes_to_float(y)
					local pz = bytes_to_float(z)
          				local pr = bytes_to_float(r)
				
					print("x:",px)
					print("y:",py)
					print("z:",pz)	
          				print("r:",pr)
			
					MovL_xyzr(px,py,pz,pr)
          
          		--5.データをエアポンプ制御信号へ変換してエアポンプ動作
			elseif id == 2 then
          
          			local pwr_data = {}
          			local dir_data = {}
          
          			for i=4,size do
						if i <= 8 then
							pwr_data[i - 4] = data[i]
						elseif i <=12 then
							dir_data[i - 8] = data[i]
              			end
              		end
          
          			local pwr = bytes_to_float(pwr_data)
          			local dir = bytes_to_float(dir_data)
          			
          			if pwr == 1 then
          				DO(1,ON)
              		else
              			DO(1,OFF)
                	end
              		
              		if dir == 1 then
            			DO(2,ON)
                  	else
                  		DO(2,OFF)
                    end
          
          			print("pwr:",pwr)
          			print("dir:",dir)
          
          		end
							
				TCPWrite(socket, "finish!")
        
			else
				print("Read error ".. err)
				break
			end
		end
	else
		print("Create failed ".. err)
	end
        --6.接続を終了
	TCPDestroy(socket)
else
  print("Create failed ".. err)
end

while true do
  Wait(500)
end
