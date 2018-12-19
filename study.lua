local http = require("http")
local json = require("json")
local wxwork = require("wxwork")
local mail = require("mail")

-- 在些定义流程节点模型
local flowjson = [[
    {
        "node1": {
            "b": "hello",
            "options": [
                {
                    "action": "ok",
                    "desc": "通过"
                },
                {
                    "action": "no",
                    "desc": "拒绝"
                },
                {
                    "action": "back",
                    "desc": "打回"
                }
            ]
        },
        "node2": {
            "b": "hello",
            "options": [
                {
                    "action": "ok",
                    "desc": "通过"
                },
                {
                    "action": "no",
                    "desc": "拒绝"
                },
                {
                    "action": "back",
                    "desc": "打回"
                }
            ]
        }
    }
]]

local s = json.decode(flowjson)
print(s.node2.options[1].desc)

print('以下是用于测试http和json组件')
-- 测试http和json组件
local client = http.client()
local request = http.request("GET", "https://ipapi.co/120.229.14.207/json/")
local result, err = client:do_request(request)
if err then error(err) end
-- print(result.body)
local ip = json.decode(result.body)
print("----------------------------")
print(ip.ip)
print(ip.org)
print(ip.country_name)
print(ip.region)
print(ip.city)
print("----------------------------")

-- 返回当前节点的可选项
function getOption(objson)
    local options = [[]]
    return options
end

-- 下一个审批节点
function nextnode(objson)
    local tb = json.decode(objson)
    print('在这里开始判断下一个节点的逻辑')
    -------------------------------------------------------




    
    
    -------------------------------------------------------
    wxwork.send('这里发送的是企业微信内容')
    mail.send('这里发送的是邮件内容')

    return tb.a .. ' 返回值'
end