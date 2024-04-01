local array = {
	Vector3.new(1, 1, 1),
	Vector3.new(-1, 1, 1),
	Vector3.new(-1, 1, -1),
	Vector3.new(1, 1, -1),
	Vector3.new(1, -1, 1),
	Vector3.new(-1, -1, 1),
	Vector3.new(-1, -1, -1),
	Vector3.new(1, -1, -1)
}

local function vertShape(cf, size2)
	local output = {}
	for i = 1, #array do
		output[i] = cf * (array[i] * size2)
	end
	return output
end

local function worldBoundingBox(cf, size2)
	local set = vertShape(cf, size2)
	local x, y, z = {}, {}, {}
	for i = 1, #set do x[i], y[i], z[i] = set[i].x, set[i].y, set[i].z end
	local min = Vector3.new(math.min(unpack(x)), math.min(unpack(y)), math.min(unpack(z)))
	local max = Vector3.new(math.max(unpack(x)), math.max(unpack(y)), math.max(unpack(z)))
	return Region3.new(min, max)
end

return worldBoundingBox
