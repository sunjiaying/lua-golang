local http = require("http")
local json = require("json")
local client = http.client()
local request = http.request("GET", "https://api.ttt.sh/ip/qqwry/")
local result, err = client:do_request(request)
if err then error(err) end
print(result.body)

local tb = json.decode('{"a":1,"b":"ss","c":{"c1":1,"c2":2},"d":[10,11],"1":100}')
print(tb.c.c2)
