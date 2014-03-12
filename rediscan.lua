return function(c, fn, filters)
	local args = {}
	local keys = nil
	local done = false

	for k, v in pairs(filters) do
		table.insert(args, k)
		table.insert(args, v)
	end

	local cursor = "0"

	repeat
		local result = c:call("SCAN", cursor, unpack(args))

		cursor = result[1]
		keys   = result[2]

		for i, key in ipairs(keys) do
			fn(key)
		end

		if cursor == "0" then
			done = true
		end
	until done
end
