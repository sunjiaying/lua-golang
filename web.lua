local http = require("http")
local json = require("json")
local wxwork = require("wxwork")
local mail = require("mail")
local lookup = require("lookup")
local strings = require("strings")

-- 在些定义流程节点模型
local flowjson = [[
{
    "proxiers": [{
        "00209": "00275,00222"
    }],
    "nodes": [{
            "name": "draft",
            "desc": "草稿提交",
            "options": [{
                "action": "submit",
                "desc": "提交",
                "nextnode": "node1"
            }]
        },
        {
            "name": "node1",
            "desc": "部门主管",
            "options": [{
                    "action": "ok",
                    "desc": "通过",
                    "nextnode": "node21&&node22"
                },
                {
                    "action": "no",
                    "desc": "拒绝",
                    "nextnode": "rejected"
                },
                {
                    "action": "back",
                    "desc": "打回",
                    "nextnode": "draft"
                }
            ]
        },
        {
            "name": "node21",
            "desc": "部门副经理",
            "options": [{
                    "action": "ok",
                    "desc": "通过",
                    "nextnode": "node3?",
                    "brothernode": "node22"
                },
                {
                    "action": "no",
                    "desc": "拒绝",
                    "nextnode": "rejected"
                },
                {
                    "action": "back",
                    "desc": "打回",
                    "nextnode": "draft"
                }
            ]
        },
        {
            "name": "node22",
            "desc": "部门经理",
            "options": [{
                    "action": "ok",
                    "desc": "通过",
                    "nextnode": "node3?",
                    "brothernode": "node21"
                },
                {
                    "action": "no",
                    "desc": "拒绝",
                    "nextnode": "rejected"
                },
                {
                    "action": "back",
                    "desc": "打回",
                    "nextnode": "draft"
                }
            ]
        },
        {
            "name": "node3",
            "desc": "公司总经理",
            "options": [{
                    "action": "ok",
                    "desc": "通过",
                    "nextnode": "ended"
                },
                {
                    "action": "no",
                    "desc": "拒绝",
                    "nextnode": "rejected"
                },
                {
                    "action": "back",
                    "desc": "打回",
                    "nextnode": "draft"
                }
            ]
        },
        {
            "name": "rejected",
            "options": []
        },
        {
            "name": "ended",
            "options": []
        }
    ]
}
]]

local current = 1

-- 返回当前节点的可选项
function getoption(objson)
    local fj = json.decode(flowjson)
    local op = fj.nodes[current].options
    local opstr = json.encode(op)
    return opstr
end


-- 当前节点的动作处理
function actiondo(objson)
    local tb = json.decode(objson)
    local fj = json.decode(flowjson)
    local n = fj.nodes[current]

    print('记录已经做了什么action')
    print('-------------------------------------------------')
    -- 记录已经做了什么action    
    print(n.desc..' '..n.options[1].action..' 了')
    print('后面的下一个节点 '..n.options[1].nextnode)        


    print('根据情况往下个节点的具体人推单')
    print('-------------------------------------------------')
    -- 根据情况往下个节点推单    
    _, q=string.find(n.options[1].nextnode, '?')    

    if (q == nil)
    then
        -- 单节点
        push(fj, n.options[1], tb)
    else
        print('有多个兄弟节点 需要判断兄弟节点是否有审批完')
        print(n.options[1].brothernode)
        print('如果兄弟都批完了 开始往具体哪个人推单')

        push(fj, n.options[1], tb)
    end

    
    -------------------------------------------------------
    -- wxwork.send('这里发送的是企业微信内容')
    -- mail.send('这里发送的是邮件内容')

    return '由脚本返回的值: '..tb.billno
end

function push(fj, act, tb)
    if(act.nextnode=='ended')
    then
        print('结束了.')
        return
    end

    _, s=string.find(act.nextnode, '&&')
    if (s == nil)
    then
        -- 如果下个节点是单节点
        _, q=string.find(act.nextnode, '?')
        -- 判断是否需要等待兄弟节点
        if (q ~= nil)
        then
            -- 判断兄弟节点是否完成动作
            print('确认 '..act.brothernode..' 已经完成动作')
            
            print('开始往具体往 '..strings.trim(act.nextnode, "?")..' 推单') 
            for j, node in ipairs(fj.nodes) do
                if(node.name == strings.trim(act.nextnode, "?"))
                then
                    lookup.getDirectTagBoss(tb.creatorname, node.desc)
                end
            end 
        else
            print('开始往具体往 '..act.nextnode..' 推单')
            for j, node in ipairs(fj.nodes) do
                if(node.name == act.nextnode)
                then
                    lookup.getDirectTagBoss(tb.creatorname, node.desc)
                end
            end
            -- lookup.getDirectBoss(tb.creatorname)
            -- lookup.getAllBoss(tb.creatorname)
        end
    else
        -- 如果下个节点是多节点
        print('开始往具体往 '..act.nextnode..' 推单')
        local result = strings.split(act.nextnode, "&&")
        for i, v in ipairs(result) do
            for j, node in ipairs(fj.nodes) do
                if(node.name == v)
                then
                    lookup.getDirectTagBoss(tb.creatorname, node.desc)
                end
            end
        end
        -- lookup.getDirectBoss(tb.creatorname)
        -- lookup.getAllBoss(tb.creatorname)        
    end
end

function router(objson)
    -- 在此确定如何找人
    -- 在流程创建时就确定所有节点的具体人员
    
end
