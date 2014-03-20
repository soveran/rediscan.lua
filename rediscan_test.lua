require("pl.strict")

local rediscan = require("rediscan")

local resp = require("resp-6e21869")

local c = resp.new("localhost", 6379)

local prepare = function(c)
	c:call("SELECT", "4")
	c:call("FLUSHDB")
end

prepare(c)

-- Basic usage without filters

local res = 0
local sum = function(key)
	res = res + tonumber(key)
end

c:call("SET", "42", "true")
c:call("SET", "23", "true")

rediscan(c, sum, {})

assert(res == 65)

prepare(c)

-- Usage with MATCH

local expected = {
	"Foo:42",
	"Foo:23",
}

local res = {}
local cat = function(key)
	table.insert(res, key)
end

c:call("SET", "Foo:42", "true")
c:call("SET", "Foo:23", "true")
c:call("SET", "Bar:11", "true")

rediscan(c, cat, { match = "Foo:*" })

assert(#res == 2)
assert(res[1] == expected[1])
assert(res[2] == expected[2])
