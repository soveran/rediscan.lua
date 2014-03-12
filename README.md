Rediscan
========

Scanner for Redis keyspace

Description
-----------

Rediscan lets you iterate over the Redis keyspace and execute a
block for each match.

Usage
-----

You need to supply a Redis client. There are no restrictions
regarding the type of the Redis client, but it must respond to
`call` and the signature must be identical to that of
[RESP][resp].


```lua
local resp = require("resp")
local client = resp.new("localhost", 6379)

-- You have to supply a Redis client, a function and a table with
-- filters for MATCH and COUNT. This example will print all the
-- keys that match "Foo:*":
rediscan(client, print, { match = "Foo:*" })
```

The function supplied as the second parameter will be called once
for each key found. You can of course inline the function:

```lua
-- Function inlined
rediscan(client, function(key) ... end, { match = "Foo:*" })
```

Installation
------------

You need to have [lsocket](http://www.tset.de/lsocket/) installed,
then just copy rediscan.lua anywhere in your package.path.

A `packages` file is provided in case you want to use [pac][pac]
to install the development dependencies. Follow the instructions
in [pac's documentation][pac] to get started.

[pac]: https://github.com/soveran/pac
[resp]: https://github.com/soveran/resp
