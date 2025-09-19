--Kenny泛滥外部汉化脚本我的哔站UID:1531514159（删了这个死妈死爹死全家）
local Translations = {
   --["这里填要替换的英文"] = "这里填中文",
["SpiderXHub🕷|Dead Rails"] = "SpiderXHub🕷|死铁轨",
["sub"] = "晓空汉化",
["Aim-Bot"] = "自瞄",
["Tip location"] = "提示位置",
["Teleport finish"] = "传送完成",
["Teleport start"] = "传送开始",
["Teleport player"] = "传送玩家",
["Esp Setting 🌬"] = "ESP设置 🌬",
["[ESP] Player"] = "[ESP] 玩家",
["[ESP] Mods"] = "[ESP] 模组",
["[ESP] Item"] = "[ESP] 物品",
["Esp Information:"] = "ESP信息:",
["With Esp you can see objects outside the vault 🌬"] = "使用ESP您可以看到保险库外的物体 🌬",
["Good Aim-Bot😊"] = "好的自瞄😊",
["Aim Informations:"] = "瞄准信息:",
["This is Best-Aim-bot😊"] = "这是最佳自瞄😊",
["6 [Best] 😊"] = "6 [最佳] 😊",
["Bring item/Auto Farm♂"] = "携带物品/自动农场♂",
["Bring All item"] = "携带所有物品",
["Bring All item (Cui)"] = "携带所有物品(Cui)",
["Auto Collect bonds"] = "自动收集债券",
["Auto Collect bonds (Cui)"] = "自动收集债券(Cui)",
["Player Functions"] = "玩家功能",
["SpeedWalk"] = "速度行走",
["Jump Power"] = "跳跃力量",
["Inf Jump"] = "无限跳跃",
["Neclip"] = "穿墙",
["Fly V3"] = "飞行 V3",
["Removing delay"] = "移除延迟",
["Unk Function"] = "未知功能",
["Spectate Player V1"] = "观察玩家 V1",
["Spectate Player V2"] = "观察玩家 V2",
["Information Script"] = "信息脚本",
["Lma/SpidersScriptRB"] = "Lma/SpidersScriptRB",
["SpidersScriptRB | Community"] = "SpidersScriptRB | 社区",
["Lma/RobitorExploitInfo"] = "Lma/RobitorExploitInfo",
["Robbox Info Exploit | Community"] = "Robbox 信息利用 | 社区",
["Cosaprenin Calventral"] = "Cosaprenin Calventral",
["@3bitmetric: dllc_distrib_char=RegionsWeb @confessions"] = "@3bitmetric: dllc_distrib_char=RegionsWeb @confessions",
["Script Local"] = "脚本本地化",
["8-current: Convo 2G+ функций"] = "8-当前: Convo 2G+ 功能",
["Script Info"] = "脚本信息",
["1/security script until become popularID"] = "1/安全脚本直到变得流行ID",
["Esp Setting 00"] = "ESP设置 00",
["Good Aim-Bot"] = "优质自瞄😊",
["Aim-bot"] = "自瞄",
["Aim Information:"] = "瞄准信息:",
["This is Beat Aim-bot"] = "这是最佳自瞄😊",
["ESP信息:"] = "ESP信息:",
["With Esp, you can see objects outside the walls 😊!"] = "使用ESP，您可以看到墙外的物体 😊!",
["Bring item/Auto Farm"] = "携带物品/自动农场♂",
["跳跃力量"] = "跳跃力量",
["inf jump"] = "无限跳跃",
["Noclip"] = "穿墙模式",
["飞行 V3"] = "飞行 V3",
["信息脚本"] = "信息脚本",
["t.me/SpiderScriptRB"] = "t.me/SpiderScriptRB",
["SpiderScriptRB | Community"] = "SpiderScriptRB | 社区",
["Join"] = "加入",
["t.me/RobloxExploitInfo"] = "t.me/RobloxExploitInfo",
["Roblox Info Exploit | Community"] = "Roblox信息利用 | 社区",
["Cosдатели Скрипта!"] = "脚本创作者!",
["@StalkerHick @itz_qlsixll @purpleguycoyote @cendicateee"] = "@StalkerHick @itz_qlsixll @purpleguycoyote @cendicateee",
["脚本本地化"] = "脚本本地化",
["В скрипте более 25+ функций!"] = "脚本包含25+功能!",
["脚本信息"] = "脚本信息",
["I hope, my script will become popular.D"] = "我希望我的脚本会变得流行.D",
["Main"] = "主要",
["Player"] = "玩家",
["Auto Farm/Bring item"] = "自动农场/携带物品",
["Aimbot [Best]"] = "自瞄 [最佳] 😊",
["Visual"] = "视觉",
["Teleport"] = "传送"
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-Script/refs/heads/main/SpiderXHub%20New.txt"))()


end)

if not success then
    warn("加载失败:", err)
end
