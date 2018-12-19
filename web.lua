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

-- 返回当前节点的可选项
function getoption(objson)
    local fj = json.decode(flowjson)
    local op = fj.node1.options
    local opstr = json.encode(op)
    return opstr
end


-- 当前节点的动作处理
function actiondo(objson)
    local tb = json.decode(objson)
    print('在这里开始判断下一个节点的逻辑')
    -------------------------------------------------------




    
    
    -------------------------------------------------------
    wxwork.send('这里发送的是企业微信内容')
    mail.send('这里发送的是邮件内容')

    return tb.a .. ' 返回值'
end