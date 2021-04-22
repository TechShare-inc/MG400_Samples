
function Go_xyzr(x,y,z,r)

	P = {}
	P["tool"] = 0
	P["armOrientation"]=right
	P["load"]=0.000000 
	P["coordinate"]={x, y, z, r, 0.000000, 0.000000 }
	P["user"]=0.000000

	Go(P,"Speed=100")
	
end

Go_xyzr(300,0,50,0)

while true do
	Go_xyzr(300,-60,50,0)
	Go_xyzr(300,60,50,0)
end
