local http = require("http")
local json = require("json")
local wxwork = require("wxwork")
local mail = require("mail")


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


-- 下一个审批节点
function nextnode(objson)
    local tb = json.decode(objson)
    print('在这里开始判断下一个节点的逻辑')
    
    -- a = 100;
    -- if( a < 20 )
    -- then
    --     print("a 小于 20" )
    -- else
    --     print("a 大于 20" )
    -- end
    -- print("a 的值为 :", a)
    
    wxwork.send('这里发送的是企业微信内容')
    mail.send('这里发送的是邮件内容')

    return tb.a .. ' 返回值'
end