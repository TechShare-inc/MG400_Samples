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

-- float型300.0をbyte列表現したもの
local bytes = { 0.000000, 0.000000, 150.000000, 67.000000 } 

print(bytes)
print(bytes_to_float(bytes))
