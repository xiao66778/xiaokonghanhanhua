local Translations = {
   --["这里填要替换的英文"] = "这里填中文",
    ["Tuff Guys | Dead Rails V1.5"] = "硬汉组 | 死亡铁轨 V1.5",
    ["Tuff Agsy"] = "硬汉阿奇",
    ["Important"] = "重要设置",
    ["Farm"] = "资源农场",
    ["Main"] = "主要设置",
    ["Items"] = "物品",
    ["Weapons"] = "武器",
    ["Teleports"] = "传送",
    ["Visuals"] = "视觉效果",
    ["Others"] = "其他",
    ["Join Discord To Know Updates!"] = "加入Discord获取更新信息！",
    ["Stay updated with the latest features and fixes"] = "随时了解最新功能与修复内容",
    ["Copy Invite"] = "复制邀请链接",
    ["Visit YouTube"] = "访问YouTube",
    ["Main Functions"] = "主要功能",
    ["Weld Anywhere Button"] = "随处焊接按钮",
    ["高级滚筒"] = "高级滚筒",
    ["Notify Unicorn Spawns"] = "通知独角兽刷新",
    ["Anti Void"] = "防虚空坠落",
    ["NoClip"] = "穿墙模式",
    ["Farming"] = "资源收集",
    ["Auto Bonds"] = "自动获取债券",
    ["Auto Win"] = "自动获胜",
    ["Auto Complete Scorched Earth"] = "自动完成焦土行动",
    ["Instant Kill"] = "秒杀",
    ["Gun Aura"] = "枪械光环",
["Auto Reload"] = "自动装弹",
["NPC Lock"] = "NPC锁定",
["Melee"] = "近战武器",
["Swing Speed"] = "挥击速度",
["Fast Melee"] = "快速近战",
["Select Item to Bring"] = "选择要传送的物品",
["Bring Item"] = "传送物品",
["Auto Collect MoneyBags"] = "自动收集钱袋",
["Auto Collect Guns"] = "自动收集枪支",
["Auto Pickup Melees"] = "自动拾取近战武器",
["Auto Collect Bonds"] = "自动收集债券",
["Auto Pickup Snake Oil & Bandages"] = "自动拾取蛇油和绷带",
["Auto Collect Ammos"] = "自动收集弹药",
["Rules Code"] = "规则码",
["Infinite Yield"] = "无限产出",
["Icon"] = "图标",
["Get"] = "获取",
["Custom Marker"] = "自定义标记",
["Time ESP"] = "时间透视",
["Item ESP"] = "物品透视",
["Value ESP"] = "价值透视", 
["Ore ESP"] = "矿石透视",
["Camera"] = "摄像机",
["Unlock 3rd Person"] = "解锁第三人称",
["Search Content"] = "搜索内容",
["FullBright"] = "全亮度",
["No Fog"] = "无雾效果",
["ESP Features"] = "透视功能",
["Fuel ESP Items"] = "燃料物品透视",
["Show Code Bank"] = "显示代码库",
["Submission Time"] = "提交时间",
["TP to Sterling"] = "传送至斯特林",
["TP to Outlaw Camp"] = "传送至亡命徒营地",
["TP to Tesla"] = "传送至特斯拉",
["TP to Castle"] = "传送至城堡",
["TP to End"] = "传送至终点",
["TP to Fort"] = "传送至要塞",
["Base's"] = "基地",
["Towns"] = "城镇",
["TP to Train"] = "传送至火车",
["Tp to Outlaw Camp"] = "传送至亡命徒营地",
["Instant Prompt"] = "即时提示"
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
--这下面填加载外部脚本
loadstring(game:HttpGet("https://raw.githubusercontent.com/TuffGuys/TuffGuys/refs/heads/main/Loader"))()


end)

if not success then
    warn("加载失败:", err)
end
