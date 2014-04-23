require("pl.strict")

local rediscan = require("rediscan")

local resp = require("lib.resp-8ea9690")

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

local res = {}
local cat = function(key)
	table.insert(res, key)
end

c:call("SET", "Foo:42", "true")
c:call("SET", "Bar:11", "true")

rediscan(c, cat, { match = "Foo:*" })

assert(#res == 1)
assert(res[1] == "Foo:42")
