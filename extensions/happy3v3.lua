--[[
	太阳神三国杀游戏模式扩展包·欢乐成双
	适用版本：V2 - 世界人权版（版本号：20131210）玉兔补丁（版本号：20131217）
	使用方法：
		将此扩展包放入游戏目录\extensions\文件夹中，重新启动太阳神三国杀，选择6人身份局模式。
		游戏开始选择武将后，会遇到是否进入“欢乐成三”模式的询问，点击“确定”即可开启此游戏模式。
]]--
module("extensions.happy3v3", package.seeall)
extension = sgs.Package("happy3v3")
--技能暗将
HappySkillAnjiang = sgs.General(extension, "HappySkillAnjiang", "god", 7, true, true, true)
--翻译信息
sgs.LoadTranslationTable{
	["happy3v3"] = "欢乐成三",
}
--[[****************************************************************
	游戏规则
]]--****************************************************************
--[[
	规则：位置固定
	内容：忠 - 反 - 忠 - 反- 忠 - 反
]]--
function Enterhappy3v3Mode(room, current)
	--欢迎界面
	room:doLightbox("$WelcomeTohappy3v3Mode", 3000)	--显示全屏信息特效
	local msg = sgs.LogMessage()
	msg.type = "$AppendSeparator"
	room:sendLog(msg) --发送提示信息：分割线
	msg.type = "#happy3v3ModeStart"
	room:sendLog(msg) --发送提示信息
	--确定六名玩家的位置
	local lord = room:getLord()
	local second = lord:getNextAlive()
	local third = second:getNextAlive()
	local forth = third:getNextAlive()
	local fifth = forth:getNextAlive()
	local sixth = fifth:getNextAlive()
	assert( sixth:getNextAlive():objectName() == lord:objectName() )
	--重置非主公角色的身份
	lord:setRole("loyalist")
	second:setRole("rebel")
	third:setRole("loyalist")
	forth:setRole("rebel")
	fifth:setRole("loyalist")
	sixth:setRole("rebel")
	room:setPlayerProperty(lord, "role", sgs.QVariant("loyalist"))
	room:changeHero(lord, lord:getGeneralName(), true, false, false, false)
	room:setPlayerProperty(second, "role", sgs.QVariant("rebel"))
	room:setPlayerProperty(third, "role", sgs.QVariant("loyalist"))
	room:setPlayerProperty(forth, "role", sgs.QVariant("rebel"))
	room:setPlayerProperty(fifth, "role", sgs.QVariant("loyalist"))
	room:setPlayerProperty(sixth, "role", sgs.QVariant("rebel"))
	room:updateStateItem()
	--重置AI
	room:resetAI(second)
	room:resetAI(third)
	room:resetAI(forth)
	room:resetAI(fifth)
	room:resetAI(sixth)	
	--启用专有规则
	local players = {lord, second, third, forth, fifth, sixth}
	room:acquireSkill(lord,"#HappyBalance3") --先手平衡规则
	for _,p in ipairs(players) do
		room:acquireSkill(p, "#HappyRewardAndPunish3") --击杀奖惩规则
		room:acquireSkill(p, "#HappyRewardAndPunish3Clear3")
		room:acquireSkill(p, "#HappyVictory3") --胜负判定规则
	end
