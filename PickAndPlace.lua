-- Version: Lua 5.4.1

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

function PompON()
  
  DO(1,ON)
  DO(2,ON)
    
end

function PompOFF()
  
  DO(1,OFF)
  DO(2,OFF)
    
end
        
local x = 280
local y = 125
local z = -78

Go_xyzr(x,0,0,0)
        
while true do
          
 Go_xyzr(x,0,0,0)
 Go_xyzr(x,y,0,0)
 Go_xyzr(x,y,z,0)
 Go_xyzr(x,y,0,0)
          
 PompON()
          
 y = -y
          
 Go_xyzr(x,y,0,0)
 Go_xyzr(x,y,z,0)
 Go_xyzr(x,y,0,0)
 
 Go_xyzr(x,0,0,0)
          
 PompOFF()
          
end
