local meta = {}
local Complex = {}
Complex.__index = Complex
setmetatable(Complex, meta)

function meta.__call(self, a, b)
    local obj = {a, b}
    return setmetatable(obj, Complex)
end

function Complex.read(val)
    if getmetatable(val) == Complex then
        return val
    else
        return Complex(val, 0)
    end
end

function Complex.__tostring(self)
        return string.format('(%s, %s)', self[1], self[2])
end

function Complex.__add(p1, p2)
    local p1 = Complex.read(p1)
    local p2 = Complex.read(p2)

    return Complex(
        p1[1] + p2[1],
        p1[2] + p2[2]
    )
end

function Complex.__sub(p1,p2)
    local p1 = Complex.read(p1)
    local p2 = Complex.read(p2)
    return Complex(
        p1[1]-p2[1],
        p1[2]-p2[2]
    )
end

function Complex.__mul(p1, p2) 
    local p1 = Complex.read(p1)
    local p2 = Complex.read(p2)
    return Complex(
        (p1[1]*p2[1])-(p1[2]*p2[2]),
        (p1[1]*p2[2])+(p1[2]*p2[1])
    )
end

function Complex.__div(p1, p2) 
    local p1 = Complex.read(p1)
    local p2 = Complex.read(p2)
    local mul = p1 * p2:conj()
    return Complex(
        mul[1]/(p2:abs())^2, 
        mul[2]/(p2:abs())^2
    )
end

function Complex.conj(p1)
    local p1 = Complex.read(p1)
    return Complex(
        p1[1], 
        -p1[2]
    )
end

function Complex.abs(p1)
    local p1 = Complex.read(p1)
    return math.sqrt(p1[1]^2 + p1[2]^2)
end

function Complex.arg(p1)
    local p1 = Complex.read(p1)
    return math.deg(math.atan(p1[1], p1[2])) 
end
return Complex