end
HappyStart3 = sgs.CreateTriggerSkill{
	name = "#HappyStart3",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.GameStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:getMode() == "06p" then
			local tag = room:getTag("Inhappy3v3Mode")
			if not tag:toBool() then
				if player:getState() ~= "robot" then
					if room:askForSkillInvoke(player, "HappyStart3") then
						room:setTag("Inhappy3v3Mode", sgs.QVariant(true))
						Enterhappy3v3Mode(room, player)
					end
				end
			end
		end
	end,
	priority = 10,
}
--添加规则
HappySkillAnjiang:addSkill(HappyStart3)
--翻译信息
sgs.LoadTranslationTable{
	["HappyStart3"] = "进入“欢乐成三”模式",
	["$WelcomeTohappy3v3Mode"] = "太阳神三国杀·欢乐成三模式",
	["#happy3v3ModeStart"] = "欢迎进入“欢乐成三”游戏模式！",
}
--[[
	规则：先手平衡
	内容：先手玩家起始少摸一张牌
	备注：原本应使用sgs.DrawInitialCards时机改变起始摸牌数，但启用此规则时该时机已过，
		所以改为sgs.DrawNCards时机改变第一次摸牌阶段摸牌数。
]]--
HappyBalance3 = sgs.CreateTriggerSkill{
	name = "#HappyBalance3",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.EventPhaseStart,sgs.DrawNCards},
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        if player:getMark("happy3v3BalanceRule") == 0 then
            if event == sgs.DrawNCards then
		
			    room:setPlayerMark(player, "happy3v3BalanceRule", 1)
			
			    local msg = sgs.LogMessage()
			    msg.type = "#BalanceRule"
			    msg.from = player
			    room:sendLog(msg) --发送提示信息
			    local n = data:toInt() - 1
			    data:setValue(n)
			end
		end
	end,
	
}
--添加规则
HappySkillAnjiang:addSkill(HappyBalance3)
--翻译信息
sgs.LoadTranslationTable{
	["#BalanceRule"] = "先手平衡规则：%from 第一次摸牌时将少摸一张牌",
}
--[[
	规则：击杀奖惩
	内容：1、击杀队友不会受到惩罚；
		2、击杀队友、敌人不会得到奖励；
		3、阵亡一方存活队友摸一张牌。
]]--
HappyRewardAndPunish3 = sgs.CreateTriggerSkill{
	name = "#HappyRewardAndPunish3",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.BuryVictim},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		room:setTag("SkipNormalDeathProcess", sgs.QVariant(true))
		local friends = {}
		local alives = room:getAlivePlayers()
		local role = player:getRole()
		--主公阵亡找忠臣
		if role == "lord" then
			for _,p in sgs.qlist(alives) do
				if p:getRole() == "loyalist" then
					table.insert(friends, p)
				end
			end
		--忠臣阵亡找主公/忠臣
		elseif role == "loyalist" then
			for _,p in sgs.qlist(alives) do
				if p:getRole() == "lord" then
					table.insert(friends, p)
				elseif p:getRole() == "loyalist" then --这里考虑了“焚心”等改变身份的技能的影响
					table.insert(friends, p)
				end
			end
		--反贼阵亡找反贼
		elseif role == "rebel" then
			for _,p in sgs.qlist(alives) do
				if p:getRole() == "rebel" then
					table.insert(friends, p)
				end
			end
		end
		--存活的队友摸一张牌
		if #friends > 0 then
			for _,friend in ipairs(friends) do
				room:drawCards(friend, 1, "HappyRewardAndPunish3")
			end
		end
	end,
	can_trigger = function(self, target)
		return ( target ~= nil )
	end,
	priority = 2,
}
HappyRewardAndPunish3Clear3 = sgs.CreateTriggerSkill{
	name = "#HappyRewardAndPunish3Clear3",
	frequency = sgs.Skill_Frequent,
	events = {sgs.BuryVictim},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		room:setTag("SkipNormalDeathProcess", sgs.QVariant(false))
	end,
	can_trigger = function(self, target)
		return ( target ~= nil )
	end,
	priority = -2,
}
extension:insertRelatedSkills("#HappyRewardAndPunish3", "#HappyRewardAndPunish3Clear3")
--添加规则
HappySkillAnjiang:addSkill(HappyRewardAndPunish3)
HappySkillAnjiang:addSkill(HappyRewardAndPunish3Clear3)
--翻译信息
sgs.LoadTranslationTable{
	["HappyRewardAndPunish3"] = "击杀奖惩",
}
--[[
	规则：胜负判定
	内容：1、主公阵亡，若有忠臣存活，则将忠臣升为主公
		2、主公阵亡，若无忠臣存活，则反贼胜利
		3、反贼阵亡，若无反贼存活，则主公和忠臣胜利
]]--
HappyVictory3 = sgs.CreateTriggerSkill{
	name = "#HappyVictory3",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.GameOverJudge},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		room:setTag("SkipGameRule", sgs.QVariant(true))
		local alives = room:getAlivePlayers()
		local role = player:getRole()
		if role == "loyalist" then
			for _,p in sgs.qlist(alives) do
				if p:getRole() == "loyalist" then
					player:setRole("loyalist")
					room:setPlayerProperty(player, "role", sgs.QVariant("loyalist"))
					p:setRole("lord")
					room:setPlayerProperty(p, "role", sgs.QVariant("loyalist"))
					return false
				end
			end
			room:gameOver("rebel")
		elseif role == "rebel" then
			for _,p in sgs.qlist(alives) do
				if p:getRole() == "rebel" then
					return false
				end
			end
			room:gameOver("loyalist+loyalist")
		end
	end,
	can_trigger = function(self, target)
		return ( target ~= nil )
	end,
	priority = 2,
}
--添加规则
HappySkillAnjiang:addSkill(HappyVictory3)
--[[****************************************************************
	系统控制
]]--****************************************************************
local generals = sgs.Sanguosha:getLimitedGeneralNames()
for _,name in ipairs(generals) do
	local general = sgs.Sanguosha:getGeneral(name)
	if general and not general:isTotallyHidden() then
		general:addSkill("#HappyStart3")
	end
end
