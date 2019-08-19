
module("extensions.techkill", package.seeall)
extension = sgs.Package("techkill")

weile = sgs.General(extension, "weile", "god", 3)
houdebang = sgs.General(extension, "houdebang", "god", 4)
lawaxi = sgs.General(extension, "lawaxi", "god", 3)
huangminglong = sgs.General(extension, "huangminglong", "god", 4)
msjuli = sgs.General(extension, "msjuli", "god", 4,false, true)
baichuan = sgs.General(extension, "baichuan", "god", 3)
nuobeier = sgs.General(extension, "nuobeier", "god", 4)
daoerdun = sgs.General(extension, "daoerdun", "god", 3)
menjieliefu = sgs.General(extension, "menjieliefu", "god", 3)
david = sgs.General(extension, "david", "god", 4)
shele = sgs.General(extension, "shele", "god", 4)
mulis = sgs.General(extension, "mulis", "god", 4)
nash = sgs.General(extension, "nash", "god", 3)
fuke = sgs.General(extension, "fuke", "god", 3, true, true)
--beir = sgs.General(extension, "beir", "god", 3)
mitena = sgs.General(extension, "mitena", "god", 4,false)
wosenklk = sgs.General(extension, "wosenklk", "god", 3)
ndgirl = sgs.General(extension, "ndgirl", "god", 3,false)
jialowa = sgs.General(extension, "jialowa", "god", 4)
yuanlongping = sgs.General(extension, "yuanlongping", "god", 3)
fiman = sgs.General(extension, "fiman", "god", 3)
zuchongzhi = sgs.General(extension, "zuchongzhi", "god", 3, true, true)
akubr = sgs.General(extension, "akubr", "god", 3)
borzm = sgs.General(extension, "borzm", "god", 3)
tesla = sgs.General(extension, "tesla", "god", 3)
yinssk = sgs.General(extension, "yinssk", "god", 4)
eldes = sgs.General(extension, "eldes", "god", 3, true, true)
kaipl = sgs.General(extension, "kaipl", "god", 4,true, true)
stevens = sgs.General(extension, "stevens", "god", 4)
hodgkin = sgs.General(extension, "hodgkin", "god", 3, false,true)
hesmu = sgs.General(extension, "hesmu", "god", 3,true,true)
karvin = sgs.General(extension, "karvin", "god", 3,true,true)
morton = sgs.General(extension, "morton", "god", 3,true,true)
ebhaus = sgs.General(extension, "ebhaus", "god", 4,true,true)
lipum = sgs.General(extension, "lipum", "god", 4,true,true)
bonuli = sgs.General(extension, "bonuli", "god", 4,true,true)
boer = sgs.General(extension, "boer", "god", 3,true,true)
keluolf = sgs.General(extension, "keluolf", "god", 3,true,true)
adamsmi = sgs.General(extension, "adamsmi", "god", 3,true,true)
lidaoyuan = sgs.General(extension, "lidaoyuan", "god", 3,true,true)
chenyinke = sgs.General(extension, "chenyinke", "god", 3,true,true)
linhuiyin = sgs.General(extension, "linhuiyin", "god", 3,false,true)
adlovelace = sgs.General(extension, "adlovelace", "god", 3,false,true)
morgan = sgs.General(extension, "morgan", "god", 3,true,true)
zhangailin = sgs.General(extension, "zhangailin", "god", 4, false, true)
sunwu = sgs.General(extension, "sunwu", "god", 4, true, true)

local science = {"weile","houdebang","lawaxi","huangminglong","msjuli","baichuan","nuobeier","daoerdun","menjieliefu","david","shele","mulis","nash","fuke","mitena","wosenklk","ndgirl","jialowa","yuanlongping","fiman","zuchongzhi","akubr","borzm","tesla","yinssk","eldes","kaipl","stevens","hodgkin","hesmu","karvin","morton","ebhaus","lipum","bonuli","boer","keluolf","adamsmi","lidaoyuan","chenyinke","linhuiyin","adlovelace","morgan","zhangailin"}

weatherer = sgs.General(extension, "weatherer", "god", 4, false, true, false)
tester = sgs.General(extension, "tester", "god", 4, false, true, false)

function targetsTable2QList(thetable)
	local theqlist = sgs.PlayerList()
	for _, p in ipairs(thetable) do
		theqlist:append(p)
	end
	return theqlist
end

------------------
--卡牌部分
------------------

acid = sgs.CreateBasicCard{
	name = "acid",
	class_name = "Acid",
	subtype = "attack_card",
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Heart,
	number = 13,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			if #targets < 1 + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, sgs.Self, self) then
				return sgs.Self:distanceTo(to_select)<= sgs.Self:getAttackRange() + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_DistanceLimit,sgs.Self, self)
			end
		end
	end,
	available = function(self, player)
		local newanal = sgs.Sanguosha:cloneCard("acid", sgs.Card_NoSuit, 0)
		if player:isCardLimited(newanal, sgs.Card_MethodUse) or player:isProhibited(player, newanal) then return false end
		return player:usedTimes("Acid") + player:usedTimes("Alkali") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, player , newanal) or (player:getWeapon() and player:getWeapon():isKindOf("aciddd")) or self:getSkillName() == "bnrepeat"
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local datacid = sgs.QVariant()
		datacid:setValue(effect.from)
		local damage = sgs.DamageStruct()
		damage.from = effect.from
		damage.to = effect.to
		damage.card = self
		if self:hasFlag("phjiwin") then
			room:damage(damage)
		else
			local card = room:askForCard(effect.to, "Alkali", "@alkalitoacid", datacid, sgs.Card_MethodResponse)
			if not card then
				room:damage(damage)
			end
		end
	end,
}

alkali = sgs.CreateBasicCard{
	name = "alkali",
	class_name = "Alkali",
	subtype = "attack_card",
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 13,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			if #targets < 1 + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, sgs.Self, self) then
				return sgs.Self:distanceTo(to_select)<= sgs.Self:getAttackRange() + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_DistanceLimit,sgs.Self, self)
			end
		end
	end,
	available = function(self, player)
		local newanal = sgs.Sanguosha:cloneCard("alkali", sgs.Card_NoSuit, 0)
		if player:isCardLimited(newanal, sgs.Card_MethodUse) or player:isProhibited(player, newanal) then return false end
		return player:usedTimes("Alkali") + player:usedTimes("Acid") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, player , newanal) or (player:getWeapon() and player:getWeapon():isKindOf("alkalidd")) or self:getSkillName() == "bnrepeat"
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local datacid = sgs.QVariant()
		datacid:setValue(effect.from)
		local damage = sgs.DamageStruct()
		damage.from = effect.from
		damage.to = effect.to
		damage.card = self
		if self:hasFlag("phjiwin") then
			room:damage(damage)
		else
			local card = room:askForCard(effect.to, "Acid", "@acidtoalkali", datacid, sgs.Card_MethodResponse)
			if not card then
				room:damage(damage)
			end
		end
	end,
}

acidfly = sgs.CreateTrickCard{
	name = "acidfly",
	class_name = "acidfly",
	subtype = "AOE",
	subclass = sgs.LuaTrickCard_TypeAOE,
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Heart,
	number = 12,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local datacid = sgs.QVariant()
		datacid:setValue(effect.from)
		local card = room:askForCard(effect.to, "Alkali", "@alkalitoacidfly", datacid, sgs.Card_MethodResponse)
		if not card then
			local damage = sgs.DamageStruct()
			damage.from = effect.from
			damage.to = effect.to
			damage.card = self
			room:damage(damage)
		end
	end,
}

alkalifly = sgs.CreateTrickCard{
	name = "alkalifly",
	class_name = "alkalifly",
	subtype = "AOE",
	subclass = sgs.LuaTrickCard_TypeAOE,
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 12,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local datacid = sgs.QVariant()
		datacid:setValue(effect.from)
		local card = room:askForCard(effect.to, "Acid", "@acidtoalkalifly", datacid, sgs.Card_MethodResponse)
		if not card then
			local damage = sgs.DamageStruct()
			damage.from = effect.from
			damage.to = effect.to
			damage.card = self
			room:damage(damage)
		end
	end,
}

c6 = sgs.CreateBasicCard{
	name = "c6",
	class_name = "C6",
	subtype = "recover_card",
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Diamond,
	number = 11,
	about_to_use = function(self, room, use)
		local log = sgs.LogMessage()
		log.from = use.from
		use.to:append(use.from)
		log.to = use.to
		log.type = "#UseCard"
		log.card_str = use.card:toString()
		room:sendLog(log)
		local thread = room:getThread()
		local data = sgs.QVariant()
		data:setValue(use)
		thread:trigger(sgs.PreCardUsed, room, use.from, data)
		card_use = data:toCardUse()
		local reason = sgs.CardMoveReason()
		reason.m_reason = sgs.CardMoveReason_S_REASON_USE
		reason.m_playerId = use.from:objectName()
		if use.to:length() == 1 then
			reason.m_targetId = card_use.to:at(0):objectName()
		end
		reason.m_skillName = self:objectName()
		local move = sgs.CardsMoveStruct()
		move.card_ids:append(card_use.card:getId())
		move.from = use.from
		move.from_place = sgs.Player_PlaceHand
		move.to_place = sgs.Player_PlaceTable
		room:moveCardsAtomic(move, true)
		thread:trigger(sgs.CardUsed, room, use.from, data)
		thread:trigger(sgs.CardFinished, room, use.from, data)
	end,
	on_effect = function(self, effect)
		local source = effect.to
		local room = source:getRoom()
		if source:isWounded() then
			local recover = sgs.RecoverStruct()
			recover.who = source
			room:recover(source, recover)
		else
			room:drawCards(source,1)
		end
	end,
}

k2cr2o7 = sgs.CreateTrickCard{
	name = "k2cr2o7",
	class_name = "k2cr2o7",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 10,
	on_use = function(self, room, source, targets)
		room:cardEffect(self, source, source)
	end,
	on_effect = function(self, effect)
		effect.from:getRoom():setPlayerFlag(effect.to, "cr2o7")
		effect.to:addMark("@mno4")
	end,

}

k2cr2o7Clear = sgs.CreateTriggerSkill{
	name = "k2cr2o7Clear",
	frequency = sgs.Skill_Compulsory, 
	global = true,
	events = {sgs.EventLoseSkill,sgs.ConfirmDamage}, 
	on_trigger = function(self, event, player, data)
		if event == sgs.ConfirmDamage then
			local damage = data:toDamage()
			local card = damage.card
			if card then
				if not damage.from:hasFlag("cr2o7") then return false end
				if string.lower(card:getClassName()) == "acid" or string.lower(card:getClassName()) == "acidfly" then 
					damage.damage = damage.damage + 1
					data:setValue(damage)
				end
			end
		end
		if data:toString() == self:objectName() and event == sgs.EventLoseSkill and player:hasFlag("cr2o7") then
			player:getRoom():setPlayerFlag(player, "-cr2o7")
		end
		return false
	end,
}

wangshui = sgs.CreateTrickCard{
	name = "wangshui",
	class_name = "Wangshui",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() and #targets == 0 then
			return not (to_select:getEquips():length()==0 and to_select:isKongcheng())
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()	
		local cards = effect.to:getHandcards()
		local a = 0
		room:showAllCards(effect.to)
		for _,equip in sgs.qlist(effect.to:getEquips()) do
			cards:append(equip)
		end
		local card_id = room:askForCardChosen(effect.to, effect.to, "he", "wangshui")
		for _,dis in sgs.qlist(cards) do
			if dis:getSuit() == sgs.Sanguosha:getCard(card_id):getSuit() then
				room:throwCard(dis, effect.to, effect.from)
				a=a+1
			end
		end
		if a>1 then
			local damage = sgs.DamageStruct()
			damage.from = effect.from
			damage.to = effect.from
			room:damage(damage)
		end
	end,
}

lengning = sgs.CreateTrickCard{
	name = "lengning",
	class_name = "Lengning",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() and #targets == 0 then
			return not (to_select:getEquips():length()==0 and  to_select:isKongcheng())
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()	
		local card_id = room:askForCardChosen(effect.from, effect.to, "he", "lengning")
		room:showCard(effect.to, card_id, effect.from)
		local ln = sgs.IntList()
		ln:append(card_id)
		local moveA = sgs.CardsMoveStruct()
		moveA.card_ids = ln
		if sgs.Sanguosha:getCard(card_id):isKindOf("EquipCard") then
			moveA.to = effect.from
			moveA.to_place = sgs.Player_PlaceHand
		else
			moveA.to_place = sgs.Player_DrawPile
		end
		room:moveCardsAtomic(moveA, false)
	end,
}

zuhua = sgs.CreateTrickCard{
	name = "zuhua",
	class_name = "Zuhua",
	subtype = "delayed_trick",
	subclass = sgs.LuaTrickCard_TypeDelayedTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0
		end
	end,
	on_effect = function(self, effect)
		local judge = sgs.JudgeStruct()
		local room = effect.to:getRoom()
		judge.pattern = ".|diamond"
		judge.good = true
		judge.reason = self:objectName()
		judge.who = effect.to
		room:judge(judge)
		if not judge:isGood() then
			judge.who:turnOver()
			room:obtainCard(judge.who, judge.card)
		end
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_NATURAL_ENTER, effect.to:objectName())
		room:throwCard(self, reason, nil)
	end,
}

sizao = sgs.CreateTrickCard{
	name = "sizao",
	class_name = "Sizao",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0
		end
	end,
	on_effect = function(self, effect)
		local room = effect.to:getRoom()
		local win = true
		local cards = ""
		local card = room:askForCard(effect.to, "Acid,Alkali", "@sizao_start", sgs.QVariant(), sgs.Card_MethodResponse)
		if card then
			win=false
			cards = card:getClassName()
			for i = 1,1000,1 do
				local carda = room:askForCard(effect.from, cards, "@sizao_ask"..cards, sgs.QVariant(), sgs.Card_MethodResponse)
				if carda then
					win = true 
				else
					break
				end
				local cardb = room:askForCard(effect.to, cards, "@sizao_ask"..cards, sgs.QVariant(), sgs.Card_MethodResponse)
				if cardb then
					win = false
				else
					break
				end
			end
		end
		local damage = sgs.DamageStruct()
		if not win then
			damage.from = effect.to
			damage.to = effect.from
		else
			damage.from = effect.from
			damage.to = effect.to
		end
		room:damage(damage)
	end,
}

edta_trigger = sgs.CreateTriggerSkill{
	name = "edta_trigger", 
--之所以不用sgs.GameStart是因为会闪退
	events = {sgs.TurnStart}, 
	can_trigger = function(self, target)
		return target
	end,
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		if event == sgs.TurnStart then
			local alives = room:getAlivePlayers()
			for _,p in sgs.qlist(alives) do
				if not p:hasSkill("edta_vs") then
					--用player:acquireSkill()可获得技能又令右下角不显示技能
					p:acquireSkill("edta_vs")
				end
			end
		end
        return false
	end, 
	priority = 3
}

edta_vs = sgs.CreateViewAsSkill{ 
	name = "edta_vs",
	n = 0,
	view_as = function(self, cards)
		--并不视为任何卡牌，仅仅是获得出牌权利而已
		return nil
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_nullification = function(self, player)
		local hcds = player:getHandcards()
		if hcds:length() > 0 then
			for _,cd in sgs.qlist(hcds) do
				if cd:objectName() == "edta" then
					return true
				end
			end
		end
	end,
}

edta = sgs.CreateTrickCard{
	name = "edta",
	class_name = "edta",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		return false
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
	end,
}

laman = sgs.CreateTrickCard{
	name = "laman",
	class_name = "Laman",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0 and not to_select:isKongcheng()
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local ids = effect.to:handCards()
		local dp = sgs.QVariant()
		dp:setValue(effect.to)
		local numb={}
		room:showAllCards(effect.to, effect.from)
		for _,cd in sgs.qlist(ids) do
			if not table.contains(numb,sgs.Sanguosha:getCard(cd):getNumberString()) then
				table.insert(numb,sgs.Sanguosha:getCard(cd):getNumberString())
			end
		end
		local choice = room:askForChoice(effect.from, "laman", table.concat(numb, "+"),dp)
		for _,cad in sgs.qlist(ids) do
			if sgs.Sanguosha:getCard(cad):getNumberString() == choice then
				local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_THROW, effect.to:objectName(), "", "laman", "")
				room:throwCard(sgs.Sanguosha:getCard(cad), reason, effect.to, effect.from)
			end
		end
	end,
}

ejump = sgs.CreateTrickCard{
	name = "ejump",
	class_name = "ejump",
	subtype = "special_trick",
	subclass = sgs.LuaTrickCard_TypeNormal,
	target_fixed = false,
	can_recast = true,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select) 
		if #targets < 2 then
			if to_select:objectName() == sgs.Self:objectName() then return false end
			local emptylist = sgs.PlayerList()
			if #targets > 0 then
				local target = targets[#targets]
				--[[local siblings = sgs.Self:getAliveSiblings()
				local last
				for _,p in sgs.qlist(siblings) do
					if p:getSeat() == target:getSeat() then
						if last and to_select:getSeat() == last:getSeat() then
							return true
						end
					elseif p:getSeat() == to_select:getSeat() then
						if last and target:getSeat() == last:getSeat() then
							return true
						end
					end
					last = p
				end]]--
				return (to_select:getSeat() == math.mod(target:getSeat(),sgs.Self:aliveCount())+1 or target:getSeat() == math.mod(to_select:getSeat(),sgs.Self:aliveCount())+1) and (to_select:getMark("@brjumptarget") + target:getMark("@brjumptarget") < 2 or self:getSkillName() == "bryueqian")
			else
				return true
			end
		end
		return false
	end,
	feasible = function(self, targets)
		return #targets == 2 or #targets == 0
	end,
	about_to_use = function(self, room, use)
		if use.to:isEmpty() then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_RECAST, use.from:objectName())
			reason.m_skillName = self:objectName()
			room:moveCardTo(self, use.from, nil, sgs.Player_DiscardPile, reason)
			use.from:broadcastSkillInvoke("@recast")

			local log = sgs.LogMessage()
			log.type = "$MoveToDiscardPile"
			log.from = use.from
			log.card_str = use.card:toString()
			room:sendLog(log)
			use.from:drawCards(1)
		else
			local log = sgs.LogMessage()
			log.from = use.from
			log.to = use.to
			log.type = "#UseCard"
			log.card_str = use.card:toString()
			room:sendLog(log)
			local thread = room:getThread()
			local data = sgs.QVariant()
			local victim = use.to:at(1)
			if use.to:at(1):getSeat() ~= use.to:at(0):getSeat() + 1 then victim = use.to:at(0) end
			use.to:removeOne(victim)
			data:setValue(use)
			thread:trigger(sgs.PreCardUsed, room, use.from, data)
			card_use = data:toCardUse()
		--	IOoutput("pre judge id")
			if card_use.card:getId() and not(card_use.card:isVirtualCard() and card_use.card:getSubcards():length() == 0) then
			--	IOoutput("judged id")
				local move = sgs.CardsMoveStruct()
				move.card_ids:append(card_use.card:getId())
				move.from = use.from
				move.from_place = sgs.Player_PlaceHand
				move.to_place = sgs.Player_PlaceTable
				room:moveCardsAtomic(move, true)
			end
			thread:trigger(sgs.CardUsed, room, use.from, data)
			thread:trigger(sgs.CardFinished, room, use.from, data)
		end
	end,
	on_effect = function(self, effect)
		local p
		local source = effect.from
		local room = source:getRoom()
		while ((not p) or p:objectName()~=effect.to:objectName()) do
			p = source:getNext()
			room:swapSeat(source,p)
			if p:objectName()==effect.to:objectName() then
			end
		end
	end,
}

jieziq = sgs.CreateTrickCard{
	name = "jieziq",
	class_name = "Jieziq",
	subtype = "delayed_trick",
	subclass = sgs.LuaTrickCard_TypeDelayedTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	movable = true,
	number = 11,
	filter = function(self, targets, to_select)
		return #targets == 0
	end,
	on_effect = function(self, effect)
		local judge = sgs.JudgeStruct()
		local room = effect.to:getRoom()
		judge.pattern = ".|.|12~13"
		judge.good = false
		judge.reason = self:objectName()
		judge.who = effect.to
		room:judge(judge)
		if not judge:isGood() then
			room:setPlayerMark(effect.to,"poisoned",1)
			for _,p in sgs.qlist(room:getAllPlayers()) do
				if p:getSeat() == math.mod(effect.to:getSeat(),room:alivePlayerCount())+1 or effect.to:getSeat() == math.mod(p:getSeat(),room:alivePlayerCount())+1 then
					room:setPlayerMark(p,"poisoned",1)
				end
			end
			for _,pe in sgs.qlist(room:getAllPlayers()) do
				if pe:getMark("poisoned") > 0 then
					room:setPlayerMark(pe,"poisoned",0)
					room:loseHp(pe)
				end
			end
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_NATURAL_ENTER, effect.to:objectName())
			room:throwCard(self, reason, nil)
		else
			--[[
			local move2 = sgs.CardsMoveStruct()
			move2.card_ids:append(self:getEffectiveId())
			move2.to_place = sgs.Player_PlaceJudge
			for _,p in sgs.qlist(room:getAllPlayers()) do
				if p:getSeat() == math.mod(effect.to:getSeat(),room:alivePlayerCount())+1 then
					move2.to = p
				end
			end
			room:moveCardsAtomic(move2, false)
			]]--
			self.on_nullified(self, effect.to)
		end
	end,
}

zhihuanfy = sgs.CreateTrickCard{
	name = "zhihuanfy",
	class_name = "Zhihuanfy",
	subtype = "global_effect",
	subclass = sgs.LuaTrickCard_TypeGlobalEffect,
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 12,
	on_use = function(self, room, source, targets)
		source:drawCards(1)
		for _, target in ipairs(targets) do
			room:cardEffect(self, source, target)
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local datacid = sgs.QVariant()
		datacid:setValue(effect.from)
		if not effect.to:isNude() then
			local card = room:askForExchange(effect.to, "zhihuanfy", 1,1, true, "@zhihuanask")
			for _,p in sgs.qlist(room:getAllPlayers()) do
				if p:getSeat() == math.mod(effect.to:getSeat(),room:alivePlayerCount())+1 then
					local move2 = sgs.CardsMoveStruct()
					move2.card_ids:append(card:getEffectiveId())
					move2.to = p
					move2.to_place = sgs.Player_PlaceHand
					room:moveCardsAtomic(move2, false)
				end
			end
		end
	end,
}

fireup = sgs.CreateTrickCard{
	name = "fireup",
	class_name = "Fireup",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0 and (not to_select:isNude())
		end
		return false
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:setTag("fireupto", sgs.QVariant(effect.to:objectName()))
		local suit = room:askForSuit(effect.from, "fireup")
		local log = sgs.LogMessage()
		log.type = "#ChooseSuit"
		log.from = effect.from
		local pattern = ""
		if suit == sgs.Card_Spade then
			suit = "spade"
		elseif suit == sgs.Card_Club then
			suit = "club"
		elseif suit == sgs.Card_Heart then
			suit = "heart"
		else
			suit = "diamond"
		end
		log.arg = suit
		room:sendLog(log)
		pattern = ".|"..suit
		local dis = room:askForCard(effect.to, pattern, "@fireupask:"..suit..":"..effect.from:objectName(), sgs.QVariant(), sgs.Card_MethodDiscard)
		if not dis then
			room:damage(sgs.DamageStruct(self, effect.from, effect.to, 1, sgs.DamageStruct_Fire))
		end
	end,
}

yimi = sgs.CreateTrickCard{
	name = "yimi",
	class_name = "Yimi",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:setPlayerCardLimitation(effect.to, "use,response", ".|.|.|hand$1", true)
		room:setPlayerMark(effect.to,"@yimi",1)
		local skill = sgs.Sanguosha:getTriggerSkill("yimiclear")
		room:getThread():addTriggerSkill(skill)
	end
}

yimiclear = sgs.CreateTriggerSkill{
	name = "yimiclear",  
	frequency = sgs.Skill_Compulsory, 
	events = {sgs.DamageCaused,sgs.EventPhaseChanging, sgs.Death},  
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		if event == sgs.DamageCaused then
			local damage = data:toDamage()
			if damage.to:getMark("@yimi") > 0 then
				room:removePlayerCardLimitation(damage.to, "use,response", ".|.|.|hand$1")
				room:setPlayerMark(damage.to,"@yimi",0)
				room:getThread():trigger(sgs.NonTrigger, room, damage.to, sgs.QVariant("YimiClear"))
			end
		else
			if event == sgs.Death then
				local death = data:toDeath()
				if death.who:objectName() ~= player:objectName() then return false end
			else
				local change = data:toPhaseChange()
				if change.to ~= sgs.Player_NotActive then return false end
			end
			for _, p in sgs.qlist(room:getAlivePlayers()) do
				if p:getMark("@yimi") > 0 then
					room:removePlayerCardLimitation(p, "use,response", ".|.|.|hand$1")
					room:setPlayerMark(p, "@yimi", 0)
					room:getThread():trigger(sgs.NonTrigger, room, p, sgs.QVariant("YimiClear"))
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end,
}

hetongbh = sgs.CreateTrickCard{
	name = "hetongbh",
	class_name = "Hetongbh",
	subtype = "delayed_trick",
	subclass = sgs.LuaTrickCard_TypeDelayedTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0
		end
	end,
	on_effect = function(self, effect)
		local judge = sgs.JudgeStruct()
		local room = effect.to:getRoom()
		judge.pattern = ".|spade"
		judge.good = true
		judge.reason = self:objectName()
		judge.who = effect.to
		room:judge(judge)
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_NATURAL_ENTER, effect.to:objectName())
		room:throwCard(self, reason, nil)
		judge.who:skip(sgs.Player_Draw)
		room:obtainCard(judge.who, judge.card)
		if not judge:isGood() then
			room:setTag("htto", sgs.QVariant(judge.who:objectName()))
			for _, p in sgs.qlist(room:getOtherPlayers(judge.who)) do
				if (not judge.who:isKongcheng()) and (not p:isKongcheng()) then
					room:fillAG(judge.who:handCards())
					room:getThread():delay(1200)
					local toc = room:askForExchange(p, self:objectName(), 1,1, false, "@hetongaskprompt:"..judge.who:objectName(), true)
					if toc and (not judge.who:isKongcheng()) then
						local getc = room:askForAG(p, judge.who:handCards(), false, "hetongbh-get")
						room:obtainCard(judge.who, toc)
						room:obtainCard(p, getc)
					end
					room:clearAG()
				end
			end
		end
	end,
}

mianyy = sgs.CreateTrickCard{
	name = "mianyy",
	class_name = "Mianyy",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0
		end
	end,
	--about_to_use = function(self,room,card_use)
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local myyskill = sgs.Sanguosha:getTriggerSkill("mianyyclear")
		room:getThread():addTriggerSkill(myyskill)
		local player,to = effect.from,effect.to
		local skill_list = {}
		local Qingchenglist = to:getTag("Qingcheng"):toString():split("+") or {}
		for _,skill in sgs.qlist(to:getVisibleSkillList()) do
			if (not table.contains(skill_list,skill:objectName())) and not skill:isAttachedLordSkill() then
				table.insert(skill_list,skill:objectName())
			end
		end
		table.removeTable(skill_list,Qingchenglist)
		local skill_qc = ""
		if (#skill_list > 0) then
			local qv = sgs.QVariant()
			qv:setValue(player)
			skill_qc = room:askForChoice(player, "mianyy", table.concat(skill_list,"+"), qv)
		end
		if (skill_qc ~= "") then
			table.insert(Qingchenglist,skill_qc)
			to:setTag("Qingcheng",sgs.QVariant(table.concat(Qingchenglist,"+")))
			room:addPlayerMark(to, "Qingcheng" .. skill_qc)
			local log = sgs.LogMessage()
			log.from = player
			log.to:append(to)
			log.type = "#mianyylog"
			log.card_str = self:toString()
			log.arg = skill_qc
			room:sendLog(log)
			room:setPlayerMark(to, "@mianyymark", to:getMark("@mianyymark")+1)
			for _,p in sgs.qlist(room:getAllPlayers())do
				room:filterCards(p, p:getCards("he"), true)
			end
		end
	end,
}

mianyyclear = sgs.CreateTriggerSkill{
	name = "mianyyclear", 
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_RoundStart then
			local room = player:getRoom()
            local Qingchenglist = player:getTag("Qingcheng"):toString():split("+")
            if #Qingchenglist == 0 then return false end
            for _,skill_name in pairs(Qingchenglist)do
                room:setPlayerMark(player, "Qingcheng" .. skill_name, 0);
            end
            player:removeTag("Qingcheng")
			room:setPlayerMark(player, "@mianyymark", 0)
            for _,p in sgs.qlist(room:getAllPlayers())do
                room:filterCards(p, p:getCards("he"), true)
			end
        end
        return false
	end,
	can_trigger = function(self, target)
		return target
	end,
	priority = 6
}

zheshe = sgs.CreateBasicCard{
	name = "zheshe",
	class_name = "Zheshe",
	subtype = "defense_card",
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Heart,
	number = 13,
	filter = function(self, targets, to_select)
		if sgs.Self:property("zhesheto") then 
			local uselist = sgs.Self:property("zhesheto"):toString():split("+")
			if uselist and (not table.contains(uselist,to_select:objectName())) and #targets == 0 then
				return to_select:getSeat() == math.mod(sgs.Self:getSeat(),sgs.Self:aliveCount())+1 or sgs.Self:getSeat() == math.mod(to_select:getSeat(),sgs.Self:aliveCount())+1
			end
		end
	end,
	available = function(self, player)
		return false
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local use = effect.from:property("zhesheing"):toCardUse()
		room:setPlayerFlag(effect.to,"zheshetarget"..use.card:getEffectiveId())
	end,
}

zheshetri = sgs.CreateTriggerSkill{
	frequency = sgs.Skill_Compulsory,
	events = {sgs.TargetConfirming},
	name = "zheshetri",
	can_trigger = function(self, target)
		return target
	end,
	global = true,
	priority = 10,
	on_trigger=function(self,event,player,data)
		local room = player:getRoom()
		local use = data:toCardUse()
		if use.card and use.card:isKindOf("BasicCard") and use.to:contains(player) and use.from:objectName()~=player:objectName() then
			room:setPlayerProperty(player, "zhesheing", data)
			local tot = {}
			for _, p in sgs.qlist(use.to) do
				table.insert(tot,p:objectName())
			end
			
			room:setPlayerProperty(player, "zhesheto", sgs.QVariant(table.concat(tot,"+")))
			if room:askForUseCard(player, "Zheshe", "@zheshe:" .. use.from:objectName()..":"..use.card:objectName(), -1, sgs.Card_MethodUse) then
				use.to:removeOne(player)
				for _, p in sgs.qlist(room:getAlivePlayers()) do
					if p:hasFlag("zheshetarget"..use.card:getEffectiveId()) then
						room:setPlayerFlag(p,"-zheshetarget"..use.card:getEffectiveId())
						use.to:append(p)
						room:sortByActionOrder(use.to)
						data:setValue(use)
						room:getThread():trigger(sgs.TargetConfirming, room, p, data)
					end
				end
			end
			room:setPlayerProperty(player, "zhesheing" , sgs.QVariant())
			room:setPlayerProperty(player, "zhesheto", sgs.QVariant())
		end
	end
}

huiyibl = sgs.CreateTrickCard{
	name = "huiyibl",
	class_name = "Huiyibl",
	subtype = "AOE",
	subclass = sgs.LuaTrickCard_TypeAOE,
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Heart,
	number = 12,
	on_use = function(self, room, source, targets)
		room:setTag("Hybl",sgs.QVariant(1))
		local tag = sgs.QVariant()
		tag:setValue(source)
		room:setTag("Hyblp",tag)
		for _, target in ipairs(targets) do
			target:addQinggangTag(self)
			room:cardEffect(self, source, target)
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local num = room:getTag("Hybl"):toInt()
		local upp = room:getTag("Hyblp"):toPlayer()
		local card = room:askForCard(effect.to, ".|.|"..num.."~".."13|hand", "@huiyiaskbl", room:getTag("Hyblp"), sgs.Card_MethodResponse)
		if card then
			local tag = sgs.QVariant()
			tag:setValue(effect.to)
			room:setTag("Hyblp",tag)
			room:setTag("Hybl",sgs.QVariant(card:getNumber()))
		else
			local damage = sgs.DamageStruct()
			if upp then
				damage.from = upp
			end
			damage.to = effect.to
			damage.card = self
			local tag = sgs.QVariant()
			tag:setValue(effect.to)
			room:setTag("Hyblp",tag)
			room:setTag("Hybl",sgs.QVariant(1))
			room:damage(damage)
		end
	end,
}

enjoyeat = sgs.CreateTrickCard{
	name = "enjoyeat",
	class_name = "Enjoyeat",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = true,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select) 
		if #targets == 0 then
			return table.contains(science,to_select:getGeneralName()) or (to_select:getGeneral2() and table.contains(science,to_select:getGeneral2Name()))
		end
		return false
	end,
	feasible = function(self, targets)
		return #targets == 1 or #targets == 0
	end,
--[[	about_to_use = function(self, room, use)
		if use.to:isEmpty() then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_RECAST, use.from:objectName())
			reason.m_skillName = self:objectName()
			room:moveCardTo(self, use.from, nil, sgs.Player_DiscardPile, reason)
			use.from:broadcastSkillInvoke("@recast")

			local log = sgs.LogMessage()
			log.type = "$MoveToDiscardPile"
			log.from = use.from
			log.card_str = use.card:toString()
			room:sendLog(log)
			use.from:drawCards(1)
		else
			local log = sgs.LogMessage()
			log.from = use.from
			log.to = use.to
			log.type = "#UseCard"
			if use.card:isVirtualCard() then
				log.card_str = IntList2StringList(to_discard).join("+")
			else
				log.card_str = use.card:toString()
			end
			room:sendLog(log)
			local thread = room:getThread()
			local data = sgs.QVariant()
			data:setValue(use)
			thread:trigger(sgs.PreCardUsed, room, use.from, data)
			card_use = data:toCardUse()
			local move = sgs.CardsMoveStruct()
			move.card_ids:append(card_use.card:getId())
			move.from = use.from
			move.from_place = sgs.Player_PlaceHand
			move.to_place = sgs.Player_PlaceTable
			room:moveCardsAtomic(move, true)
			thread:trigger(sgs.CardUsed, room, use.from, data)
			thread:trigger(sgs.CardFinished, room, use.from, data)
		end
	end,]]--
	on_use = function(self, room, source, targets)
		if #targets == 0 then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_RECAST, source:objectName())
			reason.m_skillName = self:getSkillName()
			local ids = sgs.IntList()
			if self:isVirtualCard() then
				ids = self:getSubcards()
			else
				ids:append(self:getId())
			end
			local moves = sgs.CardsMoveList()
			for _,id in sgs.qlist(ids) do
				local move = sgs.CardsMoveStruct()
				move.card_ids:append(id)
				move.to_place = sgs.Player_DiscardPile
				move.reason = reason
				moves:append(move)
			end
			room:moveCardsAtomic(moves, true)
			source:broadcastSkillInvoke("@recast")

			local log = sgs.LogMessage()
			log.type = "#UseCard_Recast";
			log.from = source
			log.card_str = self:toString()
			room:sendLog(log)
			source:drawCards(1, "recast")
		else
			for _,target in ipairs(targets) do
				local effect = sgs.CardEffectStruct()
				effect.card = self
				effect.from = source
				effect.to = target
			--	effect.multiple = (#targets > 1)
				local nullified_list = room:getTag("CardUseNullifiedList"):toStringList()
				effect.nullified = (table.contains(nullified_list,"_ALL_TARGETS") or table.contains(nullified_list,target:objectName()))
				room:cardEffect(effect)
			end
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:setPlayerMark(effect.to, "enjoyid", self:getEffectiveId())
		room:drawCards(effect.to, 4)
		local c = room:askForExchange(effect.to, "enjoyeat", 3, 3, true, "enjoyeatDis", false)
		room:throwCard(c, effect.to, effect.to)
		local typ = {}
		for _,card in sgs.qlist(c:getSubcards()) do 
			if not table.contains(typ, sgs.Sanguosha:getCard(card):getTypeId()) then
				table.insert(typ, sgs.Sanguosha:getCard(card):getTypeId())
			end
		end
		if #typ == 3 then
			local targets = sgs.SPlayerList()
			local others = room:getOtherPlayers(effect.to)
			for _,target in sgs.qlist(others) do
				if self:targetFilter(sgs.PlayerList(), target, effect.to) then
					targets:append(target)
				end
			end
			local target = room:askForPlayerChosen(effect.to, targets, "enjoyeat", "@enjoyeat-extra", true)
			room:setPlayerMark(effect.to, "enjoyid", 0)
			if target then
				local card_use = sgs.CardUseStruct()
				card_use.card = self
				card_use.from = effect.to
				card_use.to:append(target)
				room:useCard(card_use, false)
			end
		end
	end,
}

skillbuy = sgs.CreateTrickCard{
	name = "skillbuy",
	class_name = "Skillbuy",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = true,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select) 
		if #targets == 0 and to_select:objectName() ~= sgs.Self:objectName() then
			return table.contains(science,to_select:getGeneralName()) or (to_select:getGeneral2() and table.contains(science,to_select:getGeneral2Name()))
		end
		return false
	end,
	feasible = function(self, targets)
		return #targets == 1 or #targets == 0
	end,
--[[	about_to_use = function(self, room, use)
		if use.to:isEmpty() then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_RECAST, use.from:objectName())
			reason.m_skillName = self:objectName()
			room:moveCardTo(self, use.from, nil, sgs.Player_DiscardPile, reason)
			use.from:broadcastSkillInvoke("@recast")

			local log = sgs.LogMessage()
			log.type = "$MoveToDiscardPile"
			log.from = use.from
			log.card_str = use.card:toString()
			room:sendLog(log)
			use.from:drawCards(1)
		else
			local log = sgs.LogMessage()
			log.from = use.from
			log.to = use.to
			log.type = "#UseCard"
			if use.card:isVirtualCard() then
				log.card_str = IntList2StringList(to_discard).join("+")
			else
				log.card_str = use.card:toString()
			end
			room:sendLog(log)
			local thread = room:getThread()
			local data = sgs.QVariant()
			data:setValue(use)
			thread:trigger(sgs.PreCardUsed, room, use.from, data)
			card_use = data:toCardUse()
			local move = sgs.CardsMoveStruct()
			move.card_ids:append(card_use.card:getId())
			move.from = use.from
			move.from_place = sgs.Player_PlaceHand
			move.to_place = sgs.Player_PlaceTable
			room:moveCardsAtomic(move, true)
			thread:trigger(sgs.CardUsed, room, use.from, data)
			thread:trigger(sgs.CardFinished, room, use.from, data)
		end
	end,]]--
	on_use = function(self, room, source, targets)
		local myyskill = sgs.Sanguosha:getTriggerSkill("skillbuyclear")
		room:getThread():addTriggerSkill(myyskill)
		if #targets == 0 then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_RECAST, source:objectName())
			reason.m_skillName = self:getSkillName()
			local ids = sgs.IntList()
			if self:isVirtualCard() then
				ids = self:getSubcards()
			else
				ids:append(self:getId())
			end
			local moves = sgs.CardsMoveList()
			for _,id in sgs.qlist(ids) do
				local move = sgs.CardsMoveStruct()
				move.card_ids:append(id)
				move.to_place = sgs.Player_DiscardPile
				move.reason = reason
				moves:append(move)
			end
			room:moveCardsAtomic(moves, true)
			source:broadcastSkillInvoke("@recast")

			local log = sgs.LogMessage()
			log.type = "#UseCard_Recast";
			log.from = source
			log.card_str = self:toString()
			room:sendLog(log)
			source:drawCards(1, "recast")
		else
			for _,target in ipairs(targets) do
				local effect = sgs.CardEffectStruct()
				effect.card = self
				effect.from = source
				effect.to = target
			--	effect.multiple = (#targets > 1)
				local nullified_list = room:getTag("CardUseNullifiedList"):toStringList()
				effect.nullified = (table.contains(nullified_list,"_ALL_TARGETS") or table.contains(nullified_list,target:objectName()))
				room:cardEffect(effect)
			end
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:drawCards(effect.to, 1)
		local isFirstHero = table.contains(science,effect.to:getGeneralName())
		local isSecondaryHero = effect.to:getGeneral2() and table.contains(science,effect.to:getGeneral2Name())
		local other = effect.to:getGeneral()
		if isFirstHero then 
			if isSecondaryHero or (not effect.to:getGeneral2()) then
				other = nil
			else
				other = effect.to:getGeneral2()
			end
		end
		local skill_list = {}
		local Qingchenglist = effect.to:getTag("SkillBuy"):toString():split("+") or {}
		local boughtlist = effect.from:getTag("SkillBuyGet"):toString():split("+") or {}
		for _,skill in sgs.qlist(effect.to:getVisibleSkillList()) do
			if (not table.contains(skill_list,skill:objectName())) and (not table.contains(Qingchenglist,skill:objectName())) and ((not other) or (not other:hasSkill(skill:objectName()))) and (not (skill:isLordSkill() or skill:getFrequency() == sgs.Skill_Limited or skill:getFrequency() == sgs.Skill_Wake)) then
				table.insert(skill_list,skill:objectName())
			end
		end
		local skill_qc = ""
		if (#skill_list > 0) then
			skill_qc = room:askForChoice(effect.from, "skillbuy", table.concat(skill_list,"+"))
		end
		if (skill_qc ~= "")  then
			local log = sgs.LogMessage()
				log.from = effect.from
				log.type = "#skillbuyrequest"
				log.arg = skill_qc
				room:sendLog(log)
			room:setPlayerMark(effect.from, "skilltoget", 1)
			room:setPlayerProperty(effect.from, "skilltoget", sgs.QVariant(skill_qc))
			local yes = room:askForChoice(effect.to, "skillbuyask", "skillsell+denyskillbuy")
			for _,p in sgs.qlist(room:getAllPlayers())do
				room:setPlayerMark(p, "skilltoget", 0)
				room:setPlayerProperty(p, "skilltoget", sgs.QVariant())
			end
			if yes == "skillsell" then
				if not effect.from:isNude() then
					local card_id = room:askForCardChosen(effect.to, effect.from, "he", self:objectName())
					local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_EXTRACTION, effect.to:objectName())
					room:obtainCard(effect.to, sgs.Sanguosha:getCard(card_id), reason, room:getCardPlace(card_id) ~= Player_PlaceHand)
				end
				table.insert(Qingchenglist,skill_qc)
				table.insert(boughtlist,skill_qc .. ":" .. effect.to:objectName())
				effect.from:setTag("SkillBuyGet",sgs.QVariant(table.concat(boughtlist,"+")))
				effect.to:setTag("SkillBuy",sgs.QVariant(table.concat(Qingchenglist,"+")))
				room:addPlayerMark(effect.to, "Qingcheng" .. skill_qc)
				room:acquireSkill(effect.from, skill_qc)
				for _,p in sgs.qlist(room:getAllPlayers())do
					room:filterCards(p, p:getCards("he"), true)
				end
			else 
				room:damage(sgs.DamageStruct("skillbuy", effect.from, effect.to))
			end
		end
	end,
}

skillbuyclear = sgs.CreateTriggerSkill{
	name = "skillbuyclear", 
	events = {sgs.TurnStart, sgs.Death},
	on_trigger = function(self, event, player, data)
		local splayer = nil
		local room = player:getRoom()
		for _,p in sgs.qlist(room:getAlivePlayers())do
			if p:getNextAlive():objectName() == player:objectName() then splayer = p end
		end
		if event == sgs.Death then splayer = data:toDeath().who end
		if not splayer then return false end
	--	local change = data:toPhaseChange()
	--	if change.to ~= sgs.Player_NotActive then return false end
	--	room:writeToConsole("t1")
		if event == sgs.TurnStart then
			local Qingchenglist = splayer:getTag("SkillBuy"):toString():split("+")
			if #Qingchenglist == 0 then return false end
			for _,skill_name in pairs(Qingchenglist) do
				room:setPlayerMark(splayer, "Qingcheng" .. skill_name, 0);
			end
			splayer:removeTag("SkillBuy")
		end
		for _,p in sgs.qlist(room:getAllPlayers())do
			local boughtlist = p:getTag("SkillBuyGet"):toString():split("+") or {}
			local newlist = {}
			if #boughtlist ~= 0 then
				for _,sp in ipairs(boughtlist) do
					local spl = sp:split(":")
					if spl[2] == splayer:objectName() then
						if event == sgs.TurnStart then
							local log = sgs.LogMessage()
							log.from = splayer
							log.to:append(p)
							log.type = "#skillreturnlog"
							log.arg = spl[1]
							room:sendLog(log)
						end
						room:detachSkillFromPlayer(p, spl[1], false, true)
					else
						table.insert(newlist, sp)
					end
				end
				p:removeTag("SkillBuyGet")
				if #newlist > 0 then p:setTag("SkillBuyGet",sgs.QVariant(table.concat(newlist,"+"))) end
			end
		end
		for _,p in sgs.qlist(room:getAllPlayers())do
			room:filterCards(p, p:getCards("he"), true)
		end
        return false
	end,
	can_trigger = function(self, target)
		return target
	end,
	priority = 6
}

knowspread = sgs.CreateTrickCard{
	name = "knowspread",
	class_name = "Knowspread",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = true,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select) 
		if #targets == 0 and to_select:objectName() ~= sgs.Self:objectName() then
			return not (table.contains(science,to_select:getGeneralName()) or (to_select:getGeneral2() and table.contains(science,to_select:getGeneral2Name())))
		end
		return false
	end,
	feasible = function(self, targets)
		return #targets == 1 or #targets == 0
	end,
	on_use = function(self, room, source, targets)
		if #targets == 0 then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_RECAST, source:objectName())
			reason.m_skillName = self:getSkillName()
			local ids = sgs.IntList()
			if self:isVirtualCard() then
				ids = self:getSubcards()
			else
				ids:append(self:getId())
			end
			local moves = sgs.CardsMoveList()
			for _,id in sgs.qlist(ids) do
				local move = sgs.CardsMoveStruct()
				move.card_ids:append(id)
				move.to_place = sgs.Player_DiscardPile
				move.reason = reason
				moves:append(move)
			end
			room:moveCardsAtomic(moves, true)
			source:broadcastSkillInvoke("@recast")

			local log = sgs.LogMessage()
			log.type = "#UseCard_Recast";
			log.from = source
			log.card_str = self:toString()
			room:sendLog(log)
			source:drawCards(1, "recast")
		else
			for _,target in ipairs(targets) do
				local effect = sgs.CardEffectStruct()
				effect.card = self
				effect.from = source
				effect.to = target
			--	effect.multiple = (#targets > 1)
				local nullified_list = room:getTag("CardUseNullifiedList"):toStringList()
				effect.nullified = (table.contains(nullified_list,"_ALL_TARGETS") or table.contains(nullified_list,target:objectName()))
				room:cardEffect(effect)
			end
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:drawCards(effect.from, 1)
		local cards = effect.from:getHandcards()
		local left = sgs.IntList()
		local hearts = sgs.IntList()
		local non_hearts = sgs.IntList()
		for _, card in sgs.qlist(cards) do
			left:append(card:getId())
			if card:isKindOf("TrickCard") then
				hearts:append(card:getId())
			else
				non_hearts:append(card:getId())
			end
		end
		local dummy = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		if not hearts:isEmpty() then
			repeat
				room:fillAG(left, effect.to, non_hearts)
				local card_id = room:askForAG(effect.to, hearts, true, "knowspread")
				if (card_id == -1) then
					room:clearAG(effect.to)
					break
				end
				hearts:removeOne(card_id)
				left:removeOne(card_id)
				dummy:addSubcard(card_id)
				room:clearAG(effect.to)
			until hearts:isEmpty()
			if dummy:subcardsLength() > 0 then
				effect.to:obtainCard(dummy)
				local gets = dummy:getSubcards()
				local pattern = {}
				for _,get in sgs.qlist(gets) do
					local c = sgs.Sanguosha:getCard(get)
					if c:isAvailable(effect.to) then
						table.insert(pattern, c:toString())
					end
				end
				while #pattern ~= 0 do
					local using = false
					if (effect.to:getState() ~= "robot") and (effect.to:getState() ~= "offline") then
						using = room:askForUseCard(effect.to, table.concat(pattern, "#"), "@knowusing")
					else
						using = room:askForUseCard(effect.to, "knowspreadforAI", table.concat(pattern, "#"))
					end
					if using then 
						table.removeOne(pattern, using:toString())
					else
						break
					end
				end
			end
		end
	end,
}

noise = sgs.CreateBasicCard{
	name = "noise",
	class_name = "Noise",
	subtype = "defense_card",
	target_fixed = true,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 1,
	filter = function(self ,targets ,to_select)
		return sgs.Self:hasFlag("noise_Ava")
	end,
	available = function(self,player)
		return false
	end,
	on_effect = function(self,effect)
		sgs.Self:setFlags("-noise_Ava")
	end
}

noisetri = sgs.CreateTriggerSkill{
	frequency = sgs.Skill_Compulsory,
	events = {sgs.TargetConfirming},
	name = "noisetri",
	global = true,
	priority = 15,
	on_trigger = function(self,event,player,data)
		local room = player:getRoom()
		local use = data:toCardUse()
		local from = use.from
		local cardName = use.card:getClassName()
		if use.card and use.card:isKindOf("BasicCard") and use.to:contains(player) and from:objectName() ~= player:objectName() then
			room:setPlayerFlag(player,"noise_Ava")
			room:writeToConsole(cardName..":"..from:usedTimes(cardName))
			if room:askForUseCard(player, "Noise", "@noise:" .. use.from:objectName()..":"..use.card:objectName(), -1, sgs.Card_MethodUse) then
				room:addPlayerHistory(from,cardName,-1)
				use.to = sgs.SPlayerList()
				data:setValue(use)
			end
		end
	end
}

allocate = sgs.CreateTrickCard{
	name = "allocate",
	class_name = "Allocate",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		if to_select:objectName() ~= sgs.Self:objectName() then
			return #targets == 0 and not to_select:isKongcheng()
		end
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local x = effect.to:getHandcardNum()
		local to_exchange = effect.to:wholeHandCards()
		room:moveCardTo(to_exchange, effect.from, sgs.Player_PlaceHand, false)
		to_exchange = room:askForExchange(effect.from, "allocate", x, x, true, self:objectName().."prompt")
		room:moveCardTo(to_exchange, effect.to, sgs.Player_PlaceHand, false)
	end,
}

drosophila = sgs.CreateTrickCard{
	name = "drosophila",
	class_name = "Drosophila",
	subtype = "single_target_trick",
	subclass = sgs.LuaTrickCard_TypeSingleTargetTrick,
	target_fixed = false,
	can_recast = false,
	suit = sgs.Card_Spade,
	number = 11,
	filter = function(self, targets, to_select)
		return #targets == 0 and to_select:isAlive()
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		if effect.to:isWounded() and room:askForChoice(effect.to, self:objectName(), "drorecov+drodraw") == "drorecov" then
			local recover = sgs.RecoverStruct()
			recover.card = self
			recover.who = effect.from
			room:recover(effect.to, recover)
		else
			room:drawCards(effect.to, 1)
		end
		local cnt = 0
		for _,id in sgs.qlist(effect.to:handCards()) do
			if effect.to:canDiscard(effect.to, id) then cnt = cnt + 1 end
		end
		if cnt * 2 >= effect.to:getHandcardNum() and cnt > 0 then
			local asknum = math.ceil(effect.to:getHandcardNum() / 2)
			room:askForDiscard(effect.to, "drosophila", asknum, asknum, false, false)
			room:drawCards(effect.to, asknum)
		end
	end,
}

-------------
--装备部分
-------------

shiguanJdg = sgs.CreateTriggerSkill{
	name = "shiguanJdg",
	events = {sgs.CardResponded,sgs.CardUsed},
	frequency = sgs.Skill_Compulsory,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardResponded then
			local card_star = data:toCardResponse().m_card
			local victim = data:toCardResponse()
			if card_star:isKindOf("Acid") or card_star:isKindOf("Alkali") then
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					if p:getMark("shguan")>0 and player:getMark("sguan")>0 then
						local judge = sgs.JudgeStruct()
						judge.pattern = ".|red"
						judge.reason = self:objectName()
						judge.who = p
						room:judge(judge)
						if judge:isGood() then
							local recover = sgs.RecoverStruct()
							recover.who = p
							room:recover(p, recover)
						end
						room:setPlayerMark(player, "sguan", 0)
					end	
				end
				for _,pe in sgs.qlist(room:getAlivePlayers()) do
					room:setPlayerMark(pe, "shguan", 0)
				end
			end
		elseif event == sgs.CardUsed then
			local use = data:toCardUse()
			if use.card:isKindOf("Alkali") or use.card:isKindOf("Acid") then
				if player:getWeapon() and player:getWeapon():isKindOf("shiguan") then
					if use.to:length()>0 then
						for _,p in sgs.qlist(use.to) do
							room:setPlayerMark(p, "sguan", 1)
						end
					end
					room:setPlayerMark(use.from, "shguan", 1)
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

shiguan = sgs.CreateWeapon{
	name = "shiguan",
	class_name = "shiguan",
	suit = sgs.Card_Diamond,
	number = 4,
	range = 2,
	on_install = function(self,player)
		local room = player:getRoom()
		local skill = sgs.Sanguosha:getTriggerSkill("shiguanJdg")
		room:getThread():addTriggerSkill(skill)
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "shiguanJdg")
		for _,p in sgs.qlist(room:getAlivePlayers()) do
			room:setPlayerMark(p, "sguan", 0)
			room:setPlayerMark(p, "shguan", 0)
		end
	end,
}

aciddd = sgs.CreateWeapon{
	name = "aciddd",
	class_name = "aciddd",
	suit = sgs.Card_Club,
	number = 1,
	range = 1,
}

alkalidd = sgs.CreateWeapon{
	name = "alkalidd",
	class_name = "alkalidd",
	suit = sgs.Card_Heart,
	number = 1,
	range = 1,
}

bolisaiRe = sgs.CreateTriggerSkill{
	name = "bolisaiRe",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.Damaged,sgs.DamageCaused,sgs.EventPhaseChanging},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.Damaged then
			local damage = data:toDamage()
			if not( damage.to:getArmor() and damage.to:getArmor():isKindOf("bolisai") )then return false end
			room:setPlayerFlag(damage.to,"bls")
		elseif event == sgs.DamageCaused then
			local damage = data:toDamage()
			if damage.to:hasFlag("bls") then
				room:setEmotion(damage.to,"blsemotion")
				return true
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				for _,top in sgs.qlist(room:getAllPlayers()) do
					if top:hasFlag("bls") then
						room:setPlayerFlag(top,"-bls")
					end
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end
}

bolisai = sgs.CreateArmor{
	name = "bolisai",
	class_name = "bolisai",
	suit = sgs.Card_Spade,
	number = 5,
	on_install = function(self,player)
		local room = player:getRoom()
		local skill = sgs.Sanguosha:getTriggerSkill("bolisaiRe")
		room:getThread():addTriggerSkill(skill)
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "bolisaiRe")
		room:setPlayerFlag(player,"-bls")
	end,
}

phjiJdg = sgs.CreateTriggerSkill{
	name = "phjiJdg", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.TargetConfirmed}, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		if not use.card then return false end
		if use.card:hasFlag("phjiwin") or use.card:hasFlag("phjilose") or (use.to:at(0):objectName()~=player:objectName()) then return false end
		if use.card:isKindOf("Acid") or use.card:isKindOf("Alkali") then
			if not (use.from:getWeapon() and use.from:getWeapon():isKindOf("phji")) then return false end
			if room:askForSkillInvoke(use.from,self:objectName(),data) then
				local judge = sgs.JudgeStruct()
				if use.card:isKindOf("Acid") then
					judge.pattern = ".|.|1~7"
				elseif use.card:isKindOf("Alkali") then
					judge.pattern = ".|.|7~13"
				end
				judge.reason = "phji"
				judge.who = use.from
				room:judge(judge)
				if judge:isGood() then
					room:setCardFlag(use.card:getEffectiveId(), "phjiwin")
				else
					room:setCardFlag(use.card:getEffectiveId(), "phjilose")
				end
				if use.card:getSkillName() == "madejian" then return false end
			else
				room:setCardFlag(use.card:getEffectiveId(), "phjilose")
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end
}

phji = sgs.CreateWeapon{
	name = "phji",
	class_name = "phji",
	suit = sgs.Card_Spade,
	number = 5,
	range = 3,
	on_install = function(self,player)
		local room = player:getRoom()
		local skill = sgs.Sanguosha:getTriggerSkill("phjiJdg")
		room:getThread():addTriggerSkill(skill)
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "phjiJdg")
	end,
}

fhfskill = sgs.CreateTriggerSkill{
	name = "fhfskill",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.CardEffected},
	on_trigger = function(self, event, player, data)
		local effect = data:toCardEffect()
		local source = effect.from
		local dest = effect.to
		if dest:getArmor() and dest:getArmor():isKindOf("fhf") then
			if (effect.card:isKindOf("Acid") or effect.card:isKindOf("acidfly") or effect.card:isKindOf("Alkali") or effect.card:isKindOf("alkalifly")) then
				return true
			else
				return false
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

fhf = sgs.CreateArmor{
	name = "fhf",
	class_name = "fhf",
	suit = sgs.Card_Spade,
	number = 5,
	on_install = function(self,player)
		local room = player:getRoom()
		local skill = sgs.Sanguosha:getTriggerSkill("fhfskill")
		room:setPlayerCardLimitation(player, "use", "Acid,Alkali", false)
		room:getThread():addTriggerSkill(skill)
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "fhfskill")
		room:removePlayerCardLimitation(player, "use", "Acid,Alkali")
	end,
}

local beilolist = {}

beilocard = sgs.CreateSkillCard{
	name = "beilocard", 
	target_fixed = true,
	will_throw = true,
	filter = function(self, targets, to_select)
		return true
	end,
	on_use = function(self, room, source, targets)
		local room = source:getRoom()
		local list = table.concat(beilolist, "+")
		local choice = room:askForChoice(source, self:objectName(), string.lower(list))
		source:speak(list) -- 测试列表用
		local cardid = room:getCardFromPile(choice)
		local card = sgs.Sanguosha:getCard(cardid)
		if not (card:getSubtype() == "aoe" or card:getSubtype() == "global_effect" or card:targetFixed()) then
			local tolist = sgs.PlayerList()
			local flag = true
			while flag do
				flag = false
				local plist = sgs.SPlayerList()
				for _,top in sgs.qlist(room:getAllPlayers(true)) do
					local canuse = card:targetFilter(tolist, top, source)
					if canuse then
						plist:append(top)
						flag = true
					end
				end
				if not flag then break end
				if not plist:isEmpty() then
					local to = askForPlayerChosen(source, plist, self:objectName())
					tolist:append(to)
				end
			end
			if tolist:isEmpty() then return false end
			local use = sgs.CardUseStruct()
			use.card = card
			use.from = source
			use.to = tolist
			room:useCard(use)
		elseif card:getSubtype() == "aoe" then
			local use = sgs.CardUseStruct()
			use.card = card
			use.from = source
			use.to = room:getOtherPlayers(source)
			room:useCard(use)
		elseif card:getSubtype() == "global_effect" then
			local use = sgs.CardUseStruct()
			use.card = card
			use.from = source
			use.to = room:getAllPlayers()
			room:useCard(use)
		else
			local use = sgs.CardUseStruct()
			use.card = card
			use.from = source
			use.to:append(source)
			room:useCard(use)
		end
	end
}

beiloVS = sgs.CreateViewAsSkill{
	name = "beiloVS",
	n = 0,
	view_filter = function(self, selected, to_select)
		return true
	end, 
	view_as = function(self, cards)
		if #cards == 0 then
			local liuli_card = beilocard:clone()
			for _,cd in sgs.qlist(sgs.Self:getHandcards()) do
				liuli_card:addSubcard(cd)
			end
			return liuli_card
		end
	end, 
	enabled_at_play = function(self, player)
		return not sgs.Self:hasUsed("#beilocard")
	end, 
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

beilo = sgs.CreateWeapon{
	name = "beilo",
	class_name = "beilo",
	suit = sgs.Card_Spade,
	number = 5,
	range = 3,
	on_install = function(self,player)
		local room = player:getRoom()
		room:attachSkillToPlayer(player, "beiloVS")
		for _,id in sgs.qlist(room:getDrawPile()) do
			local card = sgs.Sanguosha:getCard(id)
			if card:getPackage() == self:getPackage() and card:isNDTrick() then
				if not table.contains(beilolist, card:getFullName()) then
					table.insert(beilolist, card:getFullName())
				end
			end
		end
		for _,id in sgs.qlist(room:getDiscardPile()) do
			local card = sgs.Sanguosha:getCard(id)
			if card:getPackage() == self:getPackage() and card:isNDTrick() then
				if not table.contains(beilolist, card:getFullName()) then
					table.insert(beilolist, card:getFullName())
				end
			end
		end
		for _,p in sgs.qlist(room:getAlivePlayers()) do
			for _,id in sgs.qlist(p:getHandcards()) do
				if id:getPackage() == self:getPackage() and id:isNDTrick() then
					if not table.contains(beilolist, id:getFullName()) then
						table.insert(beilolist, id:getFullName())
					end
				end
			end
		end
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "beiloVS")
	end,
}

jiujingdengVS = sgs.CreateViewAsSkill{
	name = "jiujingdengVS&",
	n = 1,
	view_filter = function(self, selected, to_select)
		return to_select:getSuit() == sgs.Card_Heart
	end, 
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local suit = card:getSuit()
			local point = card:getNumber()
			local id = card:getId()
			local fireattack = sgs.Sanguosha:cloneCard("fireup", suit, point)
			fireattack:setSkillName(self:objectName())
			fireattack:addSubcard(id)
			return fireattack
		end
	end, 
	enabled_at_play = function(self, player)
		return true
	end, 
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

jiujingdeng = sgs.CreateWeapon{
	name = "jiujingdeng",
	class_name = "jiujingdeng",
	suit = sgs.Card_Spade,
	number = 5,
	range = 3,
	on_install = function(self,player)
		local room = player:getRoom()
		room:attachSkillToPlayer(player, "jiujingdengVS")
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "jiujingdengVS")
	end,
}

peacebrokeCard = sgs.CreateSkillCard{
	name = "peacebrokeCard", 
	target_fixed = true, 
	will_throw = true, 
	on_use = function(self, room, source, targets)
		room:drawCards(source,1)
	end
}

peacebroke = sgs.CreateViewAsSkill{
	name = "peacebroke&", 
	n = 1, 
	view_filter = function(self, selected, to_select)
		return (to_select:isEquipped() and sgs.Self:getArmor():objectName() == to_select:objectName() and to_select:isKindOf("peaceagree") and #selected == 0)
	end, 
	view_as = function(self, cards) 
		if #cards == 1 then
			local card = cards[1]
			local id = card:getId()
			local fireattack = peacebrokeCard:clone()
			fireattack:setSkillName("peacebroke")
			fireattack:addSubcard(id)
			return fireattack
		end
	end, 
	enabled_at_play = function(self, player)
		return true
	end
}

peacepunished = sgs.CreateTriggerSkill{
	name = "peacepunished",
	frequency = sgs.Skill_Compulsory, 
	events = {sgs.EventPhaseStart,sgs.Death}, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Finish and player:getArmor() and player:getArmor():isKindOf("peaceagree") then
				local sentlog = false
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					if p:getHp()>player:getHp() then
						if not sentlog then
							local log = sgs.LogMessage()
							log.from = player
							log.type = "#peacelog"
							log.arg = "peacepunished"
							room:sendLog(log)
						end
						room:loseHp(p)
						room:drawCards(p,1)
						sentlog = true
					elseif p:getHp()<player:getHp() and p:isWounded() then
						if not sentlog then
							local log = sgs.LogMessage()
							log.from = player
							log.type = "#peacelog"
							log.arg = "peacepunished"
							room:sendLog(log)
						end
						local recover = sgs.RecoverStruct()
						recover.who = player
						room:recover(p, recover)
						sentlog = true
						room:askForDiscard(p, self:objectName(), 1, 1, false, true)
					end
				end
			end
		elseif event == sgs.Death then
			local death = data:toDeath()
			if death.who:getArmor() and death.who:getArmor():isKindOf("peaceagree") then
				local killer
				if death.damage then
					killer = death.damage.from
				else
					killer = nil
				end
				if killer and killer:objectName() ~= player:objectName() and killer:isAlive() then
					room:obtainCard(killer,death.who:getArmor())
				end
			end 
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

peaceagree = sgs.CreateArmor{
	name = "peaceagree",
	class_name = "peaceagree",
	suit = sgs.Card_Spade,
	number = 5,
	on_install = function(self,player)
		local room = player:getRoom()
		local skill = sgs.Sanguosha:getTriggerSkill("peacepunished")
		room:getThread():addTriggerSkill(skill)
		room:attachSkillToPlayer(player, "peacebroke")
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "peacepunished")
		room:detachSkillFromPlayer(player, "peacebroke")
	end
}

zslengjingVS = sgs.CreateViewAsSkill{
	name = "zslengjingVS&",
	n = 1,
	view_filter = function(self, selected, to_select)
		return to_select:isBlack() and not to_select:isEquipped()
	end, 
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local suit = card:getSuit()
			local point = card:getNumber()
			local id = card:getId()
			local fireattack = sgs.Sanguosha:cloneCard("zheshe", suit, point)
			fireattack:setSkillName(self:objectName())
			fireattack:addSubcard(id)
			return fireattack
		end
	end, 
	enabled_at_play = function(self, player)
		return false
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "Zheshe"
	end
}

zslengjing = sgs.CreateArmor{
	name = "zslengjing",
	class_name = "zslengjing",
	suit = sgs.Card_Spade,
	number = 5,
	range = 3,
	on_install = function(self,player)
		local room = player:getRoom()
		room:attachSkillToPlayer(player, "zslengjingVS")
	end,
	on_uninstall = function(self,player)
		local room = player:getRoom()
		room:detachSkillFromPlayer(player, "zslengjingVS")
	end,
}

-----------------------------------
--武将技能部分
-----------------------------------

youjihecheng = sgs.CreateViewAsSkill{
	name = "youjihecheng",
	n = 2,
	view_filter = function(self, selected, to_select)
		if #selected ~= 2 then
			return true
		end
		return false
	end,
	view_as = function(self, cards)
		if #cards == 2 then
			local card = cards[1]
			local card2 = cards[2]
			local suit = sgs.Card_NoSuit
			local number = 0
			if card:getSuit() == card2:getSuit() then
				suit = card:getSuit()
			end
			if card:getNumber() == card2:getNumber() then
				number = card:getNumber()
			end
			local peach = sgs.Sanguosha:cloneCard("c6", suit, number)
			peach:setSkillName(self:objectName())
			peach:addSubcard(card)
			peach:addSubcard(card2)
			return peach
		end
		return nil
	end,
	enabled_at_play = function(self, player)
		return true
	end
}

tongfenyigouCard = sgs.CreateSkillCard{
	name = "tongfenyigouCard", 
	target_fixed = true, 
	will_throw = false,
	on_use = function(self, room, source, targets)
		room:showAllCards(source)
		local cards = source:getHandcards()
		local suit = {}
		local name = {}
		for _,card in sgs.qlist(cards) do
			table.insert(suit, card:getSuitString())
			table.insert(name, card:getName())
		end
		local tocards = room:getNCards(source:getLostHp()+2)
		local move = sgs.CardsMoveStruct()
		move.card_ids = tocards
		move.to = source
		move.to_place = sgs.Player_PlaceTable
		move.reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TURNOVER, source:objectName(), self:objectName(), nil)
		room:broadcastSkillInvoke(self:objectName(),1)
		room:moveCardsAtomic(move, true)
		room:getThread():delay(1000)
		for _,id in sgs.qlist(tocards) do
			local card = sgs.Sanguosha:getCard(id)
			if (not table.contains(suit, card:getSuitString())) or table.contains(name, card:getName()) then
				room:obtainCard(source, card)
			end
		end
	end
}

tongfenyigou = sgs.CreateViewAsSkill{
	name = "tongfenyigou", 
	n = 0, 
	view_as = function(self, cards) 
		return tongfenyigouCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return (not player:hasUsed("#tongfenyigouCard")) and (not player:isKongcheng()) 
	end
}

madejianVS = sgs.CreateViewAsSkill{
	name = "madejian",
	n = 2,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then
			return true
		elseif #selected == 1 and not selected[1]:isKindOf("EquipCard") then
			return not to_select:isKindOf("EquipCard")
		end
		return false
	end,
	view_as = function(self, cards)
		local card = cards[1]
		if #cards == 2 then
			local card2 = cards[2]
			local suit = sgs.Card_NoSuit
			local number = 0
			if card:getSuit() == card2:getSuit() then
				suit = card:getSuit()
			end
			if card:getNumber() == card2:getNumber() then
				number = card:getNumber()
			end
			local peach = sgs.Sanguosha:cloneCard("alkali", suit, number)
			peach:setSkillName(self:objectName())
			peach:addSubcard(card)
			peach:addSubcard(card2)
			return peach
		elseif #cards == 1 and card:isKindOf("EquipCard") then
			local slash = sgs.Sanguosha:cloneCard("alkali", card:getSuit(), card:getNumber()) 
			slash:addSubcard(card:getId())
			slash:setSkillName(self:objectName())
			return slash
		end
		return nil
	end,
	enabled_at_play = function(self, player)
		local newanal = sgs.Sanguosha:cloneCard("alkali", sgs.Card_NoSuit, 0)
		if player:isCardLimited(newanal, sgs.Card_MethodUse) or player:isProhibited(player, newanal) then return false end
		return player:usedTimes("Alkali") + player:usedTimes("Acid") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, player , newanal) or (player:getWeapon() and player:getWeapon():isKindOf("alkalidd"))
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "Alkali"
	end
}

madejian = sgs.CreateTriggerSkill{
	name = "madejian",
	view_as_skill = madejianVS, 
	events = {sgs.CardUsed,sgs.PreCardUsed}, 
	on_trigger = function(self, event, player, data)
		local use = data:toCardUse()
		if event == sgs.CardUsed then
			local cards = use.card:getSubcards()
			if use.card:isKindOf("Alkali") and use.card:getSkillName() == "madejian" then
				if cards:length() == 1 and sgs.Sanguosha:getCard(cards:at(0)):isKindOf("EquipCard") then
					use.from:getRoom():broadcastSkillInvoke(self:objectName(),1)
				elseif cards:length() == 2 then
					use.from:getRoom():broadcastSkillInvoke(self:objectName(),2)
				end
			end
		elseif event == sgs.PreCardUsed then
			if use.card:getSkillName() == "madejian" then return true end
		end
		return false
	end
}

madejianTargetMod = sgs.CreateTargetModSkill{
	name = "#madejianTargetMod",
	frequency = sgs.Skill_NotFrequent,
	pattern = "Alkali",
	residue_func = function(self, player)
		if player:hasSkill(self:objectName()) then
			return 1
		else
			return 0
		end
	end,
	distance_limit_func = function(self, player)
		if player:hasSkill(self:objectName()) then
			return 1
		else
			return 0
		end
	end,
	extra_target_func = function(self, player)
		if player:hasSkill(self:objectName()) and player:usedTimes("Alkali")==0 then
			return 1
		else
			return 0
		end
	end,
}

extension:insertRelatedSkills("madejian", "#madejianTargetMod")

wuzhishouhengCard = sgs.CreateSkillCard{
	name = "wuzhishouhengCard", 
	target_fixed = false, 
	will_throw = true, 
	filter = function(self, targets, to_select) 
		if #targets < sgs.Self:getPile("things"):length() then
			return true
		end
		return false
	end,
	on_use = function(self, room, source, targets)
		local pile = source:getPile("things")
		if #targets == 1 then
			room:throwCard(pile:first(), nil, nil)
		elseif #targets == pile:length() then
			source:removePileByName("things")
		else
			for i=1,#targets,1 do
				room:fillAG(pile, source)
				local id = room:askForAG(source, pile, false, self:objectName())
				room:clearAG(source)
				pile:removeOne(id)
				local card = sgs.Sanguosha:getCard(id)
				room:throwCard(card, nil, nil)
			end
		end
		for i=1,#targets,1 do
			room:drawCards(targets[i],1)
		end
	end
}

wuzhishouhengVS = sgs.CreateViewAsSkill{
	name = "wuzhishouheng", 
	n = 0, 
	view_as = function(self, cards) 
		return wuzhishouhengCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return false
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@wuzhishouheng"
	end
}

wuzhishouheng = sgs.CreateTriggerSkill{
	name = "wuzhishouheng",
	frequency = sgs.Skill_NotFrequent, 
	view_as_skill = wuzhishouhengVS, 
	events = {sgs.CardsMoveOneTime, sgs.EventLoseSkill,sgs.EventPhaseStart}, 
	on_trigger = function(self, event, player, data)
		if player:isAlive() then
			if player:hasSkill(self:objectName()) and player:getPhase() == sgs.Player_NotActive then
				if event == sgs.CardsMoveOneTime then
					local move = data:toMoveOneTime()
					local source = move.from
					if source and source:objectName() == player:objectName() then
						local places = move.from_places
						local room = player:getRoom()
						if places:contains(sgs.Player_PlaceHand) or places:contains(sgs.Player_PlaceEquip) then
							if player:askForSkillInvoke(self:objectName(), data) then
								room:broadcastSkillInvoke(self:objectName(),1)
								for _,card_id in sgs.qlist(move.card_ids) do
									local CAS = room:getNCards(1, false)
									for _,id in sgs.qlist(CAS) do 
										player:addToPile("things", id) 
									end
								end
							end
						end
					end
				end
			end
		end
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Start and player:getPile("things"):length()>0 and player:hasSkill(self:objectName()) then
				player:getRoom():askForUseCard(player, "@@wuzhishouheng", "@wzsh-card")
			end
		end
		if event == sgs.EventLoseSkill then
			if data:toString() == self:objectName() then
				player:removePileByName("things")
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

lwxyanghua = sgs.CreateTriggerSkill{
	name = "lwxyanghua",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.DamageForseen,sgs.Pindian},
	on_trigger = function(self, event, player, data)
		if event == sgs.DamageForseen then 
			local damage = data:toDamage()
			local room = player:getRoom()
			local lwx = room:findPlayerBySkillName(self:objectName())
			if lwx then
				if lwx:getPhase() == sgs.Player_NotActive then
					if lwx:isKongcheng() or damage.to:isKongcheng() or damage.to:objectName() == lwx:objectName() then return false end
					if lwx:askForSkillInvoke(self:objectName(), data) then
						local unwin = damage.to:pindian(lwx, self:objectName(), nil)
						if not unwin then
							room:broadcastSkillInvoke(self:objectName(),1)
							local hurt = damage.damage
							damage.damage = hurt + 1
							data:setValue(damage)
						end
					end
				end
			end
		else
			local pindian = data:toPindian()
			if pindian.reason == self:objectName() then
				if pindian.from_card:getNumber() > pindian.to_card:getNumber() then
				--	pindian.to:obtainCard(pindian.from_card)
				else
					pindian.from:obtainCard(pindian.from_card)
					pindian.from:obtainCard(pindian.to_card)
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

hmlhuanyuan = sgs.CreateTriggerSkill{
	name = "hmlhuanyuan",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.DamageForseen,sgs.Pindian},
	on_trigger = function(self, event, player, data)
		if event == sgs.DamageForseen then 
			local damage = data:toDamage()
			local room = player:getRoom()
			local lwx = room:findPlayerBySkillName(self:objectName())
			if lwx then
				if not damage.from then return false end
				if lwx:objectName() ~= damage.from:objectName() then
					if lwx:isKongcheng() or damage.from:isKongcheng() or damage.damage == 0 then return false end
					if lwx:askForSkillInvoke(self:objectName(), data) then
						local win = lwx:pindian(damage.from, self:objectName(), nil)
						if win then
							local hurt = damage.damage
							damage.damage = hurt - 1
							data:setValue(damage)
						end
					end
				end
			end
		else
			local pindian = data:toPindian()
			if pindian.reason == self:objectName() then
				if pindian.from_card:getNumber() > pindian.to_card:getNumber() then
					pindian.to:obtainCard(pindian.from_card)
				else
					pindian.from:obtainCard(pindian.to_card)
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

liqingtilian = sgs.CreateTriggerSkill{
	name = "liqingtilian",  
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseStart},  
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		local splayer = room:findPlayerBySkillName(self:objectName())
		if splayer and splayer:objectName() ~= player:objectName() then
			if event == sgs.EventPhaseStart then
				if player:getPhase() == sgs.Player_Finish then
					local alives = room:getAlivePlayers()
					if splayer:getMark("@tilian") and splayer:getMark("@tilian")>=3 then return false end
					if splayer:askForSkillInvoke(self:objectName(), data) then
						room:broadcastSkillInvoke(self:objectName(),1)
						room:drawCards(player,3)
						if player:isKongcheng() then return false end
						local cards = room:askForExchange(player, self:objectName(), 1,1, false, self:objectName())
						local card_id = cards:getSubcards():first()
						player:addToPile("radiation", card_id)
						splayer:gainMark("@tilian",1)
					end
				elseif player:getPhase() == sgs.Player_Start then
					local n = player:getPile("radiation"):length()
					if n>0 then 
						local black = false
						room:broadcastSkillInvoke(self:objectName(),2)
						for i = 1,n,1 do
							local judge = sgs.JudgeStruct()
							judge.pattern = ".|black"
							judge.good = true
							judge.reason = self:objectName()
							judge.who = player
							room:judge(judge)
							if judge:isGood() then
								black = true
								break
							end
						end
						if black then
							local damage = sgs.DamageStruct()
							damage.from = splayer
							damage.to = player
							room:damage(damage)
						end
					end
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

liqingtilianMaxCards = sgs.CreateMaxCardsSkill{
	name = "liqingtilianMaxCards" ,
	extra_func = function(self, target)
		if target:getPile("radiation"):length() > 0 then
			return 0 - target:getPile("radiation"):length()
		else
			return 0
		end
	end
}

jltanlei = sgs.CreateTriggerSkill{
	name = "jltanlei", 
	frequency = sgs.Skill_Wake, 
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		room:setPlayerMark(player, "tanlei", 1)
		player:gainMark("@waked")
		room:loseMaxHp(player)
		room:acquireSkill(player, "leishe")
		room:broadcastSkillInvoke("jltanlei",1)
		return false
	end, 
	can_trigger = function(self, target)
		if target then
			if target:isAlive() and target:hasSkill(self:objectName()) then
				if target:getPhase() == sgs.Player_Start then
					if target:getMark("tanlei") == 0 then
						return target:getMark("@tilian") >= 3
					end
				end
			end
		end
		return false
	end
}

leishe = sgs.CreateTriggerSkill{
	name = "leishe",
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseEnd,sgs.DamageCaused},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseEnd then
			if player:getPhase() == sgs.Player_Finish then
				if not player:hasSkill(self:objectName()) then return false end 
				local slash = sgs.Sanguosha:cloneCard("thunder_slash", sgs.Card_NoSuit, 0)
				slash:setSkillName(self:objectName())
				if player:getMark("@tilian") == 0 then return false end
				if room:askForSkillInvoke(player, self:objectName(), sgs.QVariant()) then
					room:broadcastSkillInvoke(self:objectName(),1)
					room:setPlayerMark(player,"@tilian",0)
					local alives = room:getAlivePlayers()
					for _,p in sgs.qlist(alives) do
						 if p:getPile("radiation"):length() > 0 then
							for i = 1,p:getPile("radiation"):length(),1 do
								local use = sgs.CardUseStruct()
								use.from = player
								use.card = slash
								use.to:append(p)
								room:throwCard(p:getPile("radiation"):at(0), nil,nil)
								room:useCard(use, false)
							end
						 end
					end 
				end
			end
		elseif event == sgs.DamageCaused then 
			local damage = data:toDamage()
			if damage.card and damage.card:getSkillName() == self:objectName() then
				room:drawCards(damage.to,1)
			end
		end
	end, 
	can_trigger = function(self, target)
		return target
	end
}

bccanza = sgs.CreateTriggerSkill{
	name = "bccanza",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.Damaged},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()
		if room:askForSkillInvoke(player, self:objectName(),sgs.QVariant()) then
			local n = 0
			if not player:isKongcheng() then 
				n = player:getHandcards():length()
				local exchangeMove = sgs.CardsMoveList()
				local blist = sgs.IntList()
				for _,card in sgs.qlist(player:getHandcards()) do
					local moveA = sgs.CardsMoveStruct()
					local alist = sgs.IntList()
					alist:append(card:getId())
					blist:append(card:getId())
					moveA.card_ids = alist
					moveA.to_place = sgs.Player_DrawPile
					exchangeMove:append(moveA)
				end
				room:moveCardsAtomic(exchangeMove, false)
				room:askForGuanxing(player, room:getNCards(blist:length()), 1)
			end
			local list = sgs.IntList()
			for i = 1, n+2, 1 do
				if room:getDrawPile():length()>= i then
					list:append(room:getDrawPile():at(room:getDrawPile():length() - i))
				end
			end
			local move2 = sgs.CardsMoveStruct()
			move2.card_ids = list
			move2.to = player
			move2.to_place = sgs.Player_PlaceHand
			room:moveCardsAtomic(move2, false)
		end
	end
}

bcdaodian = sgs.CreateTriggerSkill{
	name = "bcdaodian", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.Damaged, sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.Damaged then
			local damage = data:toDamage()
			local killer = damage.from
			if not killer then return false end
			if killer:getPhase() ~= sgs.Player_NotActive then 
				room:setPlayerFlag(killer,"gaofenzi")
			end
		elseif event == sgs.EventPhaseStart then
			local bc = room:findPlayerBySkillName(self:objectName())
			if (not bc) or (player:getPhase() ~= sgs.Player_Finish) or (not player:hasFlag("gaofenzi")) or (bc:objectName() == player:objectName()) then
				return false 
			end
			if room:askForSkillInvoke(bc, self:objectName(),sgs.QVariant()) then
				local pattern = ".|.|.|hand"
				local judge = sgs.JudgeStruct()
				judge.pattern = "."
				judge.who = bc
				judge.reason = self:objectName()
				room:judge(judge)
				local suit = judge.card:getSuit()
				if suit == sgs.Card_Spade then
					pattern = ".|diamond,club,heart|.|hand"
				elseif suit == sgs.Card_Diamond then
					pattern = ".|spade,club,heart|.|hand"
				elseif suit == sgs.Card_Club then
					pattern = ".|diamond,spade,heart|.|hand"
				elseif suit == sgs.Card_Heart then
					pattern = ".|diamond,club,spade|.|hand"
				end
				local askcard = room:askForCard(player, pattern, "@daodian_card")
				if askcard then
					room:throwCard(askcard, player)
				else
					room:obtainCard(player, judge.card)
					room:damage(sgs.DamageStruct(self:objectName(), bc, player, 1, sgs.DamageStruct_Thunder))
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

boomCard = sgs.CreateSkillCard{
	name = "boomCard", 
	target_fixed = false,
	will_throw = true,
	filter = function(self, targets, to_select) 
		if #targets == 0 then
			local bifalist = to_select:getPile("tnt")
			if (bifalist:isEmpty()) or (bifalist:length() + self:getSubcards():length() <= 2) then
				return (to_select:objectName() ~= sgs.Self:objectName()) and (sgs.Self:inMyAttackRange(to_select))
			end
		end
		return false
	end,
	on_use = function(self, room, source, targets)
		local ids = self:getSubcards()
		local n = ids:length()
		for _,id in sgs.qlist(ids) do
			targets[1]:addToPile("tnt", id, true)
		end
	end
}

boomVS = sgs.CreateViewAsSkill{
	name = "boom", 
	n = 2, 
	view_filter = function(self, selected, to_select)
		return true
	end, 
	view_as = function(self, cards)
		if #cards > 0 then
			local acard = boomCard:clone()
			for _,card in pairs(cards) do
				acard:addSubcard(card)
			end
			acard:setSkillName(self:objectName())
			return acard
		end
	end, 
	enabled_at_play = function(self, player)
		return true
	end, 
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

boom = sgs.CreateTriggerSkill{
	name = "boom",  
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseStart}, 
	view_as_skill = boomVS, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Judge then
			local tnt_list = player:getPile("tnt")
			local boomer = room:findPlayerBySkillName(self:objectName())
			if not boomer then return false end
			if tnt_list:length() > 0 then
				local n = 0
				n = tnt_list:length()
				for i = 1,n,1 do
					if not player:isAlive() then break end
					if tnt_list:length() == 0 then return false end
					local card_id = tnt_list:first()
					local card = sgs.Sanguosha:getCard(card_id)
					tnt_list:removeOne(card_id)
					room:throwCard(card, player)
					tnt_list = player:getPile("tnt")
					local pattern
					if card:isRed() then
						pattern = ".|red"
					else
						pattern = ".|black"
					end
					local askcard = room:askForCard(player, pattern, "@boom_card")
					if askcard then
						room:throwCard(askcard, player)
					else
						room:damage(sgs.DamageStruct("boomdamage", boomer, player, 1, sgs.DamageStruct_Fire))
					end
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

brodie = sgs.CreateTriggerSkill{
	name = "brodie", 
	frequency = sgs.Skill_Wake, 
	events = {sgs.Death},
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		local death = data:toDeath()
		local damage = death.damage
		if damage then
			if damage.reason ~= "boomdamage" then return false end
			local alives = room:getAlivePlayers()
			for _,p in sgs.qlist(alives) do
				if p:hasSkill(self:objectName()) and p:getMark("brodie") == 0 then 
					room:setPlayerMark(p, "brodie", 1)
					p:gainMark("@waked")
					room:broadcastSkillInvoke(self:objectName(),1)
					room:loseMaxHp(p)
					room:acquireSkill(p, "tntfac")
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

tntfac = sgs.CreateTriggerSkill{
	name = "tntfac",
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseEnd},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseEnd then
			if player:getPhase() == sgs.Player_Finish then
				if not player:hasSkill(self:objectName()) then return false end 
				if player:getMaxHp()<=player:getHandcardNum() then return false end
				if room:askForSkillInvoke(player, self:objectName(),data) then
					room:broadcastSkillInvoke(self:objectName(),1)
					local a = player:getHandcardNum()
					player:drawCards(player:getMaxHp()-player:getHandcardNum())
					local n = 0
					local alives = room:getAlivePlayers()
					for _,p in sgs.qlist(alives) do
						 if p:getPile("tnt"):length() > 0 then
							n = n + p:getPile("tnt"):length()
						 end
					end 
					if n <= 1 then return false end
					room:askForDiscard(player, self:objectName(), n-1, n-1, false, true)
					if player:getHandcardNum() < a then
						for _,p in sgs.qlist(room:getAlivePlayers()) do
							local tnt_list = p:getPile("tnt")
							if tnt_list:length() > 0 then
								local n = 0
								n = tnt_list:length()
								for i = 1,n,1 do
									if not p:isAlive() then break end
									if tnt_list:length() == 0 then return false end
									local card_id = tnt_list:first()
									local card = sgs.Sanguosha:getCard(card_id)
									tnt_list:removeOne(card_id)
									room:throwCard(card, p)
									tnt_list = p:getPile("tnt")
									local pattern
									if card:isRed() then
										pattern = ".|red"
									else
										pattern = ".|black"
									end
									local askcard = room:askForCard(p, pattern, "@boom_card")
									local df = nil
									if player:isAlive() then df = player end
									if askcard then
										room:throwCard(askcard, p)
									else
										room:damage(sgs.DamageStruct("boomdamage", df, p, 1, sgs.DamageStruct_Fire))
									end
								end
							end
						end
					end
				end
			end
		end
	end
}

DrfenyaCard = sgs.CreateSkillCard{
	name = "DrfenyaCard",
	target_fixed = false,
	filter = function(self, targets, to_select, player)
		if #targets <= player:getLostHp() then
			return (not to_select:hasFlag("cardfrom")) and(to_select:objectName() ~= sgs.Self:objectName()) and sgs.Self:inMyAttackRange(to_select)
		end
		return false
	end,
	on_use = function(self, room, source, targets)
		for _,p in ipairs(targets) do
			room:setPlayerFlag(p, "newcardto")
		end
	end
}

DrfenyaVS = sgs.CreateViewAsSkill{
	name = "Drfenya",
	n = 0,
	view_as = function(self, cards)
		return DrfenyaCard:clone()
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@Drfenya"
	end,
}

Drfenya = sgs.CreateTriggerSkill{
	name = "Drfenya",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed},
	view_as_skill = DrfenyaVS,
	on_trigger = function(self, event, player, data)
		local use = data:toCardUse()
		local room = player:getRoom()
		local trick = use.card
		if trick then
			local splayer = room:findPlayerBySkillName(self:objectName())
			if not splayer then return false end
			if use.to:length() ==1 and use.to:contains(splayer) and use.from:objectName()~=splayer:objectName() and (use.card:isKindOf("BasicCard") or use.card:isNDTrick()) then
				room:setPlayerFlag(use.from,"cardfrom")
				room:setTag("fenyac", data)
				if room:askForUseCard(splayer,"@@Drfenya","@Drfenya") then
					local alives = room:getAlivePlayers()
					for _,p in sgs.qlist(alives) do
						 if p:hasFlag("newcardto") then
							room:drawCards(p,1)
							use.to:append(p)
							room:setPlayerFlag(p, "-newcardto")
						 end
						 room:setPlayerFlag(p, "-cardfrom")
					end 
					room:broadcastSkillInvoke(self:objectName(),1)
					data:setValue(use)
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return true
	end
}

Dratoms = sgs.CreateTriggerSkill{
	name = "Dratoms",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardsMoveOneTime},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local move = data:toMoveOneTime()
		local source = move.from
		local splayer = room:findPlayerBySkillName(self:objectName())
		if source and splayer then
			if source:objectName() ~= splayer:objectName() then
				if move.to_place == sgs.Player_DiscardPile then
					local reason = move.reason.m_reason
					local flag = false
					if reason == sgs.CardMoveReason_S_REASON_USE then
						flag = true
					end
					if reason == sgs.CardMoveReason_S_REASON_RESPONSE then
						flag = true
					end
					if flag then
						if splayer:getPile("atoms"):length() == 0 then return false end
						local n = 0
						if move.card_ids:length() == 1 then
							for i = 1,splayer:getPile("atoms"):length(),1 do
								n = n + sgs.Sanguosha:getCard(splayer:getPile("atoms"):at(i-1)):getNumber()
							end
							if n >= sgs.Sanguosha:getCard(move.card_ids:at(0)):getNumber() then
								if splayer:askForSkillInvoke(self:objectName(),data) then
									local chosen = 0
									local tgn = sgs.QVariant()
									tgn:setValue(sgs.Sanguosha:getCard(move.card_ids:at(0)):getNumber())
									room:setTag("atomstogetnum", tgn)
									while chosen < sgs.Sanguosha:getCard(move.card_ids:at(0)):getNumber() do
										room:fillAG(splayer:getPile("atoms"), splayer)
										local id = room:askForAG(splayer, splayer:getPile("atoms"), false, self:objectName())
										room:clearAG(splayer)
										chosen = chosen + sgs.Sanguosha:getCard(id):getNumber()
										local tgen = sgs.QVariant()
										tgen:setValue(room:getTag("atomstogetnum"):toInt() - sgs.Sanguosha:getCard(id):getNumber())
										room:setTag("atomstogetnum", tgen)
										splayer:getPile("atoms"):removeOne(id)
										room:throwCard(id, splayer)
									end
									if chosen >= sgs.Sanguosha:getCard(move.card_ids:at(0)):getNumber() then
										room:obtainCard(splayer, move.card_ids:at(0))
										move.card_ids = sgs.IntList()
										data:setValue(move)
									end
								end
							end
						else
							for i = 1,player:getPile("atoms"):length(),1 do
								n = n + sgs.Sanguosha:getCard(player:getPile("atoms"):at(i-1)):getNumber()
							end
							local canget = sgs.IntList()
							local cannotget = true
							for _,card_id in sgs.qlist(move.card_ids) do
								if sgs.Sanguosha:getCard(card_id):getNumber()<=n then
									cannotget = false
									canget:append(card_id)
								end
							end
							if cannotget then return false end
							if room:askForSkillInvoke(splayer, self:objectName(),data) then
								local havenotget = canget
								while (not cannotget) and canget:length()~=0 do
									room:fillAG(canget, splayer)
									local toget = room:askForAG(splayer, canget, false, self:objectName().."toget")
									room:clearAG(splayer)
									if toget==-1 then return false end
									local tgn = sgs.QVariant()
									tgn:setValue(sgs.Sanguosha:getCard(toget):getNumber())
									room:setTag("atomstogetnum", tgn)
									local chosen = 0
									while chosen < sgs.Sanguosha:getCard(toget):getNumber() do
										room:fillAG(splayer:getPile("atoms"), splayer)
										local id = room:askForAG(splayer, splayer:getPile("atoms"), false, self:objectName())
										room:clearAG(splayer)
										chosen = chosen + sgs.Sanguosha:getCard(id):getNumber()
										local tgen = sgs.QVariant()
										tgen:setValue(room:getTag("atomstogetnum"):toInt() - sgs.Sanguosha:getCard(id):getNumber())
										n = n - sgs.Sanguosha:getCard(id):getNumber()
										splayer:getPile("atoms"):removeOne(id)
										room:setTag("atomstogetnum", tgen)
										room:throwCard(id, splayer)
									end
									if chosen >= sgs.Sanguosha:getCard(toget):getNumber() then
										room:obtainCard(splayer, toget)
										table.removeOne(havenotget, toget)
									end
									canget = sgs.IntList()
									cannotget = true
									for _,card_id in sgs.qlist(havenotget) do
										if sgs.Sanguosha:getCard(card_id):getNumber()<=n then
											cannotget = false
											canget:append(card_id)
										end
									end
								end
							end
						end
					end
				end
			end
		end
		return false
	end
}

atomsget = sgs.CreateTriggerSkill{
	name = "#atomsget", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.Damaged, sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.Damaged then
			local damage = data:toDamage()
			local killer = damage.from
			if not killer then return false end
			if killer:getPhase() ~= sgs.Player_NotActive then 
				room:setPlayerFlag(killer,"atomused")
			end
		elseif event == sgs.EventPhaseStart then
			local bc = room:findPlayerBySkillName("Dratoms")
			if (not bc) or (player:getPhase() ~= sgs.Player_Finish) or (not player:hasFlag("atomused")) then
				return false 
			end
			if room:askForSkillInvoke(bc, self:objectName(),sgs.QVariant()) then
				local CAS = room:getNCards(1, false)
				for _,id in sgs.qlist(CAS) do 
					bc:addToPile("atoms", id) 
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

extension:insertRelatedSkills("Dratoms", "#atomsget")

mjyuce = sgs.CreateTriggerSkill{
	name = "mjyuce", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.StartJudge,sgs.AskForRetrial}, 
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		local judge = data:toJudge()
		if event == sgs.StartJudge then
			local splayer = room:findPlayerBySkillName(self:objectName())
			if splayer and (not splayer:isKongcheng()) then
				if splayer:askForSkillInvoke(self:objectName(), data) then
					room:setTag("mjyucestruct",data)
					local card = room:askForCardShow(splayer, splayer, "mjyuce")
					room:showCard(splayer, card:getEffectiveId())
					room:setPlayerMark(splayer,"mjyuce",card:getId())
					room:broadcastSkillInvoke(self:objectName(),1)
				end
			end
		else
			if (not player:hasSkill(self:objectName())) or player:getMark("mjyuce") == 0 then return false end
			local card 
			card = sgs.Sanguosha:getCard(player:getMark("mjyuce"))
			room:setPlayerMark(player,"mjyuce",0)
			room:getThread():delay(750)
			if card:getSuit() == judge.card:getSuit() then
				player:drawCards(1)
			else
				if player:objectName() == judge.who:objectName() then return false end
				judge.who:drawCards(1)
				if judge.who:isNude() then return false end
				local prompt_list = {"@mjyuce-ask" , judge.card:getSuitString() , card:getSuitString()  ,card:getNumber(), card:objectName()}
				local prompt = table.concat(prompt_list, ":")
				local gets = sgs.QVariant()
				gets:setValue(judge.card)
				room:setTag("mjyucegets1",gets)
				gets:setValue(card)
				room:setTag("mjyucegets2",gets)
				local givecard = room:askForExchange(judge.who, self:objectName(), 1,1, true, prompt)
				if givecard then
					room:getThread():delay(750)
					room:obtainCard(player, givecard)
					room:showCard(player, givecard:getEffectiveId())
					--local slash = sgs.Sanguosha:cloneCard(card:objectName(), card:getSuit(), card:getNumber()) 
					--slash:addSubcard(judge.card)
					--judge.card = card
					local suit = givecard:getSuit()
					if suit ~= judge.card:getSuit() and suit~= card:getSuit() then
						room:getThread():delay(750)
						room:retrial(card, player, judge, self:objectName())
					end
					--data:setValue(judge)
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

zhouqibiaoCard = sgs.CreateSkillCard{
	name = "zhouqibiaoCard", 
	target_fixed = false, 
	will_throw = true, 
	filter = function(self, targets, to_select)
		return true
	end,
	on_use = function(self, room, source, targets)
		room:setPlayerMark(source,"@zhuzuspade0",0)
		room:setPlayerMark(source,"@zhuzuspade1",0)
		room:setPlayerMark(source,"@zhuzudiamond0",0)
		room:setPlayerMark(source,"@zhuzudiamond1",0)
		room:setPlayerMark(source,"@zhuzuheart1",0)
		room:setPlayerMark(source,"@zhuzuheart0",0)
		room:setPlayerMark(source,"@zhuzuclub0",0)
		room:setPlayerMark(source,"@zhuzuclub1",0)
		for _,target in ipairs(targets) do
			local damage = sgs.DamageStruct()
			damage.from = source
			damage.to = target
			room:damage(damage)
		end
	end
}

zhouqibiaoVS = sgs.CreateViewAsSkill{
	name = "zhouqibiao", 
	n = 0,
	view_as = function(self, cards)
		return zhouqibiaoCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return player:getMark("@zhuzuspade0") + player:getMark("@zhuzuspade1") +player:getMark("@zhuzudiamond0") + player:getMark("@zhuzudiamond1")+player:getMark("@zhuzuheart1")+player:getMark("@zhuzuheart0")+player:getMark("@zhuzuclub0")+player:getMark("@zhuzuclub1") == 8
	end, 
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

zhouqibiao = sgs.CreateTriggerSkill{
	name = "zhouqibiao",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed},
	view_as_skill = zhouqibiaoVS, 
	on_trigger = function(self, event, player, data)
		local use = data:toCardUse()
		local room = player:getRoom()
		local trick = use.card
		if trick then
			local splayer = room:findPlayerBySkillName(self:objectName())
			if not splayer then return false end
			if use.to:contains(splayer) and use.from:objectName()~=splayer:objectName() and (use.card:isKindOf("BasicCard") or use.card:isNDTrick()) then
				if splayer:askForSkillInvoke(self:objectName(), data) then
					local card_ids = room:getNCards(3)
					for i = 1,3,1 do
						local card = sgs.Sanguosha:getCard(card_ids:at(i-1))
						local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_SHOW, player:objectName(), "", self:objectName(), "")
						room:moveCardTo(card, player, sgs.Player_PlaceTable, reason, true)
						room:getThread():delay(334)
						room:throwCard(card, nil)
						if splayer:getMark("@zhuzu"..card:getSuitString()..math.mod(card:getNumber(),2)) == 0 then
							splayer:gainMark("@zhuzu"..card:getSuitString()..math.mod(card:getNumber(),2))
						end
					end
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return true
	end
}

dvceran = sgs.CreateTriggerSkill{
	name = "dvceran",  
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.DamageInflicted,sgs.Damaged,sgs.EventPhaseChanging,sgs.EventPhaseStart},  
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		local splayer = room:findPlayerBySkillName(self:objectName())
		if event == sgs.DamageInflicted then
			if splayer then
				local damage = data:toDamage()
				if damage.nature ~= sgs.DamageStruct_Fire and damage.nature ~= sgs.DamageStruct_Thunder then
					if splayer:getMark("@ceran") == 1 then
						damage.nature = sgs.DamageStruct_Fire
						local json = require("json")
						local jsonValue = {
						splayer:objectName(),
						"ceran"
						}
						room:doBroadcastNotify(room:getAllPlayers(),sgs.CommandType.S_COMMAND_SET_EMOTION, json.encode(jsonValue))
						data:setValue(damage)
					end
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive and player:hasSkill(self:objectName()) and player:getMark("@ceran") == 0 then
				if player:askForSkillInvoke(self:objectName(), data) then
					player:drawCards(1)
					room:broadcastSkillInvoke(self:objectName(),1)
					room:setPlayerMark(player,"@ceran",1)
				end
			end
		elseif event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Start then
				room:setPlayerMark(player,"@ceran",0)
			end
		else
			local damage = data:toDamage()
			local victim = damage.to
			if (not victim:isDead()) and splayer and damage.nature == sgs.DamageStruct_Fire then
				if victim:askForSkillInvoke(self:objectName().."give", data) then
					victim:drawCards(1)
					if victim:isNude() then return false end
					local card = room:askForExchange(victim, self:objectName(), 1,1, true, "@ceranask", false)
					if card then
						room:broadcastSkillInvoke(self:objectName(),2)
						room:obtainCard(splayer, card)
					end
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

dvdianjie = sgs.CreateTriggerSkill{
	name = "dvdianjie",
	frequency = sgs.Skill_Limited, 
	events = {sgs.CardUsed},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		local card = use.card
		if card:isNDTrick() then
			if not (use.to:length() == 1 and use.to:contains(player)) then
				if use.from:hasSkill(self:objectName()) then
					if use.from:askForSkillInvoke(self:objectName(), data) then
						use.from:loseMark("@electricbreak")
						room:broadcastSkillInvoke(self:objectName(),1)
						local id = card:getEffectiveId()
						room:setTag("Dianjie", sgs.QVariant(id))
						local getter = room:askForPlayerChosen(use.from, room:getAlivePlayers(), self:objectName())
						room:obtainCard(getter, card)
						for _,p in sgs.qlist(use.to) do 
							if p:objectName() ~= player:objectName() then
								room:damage(sgs.DamageStruct(self:objectName(), player, p, 1, sgs.DamageStruct_Thunder))
							end
						end
					end
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		if target then
			if target:hasSkill(self:objectName()) then
				if target:isAlive() then
					return target:getMark("@electricbreak") > 0
				end
			end
		end
		return false
	end
}

dvdianjieStart = sgs.CreateTriggerSkill{
	name = "#dvdianjieStart",
	events = {sgs.GameStart},
	on_trigger = function(self, event, player, data)
		player:gainMark("@electricbreak", 1)
	end
}

dvdianjieAvoid = sgs.CreateTriggerSkill{
	name = "#dvdianjieAvoid",
	events = {sgs.CardEffected,CardFinished},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardEffected then
			if player:isAlive() then
				local effect = data:toCardEffect()
				local card = effect.card
				local tag = room:getTag("Dianjie")
				local id = tag:toInt()
				if id == card:getEffectiveId() then
					room:removeTag("Dianjie")
					return true
				end
			end
		elseif event == sgs.CardFinished then
			room:removeTag("Dianjie")
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

slransu = sgs.CreateTriggerSkill{
	name = "slransu",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		if player:getPhase() == sgs.Player_Draw then
			local room = player:getRoom()
			if room:askForSkillInvoke(player, self:objectName()) then
				local ids = room:getNCards(3, false)
				local move = sgs.CardsMoveStruct()
				move.card_ids = ids
				move.to = player
				move.to_place = sgs.Player_PlaceTable
				move.reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TURNOVER, player:objectName(), self:objectName(), nil)
				room:moveCardsAtomic(move, true)
				local card1 = sgs.Sanguosha:getCard(ids:at(0))
				local card2 = sgs.Sanguosha:getCard(ids:at(1))
				local card3 = sgs.Sanguosha:getCard(ids:at(2))
				local dummy = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
				local dis = sgs.Sanguosha:cloneCard("jink", sgs.Card_NoSuit, 0)
				local a = false
				if card1:isRed() == card2:isRed() then
					if card1:isRed() == card3:isRed() then
						for _, id in sgs.qlist(ids) do
							dummy:addSubcard(id)
						end
					else
						dummy:addSubcard(ids:at(0))
						dummy:addSubcard(ids:at(1))
						dis:addSubcard(ids:at(2))
						a = true
					end
				else
					if card1:isRed() == card3:isRed() then
						dummy:addSubcard(ids:at(0))
						dummy:addSubcard(ids:at(2))
						dis:addSubcard(ids:at(1))
						a = true
					else
						dummy:addSubcard(ids:at(1))
						dummy:addSubcard(ids:at(2))
						dis:addSubcard(ids:at(0))
						a = true
					end
				end
				room:getThread():delay(900)
				room:obtainCard(player, dummy)
				if a then
					local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_NATURAL_ENTER, player:objectName(), self:objectName(), nil)
					room:throwCard(dis, reason, nil)
					local players = sgs.SPlayerList()
					local all = room:getOtherPlayers(player)
					for _,t in sgs.qlist(all) do
						if not t:isNude() then
							players:append(t)
						end
					end
					if players:length() == 0 then return false end
					local target = room:askForPlayerChosen(player, players, "slransu")
					local use = sgs.CardUseStruct()
					use.card = sgs.Sanguosha:cloneCard("fireup", sgs.Card_NoSuit, 0)
					use.from = player
					use.to:append(target)
					room:useCard(use, false)
				end
				return true
			end
		end
	end
}

slmoyan = sgs.CreateTriggerSkill{
	name = "slmoyan",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.AskForPeaches},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local dying_data = data:toDying()
		local source = dying_data.who
		if source:objectName() == player:objectName() then
			local cards = player:getCards("he")
			if cards:length() > 0 then
				if player:askForSkillInvoke(self:objectName(), data) then
					local players = room:getOtherPlayers(player)
					local target = room:askForPlayerChosen(player, players, "slmoyan")
					local allcard = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
					for _,card in sgs.qlist(cards) do
						allcard:addSubcard(card)
					end
					room:broadcastSkillInvoke(self:objectName(),1)
					room:obtainCard(target, allcard)
				end
			end
		end
		return false
	end
}

mlspcr = sgs.CreateViewAsSkill{
	name = "mlspcr",
	n = 999,
	view_filter = function(self, selected, to_select)
		return to_select:getSuit() == sgs.Self:property("CDsuit"):toInt()-- and to_select:getNumber()>=sgs.Self:property("CDnum"):toInt()
	end,
	view_as = function(self, cards)
		local a = 0
		if #cards > 0 then
			for _,carda in pairs(cards) do
				a = a + carda:getNumber()
			end
		end
		if #cards > 0 and a >= sgs.Self:property("CDnum"):toInt() then
			local trick = sgs.Sanguosha:cloneCard(sgs.Self:property("CDname"):toString(), sgs.Self:property("CDsuit"):toInt(), sgs.Self:property("CDnum"):toInt())
			--local trick = sgs.Sanguosha:cloneCard(sgs.Sanguosha:getCard(sgs.Self:getMark("mlspcr")))
			for _,card in pairs(cards) do
				trick:addSubcard(card)
			end
			trick:setSkillName(self:objectName())
			return trick
		end
	end,
	enabled_at_play = function(self, player)
		local trick = sgs.Sanguosha:cloneCard(sgs.Self:property("CDname"):toString(), sgs.Self:property("CDsuit"):toInt(), sgs.Self:property("CDnum"):toInt())
		return player:hasFlag("mlspcrCan") and trick:isAvailable(player)
	end,
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

mlspcrTag = sgs.CreateTriggerSkill{
	name = "#mlspcrTag",
	events = {sgs.CardUsed, sgs.EventPhaseChanging},
	frequency = sgs.Skill_Compulsory,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardUsed then
			local use = data:toCardUse()
			if player:getPhase() ~= sgs.Player_Play or ((not use.card:isKindOf("BasicCard")) and (not use.card:isKindOf("TrickCard"))) or use.card:isKindOf("Nullification") then return false end
			room:setPlayerFlag(player, "mlspcrCan")
			room:setPlayerProperty(player, "CDname", sgs.QVariant(use.card:objectName()))
			room:setPlayerProperty(player, "CDnum", sgs.QVariant(use.card:getNumber()))
			room:setPlayerProperty(player, "CDsuit", sgs.QVariant(use.card:getSuit()))
			room:setPlayerProperty(player, "CDainame", sgs.QVariant(use.card:getClassName()))
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				room:setPlayerProperty(player, "CDname", sgs.QVariant())
				room:setPlayerProperty(player, "CDnum", sgs.QVariant())
				room:setPlayerProperty(player, "CDsuit", sgs.QVariant())
				room:setPlayerProperty(player, "CDainame", sgs.QVariant())
			end
		end
	end
}

nsboyi = sgs.CreateTriggerSkill{
	name = "nsboyi",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TargetSpecifying, sgs.CardUsed},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.TargetSpecifying then
			local use = data:toCardUse()
			local card = use.card
			if use.to:length() == 1 then
				if use.from then
					if use.from:hasSkill(self:objectName()) and use.from:getMark("nsboyi") ~= 1 then
						if card:isNDTrick() or card:isKindOf("BasicCard") then
							local targets = sgs.SPlayerList()
							for _, p in sgs.qlist(room:getOtherPlayers(use.from)) do
								if (not p:isKongcheng()) and (p:objectName() ~= use.from:objectName()) and (not use.to:contains(p)) then
									targets:append(p)
								end
							end
							if targets:isEmpty() then return false end
							if use.from:isKongcheng() then return false end
							if room:askForSkillInvoke(player, self:objectName(), data) then
								local target = room:askForPlayerChosen(player, targets, self:objectName(), "nsboyi-invoke")
								if target then
									local card1 = room:askForCardShow(target, use.from, "nsboyito")
									local card2 = room:askForCardShow(use.from, use.from, "nsboyi")
									local card_id1 = card1:getEffectiveId()
									local card_id2 = card2:getEffectiveId()
									room:showCard(target, card_id1)
									room:showCard(use.from, card_id2)
									room:broadcastSkillInvoke(self:objectName(),1)
									if card1:getTypeId() == card2:getTypeId() then
										use.to:append(target)
										room:sortByActionOrder(use.to)
										room:throwCard(card2,use.from,use.from)
										room:setEmotion(target,"baiaim")
										data:setValue(use)
									else
										room:setPlayerMark(use.from,"nsboyi",1)
									end
								end
							end
						end
					end
				end
			end
		elseif event == sgs.CardUsed then
			for _, p in sgs.qlist(room:getAlivePlayers()) do
				room:setPlayerMark(p,"nsboyi",0)
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

nsjunheng = sgs.CreateTriggerSkill{
	name = "nsjunheng",
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.CardsMoveOneTime}, 
	on_trigger = function(self, event, player, data)
		if player:isAlive() then
			if player:hasSkill(self:objectName()) then
				if player:getPhase() == sgs.Player_NotActive then
					if event == sgs.CardsMoveOneTime then
						local move = data:toMoveOneTime()
						local source = move.from
						if source and source:objectName() == player:objectName() then
							local places = move.from_places
							local room = player:getRoom()
							if places:contains(sgs.Player_PlaceHand) or places:contains(sgs.Player_PlaceEquip) then
								if room:askForSkillInvoke(player, self:objectName(), data) then
									room:broadcastSkillInvoke(self:objectName(),1)
									local promptlist = {"nsjunhengask",player:objectName()}
									local prompt = table.concat(promptlist, ":")
									local card = room:askForCard(room:getCurrent(), ".", prompt, data, self:objectName())
									if not card then
										room:drawCards(player,1)
									end
								end
							end
						end
					end
				end
			end
		end
		return false
	end, 
	can_trigger = function(self, target)
		return target
	end
}

fkbai = sgs.CreateTriggerSkill{
	name = "fkbai",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TargetConfirming, sgs.EventPhaseChanging},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.TargetConfirming then
			local use = data:toCardUse()
			local card = use.card
			if use.to:length() == 1 then
				if use.from then
					local to = nil
					for _,p in sgs.qlist(use.to) do
						to = p
					end
					if to == nil then return false end
					if (use.from:hasSkill(self:objectName()) or to:hasSkill(self:objectName())) and use.from:getMark("@fkbai") ~= 1 then
						if card:isNDTrick() or card:isKindOf("Slash") then
							local from = use.from:hasSkill(self:objectName())
							if from then --使用牌
								if use.from:getMark("@fkbaiup") == 1 then -- 上摆
									if room:askForSkillInvoke(use.from, self:objectName(), data) then
										local upseat = nil
										for _,t in sgs.qlist(room:getOtherPlayers(to)) do
											if to:getSeat() == math.mod(t:getSeat(),to:aliveCount())+1 then
												upseat = t
												break
											end
										end
										if upseat == nil then return false end
										use.to:append(upseat)
										room:setPlayerMark(use.from,"@fkbaiup",0)
										room:setPlayerMark(use.from,"@fkbaidown",1)
										room:setPlayerMark(use.from,"@fkbai",1)
										room:setEmotion(to,"baiup")
										room:setEmotion(upseat,"baiaim")
										data:setValue(use)
										--room:getThread():trigger(sgs.TargetConfirming, room, upseat, data)
									end
								elseif use.from:getMark("@fkbaidown") == 1 then -- 下摆
									if room:askForSkillInvoke(use.from, self:objectName(), data) then
										local upseat = nil
										for _,t in sgs.qlist(room:getOtherPlayers(to)) do
											if t:getSeat() == math.mod(to:getSeat(),to:aliveCount())+1 then
												upseat = t
												break
											end
										end
										if upseat == nil then return false end
										use.to:append(upseat)
										room:setPlayerMark(use.from,"@fkbaidown",0)
										room:setPlayerMark(use.from,"@fkbaiup",1)
										room:setPlayerMark(use.from,"@fkbai",1)
										room:setEmotion(to,"baidown")
										room:setEmotion(upseat,"baiaim")
										data:setValue(use)
										--room:getThread():trigger(sgs.TargetConfirming, room, upseat, data)
									end
								end
							else -- 被使用牌
								if to:getMark("@fkbaiup") == 1 then -- 上摆
									if room:askForSkillInvoke(to, self:objectName(), data) then
										local upseat = nil
										for _,f in sgs.qlist(room:getOtherPlayers(to)) do
											if to:getSeat() == math.mod(f:getSeat(),to:aliveCount())+1 then
												upseat = f
												break
											end
										end
										if upseat == nil then return false end
										use.to:append(upseat)
										room:setPlayerMark(to,"@fkbaiup",0)
										room:setPlayerMark(to,"@fkbaidown",1)
										room:setPlayerMark(use.from,"@fkbai",1)
										room:setEmotion(to,"baiup")
										room:setEmotion(upseat,"baiaim")
										data:setValue(use)
										--room:getThread():trigger(sgs.TargetConfirming, room, upseat, data)
									end
								elseif to:getMark("@fkbaidown") == 1 then -- 下摆
									if room:askForSkillInvoke(player, self:objectName(), data) then
										local upseat = nil
										for _,f in sgs.qlist(room:getOtherPlayers(to)) do
											if f:getSeat() == math.mod(to:getSeat(),to:aliveCount())+1 then
												upseat = f
												break
											end
										end
										if upseat == nil then return false end
										use.to:append(upseat)
										room:setPlayerMark(to,"@fkbaidown",0)
										room:setPlayerMark(to,"@fkbaiup",1)
										room:setPlayerMark(use.from,"@fkbai",1)
										room:setEmotion(to,"baidown")
										room:setEmotion(upseat,"baiaim")
										data:setValue(use)
										--room:getThread():trigger(sgs.TargetConfirming, room, upseat, data)
									end
								end
							end
						--	room:setPlayerMark(use.from,"@fkbai",1)
						end
					end
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to ~= sgs.Player_NotActive then return false end
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				room:setPlayerMark(p,"@fkbai",0)
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

fkbaiStart = sgs.CreateTriggerSkill{
	name = "#fkbaiStart",
	events = {sgs.GameStart},
	on_trigger = function(self, event, player, data)
		player:gainMark("@fkbaidown", 1)
	end
}

fkwoliuCard = sgs.CreateSkillCard{
	name = "fkwoliuCard",
	target_fixed = false,
	will_throw = true,
	filter = function(self, targets, to_select)
		if #targets == 0 then
			return true
		elseif #targets == 1 then
			return to_select:getSeat() == math.mod(targets[1]:getSeat(),sgs.Self:aliveCount())+1 or targets[1]:getSeat() == math.mod(to_select:getSeat(),sgs.Self:aliveCount())+1
		end
	end,
	feasible = function(self, targets)
		return #targets == 2
	end,
	on_use = function(self, room, source, targets)
		room:swapSeat(targets[1],targets[2])
		source:turnOver()
	end
}

fkwoliuVS = sgs.CreateViewAsSkill{
	name = "fkwoliu" ,
	n = 0 ,
	view_as = function(self, cards) 
		return fkwoliuCard:clone()
	end, 
	enabled_at_play = function()
		return false
	end ,
	enabled_at_response = function(self, player, pattern)
		return string.find(pattern, "@@fkwoliu") and sgs.Slash_IsAvailable(player) and player:faceUp()
	end
}

fkwoliu = sgs.CreateTriggerSkill{
	name = "fkwoliu", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseChanging,sgs.TurnedOver}, 
	view_as_skill = fkwoliuVS, 
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		if event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			local nextphase = change.to
			if not player:isSkipped(nextphase) then
				if nextphase == sgs.Player_Start then
					room:askForUseCard(player, "@@fkwoliu", "@fkwoliu")
				end
			end
		elseif event == sgs.TurnedOver then
			local tarlist = sgs.SPlayerList()
			local slash = sgs.Sanguosha:cloneCard("thunder_slash", sgs.Card_NoSuit, 0)
			slash:setSkillName("fkwoliu")
			for _,f in sgs.qlist(room:getOtherPlayers(player)) do
				if player:canSlash(f, slash, true) then
					tarlist:append(f)
				end
			end
			if tarlist:isEmpty() then return false end
			local target = room:askForPlayerChosen(player, tarlist, self:objectName(), "fkwoliu-invoke", true)
			if target then
				local card_use = sgs.CardUseStruct()
				card_use.card = slash
				card_use.from = player
				card_use.to:append(target)
				room:useCard(card_use, false)
			end
		end
		return false
	end
}

fkhuizhuanCard = sgs.CreateSkillCard{
	name = "fkhuizhuan" ,
	target_fixed = true ,
	on_use = function(self, room, source)
		room:setPlayerMark(source,"@fkbai",0)
		room:loseHp(source)
	end
}
fkhuizhuan = sgs.CreateZeroCardViewAsSkill{
	name = "fkhuizhuan" ,
	enabled_at_play = function(self, player)
		return true
	end ,
	view_as = function()
		return fkhuizhuanCard:clone()
	end
}

Table2IntList = function(theTable)
	local result = sgs.IntList()
	for i = 1, #theTable, 1 do
		result:append(theTable[i])
	end
	return result
end

function brtongxinMove(ids, movein, player)
	local room = player:getRoom()
	if movein then
		local move = sgs.CardsMoveStruct(ids, nil, player, sgs.Player_PlaceTable, sgs.Player_PlaceSpecial,
			sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, player:objectName(), "brtongxin", ""))
		move.to_pile_name = "&brtongxin"
		local moves = sgs.CardsMoveList()
		moves:append(move)
		local _player = sgs.SPlayerList()
		_player:append(player)
		room:notifyMoveCards(true, moves, false, _player)
		room:notifyMoveCards(false, moves, false, _player)
	else
		local move = sgs.CardsMoveStruct(ids, player, nil, sgs.Player_PlaceSpecial, sgs.Player_PlaceTable,
			sgs.CardMoveReason(sgs.CardMoveReason_S_MASK_BASIC_REASON, player:objectName(), "brtongxin", ""))
		move.from_pile_name = "&brtongxin"
		local moves = sgs.CardsMoveList()
		moves:append(move)
		local _player = sgs.SPlayerList()
		_player:append(player)
		room:notifyMoveCards(true, moves, false, _player)
		room:notifyMoveCards(false, moves, false, _player)
	end
end

brtongxincard = sgs.CreateSkillCard{
	name = "brtongxin",
	target_fixed = false,
	will_throw = false,
	filter = function(self, targets, to_select, player)
		return to_select:objectName() ~= player:objectName() and #targets < 1
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local ids = effect.to:handCards()
		local idse = effect.from:handCards()
		brtongxinMove(ids, true, effect.from)
		brtongxinMove(idse, true, effect.to)
		room:setPlayerProperty(effect.from, "brtongxintoc", sgs.QVariant(table.concat(sgs.QList2Table(ids), "+")))
		room:setPlayerProperty(effect.to, "brtongxinfromc", sgs.QVariant(table.concat(sgs.QList2Table(idse), "+")))
		room:setTag("tongxinfrom", sgs.QVariant(effect.from:objectName()))
		room:setTag("tongxinto", sgs.QVariant(effect.to:objectName()))
		--room:setTag("Dongchaee", sgs.QVariant(effect.to:objectName().."+"..effect.from:objectName()))
		--room:setTag("Dongchaer", sgs.QVariant(effect.to:objectName().."+"..effect.from:objectName()))
	end
}

brtongxin = sgs.CreateViewAsSkill{
	name = "brtongxin",
	n = 0,
	view_as = function(self, cards) 
		return brtongxincard:clone()
	end, 
	enabled_at_play = function(self, player)
		return not player:hasUsed("#brtongxin")
	end
}

brtongxinclear = sgs.CreateTriggerSkill{
	name = "#brtongxinclear",
	events = {sgs.TurnStart, sgs.CardsMoveOneTime},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.TurnStart then
			if player:objectName() ~= room:getTag("tongxinfrom"):toString() then return false end
			local list = player:property("brtongxintoc"):toString():split("+")
			local list2 = nil
			local to = nil
			if #list > 0 then
				for _,f in sgs.qlist(room:getOtherPlayers(player)) do
					if f:objectName() == room:getTag("tongxinto"):toString() then
						list2 = f:property("brtongxinfromc"):toString():split("+")
						to = f
					end
				end
				brtongxinMove(Table2IntList(list), false, player)
				if list2 == nil or to == nil then return false end
				brtongxinMove(Table2IntList(list2), false, to)
			end
			--room:setTag("Dongchaee", sgs.QVariant())
			--room:setTag("Dongchaer", sgs.QVariant())
			room:setPlayerProperty(player, "brtongxintoc", sgs.QVariant())
			room:setPlayerProperty(to, "brtongxinfromc", sgs.QVariant())
		else
			local move = data:toMoveOneTime()
			if move.from and move.from_places:contains(sgs.Player_PlaceHand) and room:getTag("tongxinto"):toString() == move.from:objectName() then
				if move.from:objectName() == room:getTag("tongxinto"):toString() then
					local list = player:property("brtongxintoc"):toString():split("+")
					if #list > 0 then
						local to_remove = sgs.IntList()
						for _,l in pairs(list) do
							if move.card_ids:contains(tonumber(l)) then
								to_remove:append(tonumber(l))
							end
						end
						brtongxinMove(to_remove, false, player)
						for _,id in sgs.qlist(to_remove) do
							table.removeOne(list, tostring(id))
						end
						local pattern = sgs.QVariant()
						if #list > 0 then
							pattern = sgs.QVariant(table.concat(list, "+"))
						end
						room:setPlayerProperty(player, "brtongxintoc", pattern)
					end
				else
					local to = nil
					for _,f in sgs.qlist(room:getAlivePlayers()) do
						local a = f:property("brtongxinfromc"):toString():split("+")
						if #a > 0 then
							to = f
						end
					end
					if to == nil then return false end
					local list = to:property("brtongxinfromc"):toString():split("+")
					if #list > 0 then
						local to_remove = sgs.IntList()
						for _,l in pairs(list) do
							if move.card_ids:contains(tonumber(l)) then
								to_remove:append(tonumber(l))
							end
						end
						brtongxinMove(to_remove, false, to)
						for _,id in sgs.qlist(to_remove) do
							table.removeOne(list, tostring(id))
						end
						local pattern = sgs.QVariant()
						if #list > 0 then
							pattern = sgs.QVariant(table.concat(list, "+"))
						end
						room:setPlayerProperty(to, "brtongxinfromc", pattern)
					end
				end
			elseif move.to and move.to_place == sgs.Player_PlaceHand and (move.to:objectName() == room:getTag("tongxinto"):toString() or move.to:objectName() == room:getTag("tongxinfrom"):toString()) then
				if move.to:objectName() == room:getTag("tongxinto"):toString() then
					local list = player:property("brtongxintoc"):toString():split("+")
					local to_add = sgs.IntList()
					for _,id in sgs.qlist(move.card_ids) do
						if not table.contains(list, tostring(id)) then
							table.insert(list, tostring(id))
							to_add:append(id)
						end
					end
					brtongxinMove(to_add, true, player)
					local pattern = sgs.QVariant(table.concat(list, "+"))
					room:setPlayerProperty(player, "brtongxintoc", pattern)
				else
					local to = nil
					for _,f in sgs.qlist(room:getAlivePlayers()) do
						if f:objectName() == room:getTag("tongxinto"):toString() then
							to = f
						end
					end
					if to == nil then return false end
					local list = to:property("brtongxinfromc"):toString():split("+")
					local to_add = sgs.IntList()
					for _,id in sgs.qlist(move.card_ids) do
						if not table.contains(list, tostring(id)) then
							table.insert(list, tostring(id))
							to_add:append(id)
						end
					end
					brtongxinMove(to_add, true, to)
					local pattern = sgs.QVariant(table.concat(list, "+"))
					room:setPlayerProperty(to, "brtongxinfromc", pattern)
				end
			end
		end
	end
}

mtliebianslCard = sgs.CreateSkillCard{
	name = "mtliebianslCard", 
	target_fixed = false, 
	will_throw = true,
	filter = function(self, targets, to_select) 
		local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		slash:setSkillName("mtliebian")
		slash:deleteLater()
		return #targets < sgs.Self:getMark("liebianslashmk") and slash:targetFilter(sgs.PlayerList(), to_select, sgs.Self)
	end,
	on_use = function(self, room, source, targets)
		room:setPlayerMark(source,"liebianslashmk",0)
		local tarlist = sgs.SPlayerList()
		for _, p in ipairs(targets) do
			tarlist:append(p)
		end
		for _, p in sgs.qlist(tarlist) do
			if not source:canSlash(p, nil, false) then
				tarlist:removeOne(p)
			end
		end
		if tarlist:length() > 0 then
			local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
			slash:setSkillName("mtliebian")
			room:useCard(sgs.CardUseStruct(slash, source, tarlist))
		end
	end
}

mtliebianCard = sgs.CreateSkillCard{
	name = "mtliebianCard", 
	target_fixed = true, 
	will_throw = true,
	on_use = function(self, room, source, targets)
		local cards = self:getSubcards()
		local maxp = 0
		local point = 0
		local cardsn = 0
		for _,card in sgs.qlist(cards) do
			maxp = maxp + sgs.Sanguosha:getCard(card):getNumber()
		end
		while maxp >= point do
			local tocards = room:getNCards(1)
			local move = sgs.CardsMoveStruct()
			move.card_ids = tocards
			move.to = source
			move.to_place = sgs.Player_PlaceTable
			move.reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TURNOVER, source:objectName(), self:objectName(), nil)
			room:moveCardsAtomic(move, true)
			room:getThread():delay(1000)
			for _,id in sgs.qlist(tocards) do
				room:obtainCard(source, id)
				cardsn = cardsn + 1
				point = point + sgs.Sanguosha:getCard(id):getNumber()
			end
		end
		if cardsn <= 2 then
			room:setPlayerMark(source,"liebianslashmk",cards:length())
			room:askForUseCard(source, "@@mtliebian", "@mtliebian:"..cards:length())
		end
	end
}

mtliebianvs = sgs.CreateViewAsSkill{
	name = "mtliebian", 
	n = 999, 
	view_filter = function(self, selected, to_select)
		if #selected == 0 then
			return (not sgs.Self:isJilei(to_select)) and sgs.Self:getMark("liebianslashmk") == 0
		else
			for _, c in ipairs(selected) do
				if c:getTypeId() == to_select:getTypeId() then return false end
			end
			return true
		end
	end ,
	view_as = function(self, cards) 
		local scard = mtliebianslCard:clone()
		if sgs.Self:getMark("liebianslashmk") == 0 then
			scard = mtliebianCard:clone()
			for _,card in ipairs(cards) do
				scard:addSubcard(card)
			end
		end
		
		return scard
	end, 
	enabled_at_play = function(self, player)
		return (not player:hasUsed("#mtliebianCard")) and (not player:isNude()) 
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@mtliebian" and sgs.Slash_IsAvailable(player)
	end
}

mtliebian = sgs.CreateTriggerSkill{
	name = "mtliebian",
	events = {sgs.EventPhaseChanging},
	view_as_skill = mtliebianvs,
	can_trigger = function(self, target)
	    return target
	end,
	on_trigger = function(self,event,player,data)
	    local room = player:getRoom()
		room:setPlayerMark(player,"liebianslashmk",0)
	end
}

mtliebianTargetMod = sgs.CreateTargetModSkill{
	name = "mtliebianTargetMod",
	distance_limit_func = function(self, from, card)
		if card:getSkillName() == "mtliebian" then
			return 1000
		end
		return 0
	end
}

wkluoxuancard = sgs.CreateSkillCard{
    name = "wkluoxuan",
    target_fixed = true,
    will_throw = true,
	on_use = function(self, room, source, targets)
		local phases = {"judge","draw","play","discard"}
		local newphases = {}
		for i=1,4,1 do
			local choices = table.concat(phases,"+")
			local choice = room:askForChoice(source,"wkluoxuan",choices)
			table.insert(newphases,choice)
			table.removeOne(phases,choice)
		end
		for s=1,#newphases,1 do
		    room:setPlayerMark(room:getCurrent(),newphases[s],s)
		end
		
		local log = sgs.LogMessage()
		log.type = "#wkluoxuanphase"
		log.from = source
		log.to:append(room:getCurrent())
		log.arg = "wkluoxuan"
		room:sendLog(log)
		
		local log1 = sgs.LogMessage()
		log1.type = "#wkluoxuanphase1"
		log1.arg = newphases[1]
		log1.arg2 = newphases[2]
		room:sendLog(log1)
		
		local log2 = sgs.LogMessage()
		log2.type = "#wkluoxuanphase2"
		log2.arg = newphases[3]
		log2.arg2 = newphases[4]
		room:sendLog(log2)
	end,
}

wkluoxuanvs = sgs.CreateViewAsSkill{
    name = "wkluoxuan",
    n = 1,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then return not to_select:isEquipped() end
		return false
	end,
	view_as = function(self, cards)
	    if #cards == 1 then
			local acard = wkluoxuancard:clone()
			for _,card in ipairs(cards) do
				acard:addSubcard(card)
			end
			acard:setSkillName(self:objectName())
			return acard
		end
	end,
	enabled_at_response = function(self,player,pattern) 
		return pattern == "@@wkluoxuan"
	end,
	enabled_at_play = function(self, player)
		return false
	end, 
}

clearlist = {}
wkluoxuan = sgs.CreateTriggerSkill{
	name = "wkluoxuan",
	events = {sgs.EventPhaseChanging,sgs.EventPhaseEnd},
	view_as_skill = wkluoxuanvs,
	can_trigger = function(self, target)
	    return target
	end,
	on_trigger = function(self,event,player,data)
	    local room = player:getRoom()
		if event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			local index = 0
			if change.to == sgs.Player_Start then
				local wk = room:findPlayerBySkillName(self:objectName())
				if wk and (not wk:isKongcheng()) then
					room:askForUseCard(wk, "@@wkluoxuan", "@wkluoxuan:"..player:objectName())
				end
			elseif change.to == sgs.Player_Judge then
				index = 1
			elseif change.to == sgs.Player_Draw then
				index = 2
			elseif change.to == sgs.Player_Play then
				index = 3
			elseif change.to == sgs.Player_Discard then
				index = 4
			elseif change.to == sgs.Player_Finish then
				table.insert(clearlist,"clear")
			end
			if index > 0 then
				if player:getMark("judge") == index then
					change.to = sgs.Player_Judge
				elseif player:getMark("draw") == index then
					change.to = sgs.Player_Draw
				elseif player:getMark("play") == index then
					change.to = sgs.Player_Play
				elseif player:getMark("discard") == index then
					change.to = sgs.Player_Discard
				end
				data:setValue(change)
			end
		end
		if event == sgs.EventPhaseEnd then
			if #clearlist > 0 then
				table.remove(clearlist)
				local phases = {"judge","draw","play","discard"}
				for i=1,#phases,1 do
					room:setPlayerMark(player,phases[i],0)
				end
			end
		end
	end,
	priority = 3
}

wkzhongxingive = sgs.CreateViewAsSkill{
	name = "wkzhongxingive&",
	n = 1,
	view_filter = function(self, selected, to_select)
		return to_select:getSuit() == sgs.Sanguosha:getCard(sgs.Self:getMark("zhongxinrecord")):getSuit()
	end, 
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local id = card:getId()
			local to = sgs.Sanguosha:getCard(sgs.Self:getMark("zhongxinrecord"))
			local fireattack = sgs.Sanguosha:cloneCard(to:getClassName(),to:getSuit(),to:getNumber())
			fireattack:setSkillName(self:objectName())
			fireattack:addSubcard(id)
			return fireattack
		end
	end, 
	enabled_at_play = function(self, player)
		local trick = sgs.Sanguosha:getCard(sgs.Self:getMark("zhongxinrecord"))
		return trick:isAvailable(player)
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == string.lower(sgs.Sanguosha:getCard(sgs.Self:getMark("zhongxinrecord")):objectName())
	end
}

wkzhongxincard = sgs.CreateSkillCard{
    name = "wkzhongxin",
    target_fixed = true,
    will_throw = true,
	on_use = function(self, room, source, targets)
		room:setPlayerMark(room:getCurrent(),"zhongxinrecord",self:getSubcards():at(0))
	end,
}

wkzhongxinvs = sgs.CreateViewAsSkill{
    name = "wkzhongxin",
    n = 1,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then return not to_select:isKindOf("EquipCard") end
		return false
	end,
	view_as = function(self, cards)
	    if #cards == 1 then
			local acard = wkzhongxincard:clone()
			for _,card in ipairs(cards) do
				acard:addSubcard(card)
			end
			acard:setSkillName(self:objectName())
			return acard
		end
	end,
	enabled_at_play = function(self, player)
		return false
	end, 
	enabled_at_response = function(self,player,pattern) 
		return pattern == "@@wkzhongxin"
	end,
}

wkzhongxin = sgs.CreateTriggerSkill{
	name = "wkzhongxin",
	events = {sgs.EventPhaseStart,sgs.EventPhaseEnd},
	view_as_skill = wkzhongxinvs,
	can_trigger = function(self, target)
	    return not target:hasSkill(self:objectName())
	end,
	on_trigger = function(self,event,player,data)
	    local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			local wk = room:findPlayerBySkillName(self:objectName())
			if not wk then return false end
			if wk:isKongcheng() then return false end
			if player:getPhase() == sgs.Player_Play then
				if room:askForUseCard(wk, "@@wkzhongxin", "@wkzhongxin:"..player:objectName()) then
					local cardid = player:getMark("zhongxinrecord")
					local card = sgs.Sanguosha:getCard(cardid)
					local askc = room:askForCard(player, ".|"..card:getSuitString(), "@wkzhongxinask:"..card:getSuitString()..":"..card:objectName(), sgs.QVariant(cardid), self:objectName())
					if askc then
						room:attachSkillToPlayer(player, "wkzhongxingive")
					else
						room:obtainCard(player, card)
						--room:askForUseCard(player, card:objectName().."|"..card:getSuitString().."|"..card:getNumber(), "@wkzhongxingive")
						room:askForUseCard(player, card:toString(), "@wkzhongxingive:"..card:objectName())
					end
				end
			end
		elseif event == sgs.EventPhaseEnd then
			if player:getMark("zhongxinrecord") > 0 then
				room:setPlayerMark(player,"zhongxinrecord",0)
				room:detachSkillFromPlayer(player, "wkzhongxingive")
			end
		end
	end
}

ndhuli = sgs.CreateTriggerSkill{
	name = "ndhuli",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.DamageCaused},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()
		local card = damage.card
		if not room:getCurrent():hasFlag("ndhuliused") then
			local targets = sgs.SPlayerList()
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:isWounded() then 
					targets:append(p)
				end
			end
			if targets:isEmpty() then return false end
			if room:askForSkillInvoke(player, self:objectName(), data) then
				local target = room:askForPlayerChosen(player, targets, self:objectName())
				if target then
					local recover = sgs.RecoverStruct()
					recover.who = player
					recover.recover = math.min(damage.damage, target:getLostHp())
					room:broadcastSkillInvoke(self:objectName(),1)
					local json = require("json")
					local jsonValue = {
					target:objectName(),
					"revive"
					}
					room:doBroadcastNotify(room:getAllPlayers(),sgs.CommandType.S_COMMAND_SET_EMOTION, json.encode(jsonValue))
					room:recover(target, recover)
					if card and card:isKindOf("TrickCard") then
						room:setPlayerFlag(room:getCurrent(),"ndhuliused")
					end
					return true
				end
			end
		end
	end
}

ndfengdengVS = sgs.CreateViewAsSkill{
	name = "ndfengdeng",
	n = 1,
	view_filter = function(self, selected, to_select)
		return #selected == 0 and to_select:isEquipped()
	end,
	view_as = function(self, cards)
		if #cards == 1 then
			local analeptic = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
			for _,card in ipairs(cards) do
				analeptic:addSubcard(card)
			end
			analeptic:setSkillName("ndfengdeng")
			return analeptic
		end
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@ndfengdeng"
	end
}

ndfengdeng = sgs.CreateTriggerSkill{
	name = "ndfengdeng",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.PreCardUsed, sgs.AskForPeaches},
	view_as_skill = ndfengdengVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.AskForPeaches then
			local dying = data:toDying()
			if dying.who:getHp() > 0 then return false end
			local nd = room:findPlayerBySkillName(self:objectName())
			if not nd then return false end
			if nd:faceUp() then return false end
			--local prompt = string.format("ndfengdeng-slash:%s", dying.who:objectName())
			--room:askForUseCard(nd, "slash", prompt)
			room:askForUseCard(nd, "@@ndfengdeng", "@ndfengdeng:"..dying.who:objectName())
		end
	end
}

ndfengdengTargetMod = sgs.CreateTargetModSkill{
	name = "#ndfengdengTargetMod",
	distance_limit_func = function(self, from, card)
		if from:hasSkill("ndfengdeng") then
			if card:getSkillName() == "ndfengdeng" then
				return 1000
			end
		end
		return 0
	end
}

ndcongyiVS = sgs.CreateViewAsSkill{
	name = "ndcongyi",
	n = 0,
	view_as = function(self, cards)
		local analeptic = sgs.Sanguosha:cloneCard("peach", sgs.Card_NoSuit, 0)
		analeptic:setSkillName("ndcongyi")
		return analeptic
	end,
	enabled_at_play = function(self, player)
		return player:isWounded() and player:faceUp()
	end,
	enabled_at_response = function(self, player, pattern)
		return string.find(pattern, "peach") and player:faceUp()
	end
}

ndcongyi = sgs.CreateTriggerSkill{
	name = "ndcongyi",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.PreCardUsed},
	view_as_skill = ndcongyiVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		local card = use.card
		if card:getSkillName() == "ndcongyi" and player:hasSkill(self:objectName()) then
			player:turnOver()
		end
	end
}

jlsidou = sgs.CreateTriggerSkill{
	name = "jlsidou",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.EventPhaseStart,sgs.DamageCaused},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Finish then
				--[[for _,p in sgs.qlist(room:getOtherPlayers(player)) do
					if p:getHp() < player:getHp() then
						cantrigger = true
						break
					end
				end]]--
				local duel = sgs.Sanguosha:cloneCard("duel", sgs.Card_NoSuit, 0)
				duel:setSkillName("jlsidou")
				local targets = sgs.SPlayerList()
				local maxnum = 0
				for _,p in sgs.qlist(room:getOtherPlayers(player)) do
					if p:getHp() > maxnum then
						targets = sgs.SPlayerList()
						targets:append(p)
						maxnum = p:getHp()
					elseif p:getHp() == maxnum then
						targets:append(p)
					end
				end
				if targets:length()>0 then
					local target = room:askForPlayerChosen(player, targets, self:objectName())
					if not target then return false end
					duel:toTrick():setCancelable(false)
					if not target:isCardLimited(duel, sgs.Card_MethodUse) and not target:isProhibited(player, duel) then
						room:broadcastSkillInvoke(self:objectName(),1)
						room:useCard(sgs.CardUseStruct(duel, target, player))
					else
						duel:deleteLater()
					end
				end
				return false
			end
		elseif event == sgs.DamageCaused then
			local damage = data:toDamage()
			if damage.from and damage.from:hasSkill(self:objectName()) and damage.card and damage.card:getSkillName() == "jlsidou" then
				room:drawCards(damage.from, 1)
				return true
			end
		end
	end
}

jlqunlunex = sgs.CreateMaxCardsSkill{
	name = "#jlqunlunex" ,
	extra_func = function(self, target)
		if target:hasSkill(self:objectName()) and (not target:getPile("qunlunpile"):isEmpty()) then
			return target:getPile("qunlunpile"):length()
		else
			return 0
		end
	end
}

jlqunlunCard = sgs.CreateSkillCard{
    name = "jlqunlunCard",
    will_throw = false,
	filter = function(self, targets, to_select, player)
		return #targets == 0
	end,
	on_use = function(self, room, source, targets)
		room:writeToConsole("pre QL")
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, source:objectName(), targets[1]:objectName(), "jlqunlun","")
		local log = sgs.LogMessage()
		log.type = "$jlqunlunGot"
		log.from = source	
		log.to:append(targets[1])
		log.arg = "jlqunlun"
		log.card_str = table.concat(sgs.QList2Table(self:getSubcards()),"+")
		room:sendLog(log)
		room:obtainCard(targets[1], self, reason, false)
	end
}

jlqunlunvs = sgs.CreateOneCardViewAsSkill{
	name = "jlqunlun", 
	filter_pattern = ".|.|.|qunlunpile",
	expand_pile = "qunlunpile",
	view_as = function(self, card)
	    local scard = jlqunlunCard:clone()
		scard:addSubcard(card)
		return scard
	end,
	enabled_at_play = function(self, player)
		return not player:getPile("qunlunpile"):isEmpty() and player:usedTimes("#jlqunlunCard") < (player:getLostHp() + 1)
	end
}

jlqunlun = sgs.CreateTriggerSkill{
	name = "jlqunlun",
	view_as_skill = jlqunlunvs,
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed, sgs.CardResponded} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local card = nil
		if event == sgs.CardUsed then
			local use = data:toCardUse()
			card = use.card
		else
			card = data:toCardResponse().m_card
		end
		if card and card:getTypeId() ~= sgs.Card_TypeSkill then
			local oldtype = ""
			if player:getMark("qunluntri") == 0 then
				room:setPlayerMark(player,"qunluntri",1)
				room:setPlayerMark(player,"@jlqunlun"..card:getType(),1)
			else
				oldtype = player:property("qunlunrecord"):toString()
			end
			if oldtype == card:getType() then
				if room:askForSkillInvoke(player, self:objectName(), data) then
					local id = room:drawCard()
					player:addToPile("qunlunpile", id)
				end
			else
				room:setPlayerMark(player,"@jlqunlun"..oldtype,0)
				room:setPlayerMark(player,"@jlqunlun"..card:getType(),1)
				room:setPlayerProperty(player, "qunlunrecord", sgs.QVariant(card:getType()))
			end
		end
		return false
	end
}

lpfengshouCard = sgs.CreateSkillCard{
	name = "lpfengshouCard" ,
	filter = function(self, targets, to_select)
		if #targets >= sgs.Self:getMark("fengshouc") then return false end
		return to_select:getMark("fengshouto") == 1
	end,
	on_effect = function(self, effect)
		effect.to:getRoom():setPlayerMark(effect.to, "fengshouto", 0)
		effect.to:getRoom():setEmotion(effect.to,"lpbanned")
	end
}

lpfengshouvs = sgs.CreateViewAsSkill{
	name = "lpfengshou",
	n = 999,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then
			return sgs.Self:getMark("fengshouing") == 0
		elseif #selected <= sgs.Self:getMark("fengshouc") then
			local flag = true
			for i = 1,#selected,1 do
				if selected[i]:getSuit() == to_select:getSuit() then
					flag = false
				end
			end
			return flag
		else
			return false
		end
	end,
	view_as = function(self, cards)
		if #cards == (sgs.Self:getMark("fengshouc") + 1) then
			local zhiheng_card = sgs.Sanguosha:cloneCard("amazing_grace", sgs.Card_NoSuit, 0)
			for _,card in pairs(cards) do
				zhiheng_card:addSubcard(card)
			end
			zhiheng_card:setSkillName("lpfengshou")
			return zhiheng_card
		elseif (#cards == 0) and (sgs.Self:getMark("fengshouing") == 1) then
			return lpfengshouCard:clone()
		end
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@lpfengshou"
	end
}

lpfengshou = sgs.CreateTriggerSkill{
	name = "lpfengshou",
	view_as_skill = lpfengshouvs,
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TargetConfirming,sgs.EventPhaseChanging} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.TargetConfirming then
			local use = data:toCardUse()
			local card = use.card
			if card:getSkillName() == "lpfengshou" then
				local oldc = player:getMark("fengshouc")
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					if use.to:contains(p) then 
						room:setPlayerMark(p, "fengshouto", 1)
					end
				end
				room:setPlayerMark(player, "fengshouing", 1)
				if oldc > 0 then
					local forbidc = room:askForUseCard(player, "@@lpfengshou", "@lpfengshou:"..oldc)
					if forbidc then
						for _,t in sgs.qlist(room:getAlivePlayers()) do
							if use.to:contains(t) and (t:getMark("fengshouto") == 0) then 
								use.to:removeOne(t)
							end
						end
					end
				end
				room:setPlayerMark(player, "fengshouing", 0)
				for _,t in sgs.qlist(room:getAlivePlayers()) do
					room:setPlayerMark(t, "fengshouto", 0)
				end
				room:setPlayerMark(player, "fengshouc", oldc + 1)
				data:setValue(use)
			end
		elseif event == sgs.EventPhaseChanging then
			room:setPlayerMark(player, "fengshouc", 0)
		end 
		return false
	end
}

lpyusui = sgs.CreateTriggerSkill{
	name = "lpyusui",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardUsed then
			local use = data:toCardUse()
			local card = use.card
			if card:isKindOf("AmazingGrace") then
				if not player:hasFlag("lpyusuiused") then
					if room:askForSkillInvoke(player, self:objectName(), data) then
						local x = player:aliveCount()
						local ids = room:getNCards(x)
						local move = sgs.CardsMoveStruct()
						move.card_ids = ids
						move.to = player
						move.to_place = sgs.Player_PlaceTable
						move.reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TURNOVER, player:objectName(), self:objectName(), nil)
						room:moveCardsAtomic(move, true)
						local card_to_throw = {}
						local card_to_gotback = {}
						local suitlist = {}
						for i=0, x-1, 1 do
							local id = ids:at(i)
							local card = sgs.Sanguosha:getCard(id)
							local suit = card:getSuit()
							if not table.contains(suitlist, card:getSuitString()) then
								table.insert(suitlist, card:getSuitString())
							end
						end
						local aidata = sgs.QVariant()
						aidata:setValue(ids)
						local choice = room:askForChoice(player, self:objectName(), table.concat(suitlist,"+"), aidata)
						for i=0, x-1, 1 do
							local id = ids:at(i)
							local card = sgs.Sanguosha:getCard(id)
							local suit = card:getSuitString()
							if suit ~= choice then
								table.insert(card_to_throw, id)
							else
								table.insert(card_to_gotback, id)
							end
						end
						local target = room:askForPlayerChosen(player, room:getAlivePlayers(), "lpyusuiask")
						if #card_to_throw > 0 then
							for i = 1, #card_to_throw, 1 do
								room:moveCardTo(sgs.Sanguosha:getCard(card_to_throw[i]), player, nil ,sgs.Player_DrawPile, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, player:objectName(), self:objectName(), nil))
							end
							--local moveA = sgs.CardsMoveStruct()
						--	moveA.card_ids = result
						--	moveA.to_place = sgs.Player_DrawPile
						--	room:moveCardsAtomic(moveA, false)
							room:askForGuanxing(player, room:getNCards(#card_to_throw), 1)
						end
						if #card_to_gotback > 0 then
							local dummy2 = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
							for _, id in ipairs(card_to_gotback) do
								dummy2:addSubcard(id)
							end
							room:obtainCard(target, dummy2)
						end
						room:setPlayerFlag(player,"lpyusuiused")
						room:broadcastSkillInvoke(self:objectName(),1)
					end
				end
			end
		end 
		return false
	end
}

fmchongzhengCard = sgs.CreateSkillCard{
	name = "fmchongzhengCard", 
	target_fixed = true, 
	will_throw = false,
	on_use = function(self, room, source, targets)
		local tos = sgs.SPlayerList()
		for _,p in sgs.qlist(room:getOtherPlayers(source)) do
			if not p:isNude() then
				tos:append(p)
			end
		end
		room:drawCards(source,1)
		if tos:isEmpty() then return false end
		for _,t in sgs.qlist(tos) do
			if not t:isNude() then
				local id = room:askForCardChosen(source, t, "he", self:objectName())
				local card = sgs.Sanguosha:getCard(id)
				local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, t:objectName(), source:objectName(), self:objectName(), nil)
				reason.m_playerId = t:objectName()
				room:moveCardTo(card, t, source, sgs.Player_PlaceHand, reason)
			end
		end
		for _,t in sgs.qlist(tos) do
			if not source:isNude() then
				room:setPlayerProperty(source, "fmchongzhengreturnto", sgs.QVariant(t:objectName()))
				local toc = room:askForExchange(source, "fmchongzheng", 1, 1, true, "fmchongzhenggive:"..t:objectName())
				room:setPlayerProperty(source, "fmchongzhengreturnto", sgs.QVariant())
				local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, source:objectName(), t:objectName(), self:objectName(), nil)
				reason.m_playerId = t:objectName()
				room:moveCardTo(toc, source, t, sgs.Player_PlaceHand, reason)
			end
		end
	end
}

fmchongzheng = sgs.CreateViewAsSkill{
	name = "fmchongzheng", 
	n = 0, 
	view_as = function(self, cards) 
		return fmchongzhengCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return not player:hasUsed("#fmchongzhengCard")
	end
}

fmtugouCard = sgs.CreateSkillCard{
	name = "fmtugouCard" ,
	will_throw = false ,
	target_fixed = false ,
	handling_method = sgs.Card_MethodNone,
	filter = function(self, targets, to_select)
		return #targets == 0 and to_select:getPile("fmpicture"):isEmpty() and to_select:objectName() ~= sgs.Self:objectName()
	end,
	on_use = function(self, room, source, targets)
		targets[1]:addToPile("fmpicture", self, false)
	end
}

fmtugouvs = sgs.CreateViewAsSkill{
	name = "fmtugou", 
	n = 1, 
	view_filter = function(self, selected, to_select)
		return #selected == 0 and (not to_select:isEquipped())
	end,
	view_as = function(self, cards) 
		if #cards ~= 1 then return false end
		local wine = fmtugouCard:clone()
		for _, c in ipairs(cards) do
			wine:addSubcard(c)
		end
		wine:setSkillName(self:objectName())
		return wine
	end, 
	enabled_at_play = function(self, player)
		return not player:isKongcheng()
	end
}

fmtugou = sgs.CreateTriggerSkill{
	name = "fmtugou",
	view_as_skill = fmtugouvs,
	events = {sgs.EventPhaseStart, sgs.BeforeCardsMove, sgs.CardUsed, sgs.PreCardUsed},
	can_trigger = function(self, target)
		return target ~= nil and target:isAlive()
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:isAlive() and player:hasSkill(self:objectName()) and player:getPhase() == sgs.Player_Start then
				for _, p in sgs.qlist(room:getAlivePlayers()) do
					if not p:getPile("fmpicture"):isEmpty() then
						local card = sgs.Sanguosha:getCard(p:getPile("fmpicture"):first())
						local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_EXCHANGE_FROM_PILE, player:objectName(), self:objectName(), "")
						room:obtainCard(player, card, reason, false)	
					end
				end
			end
		elseif event == sgs.CardUsed then
			local use = data:toCardUse()
			if use.card:getSkillName() == "madejian" then
				use.from:getRoom():broadcastSkillInvoke(self:objectName(),1)
			end
		elseif event == sgs.PreCardUsed then
			if data:toCardUse().card:getSkillName() == "fmtugou" then return true end
		else 
			local move = data:toMoveOneTime()
			if (move.to_place ~= sgs.Player_DiscardPile) then return end
			if not player:hasSkill(self:objectName()) then return end
			local to_obtain = nil
			if bit32.band(move.reason.m_reason, sgs.CardMoveReason_S_MASK_BASIC_REASON) == sgs.CardMoveReason_S_REASON_RESPONSE  or bit32.band(move.reason.m_reason, sgs.CardMoveReason_S_MASK_BASIC_REASON) == sgs.CardMoveReason_S_REASON_USE then 
				if move.from and player:objectName() == move.from:objectName() then return end 
				to_obtain = move.reason.m_extraData:toCard()
				if (not to_obtain) or move.from:getPile("fmpicture"):isEmpty() or move.from:getPhase() == sgs.Player_NotActive then return end
			else
				return 
			end
			if to_obtain then 
				local pic = sgs.Sanguosha:getCard(move.from:getPile("fmpicture"):first())
				room:showCard(player, move.from:getPile("fmpicture"):first())
				if pic:getType() == to_obtain:getType() then
					room:obtainCard(player, to_obtain)
					move:removeCardIds(move.card_ids)
					room:broadcastSkillInvoke(self:objectName(),3)
				else
					room:drawCards(player,1)
					player:turnOver()
					room:broadcastSkillInvoke(self:objectName(),2)
				end
				room:obtainCard(player, move.from:getPile("fmpicture"):first())
				room:setPlayerProperty(player, "fmtugoumove", data)
				local exc = room:askForExchange(player, self:objectName(), 1, 1, false, "fmtugougive:"..move.from:objectName())
				room:setPlayerProperty(player, "fmtugoumove", sgs.QVariant())
				if exc then
					room:getCurrent():addToPile("fmpicture", exc, false)
				end
			end
			data:setValue(move)
		end
		return false
	end
}

czyingkuiCard = sgs.CreateSkillCard{
	name = "czyingkuiCard",
	target_fixed = true,
	will_throw = false,
	on_use = function(self, room, source, targets)
		room:setPlayerMark(source,"czyingkuiused",1)
		if source:getMark("@czkui") > 0 then
			room:setPlayerMark(source,"@czying",1)
			room:setPlayerMark(source,"@czkui",0)
			local log = sgs.LogMessage()
			log.type = "#czmarkturn"
			log.from = source
			log.arg = "@czkui"
			log.arg2 = "@czying"
			room:sendLog(log)
		else
			room:setPlayerMark(source,"@czying",0)
			room:setPlayerMark(source,"@czkui",1)
			local log = sgs.LogMessage()
			log.type = "#czmarkturn"
			log.from = source
			log.arg = "@czying"
			log.arg2 = "@czkui"
			room:sendLog(log)
		end
	end
}

czyingkui = sgs.CreateViewAsSkill{
	name = "czyingkui" ,
	n = 0 ,
	view_as = function(self, cards) 
		return czyingkuiCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return player:getMark("czyingkuiused") == 0
	end
}

czyingkuimark = sgs.CreateTriggerSkill{
	name = "#czyingkuimark", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.GameStart,sgs.CardFinished,sgs.EventPhaseChanging}, 
	view_as_skill = czyingkuiVS, 
	on_trigger = function(self, event, player, data) 
		if event == sgs.GameStart then
			player:gainMark("@czkui")
		elseif event == sgs.CardFinished then
			local room = player:getRoom()
			local use = data:toCardUse()
			if player:isAlive() and player:getPhase() ~= sgs.Player_NotActive and use.card:getSkillName() == "czzhuishu" then
				room:setPlayerMark(player,"czyingkuiused",0)
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			local room = player:getRoom()
			if change.to == sgs.Player_NotActive then
				room:setPlayerMark(player, "czyingkuiused", 0)
			end
		end
		return false
	end
}

czzhuishuCard = sgs.CreateSkillCard{
	name = "czzhuishuCard",
	will_throw = false,
	handling_method = sgs.Card_MethodNone,
	filter = function(self, targets, to_select)
		local card = sgs.Self:getTag("czzhuishu"):toCard()
		card:addSubcards(sgs.Self:getHandcards())
		card:setSkillName(self:objectName())
		if card and card:targetFixed() then
			return false
		end
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		return card and card:targetFilter(qtargets, to_select, sgs.Self) 
			and not sgs.Self:isProhibited(to_select, card, qtargets)
	end,
	feasible = function(self, targets)
		local card = sgs.Self:getTag("czzhuishu"):toCard()
		card:addSubcards(sgs.Self:getHandcards())
		card:setSkillName(self:objectName())
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		if card and card:canRecast() and #targets == 0 then
			return false
		end
		return card and card:targetsFeasible(qtargets, sgs.Self)
	end,	
	on_validate = function(self, card_use)
		local xunyou = card_use.from
		local room = xunyou:getRoom()
		local use_card = sgs.Sanguosha:cloneCard(self:getUserString())
		local subc = sgs.CardList()
		for _,id in sgs.qlist(self:getSubcards()) do
			subc:append(sgs.Sanguosha:getCard(id))
		end
		use_card:addSubcards(subc)
		use_card:setSkillName("czzhuishu")
		local available = true
		for _,p in sgs.qlist(card_use.to) do
			if xunyou:isProhibited(p,use_card)	then
				available = false
				break
			end
		end
		available = available and use_card:isAvailable(xunyou)
		if not available then return nil end
		return use_card		
	end,
}

czzhuishuVS = sgs.CreateViewAsSkill{
	name = "czzhuishu",
	n = 1,
	view_filter = function(self, selected, to_select)
		local a = 0
		if sgs.Self:getMark("@czying") > 0 then
			a = 12 - (2 * sgs.Self:getMark("@czsuanchou"))
		else
			a = (2 * sgs.Self:getMark("@czsuanchou")) + 1
		end
		return to_select:getNumber() == a and #selected == 0
	end,
	view_as = function(self, cards)
		local c = sgs.Self:getTag("czzhuishu"):toCard()
		if c and #cards == 1 then
			local card = czzhuishuCard:clone()
			card:addSubcard(cards[1])
			card:setUserString(c:objectName())
			card:setSkillName("czzhuishu")	
			return card
		end
		return nil
	end,
	enabled_at_play = function(self, player)
		return true
	end,
}

czzhuishu = sgs.CreateTriggerSkill{
	name = "czzhuishu", 
	events = {sgs.CardFinished,sgs.EventPhaseChanging}, 
	view_as_skill = czzhuishuVS, 
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		if event == sgs.CardFinished then
			local use = data:toCardUse()
			if player:getPhase() ~= sgs.Player_NotActive and player:isAlive() and use.card:getTypeId() ~= sgs.Card_TypeSkill then
				room:addPlayerMark(player,"czsuanchou")
				if player:hasSkill("czzhuishu") then
					room:setPlayerMark(player, "@czsuanchou", player:getMark("czsuanchou"))
				end
				if use.card:getSkillName() == "czzhuishu" then
					room:setPlayerCardLimitation(player, "use", use.card:getClassName(), true)
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				room:setPlayerMark(player, "@czsuanchou", 0)
				room:setPlayerMark(player, "czsuanchou", 0)
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target ~= nil
	end
}

czzhuishu:setGuhuoDialog("r")

akqusu = sgs.CreateTriggerSkill{
	name = "akqusu" ,
	events = {sgs.EventPhaseStart,sgs.EventPhaseChanging} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() ~= sgs.Player_Finish then return false end
			if not player:hasSkill(self:objectName()) then return false end
			local to = room:askForPlayerChosen(player, room:getAlivePlayers(), self:objectName(), "akqusu-invoke", true, true)
			if to then
				room:broadcastSkillInvoke(self:objectName(),1)
				room:drawCards(to, 1)
				if to:objectName()~=player:objectName() and to:faceUp() then
					local playerdata = sgs.QVariant()
					playerdata:setValue(to)
					room:setTag("akqusuTarget", playerdata)
					room:setPlayerFlag(to,"akqusudis")
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive and player:hasFlag("akqusudis") then
				room:setPlayerFlag(player,"-akqusudis")
				if player:faceUp() then
					player:turnOver()
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target ~= nil
	end
}

akqusuGive = sgs.CreateTriggerSkill{
	name = "#akqusuGive" ,
	events = {sgs.EventPhaseStart} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:getTag("akqusuTarget") then
			local target = room:getTag("akqusuTarget"):toPlayer()
			room:removeTag("akqusuTarget")
			if target and target:isAlive() then
				target:gainAnExtraTurn()
			end
		end
		return false
	end ,
	can_trigger = function(self, target)
		return target and (target:getPhase() == sgs.Player_NotActive)
	end ,
	priority = 1
}

akzhouxiang = sgs.CreateTriggerSkill{
	name = "akzhouxiang" ,
	events = {sgs.EventPhaseStart,sgs.PreDamageDone,sgs.EventPhaseEnd} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			local aku = room:findPlayerBySkillName(self:objectName())
			if aku then
				if player:getPhase() == sgs.Player_Play then
					if not aku:canDiscard(player, "hej") then return false end
					if room:askForSkillInvoke(aku,self:objectName(),data) then
						local patternlist = {"h","e","j"}
						local n = 0
						local hn = 0
						local en = 0 
						local jn = 0
						for i = 1,aku:getLostHp() + 1,1 do
							local pattern = table.concat(patternlist,"")
							if (not aku:canDiscard(player, pattern)) or #patternlist == 0 then break end
							if room:askForChoice(aku, self:objectName(), "akdiscard+cancel", sgs.QVariant(i)) == "cancel" then break end
							local todis = room:askForCardChosen(aku, player, pattern, self:objectName())
							local pl = room:getCardPlace(todis)
							if pl == sgs.Player_PlaceEquip then
								en = en + 1
								if en >= aku:getLostHp() then
									table.removeOne(patternlist,"e")
								end
							elseif pl == sgs.Player_PlaceHand then
								hn = hn + 1
								if hn >= aku:getLostHp() then
									table.removeOne(patternlist,"h")
								end
							else
								jn = jn + 1
								if jn >= aku:getLostHp() then
									table.removeOne(patternlist,"j")
								end
							end
							room:throwCard(todis, player, aku)
							n = n + 1
						end
						room:setPlayerMark(player,"akzhouxiangmark",n)
					end
				end
			end
		elseif event == sgs.PreDamageDone then
			local damage = data:toDamage()
			if damage.from and damage.from:getPhase() == sgs.Player_Play and not damage.from:getMark("akzhouxiangdamage") == 0 and damage.from:getMark("akzhouxiangmark") > 0 then
				room:setPlayerMark(damage.from,"akzhouxiangdamage",1)
			end
		elseif event == sgs.EventPhaseEnd then
			local can_trigger = true
			local mk = player:getMark("akzhouxiangmark")
			if player:getMark("akzhouxiangdamage") > 0 then
				can_trigger = false	
				room:setPlayerMark(player,"akzhouxiangdamage",0)
			end
			local aku = room:findPlayerBySkillName(self:objectName())
			if aku and player and player:isAlive() and player:getMark("akzhouxiangmark") > 0 and player:getPhase() == sgs.Player_Play and can_trigger then
				local akun = aku:objectName()
				if room:askForCard(player, ".", "@akzhouxiang-askdis:"..akun..":"..mk, sgs.QVariant(), self:objectName()) then
					for i = 1,mk,1 do
						if not player:canDiscard(aku, "he") then break end
						local todis = room:askForCardChosen(player, aku, "he", self:objectName())
						room:throwCard(todis, aku, player)
					end
				else
					room:drawCards(player, mk)
				end
				room:setPlayerMark(player,"akzhouxiangmark",0)
			end
		end
		return false
	end ,
	can_trigger = function(self, target)
		return target ~= nil
	end
}

brshuyun = sgs.CreateTriggerSkill{
	name = "brshuyun" ,
	events = {sgs.EventPhaseStart} ,
	can_trigger = function(self, target)
		return target ~= nil
	end ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() ~= sgs.Player_Finish then return false end
		local br = room:findPlayerBySkillName(self:objectName())
		if not br then return false end
		if player:getHandcardNum() + player:getEquips():length() < 2 then return false end
		if room:askForSkillInvoke(br, self:objectName(), data) then
			local todis1 = room:askForCardChosen(br, player, "he", self:objectName())
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, br:objectName(), nil, "brshuyun", nil)
			room:showCard(player, todis1, br)
			room:moveCardTo(sgs.Sanguosha:getCard(todis1), player, nil ,sgs.Player_DrawPile, reason, false)
			local todis2 = room:askForCardChosen(br, player, "he", self:objectName() .. "ex")
			room:showCard(player, todis2, br)
			room:moveCardTo(sgs.Sanguosha:getCard(todis2), player, nil ,sgs.Player_DrawPile, reason, false)
			if not room:askForCard(br, "EquipCard", "@brshuyuneq", data, self:objectName()) then
				local result = room:askForChoice(player, "brshuyun", "brdamage+brrecov")
				if result == "brrecov" then
					local recover = sgs.RecoverStruct()
					recover.who = player
					room:recover(br, recover)
				else
					room:damage(sgs.DamageStruct(self:objectName(), player, br))
				end
			end
		end
		return false
	end
}

brshangbian = sgs.CreateTriggerSkill{
	name = "brshangbian",
	events = {sgs.HpChanged,sgs.MaxHpChanged},
	frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:askForSkillInvoke(player, self:objectName(), data) then
			room:drawCards(player,1)
		end
		return false;
	end
}

tsjiaobian = sgs.CreateTriggerSkill{
	name = "tsjiaobian",
	events  = {sgs.Damaged},
	can_trigger = function(self, target)
		return target
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local tes = room:findPlayerBySkillName(self:objectName())
		if not tes then return false end
	--[[	if event == sgs.Death then
			local death = data:toDeath()
			if death.damage and death.damage.nature == sgs.DamageStruct_Thunder then
				local tag = sgs.QVariant()
				tag:setValue(death.who:getNext())
				tes:setTag("JBtokill", tag)
			end
		else]]--
			local damage = data:toDamage()
			if damage.nature ~= sgs.DamageStruct_Thunder then return false end
			if tes:askForSkillInvoke(self:objectName(),data) then
				local x = tes:getHp()
				if tes:faceUp() then
					local todi = room:askForExchange(tes, "tsjiaobian", x, x, true, "tsjiaobiandis:"..x..":"..x-1, true)
					if todi then
						local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_THROW, tes:objectName(), "", "tsjiaobian", "")
						room:moveCardTo(todi, tes, nil, sgs.Player_DiscardPile, reason, true)
					else
						tes:turnOver()
						room:drawCards(tes,x-1)
					end
					local vict = nil
					--[[local tag = tes:getTag("JBtokill")
					if tag and tag:toPlayer() then
						if tes:faceUp() then
							for _,p in sgs.qlist(room:getAlivePlayers()) do
								if tag:toPlayer():getSeat() == math.mod(p:getSeat(),tes:aliveCount())+1 then
									vict = p
									break
								end
							end
						else
							vict = tag:toPlayer()
						end
						tes:setTag("JBtokill", sgs.QVariant())
					else]]--
						if tes:faceUp() then
							if damage.to:isAlive() then
								vict = damage.to:getNextAlive(tes:aliveCount()-1)
							else
								vict = damage.to:getNextAlive(tes:aliveCount())
							end
						else
							vict = damage.to:getNextAlive()
						end
					--end
					local adamage = sgs.DamageStruct()
					adamage.from = tes
					adamage.to = vict
					adamage.nature = sgs.DamageStruct_Thunder
					room:damage(adamage)
				else
					local todi = room:askForExchange(tes, "tsjiaobian", x, x, true, "tsjiaobiandisb:"..x..":"..damage.to:getNextAlive():objectName(), true)
					if todi then
						local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_THROW, tes:objectName(), "", "tsjiaobian", "")
						room:moveCardTo(todi, tes, nil, sgs.Player_DiscardPile, reason, true)
						local adamage = sgs.DamageStruct()
						adamage.from = tes
						--[[if tag and tag:toPlayer() then
							adamage.to = tag:toPlayer()
							tes:setTag("JBtokill", sgs.QVariant())
						else
							
						end]]--
						adamage.to = damage.to:getNextAlive()
						adamage.nature = sgs.DamageStruct_Thunder
						room:damage(adamage)
					end
				end
			end
		--end
	end,
}

tswuxianCard = sgs.CreateSkillCard{
	name = "tswuxianCard", 
	target_fixed = false,
	will_throw = true,
	filter = function(self, targets, to_select) 
		if #targets == 0 then
			local bifalist = to_select:getPile("tszhubo")
			if bifalist:isEmpty() then
				return to_select:objectName() ~= sgs.Self:objectName()
			end
		end
		return false
	end,
	on_use = function(self, room, source, targets)
		local ids = self:getSubcards()
		local n = ids:length()
		for _,id in sgs.qlist(ids) do
			targets[1]:addToPile("tszhubo", id, true)
		end
	end
}

tswuxianVS = sgs.CreateViewAsSkill{
	name = "tswuxian", 
	n = 1, 
	view_filter = function(self, selected, to_select)
		return true
	end, 
	view_as = function(self, cards)
		if #cards > 0 then
			local acard = tswuxianCard:clone()
			for _,card in pairs(cards) do
				acard:addSubcard(card)
			end
			acard:setSkillName(self:objectName())
			return acard
		end
	end, 
	enabled_at_play = function(self, player)
		return true
	end, 
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

tswuxian = sgs.CreateTriggerSkill{
	name = "tswuxian",  
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.DamageInflicted}, 
	view_as_skill = tswuxianVS, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()
		if not damage.to:hasSkill(self:objectName()) then return false end
		local targets = sgs.SPlayerList()
		for _,p in sgs.qlist(room:getAlivePlayers()) do
			if not p:getPile("tszhubo"):isEmpty() then
				targets:append(p)
			end
		end
		local to = room:askForPlayerChosen(player, targets, self:objectName(), "tswuxian-invoke", true, true)
		if to then
			local zhub = sgs.Sanguosha:getCard(to:getPile("tszhubo"):at(0))
			local card = room:askForCard(to, ".|"..zhub:getSuitString().."|.|hand", "@tswuxian-show:"..zhub:getSuitString()..":"..zhub:objectName(), data, sgs.Card_MethodNone)
			if card then
				local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_REMOVE_FROM_PILE, "", self:objectName(), "")
				room:throwCard(zhub, reason, nil)
				room:getThread():delay(400)
				room:showCard(to,card:getEffectiveId())
				damage.damage = damage.damage - 1
				data:setValue(damage)
				if damage.damage < 1 then
					local log = sgs.LogMessage()
						log.type = "#tswuxian-dfs"
						log.from = player
						log.arg = self:objectName()
						room:sendLog(log)
					return true
				end
			else
				to:obtainCard(zhub)
				local adamage = sgs.DamageStruct()
				adamage.from = player
				adamage.to = to
				adamage.nature = sgs.DamageStruct_Thunder
				room:damage(adamage)
			end
		end
		return false
	end
}

ysbengdong = sgs.CreateTriggerSkill{
	name = "ysbengdong" ,
	frequency = sgs.Skill_NotFrequent ,
	events = {sgs.BeforeCardsMove,sgs.EventPhaseChanging},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.BeforeCardsMove then
			if player:hasSkill(self:objectName()) then 
				local move = data:toMoveOneTime()
				local tag = room:getTag("bddisp"):toString()
				local dispile = {}
				local moved = {}
				for _, bb in ipairs(tag:split(":")) do
					local a = {}
					for _, cc in ipairs(bb:split("+")) do
						table.insert(a,cc)
					end
					table.insert(dispile,a)
				end
				if move.from_places:contains(sgs.Player_DiscardPile) then
					local fromlist = {}
					for i = 0, move.card_ids:length() - 1, 1 do
						if move.from_places:at(i) == sgs.Player_DiscardPile and (sgs.Sanguosha:getCard(move.card_ids:at(i)):isNDTrick() or  sgs.Sanguosha:getCard(move.card_ids:at(i)):isKindOf("BasicCard")) then
							table.insert(fromlist,move.card_ids:at(i))
						end
					end
					if not (#fromlist == 0 or #dispile == 0) then
						for _, dislist in ipairs(dispile) do
							for _, disid in ipairs(fromlist) do
								if table.contains(dislist,disid) then
									table.removeOne(dislist,disid)
								end
							end
						end
						table.removeOne(dispile,{})
					end
				end
				if move.to_place == sgs.Player_DiscardPile then
					local tolist = {}
					for i = 0, move.card_ids:length() - 1, 1 do
						if sgs.Sanguosha:getCard(move.card_ids:at(i)):isNDTrick() or  sgs.Sanguosha:getCard(move.card_ids:at(i)):isKindOf("BasicCard") then
							table.insert(tolist,move.card_ids:at(i))
						end
					end
					if #tolist ~= 0 then
						table.insert(dispile,tolist)
						table.removeOne(dispile,{})
						--player:speak("5")
					end
				end
				for _, dislist in ipairs(dispile) do
					local d = table.concat(dislist, "+")
					table.insert(moved,d)
				end
				if #moved ~= 0 then
					room:setTag("bddisp",sgs.QVariant(table.concat(moved,":")))
				end
				
			end
		else
			local splayer = room:findPlayerBySkillName(self:objectName())
			if not splayer then return false end
			local tag = room:getTag("bddisp")
			if tag and data:toPhaseChange().to == sgs.Player_Play and tag:toString() ~= "" then
				local alist = tag:toString():split(":")[#tag:toString():split(":")]
				local list = alist:split("+")
				if #list == 0 then return false end
				if not splayer:canDiscard(splayer,"h") then return false end
				local l = Table2IntList(list)
				if splayer:askForSkillInvoke(self:objectName(), data) then
					room:fillAG(l,splayer)
					local to_back = room:askForAG(splayer, l, false, self:objectName())
					local to_give = room:askForCard(splayer, ".|.|.|hand", self:objectName().."ask", data, self:objectName())
					room:clearAG(splayer)
					if to_give then
						local reason1 = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TRANSFER, splayer:objectName(), self:objectName(), nil)
						local reason2 = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_OVERRIDE, splayer:objectName(), self:objectName(), nil)
						local move1 = sgs.CardsMoveStruct()
						move1.card_ids:append(to_give:getEffectiveId())
						move1.from = splayer
						move1.to = nil
						move1.to_place = sgs.Player_DiscardPile
						if sgs.Sanguosha:getCard(to_back):getTypeId() == to_give:getTypeId() then
							local toget = room:askForPlayerChosen(splayer, room:getOtherPlayers(splayer), self:objectName())
							move1.to = toget or nil
							move1.to_place = toget and sgs.Player_PlaceHand or sgs.Player_DiscardPile
						end
						move1.reason = reason1
						local move2 = sgs.CardsMoveStruct()
						move2.card_ids:append(to_back)
						move2.from = splayer
						move2.to = splayer
						move2.to_place = sgs.Player_PlaceHand
						move2.reason = reason2
						local moves = sgs.CardsMoveList()
						moves:append(move1)
						moves:append(move2)
						room:moveCardsAtomic(moves, false)
					end
				end
			end
		end
		return false
	end ,
	can_trigger = function(self, target)
		return target
	end ,
}

edkanlungiveCard = sgs.CreateSkillCard{
	name = "edkanlun", 
	target_fixed = false,
	will_throw = false,
	filter = function(self, selected, to_select)
		return (#selected <= sgs.Self:getLostHp()) and not to_select:hasSkill("edcankao") and sgs.Self:getPhase() ~= sgs.Player_Play
	end ,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		room:acquireSkill(effect.to,"edcankao")
		room:setPlayerMark(effect.to,"@kanlungive",1)
	end
}

edkanlunCard = sgs.CreateSkillCard{
	name = "edkanlunCard", 
	target_fixed = true,
	will_throw = false,
	handling_method = sgs.Card_MethodNone,
	on_use = function(self, room, source, targets)
		local ids = self:getSubcards()
		local n = ids:length()
		for _,id in sgs.qlist(ids) do
			if source:getPile("edarticle"):contains(id) then
				room:obtainCard(source, id)
			else
				source:addToPile("edarticle", id, true)
			end
		end
	end
}

edkanlunVS = sgs.CreateViewAsSkill{
	name = "edkanlun", 
	expand_pile = "edarticle",
	n = 1, 
	view_filter = function(self, selected, to_select)
		return (not to_select:isKindOf("EquipCard")) and sgs.Sanguosha:getCurrentCardUsePattern() ~= "@@edkanlun"
	end, 
	view_as = function(self, cards)
		local acard = edkanlungiveCard:clone()
		if #cards > 0 then
			acard = edkanlunCard:clone()
			for _,card in pairs(cards) do
				acard:addSubcard(card)
			end
		end
		acard:setSkillName(self:objectName())
		return acard
	end, 
	enabled_at_play = function(self, player)
		return not player:hasUsed("#edkanlunCard")
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@edkanlun"
	end
}

edkanlun = sgs.CreateTriggerSkill{
	name = "edkanlun",  
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseEnd}, 
	view_as_skill = edkanlunVS, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Finish then
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:getMark("@kanlungive") > 0 then
					room:setPlayerMark(p,"@kanlungive",0)
					room:handleAcquireDetachSkills(p,"-edcankao")
				end
			end
			room:askForUseCard(player, "@@edkanlun", "@edkanlung")
		end
		return false
	end
}

edcankaoVS = sgs.CreateViewAsSkill{
	name = "edcankao",
	enabled_at_play = function(self, player)
		local flag = false
		local spile = player:getPile("edarticle")
		local usedp = player:property("edcankaoused"):toString()
		local used = usedp:split("+")
		
		local enabled = sgs.IntList()
		if not spile:isEmpty() then
			for _,id in sgs.qlist(spile) do
				if not table.contains(used, id) then
					enabled:append(id)
				end
			end
		end
		for _,p in sgs.qlist(player:getAliveSiblings()) do
			local opile = p:getPile("edarticle")
			if not opile:isEmpty() then
				for _,id in sgs.qlist(opile) do
					if not table.contains(used, id) then
						enabled:append(id)
					end
				end
			end
		end
		for _,id in sgs.qlist(enabled) do
			local card = sgs.Sanguosha:getCard(id)
			if card:isAvailable(player) then flag = true end
		end
		return flag
	end, 
	enabled_at_response = function(self, player, pattern)
		local flag = false
		local spile = player:getPile("edarticle")
		local usedp = player:property("edcankaoused"):toString()
		local used = usedp:split("+")
		local enabled = sgs.IntList()
		if not spile:isEmpty() then
			for _,id in sgs.qlist(spile) do
				if not table.contains(used, id) then
					enabled:append(id)
				end
			end
		end
		for _,p in sgs.qlist(player:getAliveSiblings()) do
			local opile = p:getPile("edarticle")
			if not opile:isEmpty() then
				for _,id in sgs.qlist(opile) do
					if not table.contains(used, id) then
						enabled:append(id)
					end
				end
			end
		end
		if enabled:isEmpty() then return false end
		for _,id in sgs.qlist(enabled) do
			local card = sgs.Sanguosha:getCard(id)
			if (sgs.Sanguosha:matchExpPattern(pattern, nil, card) or string.find(pattern,card:objectName()) or string.find(pattern,card:getClassName())) then flag = true end
		end
		return flag
	end,
	view_as = function(self,cards)
		local acard = edcankaoCard:clone()
		local pattern = ""
		local st = {}
		if sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_PLAY then
			local spile = sgs.Self:getPile("edarticle")
			local usedp = sgs.Self:property("edcankaoused"):toString()
			local used = usedp:split("+")
			local enabled = sgs.IntList()
			if not spile:isEmpty() then
				for _,id in sgs.qlist(spile) do
					if not table.contains(used, id) then
						enabled:append(id)
					end
				end
			end
			for _,p in sgs.qlist(sgs.Self:getAliveSiblings()) do
				local opile = p:getPile("edarticle")
				if not opile:isEmpty() then
					for _,id in sgs.qlist(opile) do
						if not table.contains(used, id) then
							enabled:append(id)
						end
					end
				end
			end
			for _,id in sgs.qlist(enabled) do
				local card = sgs.Sanguosha:getCard(id)
				if card:isAvailable(sgs.Self) and not table.contains(st,card:objectName()) then table.insert(st,card:objectName()) end
			end
			pattern = table.concat(st,"+")
		else
			pattern = sgs.Sanguosha:getCurrentCardUsePattern()
		end
		acard:setUserString(pattern)
		return acard
	end
}

edcankao = sgs.CreateTriggerSkill{
	name = "edcankao",
	view_as_skill = edcankaoVS,
	events = {sgs.CardAsked,sgs.EventPhaseStart},
	on_trigger = function(self,event,player,data)
		local room = player:getRoom()
		if event == sgs.CardAsked then
			if not player:hasSkill(self:objectName()) then return false end
			local pattern = data:toStringList()[1]
			if string.find(data:toStringList()[2],"@edcankaoaskforc") then return false end
			if room:askForSkillInvoke(player, self:objectName(), data) then
				local usedp = player:property("edcankaoused"):toString()
				local used = usedp:split("+")
				local enabled = sgs.IntList()
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					local spile = p:getPile("edarticle")
					for _,cid in sgs.qlist(spile) do
						if (sgs.Sanguosha:matchExpPattern(pattern, player, sgs.Sanguosha:getCard(cid)) or string.find(pattern,sgs.Sanguosha:getCard(cid):objectName())) and not table.contains(used, tostring(cid)) then
							enabled:append(cid)
						end
					end
				end
				room:fillAG(enabled, player)
				local id = room:askForAG(player, enabled, true, "edcankao")
				room:clearAG(player)
				if id ~= -1 then
					local touse = sgs.Sanguosha:cloneCard(sgs.Sanguosha:getCard(id):objectName(),sgs.Sanguosha:getCard(id):getSuit(),sgs.Sanguosha:getCard(id):getNumber())
					local cd = room:askForCard(player, ".|"..sgs.Sanguosha:getCard(id):getSuitString(), "@edcankaoask", sgs.QVariant(), sgs.Card_MethodNone, nil, false, "edcankao")
					if cd then
					--	local using = sgs.Sanguosha:getCard(player:property("edcankaousing"):toInt())
					--	room:setPlayerProperty(player, "edcankaoasking", sgs.QVariant())
						table.insert(used,id)
						touse:addSubcard(cd) 
					--	room:setPlayerProperty(player, "edcankaousing",sgs.QVariant())
						room:setPlayerProperty(player, "edcankaoused", sgs.QVariant(table.concat(used,"+")))
					else 
						return false
					end
					room:provide(touse)
					return true
				end
			end
		else
			if player:getPhase() == sgs.Player_NotActive then
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					room:setPlayerProperty(p, "edcankaoused", sgs.QVariant())
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target ~= nil
	end ,
}

edcankaoCard = sgs.CreateSkillCard{
	name = "edcankao",
	will_throw = true ,
	target_fixed = true,
	filter = function(self, targets, to_select)
		local name = ""
		local card
		local plist = sgs.PlayerList()
		for i = 1, #targets do plist:append(targets[i]) end
		local aocaistring = self:getUserString()
		if aocaistring ~= "" then
			local uses = aocaistring:split("+")
			name = uses[1]
			card = sgs.Sanguosha:cloneCard(name)
		end
		return card and card:targetFilter(plist, to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, card, plist)
	end ,
	feasible = function(self, targets)
		local name = ""
		local card
		local plist = sgs.PlayerList()
		for i = 1, #targets do plist:append(targets[i]) end
		local aocaistring = self:getUserString()
		if aocaistring ~= "" then
			local uses = aocaistring:split("+")
			name = uses[1]
			card = sgs.Sanguosha:cloneCard(name)
		end
		return card and card:targetsFeasible(plist, sgs.Self)
	end,
	on_validate_in_response = function(self, user)
		local room = user:getRoom()
		local aocaistring = self:getUserString()
		local names = aocaistring:split("+")
		local usedp = user:property("edcankaoused"):toString()
		local used = usedp:split("+")
		if table.contains(names, "slash") then
			table.insert(names,"fire_slash")
			table.insert(names,"thunder_slash")
		end
		local enabled = sgs.IntList()
	--	room:writeToConsole("key"..aocaistring)
		for _,p in sgs.qlist(room:getAlivePlayers()) do
			local spile = p:getPile("edarticle")
			for _,cid in sgs.qlist(spile) do
			--	room:writeToConsole("ok"..sgs.Sanguosha:getCard(cid):objectName())
				if (table.contains(names, sgs.Sanguosha:getCard(cid):objectName()) or table.contains(names, sgs.Sanguosha:getCard(cid):getClassName())) and (not table.contains(used, tostring(cid))) then
					enabled:append(cid)
				--	room:writeToConsole("ena"..sgs.Sanguosha:getCard(cid):objectName())
				end
			end
		end
		room:fillAG(enabled, user)
		local id = room:askForAG(user, enabled, true, "edcankao")
		room:clearAG(user)
		if id == -1 then return nil end
		local touse = sgs.Sanguosha:cloneCard(sgs.Sanguosha:getCard(id):objectName(),sgs.Sanguosha:getCard(id):getSuit(),sgs.Sanguosha:getCard(id):getNumber())
		room:setPlayerProperty(user, "edcankaoasking", sgs.QVariant(id))
		local cd = room:askForCard(user, ".|"..sgs.Sanguosha:getCard(id):getSuitString(), "@edcankaoaskforc", sgs.QVariant(), sgs.Card_MethodNone, nil, false, "edcankao")
		if cd then
			local using = sgs.Sanguosha:getCard(user:property("edcankaousing"):toInt())
			room:setPlayerProperty(user, "edcankaoasking", sgs.QVariant())
			table.insert(used,id)
			touse:addSubcard(using) 
			room:setPlayerProperty(user, "edcankaousing",sgs.QVariant())
			room:setPlayerProperty(user, "edcankaoused", sgs.QVariant(table.concat(used,"+")))
		else 
			return nil
		end
		return touse
	end,
	on_validate = function(self, cardUse)
		cardUse.m_isOwnerUse = false
		local user = cardUse.from
		local room = user:getRoom()
		local aocaistring = self:getUserString()
		local names = aocaistring:split("+")
		local usedp = user:property("edcankaoused"):toString()
		local used = usedp:split("+")
		if table.contains(names, "slash") then
			table.insert(names,"fire_slash")
			table.insert(names,"thunder_slash")
		end
		local enabled = sgs.IntList()
		for _,p in sgs.qlist(room:getAlivePlayers()) do
			local spile = p:getPile("edarticle")
			for _,cid in sgs.qlist(spile) do
				if (table.contains(names, sgs.Sanguosha:getCard(cid):objectName()) or table.contains(names, sgs.Sanguosha:getCard(cid):getClassName())) and not table.contains(used, tostring(cid)) then
					enabled:append(cid)
				end
			end
		end
		room:fillAG(enabled, user)
		local id = room:askForAG(user, enabled, true, "edcankao")
		room:clearAG(user)
		if id == -1 then return nil end
		local touse = sgs.Sanguosha:cloneCard(sgs.Sanguosha:getCard(id):objectName(),sgs.Sanguosha:getCard(id):getSuit(),sgs.Sanguosha:getCard(id):getNumber())
		room:setPlayerProperty(user, "edcankaoasking", sgs.QVariant(id))
		--[[local cd = room:askForCard(user, ".|"..sgs.Sanguosha:getCard(id):getSuitString(), "@edcankaoask", sgs.QVariant(), sgs.Card_MethodNone, nil, false, "edcankao")
		if cd then
			table.insert(used,touse:getEffectiveId())
			touse:addSubcard(cd) 
			room:setPlayerProperty(user, "edcankaoused", sgs.QVariant(table.concat(used,"+")))
		else 
			return nil
		end]]--
		--room:attachSkillToPlayer(user, "edcankaosecond")
		local who = user
		for _,p in sgs.qlist(room:getAlivePlayers()) do
			if p:getSeat() == user:getSeat() then
				who = p
			end
		end
		if room:askForUseCard(who, "@@edcankaosecond", "@edcankaoaskforc") then
			local using = sgs.Sanguosha:getCard(user:property("edcankaousing"):toInt())
			room:setPlayerProperty(user, "edcankaoasking", sgs.QVariant())
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:hasFlag("edcankaouseto") then
					p:setFlags("-edcankaouseto")
					cardUse.to:append(p)
				end
			end
			table.insert(used,id)
			touse:addSubcard(using) 
			room:setPlayerProperty(user, "edcankaousing",sgs.QVariant())
			room:setPlayerProperty(user, "edcankaoused", sgs.QVariant(table.concat(used,"+")))
			return touse
		end
		return nil
	end
}

edcankaosecondCard = sgs.CreateSkillCard{
	name = "edcankaosecond",
	will_throw = false ,
	filter = function(self, targets, to_select)
		local toc = sgs.Sanguosha:getCard(sgs.Self:property("edcankaoasking"):toInt())
		local plist = sgs.PlayerList()
		for _, p in ipairs(targets) do
			plist:append(p)
		end
		if toc and toc:targetFixed() then
			return false
		end
		return toc and toc:targetFilter(plist, to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, toc, plist)
	end,
	feasible = function(self, targets)
		local card = sgs.Sanguosha:getCard(sgs.Self:property("edcankaoasking"):toInt())
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		if card and card:canRecast() and #targets == 0 then
			return false
		end
		return card and card:targetsFeasible(qtargets, sgs.Self)
	end,	
	on_use = function(self, room, source, targets)
		local card = sgs.Sanguosha:getCard(source:property("edcankaoasking"):toInt())
		if card:getSubtype() == "aoe" then
			for _, target in sgs.qlist(room:getOtherPlayers(source)) do
				room:cardEffect(self, source, target)
			end
		elseif card:getSubtype() == "global_effect" then
			for _, target in sgs.qlist(room:getAllPlayers()) do
				room:cardEffect(self, source, target)
			end
		elseif (card:targetFixed() or #targets == 0) then
			room:cardEffect(self, source, source)
		else
			for _, target in ipairs(targets) do
				room:cardEffect(self, source, target)
			end
		end
	end,
	on_effect = function(self, effect)
	--	local card = sgs.Sanguosha:getCard(sgs.Self:property("edcankaoasking"):toInt())
		effect.to:setFlags("edcankaouseto")
		effect.from:getRoom():setPlayerProperty(effect.from, "edcankaousing",sgs.QVariant(self:getSubcards():first()))
	end
}

edcankaosecond = sgs.CreateViewAsSkill{
	name = "edcankaosecond",
	n = 1,
	view_filter = function(self, selected, to_select)
		return #selected == 0 and to_select:getSuit() == sgs.Sanguosha:getCard(sgs.Self:property("edcankaoasking"):toInt()):getSuit()
	end ,
	view_as = function(self, cards)
		if #cards > 0 then
			local zhijian_card = edcankaosecondCard:clone()
			zhijian_card:addSubcard(cards[1])
			zhijian_card:setSkillName(self:objectName())
			return zhijian_card
		end
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@edcankaosecond"
	end,
}

edliuxiCard = sgs.CreateSkillCard{
	name = "edliuxi",
	will_throw = false ,
	target_fixed = false,
	filter = function(self, targets, to_select)
		return #targets == 0 and to_select:objectName() ~= sgs.Self:objectName() and to_select:getHandcardNum() <= sgs.Self:getHandcardNum()
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, effect.from:objectName(), effect.to:objectName(), "edliuxi","")
		room:moveCardTo(self,effect.from,effect.to,sgs.Player_PlaceHand,reason)
		if effect.from:getHandcardNum() < effect.to:getHandcardNum() then
			local recover = sgs.RecoverStruct()
			recover.who = effect.from
			room:recover(effect.from, recover)
		end
	end
}

edliuxiVS = sgs.CreateViewAsSkill{
	name = "edliuxi",
	n = 999,
	view_filter = function(self, selected, to_select)
		return not to_select:isEquipped()
	end ,
	view_as = function(self, cards)
		if #cards >= sgs.Self:getHp() then
			local zhijian_card = edliuxiCard:clone()
			for _,card in ipairs(cards) do
				zhijian_card:addSubcard(card)
			end
			zhijian_card:setSkillName(self:objectName())
			return zhijian_card
		end
	end,
	enabled_at_play = function(self, player)				
		return false
	end,	
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@edliuxi"
	end,
}

edliuxi = sgs.CreateTriggerSkill{
	name = "edliuxi" ,
	events = {sgs.Damaged},
	view_as_skill = edliuxiVS,
	on_trigger = function(self, event, player, data)
		local damage = data:toDamage()
		local room = player:getRoom()
		if player:getHp() > 0 then 
			room:askForUseCard(player, "@@edliuxi", "@edliuxiask")
		end
	end
}

listIndexOf = function(theqlist, theitem)
	local index = 0
	for _, item in sgs.qlist(theqlist) do
		if item == theitem then return index end
		index = index + 1
	end
end

kpxingtuCard = sgs.CreateSkillCard{
    name = "kpxingtu",
    will_throw = false,
	target_fixed = true,
	on_use = function(self, room, source, targets)
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, source:objectName(), nil, "kpxingtu", nil)
		room:moveCardTo(sgs.Sanguosha:getCard(self:getSubcards():at(0)), source, nil ,sgs.Player_DrawPile, reason, false)
	end
}

kpxingtuVS = sgs.CreateOneCardViewAsSkill{
	name = "kpxingtu", 
	filter_pattern = ".|.|.|kpstar",
	response_pattern = "@@kpxingtu" ,
	expand_pile = "kpstar",
	view_as = function(self, card)
	    local scard = kpxingtuCard:clone()
		scard:addSubcard(card)
		return scard
	end,
	enabled_at_play = function(self, player)
		return false
	end
}

kpxingtu = sgs.CreateTriggerSkill{
	name = "kpxingtu",
	frequency = sgs.Skill_Frequent,
	events = {sgs.BeforeCardsMove},
	view_as_skill = kpxingtuVS,
	on_trigger=function(self, event, player, data)
		local room = player:getRoom()
		local move = data:toMoveOneTime()
		if event == sgs.BeforeCardsMove then
			local reason = move.reason.m_reason
			local reasonx = bit32.band(reason, sgs.CardMoveReason_S_MASK_BASIC_REASON)
			local Yes = reasonx == sgs.CardMoveReason_S_REASON_DISCARD
			or reasonx == sgs.CardMoveReason_S_REASON_USE or reasonx == sgs.CardMoveReason_S_REASON_RESPONSE
			if Yes then
				local card
				local toget = sgs.IntList()
				local geting = sgs.IntList()
				for _,id in sgs.qlist(move.card_ids) do
					card = sgs.Sanguosha:getCard(id)
					if move.from_places:at(listIndexOf(move.card_ids, id)) == sgs.Player_PlaceHand
						or move.from_places:at(listIndexOf(move.card_ids, id)) == sgs.Player_PlaceEquip then
						--[[if card and move.to_place == sgs.Player_PlaceTable and room:getCardOwner(id):getSeat() == move.from:getSeat() then
							if move.from:objectName() == player:objectName() then
								toget:append(id)
							else
								room:setTag("kpxingtuother",sgs.QVariant(true))
							end
							room:setTag("kpxingtutable",sgs.QVariant(true))
							room:setTag("kpxingtucard",sgs.QVariant(table.concat(sgs.QList2Table(toget), "+")))
						end]]--
						local tag = sgs.QVariant()
						tag:setValue(room:getCardOwner(id))
						if card then
							card:setTag("kpusefrom",tag)
						end
					end
				end
				if move.to_place == sgs.Player_DiscardPile then
				--[[local other = room:getTag("kpxingtuother"):toBool()
					local tabled = room:getTag("kpxingtutable"):toBool()
					toget = Table2IntList(room:getTag("kpxingtucard"):toString():split("+"))
					room:setTag("kpxingtuother",sgs.QVariant(false))
					room:setTag("kpxingtutable",sgs.QVariant(false))
					room:writeToConsole("yes3"..room:getTag("kpxingtucard"):toString())]]--
				--	if not tabled then
					local otheruse = false
					toget = sgs.IntList()
					for _,id in sgs.qlist(move.card_ids) do
						card = sgs.Sanguosha:getCard(id)
						local cardfrom = card:getTag("kpusefrom"):toPlayer()
						if cardfrom then
							if cardfrom:objectName() == player:objectName() then
								toget:append(id)
							else
								otheruse = true
							end
							card:setTag("kpusefrom",sgs.QVariant())
						end
					end
				--	end
					if not otheruse then
						if toget:isEmpty() then
							return false
						elseif player:askForSkillInvoke(self:objectName(), data) then
							while not toget:isEmpty() do
								room:fillAG(toget, player)
								local id = room:askForAG(player, toget, true, self:objectName())
								if id == -1 then
									room:clearAG(player)
									break
								end
								toget:removeOne(id)
								geting:append(id)
								room:clearAG(player)
							end
							if not geting:isEmpty() then
								for _, id in sgs.qlist(geting) do
									if move.card_ids:contains(id) then
										move.from_places:removeAt(listIndexOf(move.card_ids, id))
										move.card_ids:removeOne(id)
										data:setValue(move)
									end
									player:addToPile("kpstar", id)
								--	room:moveCardTo(sgs.Sanguosha:getCard(id), player, sgs.Player_PlaceHand, move.reason, true)
									if not player:isAlive() then break end
								end
							end
						end
					else
						if not player:getPile("kpstar"):isEmpty() then
							room:askForUseCard(player, "@@kpxingtu", "@kpxingtuask")
						end
					end
				end
			end
		end
	end,
}

kpxingyunCard = sgs.CreateSkillCard{
	name = "kpxingyunCard",
	will_throw = false ,
	target_fixed = false,
	filter = function(self, targets, to_select)
		local card = sgs.Sanguosha:getCard(self:getSubcards():first())
		local flag = false
		if card:isKindOf("DelayedTrick") then
			flag = (to_select:getJudgingArea():length() ~= 0)
		elseif card:isKindOf("EquipCard") then
			local equip = card:getRealCard():toEquipCard()
			local equip_index = equip:location()
			flag = (to_select:getEquip(equip_index) ~= nil)
		end
		if not to_select:isKongcheng() then flag = true end
		return #targets == 0 and flag
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local pattern = "h"
		local banlist = sgs.IntList()
		local card = sgs.Sanguosha:getCard(self:getSubcards():first())
		if card:isKindOf("DelayedTrick") then 
			pattern = "hj"
		elseif card:isKindOf("EquipCard") then
			pattern = "he"
			local eqs = effect.to:getEquips()
			local equip = card:getRealCard():toEquipCard()
			local equip_index = equip:location()
			for _,eq in sgs.qlist(eqs) do
				if eq:getRealCard():toEquipCard():location() ~= equip_index then banlist:append(eq:getEffectiveId()) end
			end
		end
		local id = room:askForCardChosen(effect.from, effect.to, pattern, "kpxingyun", false, sgs.Card_MethodNone, banlist)
		local place = room:getCardPlace(id)
		effect.from:addToPile("kpstar", id)
		local exchangeMove = sgs.CardsMoveList()
		local move1 = sgs.CardsMoveStruct(self:getSubcards():first(), effect.to, place, sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TRANSFER, effect.from:objectName(), "kpxingyun", ""))
		exchangeMove:append(move1)
        room:moveCardsAtomic(exchangeMove, false)
	end
}

kpxingyunVS = sgs.CreateOneCardViewAsSkill{
	name = "kpxingyun", 
	filter_pattern = ".|.|.|kpstar",
	response_pattern = "@@kpxingyun" ,
	expand_pile = "kpstar",
	view_as = function(self, card)
	    local scard = kpxingyunCard:clone()
		scard:addSubcard(card)
		return scard
	end,
	enabled_at_play = function(self, player)
		return false
	end
}

kpxingyun = sgs.CreateTriggerSkill{
	name = "kpxingyun",  
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.EventPhaseEnd}, 
	view_as_skill = kpxingyunVS, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Start then
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:isAlive() and p:distanceTo(player) <= 1 and p:hasSkill(self:objectName()) then
					room:askForUseCard(p, "@@kpxingyun", "@kpxingyunuse")
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target and target:isAlive()
	end
}

kpguance = sgs.CreateTriggerSkill{
	name = "kpguance" ,
	frequency = sgs.Skill_Wake ,
	events = {sgs.EventPhaseStart} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		room:addPlayerMark(player, "kpguance")
		if room:changeMaxHpForAwakenSkill(player) then
			room:acquireSkill(player, "kpxingyun")
		end
		return false
	end ,
	can_trigger = function(self, target)
		return (target and target:isAlive() and target:hasSkill(self:objectName()))
			and (target:getMark("kpguance") == 0)
			and (target:getPhase() == sgs.Player_Start)
			and (not target:getPile("kpstar"):isEmpty())
			and target:getPile("kpstar"):length() >= target:getHandcardNum()
	end
}

stdriveCard = sgs.CreateSkillCard{
	name = "stdriveCard",
	will_throw = false,
	target_fixed = false,
	filter = function(self, targets, to_select)
		if #targets ~= 0 or to_select:objectName() == sgs.Self:objectName() then return false end
		if self:getSubcards():isEmpty() and sgs.Self:getPile("strail"):length() >= 3 then return (to_select:isWounded() and to_select:getPile("strail"):length() >= 3) end
		if (not self:getSubcards():isEmpty()) and sgs.Sanguosha:getCard(self:getSubcards():at(0)):isEquipped() and sgs.Self:getPile("strail"):length() >= 2 then
			local flag = true
			for _,c in sgs.qlist(self:getSubcards()) do
				local card = sgs.Sanguosha:getCard(c)
				local equip = card:getRealCard():toEquipCard()
				local equip_index = equip:location()
				if to_select:getEquip(equip_index) ~= nil then flag = false end
			end
			return flag and to_select:getPile("strail"):length() >= 2
		end
		if (not self:getSubcards():isEmpty()) and (not sgs.Sanguosha:getCard(self:getSubcards():at(0)):isEquipped()) and sgs.Self:getPile("strail"):length() >= 1 then
			return to_select:getPile("strail"):length() >= 1
		end
		return false
	end,
	feasible = function(self, targets)
		return #targets > 0 
	end,
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		if self:getSubcards():isEmpty() then
			room:loseHp(effect.from,1)
			local recover = sgs.RecoverStruct()
			if effect.from:isAlive() then
				recover.who = effect.from
			end
			room:recover(effect.to, recover)
		elseif room:getCardPlace(self:getSubcards():first()) == sgs.Player_PlaceEquip then
			for _,c in sgs.qlist(self:getSubcards()) do
				room:moveCardTo(sgs.Sanguosha:getCard(c), effect.from, effect.to, sgs.Player_PlaceEquip,sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, effect.from:objectName(), "sttransport", ""))
			end
		else
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_GIVE, effect.from:objectName(), effect.to:objectName(), "sttransport","")
			room:moveCardTo(self,effect.to,sgs.Player_PlaceHand,reason)
		end
	end,
}

stdrive = sgs.CreateViewAsSkill{
	name = "stdrive&" ,
	n = 999,
	enabled_at_play = function(self, player)
		return not player:getPile("strail"):isEmpty()
	end ,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then
			return sgs.Self:getPile("strail"):length() >= 2 or (not to_select:isEquipped())
		else
			return selected[1]:isEquipped() == to_select:isEquipped()
		end
	end ,
	view_as = function(self, cards)
		local wine = stdriveCard:clone()
		if #cards > 0 then
			for _, c in ipairs(cards) do
				wine:addSubcard(c)
			end
		end
		wine:setSkillName(self:objectName())
		return wine
	end ,
}

sttransportCard = sgs.CreateSkillCard{
	name = "sttransport",
	will_throw = false,
	target_fixed = false,
	filter = function(self, targets, to_select)
		return (not self:getSubcards():isEmpty()) and #targets < self:getSubcards():length() and to_select:getPile("strail"):length()<3
	end,
	feasible = function(self, targets)
		return #targets > 0 and #targets == self:getSubcards():length()
	end,
	on_use = function(self, room, source, targets)
		if not source:hasSkill("stdrive") then 
			room:attachSkillToPlayer(source, "stdrive")
		end
		for i = 1, #targets, 1 do
			targets[i]:addToPile("strail", self:getSubcards():at(i-1))
			if not targets[i]:hasSkill("stdrive") then 
				room:attachSkillToPlayer(targets[i], "stdrive")
			end
		end
		local x = self:getSubcards():length()
		local ids = room:getNCards(x, false)
		local move = sgs.CardsMoveStruct()
		move.card_ids = ids
		move.to = source
		move.to_place = sgs.Player_PlaceTable
		move.reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_TURNOVER, source:objectName(), self:objectName(), nil)
		room:moveCardsAtomic(move, true)
		room:getThread():delay(1000)
		local card_to_gotback = {}
		local typs = {}
		for i=0, x-1, 1 do
			local id = ids:at(i)
			local card = sgs.Sanguosha:getCard(id)
			if not table.contains(typs, card:getType()) then
				table.insert(typs, card:getType())
			end
		end
		local choice = room:askForChoice(source, self:objectName(), table.concat(typs, "+"))
		for i=0, x-1, 1 do
			local id = ids:at(i)
			local card = sgs.Sanguosha:getCard(id)
			if card:getType() == choice then
				table.insert(card_to_gotback, id)
			end
		end
		if #card_to_gotback == 0 then return false end
		local dummy = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		for _,c in ipairs(card_to_gotback) do
			dummy:addSubcard(c)
		end
		source:obtainCard(dummy)
	end,
}

sttransportVS = sgs.CreateViewAsSkill{
	name = "sttransport" ,
	n = 999,
	enabled_at_play = function()
		return false
	end ,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@sttransport"
	end ,
	view_filter = function(self, selected, to_select)
		return not to_select:isEquipped()
	end ,
	view_as = function(self, cards)
		local wine = sttransportCard:clone()
		for _, c in ipairs(cards) do
			wine:addSubcard(c)
		end
		wine:setSkillName(self:objectName())
		return wine
	end ,
}

sttransport = sgs.CreateTriggerSkill{
	name = "sttransport",
	events = {sgs.DrawInitialCards,sgs.AfterDrawInitialCards,sgs.EventPhaseStart},
	view_as_skill = sttransportVS, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.DrawInitialCards then
			room:attachSkillToPlayer(player, "stdrive")
			room:sendCompulsoryTriggerLog(player, "sttransport")
			data:setValue(data:toInt() + 3)
		elseif event == sgs.AfterDrawInitialCards then
			local exchange_card = room:askForExchange(player, "sttransport", 3, 3)
			player:addToPile("strail", exchange_card:getSubcards())
			exchange_card:deleteLater()
		elseif event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_RoundStart then
				room:askForUseCard(player, "@@sttransport", "@sttransportask")
			end
		end
		return false
	end,
}

hglaser = sgs.CreateTriggerSkill{
	name = "hglaser" ,
	events = {sgs.Damaged} ,
	frequency = sgs.Skill_NotFrequent ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()
		if damage.from and not damage.from:isNude() then
			if room:askForSkillInvoke(player, self:objectName(), data) then
				room:setPlayerFlag(damage.to, "hglaser_InTempMoving")
				local able = damage.from:getCards("hej")
				local disabled = sgs.IntList()
				local tothrow = sgs.IntList()
				local f = true
				local original_places = sgs.IntList()
				while (not able:isEmpty()) and (f or room:askForChoice(player, self:objectName(), "hgdiscard+cancel") == "hgdiscard") do 
					f = false
					local id = room:askForCardChosen(player, damage.from, "hej", "hglaser", true, sgs.Card_MethodDiscard, disabled)
					if id then
						local c = sgs.Sanguosha:getCard(id)
						tothrow:append(id)
						for _,cd in sgs.qlist(damage.from:getCards("hej")) do
							if cd:getTypeId() == c:getTypeId() then
								disabled:append(cd:getEffectiveId())
								original_places:append(room:getCardPlace(cd:getEffectiveId()))
								damage.from:addToPile("#hglaser", cd:getEffectiveId(), false)
								able:removeOne(cd)
							end
						end
					end
				end
				for i = 0,disabled:length() - 1, 1 do
					room:moveCardTo(sgs.Sanguosha:getCard(disabled:at(i)), damage.from, original_places:at(i), false)
				end
				room:setPlayerFlag(damage.to, "-hglaser_InTempMoving")
				if tothrow:length() > 0 then
					local dummy = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
					for _,cad in sgs.qlist(tothrow) do
						dummy:addSubcard(cad)
					end
					local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_THROW, damage.from, "", "hglaser", "")
					room:throwCard(dummy, damage.from, player)
					room:broadcastSkillInvoke(self:objectName(),1)
				end
			end
		end
	end
}

hglaserFakeMove = sgs.CreateTriggerSkill{
	name = "#hglaserFakeMove" ,
	events = {sgs.BeforeCardsMove, sgs.CardsMoveOneTime} ,
	priority = 10 ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		for _, p in sgs.qlist(room:getAllPlayers()) do
			if p:hasFlag("hglaser_InTempMoving") then return true end
		end
		return false
	end
}

hgjiejing = sgs.CreateTriggerSkill{
	name = "hgjiejing" ,
	events = {sgs.CardFinished,sgs.EventPhaseChanging} ,
	frequency = sgs.Skill_NotFrequent ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardFinished then
			local use = data:toCardUse()
			if player:hasSkill(self:objectName()) and use.card:getTypeId() ~= sgs.Card_TypeSkill and player:isAlive() then
				room:addPlayerMark(player, "@hgjiejing", 1)
				local count = player:getMark("@hgjiejing")
				local used_cards = sgs.IntList()
				if use.card:isVirtualCard() then
					used_cards = use.card:getSubcards()
				else
					used_cards:append(use.card:getEffectiveId())
				end
				if (not used_cards:isEmpty()) and player:getCards("he"):length() >= count then
					local ex = room:askForExchange(player, self:objectName(), count, count, true, "@hgjiejingask:"..tostring(count), true)
					if ex then
						room:broadcastSkillInvoke(self:objectName(),1)
						room:throwCard(ex, player, player)
						room:obtainCard(player, use.card)
						local smallest = true
						for _,p in sgs.qlist(room:getOtherPlayers(player)) do
							if p:getHandcardNum() < player:getHandcardNum() then smallest = false end
						end
						if smallest then
							room:drawCards(player,1)
						end
					end
				end
			end
		else
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					room:setPlayerMark(p, "@hgjiejing", 0)
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

hskefa = sgs.CreateTriggerSkill{
	name = "hskefa",
	events = {sgs.EventPhaseStart, sgs.CardUsed, sgs.CardResponded, sgs.EventPhaseChanging},
	can_trigger = function(self, target)
		return target ~= nil
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_RoundStart then
				for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
					if sp:hasSkill(self:objectName()) and room:askForSkillInvoke(sp, self:objectName(), data) then
						local pattern = "BasicCard+TrickCard+EquipCard"
						local ask = room:askForChoice(sp, self:objectName(), pattern)
						local flag = "+false+okey"
						local log = sgs.LogMessage()
							log.type = "#hskefaAnnounce"
							log.from = player
							log.arg = "hsunwill"
							log.arg2 = ask
						local prompt = ask
						if room:askForSkillInvoke(player, self:objectName() .. "d", sgs.QVariant(prompt)) then 
						--	room:writeToConsole("he will use!")
							flag = "+true+punish" 
							log.arg = "hswill"
						end
						room:setPlayerProperty(sp, "hskefauser", sgs.QVariant("" .. ask .. flag))
					--	room:writeToConsole("666")
						room:setPlayerMark(sp, "hskefafound", 1)
						room:sendLog(log)
					end
				end
			end
		elseif event == sgs.EventPhaseChanging then
			if data:toPhaseChange().to == sgs.Player_NotActive then
				for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
					if sp:getMark("hskefafound") > 0 then
						local record = sp:property("hskefauser"):toString():split("+")
						local okey = record[3]
					--	room:writeToConsole("end!")
						if okey == "punish" then
							local log = sgs.LogMessage()
								log.type = "#TriggerSkill"
								log.from = sp
								log.arg = self:objectName()
								room:sendLog(log)
							room:damage(sgs.DamageStruct(self:objectName(), sp, player))
						else
							local tothrow = room:askForExchange(sp, self:objectName(), 999, 1, true, "hskefaask:" .. record[1], true, record[1])
							if tothrow then
								local log = sgs.LogMessage()
									log.type = "#TriggerSkill"
									log.from = sp
									log.arg = self:objectName()
									room:sendLog(log)
								local n = tothrow:getSubcards():length()
								room:throwCard(tothrow, sp, sp)
								room:drawCards(sp, n)
							end
						end
						room:setPlayerProperty(sp, "hskefauser", sgs.QVariant())
						room:setPlayerMark(sp, "hskefafound", 0)
					end
				end
			end
		else
			local card = nil
			if player:objectName() == room:getCurrent():objectName() then
				if event == sgs.CardUsed then
					local use = data:toCardUse()
					card = use.card
				else
					card = data:toCardResponse().m_card
				end
				for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
					if card and sp:getMark("hskefafound") > 0 then
					--	room:writeToConsole("find hesmu")
						local record = sp:property("hskefauser"):toString():split("+")
						if card:isKindOf(record[1]) then
							if record[2] == "false" then
							--	room:writeToConsole("used!")
								room:setPlayerProperty(sp, "hskefauser", sgs.QVariant(table.concat({record[1], record[2], "punish"}, "+")))
							else
							--	room:writeToConsole("used!ok!")
								room:setPlayerProperty(sp, "hskefauser", sgs.QVariant(table.concat({record[1], record[2], "okey"}, "+")))
							end
						end
					end
				end
			end
		end
		return false
	end	
}

hsxianheCard = sgs.CreateSkillCard{
	name = "hsxianheCard",
	target_fixed = true,
	will_throw = false,
	on_use = function(self, room, source, targets)
		local players = room:getAlivePlayers()
		local general_names = {}
		for _,player in sgs.qlist(players) do
			table.insert(general_names, player:getGeneralName())
			if player:getGeneral2() then
				table.insert(general_names, player:getGeneral2Name())
			end
		end
		local all_generals = sgs.Sanguosha:getLimitedGeneralNames()
		local shu_generals = {}
		for _,name in ipairs(all_generals) do
			if table.contains(science, name) then
				if not table.contains(general_names, name) then
					table.insert(shu_generals, name)
				end
			end
		end
		local general = room:askForGeneral(source, table.concat(shu_generals, "+"))
		source:setTag("newgeneral", sgs.QVariant(general))
		local isSecondaryHero = not (sgs.Sanguosha:getGeneral(source:getGeneralName()):hasSkill("hsxianhe"))
		if isSecondaryHero then
			source:setTag("originalGeneral",sgs.QVariant(source:getGeneral2Name()))
		else
			source:setTag("originalGeneral",sgs.QVariant(source:getGeneralName()))
		end
		room:changeHero(source, general, false, false, isSecondaryHero)
		room:setPlayerMark(source, "@hsxianheFirstRound", 1)
		room:acquireSkill(source, "hsxianhe", false)
		room:acquireSkill(source, "hskefa", true)
		source:loseMark("@hsxianheMark")
		local maxhp = source:getMaxHp()
		local hpi = math.min(3, maxhp)
		local hp = math.max(hpi, source:getHp())
		room:setPlayerProperty(source, "hp", sgs.QVariant(hp))
	end
}

hsxianheVS = sgs.CreateViewAsSkill{
	name = "hsxianhe",
	n = 0,
	view_as = function(self, cards)
		return hsxianheCard:clone()
	end,
	enabled_at_play = function(self, player)
		return player:getMark("@hsxianheMark") > 0
	end,
	enabled_at_response = function(self, player, pattern)
		return string.find(pattern, "@@hsxianhe")
	end 
}

hsxianhe = sgs.CreateTriggerSkill{
	name = "hsxianhe",
	frequency = sgs.Skill_Limited,
	events = {sgs.EventPhaseStart, sgs.EventPhaseChanging, sgs.AskForPeaches},
	view_as_skill = hsxianheVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Start then
				if player:getMark("@hsxianheFirstRound") > 0 then
					room:setPlayerMark(player, "@hsxianheFirstRound", 0)
					room:setPlayerMark(player, "@hsxianheDie", 1)
				end
			end
		elseif event == sgs.EventPhaseChanging then
			if data:toPhaseChange().to == sgs.Player_NotActive and player:getMark("@hsxianheDie") > 0 then
				local log = sgs.LogMessage()
					log.type = "#TriggerSkill"
					log.from = player
					log.arg = "hsxianheDie"
					room:sendLog(log)
				room:loseHp(player)
			end
		elseif event == sgs.AskForPeaches then
			local room = player:getRoom()
			local dying_data = data:toDying()
			local source = dying_data.who
			if source:objectName() == player:objectName() and player:getMark("@hsxianheMark") > 0 and room:askForSkillInvoke(player, "hsxianhe") then
				room:askForUseCard(player,"@@hsxianhe","@hsxianhe")
			end
		end
		return false
	end,
}

hsxianheStart = sgs.CreateTriggerSkill{
	name = "#hsxianheStart",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.GameStart},
	on_trigger = function(self, event, player, data)
		player:gainMark("@hsxianheMark")
	end
}

IOoutput = function(output)
	assert(type(output) == "string")
	local ouf = assert(io.open("IOoutputdata.txt", "a"))
	ouf:write(output)
	ouf:write("\n")
	io.close(ouf)
end

krcircleDummyCard = sgs.CreateSkillCard{
	name = "krcircleDummyCard",
}

krcircle = sgs.CreateTriggerSkill{
	name = "krcircle",
	events = {sgs.BeforeCardsMove,sgs.DrawNCards,sgs.AfterDrawNCards},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.BeforeCardsMove then
			local move = data:toMoveOneTime()
			if move.to_place == sgs.Player_DiscardPile and player:getPhase() ~= sgs.Player_Play then
				local card
				local toget = sgs.IntList()
				local geting = sgs.IntList()
				for _,id in sgs.qlist(move.card_ids) do
					card = sgs.Sanguosha:getCard(id)
					if move.from_places:at(listIndexOf(move.card_ids, id)) == sgs.Player_PlaceHand
						or move.from_places:at(listIndexOf(move.card_ids, id)) == sgs.Player_PlaceEquip then
						local tag = sgs.QVariant()
						tag:setValue(room:getCardOwner(id))
						if card then
							card:setTag("krusefrom",tag)
						end
					end
				end
				if move.to_place == sgs.Player_DiscardPile then
					local otheruse = false
					toget = sgs.IntList()
					for _,id in sgs.qlist(move.card_ids) do
						card = sgs.Sanguosha:getCard(id)
						local cardfrom = card:getTag("krusefrom"):toPlayer()
						if cardfrom then
							if cardfrom:objectName() == player:objectName() then
								toget:append(id)
							else
								otheruse = true
							end
							card:setTag("krusefrom",sgs.QVariant())
						end
					end
					if not otheruse then
						if toget:isEmpty() then
							return false
						elseif player:askForSkillInvoke(self:objectName(), data) then
							while not toget:isEmpty() do
								room:fillAG(toget, player)
								local id = room:askForAG(player, toget, true, self:objectName())
								if id == -1 then
									room:clearAG(player)
									break
								end
								toget:removeOne(id)
								geting:append(id)
								room:clearAG(player)
							end
							if not geting:isEmpty() then
								for _, id in sgs.qlist(geting) do
									if move.card_ids:contains(id) then
										move.from_places:removeAt(listIndexOf(move.card_ids, id))
										move.card_ids:removeOne(id)
										data:setValue(move)
									end
									player:addToPile("Carbon", id)
								--	room:moveCardTo(sgs.Sanguosha:getCard(id), player, sgs.Player_PlaceHand, move.reason, true)
									if not player:isAlive() then break end
								end
							end
						end
					end
				end
				
			end
		elseif event == sgs.DrawNCards then
			local count = data:toInt()
			local car = player:getPile("Carbon")
			if (not car:isEmpty()) and room:askForSkillInvoke(player, self:objectName()) then
				local geting = sgs.IntList()
				while (not car:isEmpty()) and count > 0 do
					room:fillAG(car, player)
					local id = room:askForAG(player, car, true, self:objectName())
					if id == -1 then
						room:clearAG(player)
						break
					end
					count = count - 1
					car:removeOne(id)
					geting:append(id)
					room:clearAG(player)
				end
			--	IOoutput("AA")
				room:setPlayerProperty(player, "krdraw",  sgs.QVariant(table.concat(sgs.QList2Table(geting),"+")))
				room:setPlayerMark(player, "krdrawmark", 1)
			--	IOoutput("BB")
				data:setValue(count)
			--	IOoutput("CC")
			end
		elseif event == sgs.AfterDrawNCards then
		--	IOoutput("DD")
			local listc = player:property("krdraw"):toString():split("+")
			local dummy_card = krcircleDummyCard:clone()
			for _,id in ipairs(listc) do
				dummy_card:addSubcard(id)
			end  
		--	IOoutput("EE" .. player:property("krdraw"):toString())
			room:setPlayerProperty(player, "krdraw",  sgs.QVariant())
			room:setPlayerMark(player, "krdrawmark", 0)
			room:obtainCard(player, dummy_card)
		--	IOoutput("FF")
		end
	end
}

krcirclePass = sgs.CreateTriggerSkill{
	name = "#krcirclePass", 
	frequency = sgs.Skill_NotFrequent, 
	events = {sgs.BeforeGameOverJudge},  
	on_trigger = function(self, event, player, data) 
		local room = player:getRoom()
		if player:getPile("Carbon"):length() > 0 and player:askForSkillInvoke("krcircle", data) then
			local target = room:askForPlayerChosen(player, room:getAlivePlayers(), self:objectName())
			local dummy_card = krcircleDummyCard:clone()
			for _,id in sgs.qlist(player:getPile("Carbon")) do
				dummy_card:addSubcard(id)
			end  
			room:obtainCard(target, dummy_card)
			return false
		end
	end, 
	can_trigger = function(self, target)
		if target then
			return target:hasSkill(self:objectName())
		end
		return false
	end
}

--[[krenergyCard = sgs.CreateSkillCard{
	name = "krenergyCard",
	will_throw = false,
	handling_method = sgs.Card_MethodNone,
	filter = function(self, targets, to_select)
		local card = sgs.Self:getTag("krenergy"):toCard()
		card:addSubcards(sgs.Self:getHandcards())
		card:setSkillName(self:objectName())
		if card and card:targetFixed() then
			return false
		end
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		return card and card:targetFilter(qtargets, to_select, sgs.Self) 
			and not sgs.Self:isProhibited(to_select, card, qtargets)
	end,
	feasible = function(self, targets)
		local card = sgs.Self:getTag("krenergy"):toCard()
		card:addSubcards(sgs.Self:getHandcards())
		card:setSkillName(self:objectName())
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		if card and card:canRecast() and #targets == 0 then
			return false
		end
		return card and card:targetsFeasible(qtargets, sgs.Self)
	end,	
	on_validate = function(self, card_use)
		local xunyou = card_use.from
		local room = xunyou:getRoom()
		local use_card = sgs.Sanguosha:cloneCard(self:getUserString())
		local subc = sgs.CardList()
		for _,id in sgs.qlist(self:getSubcards()) do
			subc:append(sgs.Sanguosha:getCard(id))
		end
		use_card:addSubcards(subc)
		use_card:setSkillName("krenergy")
		local available = true
		for _,p in sgs.qlist(card_use.to) do
			if xunyou:isProhibited(p,use_card)	then
				available = false
				break
			end
		end
		available = available and use_card:isAvailable(xunyou)
		if not available then return nil end
		return use_card		
	end,
}

krenergyVS = sgs.CreateViewAsSkill{
	name = "krenergy" ,
	n = 0 ,
	view_as = function(self, cards)
		local c = sgs.Self:getTag("krenergy"):toCard()
		if c then
			local card = krenergyCard:clone()
			card:setUserString(c:objectName())
			card:setSkillName("krenergy")	
			return card
		end
		return nil
	end,
	enabled_at_play = function()
		return false
	end ,
	enabled_at_response = function(self, player, pattern)
		return string.find(pattern, "@@krenergy")
	end
}]]--

function Set(list)
	local set = {}
	for _, l in ipairs(list) do set[l] = true end
	return set
end

krenergy = sgs.CreateTriggerSkill{
	name = "krenergy",
	events = {sgs.EventPhaseStart,sgs.EventPhaseEnd},
--	view_as_skill = krenergyVS,
--	guhuo_type = "l",
	can_trigger = function(self, target)
	    return target and target:isAlive()
	end,
	on_trigger = function(self,event,player,data)
	    local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			local wk = room:findPlayerBySkillName(self:objectName())
			if not wk then return false end
			if wk:isNude() then return false end
			if player:getPhase() == sgs.Player_Play then
				local c = room:askForCard(wk, ".", "@krenergy:"..player:objectName(), data)
				if c then
					room:setPlayerMark(player,"@energyrecord",1)
					if wk:getPile("Carbon"):length() > 0 then
						local dummy_card = krcircleDummyCard:clone()
						for _,id in sgs.qlist(wk:getPile("Carbon")) do
							if sgs.Sanguosha:getCard(id):isBlack() ~= c:isBlack() then
								dummy_card:addSubcard(id)
							end
						end  
						room:throwCard(dummy_card, wk)
						if dummy_card:getSubcards():length() > 1 then
							local ids = {}
							local energy_cards = {}
							for i = 0, 10000 do
								local card = sgs.Sanguosha:getEngineCard(i)
								if card == nil then break end
								if not (Set(sgs.Sanguosha:getBanPackages()))[card:getPackage()] and card:isKindOf("BasicCard") and not table.contains(energy_cards, card:objectName()) and not table.contains(sgs.Sanguosha:getBanPackages(), card:getPackage()) and card:isAvailable(player) then
									table.insert(energy_cards, card:objectName())
									table.insert(ids, i)
								end
							end
							if #ids == 0 then return false end
						--	IOoutput("AB")
							ids = Table2IntList(ids)
						--	IOoutput("BC")
							room:fillAG(ids, player)
						--	IOoutput("CD")
							local ag = room:askForAG(player, ids, true, self:objectName())
							room:clearAG(player)
							if ag == -1 then return false end
						--	IOoutput("DE")
							room:setPlayerMark(player, self:objectName(), ag)
						--	IOoutput("EF")
							if room:askForUseCard(player, "@@krenergysecond", "@krenergyaskforc") then
						--		IOoutput("FG")
								local slash = sgs.Sanguosha:cloneCard(sgs.Sanguosha:getCard(ag):objectName(), sgs.Card_NoSuit, 0)
								slash:setSkillName(self:objectName())
								local card_use = sgs.CardUseStruct()
								card_use.from = player
								for _,p in sgs.qlist(room:getAlivePlayers()) do
									if p:hasFlag("krenergyuseto") then
										p:setFlags("-krenergyuseto")
										card_use.to:append(p)
									end
								end
								card_use.card = slash
								room:useCard(card_use, false)
							end
							room:setPlayerMark(player, self:objectName(), 0)
						end
					end
				end
			end
		elseif event == sgs.EventPhaseEnd then
			if player:getMark("@energyrecord") > 0 and player:getPhase() == sgs.Player_Finish then
				room:setPlayerMark(player,"@energyrecord",0)
			end
		end
	end
}

krenergysecondCard = sgs.CreateSkillCard{
	name = "krenergysecond",
	will_throw = false ,
	filter = function(self, targets, to_select)
		local toc = sgs.Sanguosha:getCard(sgs.Self:getMark("krenergy"))
		local plist = sgs.PlayerList()
		for _, p in ipairs(targets) do
			plist:append(p)
		end
		if toc and toc:targetFixed() then
			return false
		end
		return toc and toc:targetFilter(plist, to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, toc, plist)
	end,
	feasible = function(self, targets)
		local card = sgs.Sanguosha:getCard(sgs.Self:getMark("krenergy"))
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		if card and card:canRecast() and #targets == 0 then
			return false
		end
		return card and card:targetsFeasible(qtargets, sgs.Self)
	end,	
	on_use = function(self, room, source, targets)
		local card = sgs.Sanguosha:getCard(source:getMark("krenergy"))
		if card:getSubtype() == "aoe" then
			for _, target in sgs.qlist(room:getOtherPlayers(source)) do
				room:cardEffect(self, source, target)
			end
		elseif card:getSubtype() == "global_effect" then
			for _, target in sgs.qlist(room:getAllPlayers()) do
				room:cardEffect(self, source, target)
			end
		elseif (card:targetFixed() or #targets == 0) then
			room:cardEffect(self, source, source)
		else
			for _, target in ipairs(targets) do
				room:cardEffect(self, source, target)
			end
		end
	end,
	on_effect = function(self, effect)
	--	local card = sgs.Sanguosha:getCard(sgs.Self:property("edcankaoasking"):toInt())
		effect.to:setFlags("krenergyuseto")
		effect.from:getRoom():setPlayerMark(effect.from, "krenergy", 0)
	end
}

krenergysecond = sgs.CreateViewAsSkill{
	name = "krenergysecond",
	n = 0,
	view_as = function(self, cards)
		return krenergysecondCard:clone()
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@krenergysecond"
	end,
}

krenergyb = sgs.CreateTargetModSkill{
	name = "#krenergyb",
	pattern = ".",
	distance_limit_func = function(self, player)
		if player:getMark("@energyrecord") > 0 then
			return 1000
		end
	end,
}

mdmazuiCard = sgs.CreateSkillCard{
	name = "mdmazuiCard",
	handling_method = sgs.Card_MethodNone,
	will_throw = false,
	filter = function(self, targets, to_select, player)
		local yim = sgs.Sanguosha:cloneCard("yimi",sgs.Card_NoSuit,0)
		return #targets == 0 and yim:targetFilter(sgs.PlayerList(), to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, yim, sgs.PlayerList())
	end,
	on_use = function(self, room, source, targets)
		local dest = targets[1]
		local c = room:askForCardChosen(dest, source, "h", self:objectName())
		if c then
			room:obtainCard(dest, c, false)
			local slash = sgs.Sanguosha:cloneCard("yimi", sgs.Card_NoSuit, 0)
			slash:setSkillName("mdmazui")
			local card_use = sgs.CardUseStruct()
			card_use.from = source
			card_use.to:append(dest)
			card_use.card = slash
			room:useCard(card_use, false)
		end
	end,
}

mdmazuiVS = sgs.CreateViewAsSkill{
	name = "mdmazui",
	n = 0,
	view_as = function(self, cards)
		return mdmazuiCard:clone()
	end,
	enabled_at_play = function(self, player)
		return false
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@mdmazui"
	end,
}

mdmazui = sgs.CreateTriggerSkill{
	name = "mdmazui",
	events = {sgs.EventPhaseStart},
	view_as_skill = mdmazuiVS,
	can_trigger = function(self, target)
	    return target and target:isAlive()
	end,
	on_trigger = function(self,event,player,data)
	    local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			local wk = room:findPlayerBySkillName(self:objectName())
			if not wk then return false end
			if wk:isKongcheng() then return false end
			if player:getPhase() == sgs.Player_Play then
				room:askForUseCard(wk, "@@mdmazui", "@mdmazuiask:" .. player:objectName())
			end
		end
	end
}

mdzhumaVS = sgs.CreateOneCardViewAsSkill{
	name = "mdzhuma", 
	filter_pattern = ".",
	response_or_use = true,
	view_as = function(self, card) 
		local jink = sgs.Sanguosha:cloneCard("yimi",card:getSuit(),card:getNumber())
		jink:setSkillName("mdzhuma")
		jink:addSubcard(card:getId())
		return jink
	end,
	enabled_at_play = function(self, player)
		return false
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@mdzhuma"
	end
}

mdzhuma = sgs.CreateTriggerSkill{
	name = "mdzhuma",
	events = {sgs.NonTrigger, sgs.DamageForseen},
	view_as_skill = mdzhumaVS,
	can_trigger = function(self, target)
	    return target and target:isAlive()
	end,
	on_trigger = function(self,event,player,data)
	    local room = player:getRoom()
		if event == sgs.NonTrigger then
			if data:toString() == "YimiClear" then
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					if p:hasSkill(self:objectName()) then
						room:setPlayerProperty(p, "zhumaee", sgs.QVariant(player:objectName()))
						room:askForUseCard(p, "@@mdzhuma", "@mdzhumaask:" .. player:objectName())
						room:setPlayerProperty(p, "zhumaee", sgs.QVariant())
					end
				end
			end
		elseif event == sgs.DamageForseen then
			local damage = data:toDamage()
			local wk = room:findPlayerBySkillName(self:objectName())
			if not wk then return false end
			if damage.from:objectName() == wk:objectName() then return false end
			if damage.to:isNude() then return false end
			if damage.to:getMark("@yimi") == 0 then return false end
			if room:askForSkillInvoke(damage.from, self:objectName() .. "give", data) then
				local c = room:askForCardChosen(damage.from, damage.to, "he", self:objectName())
				if c then
					room:obtainCard(wk, c)
					return true
				end
			end
		end
	end
}

mdzhumaPro = sgs.CreateProhibitSkill{
	name = "mdzhumaPro", 
	is_prohibited = function(self, from, to, card)
		return card:getSkillName() == "mdzhuma" and to:objectName() ~= from:property("zhumaee"):toString()
	end
}

abcuojueCard = sgs.CreateSkillCard{
	name = "abcuojueCard",
	will_throw = true,
	filter = function(self, targets, to_select, player)
		local yim = sgs.Card_Parse(sgs.Self:property("abcuojuecard"):toString())
		IOoutput("DD")
		return #targets == 0 and to_select:getMark("abcuojueee") > 0 and (not sgs.Self:isProhibited(to_select, yim))
	end,
	on_use = function(self, room, source, targets)
		room:setPlayerMark(targets[1], "abcuojuevictim", 1)
	end,
}

abcuojueVS = sgs.CreateOneCardViewAsSkill{
	name = "abcuojue", 
	filter_pattern = ".",
	response_or_use = true,
	view_as = function(self, card)
		local wine = abcuojueCard:clone()
		IOoutput("AA")
		wine:addSubcard(card)
		IOoutput("BB")
		wine:setSkillName(self:objectName())
		IOoutput("CC")
		return wine
	end ,
	enabled_at_play = function(self, player)
		return false
	end, 
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@abcuojue"
	end
}

abcuojue = sgs.CreateTriggerSkill{
	name = "abcuojue",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TargetSpecifying},
	view_as_skill = abcuojueVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.TargetSpecifying then
			local use = data:toCardUse()
			local card = use.card
			local ab = room:findPlayerBySkillName(self:objectName())
			if ab and ab:objectName() ~= use.from:objectName() and (card:isKindOf("BasicCard") or card:isKindOf("TrickCard")) then
				local ad = use.from:distanceTo(ab)
				local readying = false
				for i = 1, math.max(ad, 1), 1 do
					if not ab:isAlive() then break end
					for _,p in sgs.qlist(room:getAlivePlayers()) do
						local upp = nil
						for _,pe in sgs.qlist(room:getOtherPlayers(p)) do
							if p:getSeat() == math.mod(pe:getSeat(),p:aliveCount())+1 then upp = pe break end
						end
						if use.to:contains(p) then
							if upp and upp:getHp() >= p:getHp() and p:getNextAlive():getHp() >= p:getHp() then room:setPlayerMark(p, "abcuojueee", 1) end
						elseif (not card:isKindOf("DelayedTrick")) then
							if upp and upp:getHp() <= p:getHp() and p:getNextAlive():getHp() <= p:getHp() and (use.to:contains(upp) or use.to:contains(p:getNextAlive())) then room:setPlayerMark(p, "abcuojueee", 1) end
						end
					end
					room:setPlayerProperty(ab, "abcuojuecard", sgs.QVariant(use.card:toString()))
					local leavenum = math.max(ad, 1) + 1 - i
					local ac = room:askForUseCard(ab, "@@abcuojue", "@abcuojueask:" .. use.from:objectName() .. ":" .. leavenum)
					room:setPlayerProperty(ab, "abcuojuecard", sgs.QVariant())
					for _,p in sgs.qlist(room:getAlivePlayers()) do
						room:setPlayerMark(p, "abcuojueee", 0)
					end
					if not ac then break end
					for _,p in sgs.qlist(room:getAlivePlayers()) do
						if p:getMark("abcuojuevictim") > 0 then
							readying = true
							room:setPlayerMark(p, "abcuojuevictim", 0)
							local log = sgs.LogMessage()
							if use.to:contains(p) then
								use.to:removeOne(p)
								log.type = "#abcuojueRemove"
								room:setEmotion(p,"lpbanned")
							else
								use.to:append(p)
								room:setEmotion(p,"baiaim")
								log.type = "#abcuojueAdd"
							end
							log.from = use.from
							log.to:append(p)
							log.card_str = use.card:toString()
							room:sendLog(log)
							data:setValue(use)
						end
					end
				end
				if readying then
					local log = sgs.LogMessage()
					log.type = "#abcuojueFinish"
					log.from = use.from
					log.to = use.to
					log.card_str = use.card:toString()
					room:sendLog(log)
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

abforget = sgs.CreateTriggerSkill{
	name = "abforget",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.EventPhaseChanging,sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				if player:hasSkill(self:objectName()) and player:isWounded() then
					room:broadcastSkillInvoke(self:objectName(),1)
					local card_ids = room:getNCards(1)
					local id = card_ids:first()
					room:fillAG(card_ids, nil)
					local card = sgs.Sanguosha:getCard(id)
					player:obtainCard(card)
					room:getThread():delay(1000)
					room:clearAG()
					local color = card:getSuitString()
					local pattern = ".|" .. color .. "|.|hand"
					player:setTag(self:objectName(), sgs.QVariant(color))
					room:addPlayerMark(player, "abforget", 1)
					room:addPlayerMark(player, "@abforget_" .. color, 1)
					room:setPlayerCardLimitation(player, "use,response", pattern, false)
				end
			end
		elseif event == sgs.EventPhaseStart then
			if player:getPhase() ~= sgs.Player_RoundStart then return false end
			if player:getMark("abforget") > 0 then
				local color = player:getTag(self:objectName()):toString()
				local pattern = ".|" .. color .. "|.|hand"
				room:setPlayerMark(player, "abforget", 0)
				room:setPlayerMark(player, "@abforget_" .. color, 0)
				room:removePlayerCardLimitation(player, "use,response", pattern)
				player:setTag(self:objectName(), sgs.QVariant())
			end
		end
	end
}

lpyuqing = sgs.CreateTriggerSkill{
	name = "lpyuqing" ,
	events = {sgs.EventPhaseStart} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Draw then
			local tgs = sgs.SPlayerList()
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				local num = p:getHandcardNum()
				local flag = true
				for _,pe in sgs.qlist(room:getOtherPlayers(p)) do
					if flag and not (pe:getHandcardNum() > num) then
						tgs:append(p) 
						flag = false
					end
				end
			end
			if tgs:isEmpty() then return false end
			local victim = room:askForPlayerChosen(player, tgs, self:objectName(), "lpyuqingask", true, true)
			if victim then
				local chosers = sgs.SPlayerList()
				for _,pe in sgs.qlist(room:getOtherPlayers(victim)) do
					if not (pe:getHandcardNum() > victim:getHandcardNum()) then
						chosers:append(pe) 
					end
				end
				room:broadcastSkillInvoke(self:objectName(),1)
				for _,pe in sgs.qlist(chosers) do
					if pe and pe:isAlive() then
						local choices = "lpyqdraw"
						if pe:canDiscard(victim, "hej") then choices = "lpyqdraw+lpyqdis" end
						local choice = room:askForChoice(pe, self:objectName(), choices, sgs.QVariant(victim:objectName()))
						if choice == "lpyqdraw" then
							room:drawCards(pe, 1)
						else
							local disc = room:askForCardChosen(pe, victim, "hej", self:objectName())
							room:throwCard(disc, victim, pe)
						end
					end 
				end
			end
		end
		return false
	end
}

bnrepeatVS = sgs.CreateViewAsSkill{
	name = "bnrepeat",
	n = 0,
	view_as = function(self, cards)
		local trick = sgs.Sanguosha:cloneCard(sgs.Self:property("BNRname"):toString(), sgs.Self:property("BNRsuit"):toInt(), sgs.Self:property("BNRnum"):toInt())
		trick:setSkillName(self:objectName())
		return trick
	end,
	enabled_at_play = function(self, player)
		local trick = sgs.Sanguosha:cloneCard(sgs.Self:property("BNRname"):toString(), sgs.Self:property("BNRsuit"):toInt(), sgs.Self:property("BNRnum"):toInt())
		if player:hasFlag("bnrepeatCan") then trick:setSkillName(self:objectName()) end
		return player:hasFlag("bnrepeatCan") and (not player:hasFlag("bnrepeatFor")) and trick:isAvailable(player)
	end,
	enabled_at_response = function(self, player, pattern)
		return false
	end
}

bnrepeat = sgs.CreateTriggerSkill{
	name = "bnrepeat",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.PreCardUsed, sgs.CardUsed, sgs.EventPhaseChanging, sgs.CardEffected, sgs.EventPhaseStart},
	view_as_skill = bnrepeatVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.PreCardUsed then
			local use = data:toCardUse()
			room:setPlayerProperty(player, "BNRsuiting", sgs.QVariant(use.card:getSuit()))
			local card = use.card
			if card:getSkillName() == "bnrepeat" then
				room:loseHp(player, 1)
			end
		elseif event == sgs.CardUsed then
			local use = data:toCardUse()
			if player:getPhase() == sgs.Player_NotActive or (not use.card:isKindOf("BasicCard")) and (not use.card:isNDTrick()) then return false end
			local trick = sgs.Sanguosha:cloneCard(player:property("BNRname"):toString(), player:property("BNRsuiting"):toInt(), player:property("BNRnum"):toInt())
			room:setPlayerFlag(player, "bnrepeatCan")
			room:setPlayerProperty(player, "BNRname", sgs.QVariant(use.card:objectName()))
			room:setPlayerProperty(player, "BNRnum", sgs.QVariant(use.card:getNumber()))
			room:setPlayerProperty(player, "BNRsuit", sgs.QVariant(use.card:getSuit()))
			room:setPlayerProperty(player, "BNRainame", sgs.QVariant(use.card:getClassName()))
			if use.card:getSkillName() == "bnrepeat" then
				local judge = sgs.JudgeStruct()
				judge.who = player
				judge.reason = self:objectName()
				room:judge(judge)
				local c = judge.card
				if c:isBlack() ~= trick:isBlack() then
					room:setPlayerFlag(player, "bnrepeatFor")
					local ids = room:getNCards(1, false)
					local gcard = sgs.Sanguosha:getCard(ids:first())
					room:obtainCard(player, gcard, false)
					local list = player:property("bnrepeat"):toString():split("+")
					room:writeToConsole("pre " .. table.concat(list, "+"))
					table.insert(list, ids:first())
					bnrepeatMove(ids, true, player)
					room:setPlayerProperty(player, "bnrepeat", sgs.QVariant(table.concat(list, "+")))
					room:showCard(player, ids:first())
					room:writeToConsole("after " .. table.concat(list, "+"))
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				room:setPlayerProperty(player, "BNRname", sgs.QVariant())
				room:setPlayerProperty(player, "BNRnum", sgs.QVariant())
				room:setPlayerProperty(player, "BNRsuit", sgs.QVariant())
				room:setPlayerProperty(player, "BNRainame", sgs.QVariant())
			end
		elseif event == sgs.CardEffected then
			local effect = data:toCardEffect()
			if effect.card:getSkillName() == "bnrepeat" and effect.from:objectName() == effect.to:objectName() then return true else return false end
		elseif event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Play then
				
			end
		end
	end
}

bnrepeatRes = sgs.CreateTargetModSkill{
	name = "#bnrepeatRes",
	pattern = ".",
	residue_func = function(self, from, card)
		if card:getSkillName() == "bnrepeat" then
		--if card:isKindOf("Slash") then
			return 999
		else
			return 0
		end
	end
}

function bnrepeatMove(ids, movein, player)
	local room = player:getRoom()
	if movein then
		local move = sgs.CardsMoveStruct(ids, nil, player, sgs.Player_PlaceTable, sgs.Player_PlaceSpecial,
			sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, player:objectName(), "bnrepeat", ""))
		move.to_pile_name = "bnrepeatshow"
		local moves = sgs.CardsMoveList()
		moves:append(move)
		local _player = room:getAllPlayers(true)
		local tb = {}
		for _,id in sgs.qlist(ids) do
			table.insert(tb, sgs.Sanguosha:getCard(id):toString())
		end
		local log = sgs.LogMessage()
			log.type = "$MoveToShowcardPile"
			log.from = player
			log.card_str = table.concat(tb, "+")
			room:sendLog(log)
		room:notifyMoveCards(true, moves, false, _player)
		room:notifyMoveCards(false, moves, false, _player)
	else
		local move = sgs.CardsMoveStruct(ids, player, nil, sgs.Player_PlaceSpecial, sgs.Player_PlaceTable,
			sgs.CardMoveReason(sgs.CardMoveReason_S_MASK_BASIC_REASON, player:objectName(), "bnrepeat", ""))
		move.from_pile_name = "bnrepeatshow"
		local moves = sgs.CardsMoveList()
		moves:append(move)
		local _player = room:getAllPlayers(true)
		local tb = {}
		for _,id in sgs.qlist(ids) do
			table.insert(tb, sgs.Sanguosha:getCard(id):toString())
		end
		local log = sgs.LogMessage()
			log.type = "$MoveToHidecardPile"
			log.from = player
			log.card_str = table.concat(tb, "+")
			room:sendLog(log)
		room:notifyMoveCards(true, moves, false, _player)
		room:notifyMoveCards(false, moves, false, _player)
	end
end

bnrepeat_global = sgs.CreateTriggerSkill{
	name = "#bnrepeat_global",
	events = {sgs.CardsMoveOneTime, sgs.BeforeCardsMove},
	can_trigger = function(self, player)
		return true
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardsMoveOneTime then
			local move = data:toMoveOneTime()
			if move.from and move.from:objectName() == player:objectName() then
				local list = player:property("bnrepeat"):toString():split("+")
				if #list > 0 then
					local to_remove = sgs.IntList()
					local to_set = {}
					for _,l in pairs(list) do
						if move.card_ids:contains(tonumber(l)) then
							to_remove:append(tonumber(l))
						else
							table.insert(to_set, l)
						end
					end
					if not to_remove:isEmpty() then
						bnrepeatMove(to_remove, false, player)
						local pattern = sgs.QVariant()
						if #to_set > 0 then
							pattern = sgs.QVariant(table.concat(to_set, "+"))
						end
						room:setPlayerProperty(player, "bnrepeat", pattern)
					end
				end
			end
		elseif event == sgs.BeforeCardsMove then
			local move = data:toMoveOneTime()
			local source = move.reason.m_playerId
			if source and move.from and move.from:objectName() ~= source and player:objectName() == source
				and move.from_places:contains(sgs.Player_PlaceHand)
				and move.reason.m_skillName ~= "hglaser"
				and move.reason.m_skillName ~= "laman"
				and move.reason.m_skillName ~= "gongxin"
				and move.reason.m_skillName ~= "langgu"
				and not(room:getTag("Dongchaer"):toString() == player:objectName()
				and room:getTag("Dongchaee"):toString() == move.from:objectName()) then
				local list = move.from:property("bnrepeat"):toString():split("+")
				if #list > 0 then
					if #list == 1 and move.from:getHandcards():length() == 1 then return false end
					local ids = sgs.IntList()
					for _,l in pairs(list) do
						ids:append(tonumber(l))
					end
					local to_move = move.card_ids
					local invisible_hands = move.from:getHandcards()
					for _,k in sgs.qlist(move.from:getHandcards()) do
						if ids:contains(k:getId()) then
							invisible_hands:removeOne(k)
						end
					end
					if invisible_hands:length() == 0 then
						local poi = ids
						for _,x in sgs.qlist(move.card_ids) do
							if ids:contains(x) then
								room:fillAG(poi)
								local id = room:askForAG(player, poi, false, "bnrepeat")
								if id ~= -1 then
									to_move:append(id)
									to_move:removeOne(x)
									poi:removeOne(id)
								end
								room:clearAG()
							end
						end
					else
						local hands = sgs.IntList()
						for _,i in sgs.qlist(move.card_ids) do
							if room:getCardPlace(i) == sgs.Player_PlaceHand then
								if ids:contains(i) then
									local rand = invisible_hands:at(math.random(0, invisible_hands:length() - 1)):getId()
									to_move:append(rand)
									to_move:removeOne(i)
									i = rand
								end
								hands:append(i)
							end
						end
						if hands:length() == move.from:getHandcardNum() or hands:length() == 0 then return false end
						local view = ids
						for _,j in sgs.qlist(hands) do
							if view:length() == 0 then break end
							local choice = room:askForChoice(player, "bnrepeat", "bnrepeatpile+bnrepeathand", data)
							if choice == "bnrepeatpile" then
								if view:length() == 1 then
									local id = view:first()
									to_move:append(id)
									to_move:removeOne(j)
									view:removeOne(id)
								else
									room:fillAG(view)
									local id = room:askForAG(player, view, false, "bnrepeat")
									if id ~= -1 then
										to_move:append(id)
										to_move:removeOne(j)
										view:removeOne(id)
									end
									room:clearAG()
								end
							else
								break
							end
						end
					end
					local bools = sgs.BoolList()
					for _,t in sgs.qlist(to_move) do
						bools:append(ids:contains(t))
					end
					move.card_ids = to_move
					move.open = bools
					data:setValue(move)
				end
			end
		end
	end
}

bncaidu = sgs.CreateTriggerSkill{
	name = "bncaidu",
	events = {sgs.StartJudge, sgs.EventPhaseStart},
	frequency = sgs.Skill_Wake,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.StartJudge then
			local judge = data:toJudge()
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:hasSkill(self:objectName()) and p:getMark("caiduUsed") == 0 then
					local list = p:property("bnrepeat"):toString():split("+")
					local ids = sgs.IntList()
					if #list > 0 then
						for _,l in pairs(list) do
							ids:append(tonumber(l))
						end
					end
					local invisible_hands = p:getHandcards()
					for _,k in sgs.qlist(p:getHandcards()) do
						if ids:contains(k:getId()) then
							invisible_hands:removeOne(k)
						end
					end
					if invisible_hands:length() >0 then
						local pattern = {}
						for _,c in sgs.qlist(invisible_hands) do
							table.insert(pattern, c:toString())
						end
						local c = room:askForCard(p, table.concat(pattern, "#"), "@bncaidushow:"..judge.who:objectName(), data, sgs.Card_MethodNone)
						if c then 
						--	room:writeToConsole("pre " .. table.concat(list, "+"))
							room:setPlayerMark(p, "caiduUsed", 1)
							local cs = sgs.IntList()
							cs:append(c:getEffectiveId())
							table.insert(list, cs:first())
							room:setPlayerProperty(p, "bnrepeat", sgs.QVariant(table.concat(list, "+")))
							bnrepeatMove(cs, true, p)
						--	room:writeToConsole("after " .. table.concat(list, "+"))
						end
					end
				end
			end
		elseif event == sgs.EventPhaseStart then
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				room:setPlayerMark(p, "caiduUsed", 0)
			end
			if player:hasSkill(self:objectName()) and player:getPhase() == sgs.Player_RoundStart and player:isWounded() and player:getMark("bncaidu") == 0 then
				local list = player:property("bnrepeat"):toString():split("+")
				if player:getHandcards():length() < (2 * #list) then
					room:setPlayerMark(player, "bncaidu", 1)
					player:gainMark("@waked")
					room:loseMaxHp(player)
					room:acquireSkill(player, "bnbigmath")
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target and target:isAlive()
	end
}

bnbigmath = sgs.CreateTriggerSkill{
	name = "bnbigmath",
	events = {sgs.EventPhaseStart, sgs.AskForRetrial, sgs.EventPhaseChanging},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			local bn = room:findPlayerBySkillName(self:objectName())
			if bn and bn:isAlive() and player:getPhase() == sgs.Player_RoundStart and room:askForSkillInvoke(bn,self:objectName(),data) then
				local card_ids = room:getNCards(player:getLostHp() + 2)
				local jsonLog = {
					"$ViewDrawPile",
					bn:objectName(),
					"",
					table.concat(sgs.QList2Table(card_ids),"+"),
					"",
					""
				}
				room:doNotify(bn, sgs.CommandType.S_COMMAND_LOG_SKILL, json.encode(jsonLog))
				room:fillAG(card_ids,bn)
				local id = room:askForAG(bn, card_ids, false, self:objectName())
				card_ids:removeOne(id)
				room:returnToTopDrawPile(card_ids)
				room:clearAG(bn)
				player:addToPile("bigmath", id)
				sgs.Sanguosha:getCard(id):setSkillName(self:objectName())
			end
		elseif event == sgs.AskForRetrial then
			local judge = data:toJudge()
			if not player:hasSkill(self:objectName()) then return false end
			if room:getCurrent():getPile("bigmath"):isEmpty() then return false end
			local list = player:property("bnrepeat"):toString():split("+")
			if #list > 0 then
				local pattern = {}
				for _,l in ipairs(list) do
					table.insert(pattern, sgs.Sanguosha:getCard(tonumber(l)):toString())
				end
				local cd = room:askForCard(player, table.concat(pattern, "#"), "@bncaiduhide:"..judge.who:objectName(), data, sgs.Card_MethodNone)
				if cd then 
					local llist = list
				--	room:writeToConsole("preh " .. table.concat(list, "+"))
					local cs = sgs.IntList()
					cs:append(cd:getId())
					table.removeOne(llist, tostring(cs:first()))
					room:setPlayerProperty(player, "bnrepeat", sgs.QVariant(table.concat(llist, "+")))
					bnrepeatMove(cs, false, player)
					local new_card = sgs.Sanguosha:getCard(room:getCurrent():getPile("bigmath"):first())
					judge.card = new_card
					local log = sgs.LogMessage()
						log.type = "#InvokeSkill"
						log.from = player
						log.arg = "bnbigmath"
						room:sendLog(log)
					judge:updateResult()
					room:broadcastUpdateCard(room:getAllPlayers(true), judge.card:getId(), new_card)
				--	room:writeToConsole("afterh " .. table.concat(llist, "+"))
				end
			end
		elseif event == sgs.EventPhaseChanging then
			if data:toPhaseChange().to ~= sgs.Player_NotActive then return false end
			player:removePileByName("bigmath")
		end
	end,
	can_trigger = function(self, target)
		return target and target:isAlive()
	end
}

bncaiduExtra = sgs.CreateMaxCardsSkill{
	name = "#bncaiduExtra" ,
	extra_func = function(self, target)
		if target:hasSkill("bncaidu") then
			local list = target:property("bnrepeat"):toString():split("+")
			return #list
		else
			return 0
		end
	end
}

bryueqianCard = sgs.CreateSkillCard{
	name = "bryueqianCard", 
	target_fixed = false,
	will_throw = true,
	filter = function(self, targets, to_select) 
		local ej = sgs.Sanguosha:cloneCard("ejump", sgs.Card_NoSuit, 0)
		return ej:targetFilter(targetsTable2QList(targets), to_select, sgs.Self)
	end,
	feasible = function(self, targets)
		local ej = sgs.Sanguosha:cloneCard("ejump", sgs.Card_NoSuit, 0)
		return ej:targetsFeasible(targetsTable2QList(targets), sgs.Self)
	end,
	on_use = function(self, room, source, targets) 
		local tlist = source:property("bryueqiantarget"):toString():split("+")
		for _,p in sgs.qlist(room:getAllPlayers(true)) do
			if table.contains(tlist, p:objectName()) then
				room:setPlayerMark(p, "@brjumptarget", p:getMark("@brjumptarget") - 1)
			end
		end
		local list = {}
		for _,p in ipairs(targets) do
			table.insert(list, p:objectName())
			room:setPlayerMark(p, "@brjumptarget", p:getMark("@brjumptarget") + 1)
		end
		room:setPlayerProperty(source, "bryueqiantarget", sgs.QVariant(table.concat(list, "+")))
	end,
}

bryueqianVS = sgs.CreateZeroCardViewAsSkill{
	name = "bryueqian", 
	response_pattern = "@@bryueqian!",
	view_as = function(self, cards) 
		return bryueqianCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return false
	end,
}

bryueqian = sgs.CreateTriggerSkill{
	name = "bryueqian", 
	events = {sgs.EventPhaseChanging,sgs.Death, sgs.EventPhaseStart}, 
	view_as_skill = bryueqianVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.Death then
			local death = data:toDeath()
			if player:hasSkill(self:objectName()) and death.who:objectName() == player:objectName() then
				local tlist = player:property("bryueqiantarget"):toString():split("+")
				for _,p in sgs.qlist(room:getAllPlayers(true)) do
					if table.contains(tlist, p:objectName()) then
						room:setPlayerMark(p, "@brjumptarget", p:getMark("@brjumptarget") - 1)
					end
				end
			end
			if player:objectName() == death.who:objectName() and player:getMark("@brjumptarget") > 0 then
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					local tlist = p:property("bryueqiantarget"):toString():split("+")
					if table.contains(tlist, death.who:objectName()) then
						room:askForUseCard(p, "@@bryueqian!", "@bryueqian")
					end
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive and player:hasSkill(self:objectName()) then
				room:askForUseCard(player, "@@bryueqian!", "@bryueqian")
			end
		elseif event == sgs.EventPhaseStart then
			local upp = nil
			for _,pe in sgs.qlist(room:getOtherPlayers(player)) do
				if player:getSeat() == math.mod(pe:getSeat(),player:aliveCount())+1 then upp = pe break end
			end
			if player:getPhase() == sgs.Player_RoundStart and player:getMark("@brjumptarget") > 0 and upp and upp:getMark("@brjumptarget") > 0 then
				local notused = true
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					local list = p:property("bryueqiantarget"):toString():split("+")
					if notused and table.contains(list, player:objectName()) and table.contains(list, upp:objectName()) then
						room:setPlayerMark(player, "@brjumptarget", player:getMark("@brjumptarget") - 1)
						room:setPlayerMark(upp, "@brjumptarget", upp:getMark("@brjumptarget") - 1)
						room:setPlayerProperty(p, "bryueqiantarget", sgs.QVariant())
						local slash = sgs.Sanguosha:cloneCard("ejump", sgs.Card_NoSuit, 0)
						slash:setSkillName(self:objectName())
						local use = sgs.CardUseStruct()
						use.card = slash
						use.from = p
						use.to:append(player)
						use.to:append(upp)
						slash:toTrick():setCancelable(false)
						room:useCard(use)
					end
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end
}

function getAbleBscResCard(player, pattern)
	local ids = {}
	local energy_cards = {}
	for i = 0, 10000 do
		local card = sgs.Sanguosha:getEngineCard(i)
		if card == nil then break end
		if not (Set(sgs.Sanguosha:getBanPackages()))[card:getPackage()] and card:isKindOf("BasicCard") and not table.contains(energy_cards, card:objectName()) and not table.contains(sgs.Sanguosha:getBanPackages(), card:getPackage()) and (sgs.Sanguosha:matchExpPattern(pattern, player, card) or string.find(pattern, card:objectName()) or string.find(pattern, card:getClassName())) then
			table.insert(energy_cards, card:objectName())
			table.insert(ids, i)
		end
	end
	return ids
end

brqingpuCard = sgs.CreateSkillCard{
	name = "brqingpuCard",
    will_throw = false,
	handling_method = sgs.Card_MethodNone,
	filter = function(self, targets, to_select)
		local players = sgs.PlayerList()
		for i = 1 , #targets do
			players:append(targets[i])
		end
		if sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE_USE then
			local card = nil
			if self:getUserString() and self:getUserString() ~= "" then
				card = sgs.Sanguosha:cloneCard(self:getUserString():split("+")[1])
				return card and card:targetFilter(players, to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, card, players)
			end
		elseif sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE then
			return false
		end
		local _card = sgs.Self:getTag("brqingpu"):toCard()
		if _card == nil then
			return false
		end
		local card = sgs.Sanguosha:cloneCard(_card)
	--	IOoutput("BC")
		card:setCanRecast(false)
		card:deleteLater()
		return card and card:targetFilter(players, to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, card, players)
	end ,
	feasible = function(self, targets)
		local players = sgs.PlayerList()
		for i = 1 , #targets do
			players:append(targets[i])
		end
		if sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE_USE then
			local card = nil
			if self:getUserString() and self:getUserString() ~= "" then
				card = sgs.Sanguosha:cloneCard(self:getUserString():split("+")[1])
				return card and card:targetsFeasible(players, sgs.Self)
			end
		elseif sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE then
			return true
		end
		local _card = sgs.Self:getTag("brqingpu"):toCard()
		if _card == nil then
			return false
		end
		local card = sgs.Sanguosha:cloneCard(_card)
		card:setCanRecast(false)
		card:deleteLater()
		return card and card:targetsFeasible(players, sgs.Self)
	end ,
	on_validate = function(self, card_use)
		local yuji = card_use.from
		local room = yuji:getRoom()
	--	IOoutput("AB1")
		local to_guhuo = self:getUserString()
		local ids = getAbleBscResCard(yuji, to_guhuo)
	--	IOoutput("AB2")
		ids = Table2IntList(ids)
		room:fillAG(ids, yuji)
		local id = room:askForAG(yuji, ids, false, "brqingpu")
		room:clearAG(yuji)
	--	IOoutput("AB3")
		--yuji:setTag("GuhuoSlash", sgs.QVariant(user_str))
		local ca = sgs.Sanguosha:getCard(id)
		local subc = sgs.Sanguosha:getCard(self:getSubcards():at(0))
		local use_card = sgs.Sanguosha:cloneCard(ca:objectName(), subc:getSuit(), subc:getNumber())
		use_card:setSkillName("brqingpu")
		use_card:addSubcard(subc)
		use_card:deleteLater()
	--	IOoutput("AB4")
		local tos = card_use.to
		for _, to in sgs.qlist(tos) do
			local skill = room:isProhibited(yuji, to, use_card)
			if skill then
				card_use.to:removeOne(to)
			end
		end
		room:setPlayerMark(yuji, "@brqingpu", 0)
	--	IOoutput("AB5")
		return use_card
	end ,
	on_validate_in_response = function(self, yuji)
		local room = yuji:getRoom()
		local to_guhuo = self:getUserString()
		local ids = getAbleBscResCard(yuji, to_guhuo)
	--	IOoutput("AB6")
		ids = Table2IntList(ids)
		room:fillAG(ids,yuji)
		local id = room:askForAG(yuji, ids, false, "brqingpu")
		room:clearAG(yuji)
		local ca = sgs.Sanguosha:getCard(id)
		local subc = sgs.Sanguosha:getCard(self:getSubcards():at(0))
		local use_card = sgs.Sanguosha:cloneCard(ca:objectName(), subc:getSuit(), subc:getNumber())
	--	IOoutput("AB7")
		use_card:setSkillName("brqingpu")
		use_card:addSubcard(subc)
		use_card:deleteLater()
		room:setPlayerMark(yuji, "@brqingpu", 0)
		return use_card
	end
}

brqingpuVS = sgs.CreateOneCardViewAsSkill{
	name = "brqingpu",
	response_or_use = true,
	view_filter = function(self,to_select)
		return true
	end,
	enabled_at_response = function(self, player, pattern)
	--	player:speak(pattern .. " fuck")
	--	IOoutput("fuck " .. pattern)
		if string.sub(pattern, 1, 1) == "." or string.sub(pattern, 1, 1) == "@" then
            return false
		end
        if pattern == "peach" and player:getMark("Global_PreventPeach") > 0 then return false end
    --    if string.find(pattern, "[%u%d]") then return false end--这是个极其肮脏的黑客！！ 因此我们需要去阻止基本牌模式
	--	player:speak(pattern)
	--	IOoutput(pattern)
		return #getAbleBscResCard(player, pattern) > 0 and player:getMark("@brqingpu") > 0 and not player:hasFlag("brqingpuDying")
	end,
	enabled_at_play = function(self, player)
		return player:getMark("@brqingpu") > 0 and not player:hasFlag("brqingpuDying")
	end,
	view_as = function(self, cards)
		if sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE or sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_RESPONSE_USE then
			local card = brqingpuCard:clone()
			card:setUserString(sgs.Sanguosha:getCurrentCardUsePattern())
			card:addSubcard(cards)
			return card
		end
	--	IOoutput("AB")
		local c = sgs.Self:getTag("brqingpu"):toCard()
        if c then
            local card = brqingpuCard:clone()
            card:setUserString(c:objectName())
			card:addSubcard(cards)
			return card
        else
			return nil
		end
	end
}

brqingpu = sgs.CreateTriggerSkill{
	name = "brqingpu",
	events = {sgs.HpChanged, sgs.MaxHpChanged, sgs.QuitDying, sgs.AskForPeachesDone, sgs.EventPhaseChanging},
	view_as_skill = brqingpuVS, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.HpChanged or event == sgs.MaxHpChanged then
			for _,sp in sgs.qlist(room:getAlivePlayers()) do
				if sp:hasSkill(self:objectName()) and (not sp:hasFlag("brqingpuDying")) and sp:getMark("@brqingpu") + sp:getMark("@fenyong") == 0 and (sp:getSeat() == math.mod(player:getSeat(),sp:aliveCount())+1 or player:getSeat() == math.mod(sp:getSeat(),sp:aliveCount())+1)  then
					if room:askForSkillInvoke(sp, self:objectName(), data) then
						room:setPlayerMark(sp, "@brqingpu", 1)
					end
				end
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive  then
				for _,sp in sgs.qlist(room:getAlivePlayers()) do
					if sp:hasSkill(self:objectName()) and sp:hasFlag("brqingpuDying") then
						room:setPlayerFlag(sp, "-brqingpuDying")
					end
				end
			end
		else
			local dying = data:toDying()
			if event == sgs.AskForPeachesDone then
				for _,sp in sgs.qlist(room:getAlivePlayers()) do
					if (sp:getSeat() == math.mod(dying.who:getSeat(),sp:aliveCount())+1 or dying.who:getSeat() == math.mod(sp:getSeat(),sp:aliveCount())+1) and sp:hasSkill(self:objectName()) then
						room:setPlayerMark(sp, "brqingpuDyingPre", 1)
					end
				end
			elseif event == sgs.QuitDying then
				for _,sp in sgs.qlist(room:getAlivePlayers()) do
					if sp:getMark("brqingpuDyingPre") > 0 then
						room:setPlayerMark(sp, "brqingpuDyingPre", 0)
						room:setPlayerFlag(sp, "brqingpuDying")
					end
				end
			end
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end
}

brqingpu:setGuhuoDialog("l")

klweixingCard = sgs.CreateSkillCard{
	name = "klweixingCard",
	will_throw = false,
	handling_method = sgs.Card_MethodNone,
	target_fixed = false,
	filter = function(self, targets, to_select)
		if #targets >= 1 then return false end
		return sgs.Self:getMark("satelliting") == to_select:getSeat()
	end ,
	on_use = function(self, room, source, targets)
		local id = self:getSubcards():first()
		local dest = targets[1]
		room:setPlayerMark(source,"satelliting",0)
		dest:addToPile("satellite",id)
		local dt = sgs.QVariant()
		dt:setValue(dest)
		local duel = sgs.Sanguosha:cloneCard("fireup", sgs.Card_NoSuit, 0)
		duel:toTrick():setCancelable(true)-- 这里true改为false 就是旧版技能
		duel:setSkillName("klweixing")
		local cs = "kldraw"
		if not source:isCardLimited(duel, sgs.Card_MethodUse) and not source:isProhibited(dest, duel) then cs = "kldraw+kldmg" end
		local choice = room:askForChoice(source, "satellite", cs, dt)
		if choice == "kldraw" then
			room:drawCards(source,1)
		else
			if not source:isCardLimited(duel, sgs.Card_MethodUse) and not source:isProhibited(dest, duel) then
				room:useCard(sgs.CardUseStruct(duel, source, dest))
			else
				duel:deleteLater()
			end
		end
		if source:isAlive() then
			local stl = room:askForCard(source, ".", "@satellitelaunch", sgs.QVariant(), sgs.Card_MethodNone)
			if stl then
				source:addToPile("satellite",stl)
			end
		end
	end,
}

klweixingVS = sgs.CreateOneCardViewAsSkill{
	name = "klweixing",
	response_pattern = "@@klweixing" ,
	filter_pattern = ".|.|.|satellite" ,
	expand_pile = "satellite",
	view_as = function(self, cd)
		local card = klweixingCard:clone()
		card:setSkillName(self:objectName())
		card:addSubcard(cd)
		return card
	end
}

klweixing = sgs.CreateTriggerSkill{
	name = "klweixing",
	events = {sgs.EventPhaseStart, sgs.BeforeCardsMove},
	view_as_skill = klweixingVS,
	can_trigger = function(self, target)
		return target ~= nil and target:isAlive()
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:isAlive() and player:hasSkill(self:objectName()) and player:getPhase() == sgs.Player_Play and player:getPile("satellite"):length() == 0 then
				local stl = room:askForCard(player, ".", "@satellitelaunch", data, sgs.Card_MethodNone)
				if stl then
					player:addToPile("satellite",stl)
				end
			elseif player:getPhase() == sgs.Player_Judge and player:getPile("satellite"):length() > 0 then
				local intlist = sgs.IntList()
				for _,id in sgs.qlist(player:getPile("satellite")) do
					intlist:append(id)
				end
				for _,id in sgs.qlist(intlist) do
					room:obtainCard(player, sgs.Sanguosha:getCard(id))
				end
			end
		else
			if not player:hasSkill(self:objectName()) then return end
			local sp = player
			if sp:getPile("satellite"):length()==0 then return end
			local stl = sgs.Sanguosha:getCard(sp:getPile("satellite"):first())
			local move = data:toMoveOneTime()
			if (move.to_place ~= sgs.Player_DiscardPile) then return end
			local trig = false
			if bit32.band(move.reason.m_reason, sgs.CardMoveReason_S_MASK_BASIC_REASON) == sgs.CardMoveReason_S_REASON_RESPONSE or bit32.band(move.reason.m_reason, sgs.CardMoveReason_S_MASK_BASIC_REASON) == sgs.CardMoveReason_S_REASON_USE then 
				if move.from and player:objectName() == move.from:objectName() then return end 
				for _,id in sgs.qlist(move.card_ids) do
					if sgs.Sanguosha:getCard(id):getSuit() == stl:getSuit() then
						trig = true
						break
					end
				end
				if trig then
					room:setPlayerMark(sp,"satelliting",move.from:getSeat())
					room:askForUseCard(sp,"@@klweixing","@satellite_move:"..move.from:objectName())
					room:setPlayerMark(sp,"satelliting",0)
				end
			end
		end
		return false
	end
}

kltiance = sgs.CreateTriggerSkill{
	name = "kltiance" ,
	events = {sgs.CardUsed} ,
	on_trigger = function(self, event, player, data)
		local use = data:toCardUse()
		local room = player:getRoom()
		local card = use.card
		if card:isKindOf("BasicCard") or card:isKindOf("TrickCard") then
			local splayer = room:findPlayerBySkillName(self:objectName())
			if not splayer then return false end
			if not use.to:contains(splayer) then return false end
			if use.from:objectName() == splayer:objectName() then return false end
			local upp = use.from
			for i = 1,splayer:aliveCount()-1,1 do
				upp = upp:getNextAlive()
			end
			local upok = upp:getPile("satellite"):length() > 0
			local downok = use.from:getNextAlive():getPile("satellite"):length() > 0
			if upok or downok then
				local offer = sgs.SPlayerList()
				if upok then offer:append(upp) end
				if downok then offer:append(use.from:getNextAlive()) end
				local theoffer = room:askForPlayerChosen(splayer,offer,self:objectName(),"kltiance-invoke",true)
				if theoffer then
					room:fillAG(theoffer:getPile("satellite"), splayer)
					local card_id = room:askForAG(splayer, theoffer:getPile("satellite"), false, self:objectName())
					if card_id ~= -1 then
						use.from:addToPile("satellite",card_id)
						use.to = sgs.SPlayerList()
						data:setValue(use)
						if room:askForSkillInvoke(theoffer,self:objectName(),sgs.QVariant("poi:"..use.from:objectName())) then room:drawCards(use.from,1) end;
					end
					room:clearAG(splayer)
				end
			end
		end
		return false
	end ,
	can_trigger = function(self, target)
		return target
	end
}

LuaZuixiangType = {
	"BasicCard",	--sgs.Card_TypeBasic (1)
	"TrickCard",	--sgs.Card_TypeTrick (2)
	"EquipCard"		--sgs.Card_TypeEquip (3)
}

adfengongCard = sgs.CreateSkillCard{
	name = "adfengongCard", 
	target_fixed = false,
	will_throw = false,
	filter = function(self, targets, to_select) 
		return not to_select:isKongcheng()
	end,
	on_use = function(self, room, source, targets) 
		for _,target in ipairs(targets) do
			local card = room:askForCard(target,".|.|.|hand","@adfengong-show",sgs.QVariant(),sgs.Card_MethodNone)
			if card then
				room:showCard(target,card:getEffectiveId())
				room:setPlayerMark(target,"@fengong_prepare",1)
				room:setPlayerProperty(target,"fengongwork",sgs.QVariant(LuaZuixiangType[card:getTypeId()]))
			end
		end
	end,
}

adfengongVS = sgs.CreateZeroCardViewAsSkill{
	name = "adfengong", 
	view_as = function(self, cards) 
		return adfengongCard:clone()
	end, 
	enabled_at_play = function(self, player)
		return not player:hasUsed("#adfengongCard")
	end,
}

adfengong = sgs.CreateTriggerSkill{
	name = "adfengong" ,
	events = {sgs.CardFinished,sgs.EventPhaseStart,sgs.EventPhaseEnd},
	view_as_skill = adfengongVS,
	can_trigger = function(self, target)
		return target
	end ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardFinished then
			local use = data:toCardUse()
			if use.from:getMark("@fengong_effect") == 0 then return false end
			local nam = use.from:property("fengongwork"):toString()
			if LuaZuixiangType[use.card:getTypeId()] == nam then room:drawCards(use.from,1) end
		elseif event == sgs.EventPhaseEnd then
			if player:getPhase() == sgs.Player_Play and player:getMark("@fengong_effect") > 0 then
				room:removePlayerCardLimitation(player, "use", "^"..player:property("fengongwork"):toString())
				room:setPlayerProperty(player,"fengongwork",sgs.QVariant())
				room:setPlayerMark(player,"@fengong_effect",0)
			end
		else
			if player:getPhase() == sgs.Player_Play and player:getMark("@fengong_prepare")>0 then
				room:setPlayerMark(player,"@fengong_prepare",0)
				room:setPlayerCardLimitation(player, "use", "^"..player:property("fengongwork"):toString(), true)
				room:setPlayerMark(player,"@fengong_effect",1)
			end
		end
		return false
	end
}

adfengongTargetMod = sgs.CreateTargetModSkill{
	name = "adfengongTargetMod",
	distance_limit_func = function(self, from, card)
		if from:getMark("@fengong_effect")>0 and (LuaZuixiangType[card:getTypeId()] == from:property("fengongwork"):toString()) then
			return 1000
		else
			return 0
		end
	end
}

adshuifu = sgs.CreateTriggerSkill{
	name = "adshuifu" ,
	events = {sgs.EventPhaseChanging,sgs.TargetConfirmed} ,
	can_trigger = function(self, target)
		return target
	end ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				if player:hasFlag("shuifuTarget") then
					for _,yoke in sgs.qlist(room:getOtherPlayers(player)) do
						if yoke:getMark("shuifuyoke")>0 then
							room:setPlayerMark(yoke,"shuifuyoke",0)
							local slash = sgs.Sanguosha:cloneCard("allocate", sgs.Card_NoSuit, 0)
							local tarlist = sgs.SPlayerList()
							if player:isAlive() and (not yoke:isCardLimited(slash, sgs.Card_MethodUse)) and (not yoke:isProhibited(player, slash)) and (not player:isKongcheng()) and room:askForSkillInvoke(yoke,self:objectName(),data) then
								tarlist:append(player)
								room:useCard(sgs.CardUseStruct(slash, yoke, tarlist))
							end
						end
					end
				end
			end
		else
			local use = data:toCardUse()
			if use.to:length()==1 and use.to:at(0):isAlive() and use.to:at(0):hasSkill(self:objectName()) then
				room:setPlayerMark(use.to:at(0),"shuifuyoke",1)
				room:setPlayerFlag(use.from,"shuifuTarget")
			end
		end
		return false
	end
}

ldshexian = sgs.CreateTriggerSkill{
	name = "ldshexian", 
	events = {sgs.EventPhaseChanging,sgs.Death,sgs.EventPhaseStart,sgs.GameStart}, 
	frequency = sgs.Skill_Compulsory ,
	on_trigger = function(self, triggerEvent, player, data)
		local room = player:getRoom()
		if triggerEvent == sgs.Death then
			local death = data:toDeath()
			if death.who:objectName() ~= player:objectName() then
				return false
			end
		elseif triggerEvent == sgs.GameStart then
			if not player:hasSkill(self:objectName()) then return false end
		elseif triggerEvent == sgs.EventPhaseStart then
			local phase = player:getPhase()
			if phase == sgs.Player_RoundStart and player:getMark("ldshexian") >0 then
				room:handleAcquireDetachSkills(player,"-kanpo",true)
				room:setPlayerMark(player,"ldshexian",0)
			end
			return false
		elseif triggerEvent == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to ~= sgs.Player_NotActive then
				return false
			end
		end
		if player:hasSkill(self:objectName()) then
			room:setPlayerMark(player,"ldshexian",1)
			room:handleAcquireDetachSkills(player,"kanpo")
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end
}

ldshexianP = sgs.CreateProhibitSkill{
	name = "#ldshexianP" ,
	is_prohibited = function(self, from, to, card)
		for _, p in sgs.qlist(from:getAliveSiblings()) do
			if p:objectName()~=to:objectName() and p:getHp()<=to:getHp() then return false end
		end
		return to:hasSkill("ldshexian") and to:getHp()>=to:getHandcardNum() and (not card:isKindOf("EquipCard")) and card:isBlack() and card:getSkillName() ~= "nosguhuo" --特别注意旧蛊惑
	end
}

ldannotateVS = sgs.CreateViewAsSkill{
	name = "ldannotate",
	n = 1,
	view_filter = function(self, selected, to_select)
			if #selected == 0 then
				return to_select:getNumber()>=sgs.Self:property("annotatenum"):toInt() and not to_select:isEquipped()
			end
		return false
	end,
	view_as = function(self, cards)
		if #cards == 1 then
			local first = cards[1]
			local name = sgs.Self:property("annotatename"):toString()
			local suit = first:getSuit()
			local point = first:getNumber()
			local new_card = sgs.Sanguosha:cloneCard(name, suit, point)
			new_card:addSubcard(first)
			new_card:setSkillName(self:objectName())
			return new_card
		end
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		local c = sgs.Sanguosha:cloneCard(player:property("annotatename"):toString(), sgs.Card_NoSuit, 0)
		return pattern == "@@ldannotate" and c:isAvailable(player)
	end
}

ldannotate = sgs.CreateTriggerSkill{
	name = "ldannotate",
	events = {sgs.BeforeCardsMove,sgs.EventPhaseChanging}, 
	view_as_skill = ldannotateVS,
	on_trigger = function(self, event, player, data)
		local room =  player:getRoom()
		if event == sgs.BeforeCardsMove then
			if not player:hasSkill(self:objectName()) then return end
			local move = data:toMoveOneTime()
			if (move.to_place ~= sgs.Player_DiscardPile) then return end
			local to_obtain = nil
			if bit32.band(move.reason.m_reason, sgs.CardMoveReason_S_MASK_BASIC_REASON) ==    sgs.CardMoveReason_S_REASON_USE then 
				if not move.from then return end
				if move.from and (room:getCurrent():objectName() ~= move.from:objectName() or move.from:objectName() == player:objectName()) then return end 
				to_obtain = move.reason.m_extraData:toCard()
			else
				return 
			end
			if not to_obtain or not to_obtain:isNDTrick() then return end
			room:setPlayerProperty(player,"annotatename",sgs.QVariant(to_obtain:objectName()))
			room:setPlayerProperty(player,"annotatenum",sgs.QVariant(to_obtain:getNumber()))
			if room:askForUseCard(player, "@@ldannotate", "@ldannotateprompt") then
				player:addMark("@annotateTimes")
			end
		elseif event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to ~= sgs.Player_NotActive then
				return false
			end
			for _,p in sgs.qlist(room:getOtherPlayers(player)) do
				local _data = sgs.QVariant()
				_data:setValue(p)
				if p:getMark("@annotateTimes")>1 and room:askForSkillInvoke(player,self:objectName().."a",_data) then 
					room:drawCards(p,p:getMark("@annotateTimes")-1)
				end
				room:setPlayerMark(p,"@annotateTimes",0)
			end
		end
		return
	end,
	can_trigger = function(self, target)
		return target
	end
}

cyyuanshi = sgs.CreateTriggerSkill{
	name = "cyyuanshi" ,
	events = {sgs.EventPhaseEnd,sgs.EventPhaseChanging} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseEnd then
			if player:getPhase() == sgs.Player_Draw then
				local tps = {"BasicCard","TrickCard","EquipCard"}
				local oktps = {}
				for i = 1,3,1 do
					if player:getMark("@yuanshiType"..i) == 0 then
						table.insert(oktps,tps[i])
					end
				--	room:setPlayerMark(player,"@yuanshiType"..i,0)
				end
				local sts = {"spade","club","heart","diamond"}
				local oksts = {}
				for i = 1,4,1 do
					if player:getMark("@yuanshiSuit"..i) == 0 then
						table.insert(oksts,sts[i])
					end
				--	room:setPlayerMark(player,"@yuanshiSuit"..i,0)
				end
				if #oktps==0 then return false end
				if #oksts==0 then return false end
				local c = room:askForExchange(player,self:objectName(),999,1,false,self:objectName().."prompt",true,table.concat(oktps,",").."|"..table.concat(oksts,","))
				for i = 1,3,1 do room:setPlayerMark(player,"@yuanshiType"..i,0) end
				for i = 1,4,1 do room:setPlayerMark(player,"@yuanshiSuit"..i,0) end
				if c then
					local jsonValue = {
						player:objectName(),
						false,
						sgs.QList2Table(c:getSubcards())
					}
					room:doBroadcastNotify(room:getOtherPlayers(player),sgs.CommandType.S_COMMAND_SHOW_ALL_CARDS, json.encode(jsonValue))
					local log = sgs.LogMessage()
						log.type = "$ShowCard"
						log.from = player
						log.card_str = table.concat(sgs.QList2Table(c:getSubcards()),"+")
						room:sendLog(log)
					
					oktps = {0,0,0,0}
					oksts = {0,0,0,0,0}
					local a1 = 0
					local a2 = 0
					for _,cid in sgs.qlist(c:getSubcards()) do
						local cc = sgs.Sanguosha:getCard(cid)
						cc:setFlags("visible")
						oktps[cc:getTypeId()]=1
						oksts[cc:getSuit()+1]=1
						room:setPlayerMark(player,"@yuanshiType"..cc:getTypeId(),1)
						room:setPlayerMark(player,"@yuanshiSuit"..cc:getSuit()+1,1)
					end
					for i = 1,3,1 do a1 = a1 + oktps[i] end
					for i = 1,4,1 do a2 = a2 + oksts[i] end
					room:drawCards(player,a1)
					room:setPlayerMark(player,"@yuanshiKeep",a2)
				end
			end
		else
			if data:toPhaseChange().to ~= sgs.Player_NotActive then return false end
			if player:getMark("@yuanshiKeep") == 0 then
				for i = 1,3,1 do room:setPlayerMark(player,"@yuanshiType"..i,0)end
			end
			room:setPlayerMark(player,"@yuanshiKeep",0)
		end
		return false
	end
}

cyyuanshiKeep = sgs.CreateMaxCardsSkill{
	name = "#cyyuanshiKeep",
	extra_func = function(self, target)
		return target:getMark("@yuanshiKeep")
	end
}

cymingdaoCard = sgs.CreateSkillCard{
	name = "cymingdaoCard",
	filter = function(self, targets, to_select)
		if to_select:objectName() == sgs.Self:objectName() then return false end
		return #targets < self:subcardsLength() and not to_select:isKongcheng()
	end,
	feasible = function(self, targets)
		return self:subcardsLength() + sgs.Self:getMaxHp() == sgs.Self:getHandcardNum()
	end,
	on_use = function(self, room, source, targets)
		local st = {0,0,0,0,0}
		local pt = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
		for _,cid in sgs.qlist(self:getSubcards()) do
			local c = sgs.Sanguosha:getCard(cid)
			st[c:getSuit()+1]=1
			pt[c:getNumber()+1]=1
		end
		for _,t in ipairs(targets) do
			local card = room:askForCardShow(t, source, "cymingdao")
			local card_id = card:getEffectiveId()
			room:showCard(t, card_id)
			if st[card:getSuit()+1]==1 then t:drawCards(1) end
			if pt[card:getNumber()+1]==1 then source:drawCards(1) end
 		end
	end
}

cymingdaoVS = sgs.CreateViewAsSkill{
	name = "cymingdao",
	n = 999 ,
	view_filter = function(self, selected, to_select)
		return (not sgs.Self:isJilei(to_select)) and not to_select:isEquipped()
	end ,
	view_as = function(self, cards)
		local card = cymingdaoCard:clone()
		for _, c in ipairs(cards) do
	   		card:addSubcard(c)
		end
	   	return card
	end ,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@cymingdao!"
	end
}

cymingdao = sgs.CreateTriggerSkill{
	name = "cymingdao" ,
	frequency = sgs.Skill_Compulsory, 
	view_as_skill = cymingdaoVS,
	events = {sgs.EventPhaseChanging} ,
	can_trigger = function(self, target)
		return target
	end ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseChanging then
			local change = data:toPhaseChange()
			if change.to == sgs.Player_NotActive then
				for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
					local n = sp:getHandcardNum() - sp:getMaxHp()
					local flag = false
					for i = 0,3,1 do
						if sp:getMark("@yuanshiType"..i) == 1 then
							flag = true 
							break
						end
					end
					if sp:hasSkill(self:objectName()) and n > 0 and flag then
						room:askForUseCard(sp,"@@cymingdao!","@cymingdao")
					end
				end
			end
		end
		return false
	end
}

lymiansuVS = sgs.CreateOneCardViewAsSkill{
	name = "lymiansu",
	view_filter = function(self, card)
		return card:isRed() and (not sgs.Self:isJilei(card)) and not card:isEquipped()
	end,
	view_as = function(self, card)
		local indulgence = sgs.Sanguosha:cloneCard("indulgence", sgs.Card_SuitToBeDecided, -1)
		indulgence:addSubcard(card:getId())
		indulgence:setSkillName(self:objectName())
		return indulgence
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self,player,pattern)
		return pattern == "@@lymiansu"
	end
}

lymiansu = sgs.CreateTriggerSkill{
	name = "lymiansu",
	view_as_skill = lymiansuVS ,
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Discard then
			while room:askForUseCard(player, "@@lymiansu", "@lymiansu-card") do
				if player:isChained() then
					room:setPlayerProperty(player, "chained", sgs.QVariant(false))
					room:loseHp(player)
				else
					room:setPlayerProperty(player, "chained", sgs.QVariant(true))
				end
			end
		end
	end
}

lyguijian = sgs.CreateTriggerSkill{
	name = "lyguijian",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TargetConfirmed},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		local card = use.card
		local LinHuiYin = room:findPlayerBySkillName(self:objectName())
		if not LinHuiYin or LinHuiYin:isDead() then return end
		if card and card:isKindOf("DelayedTrick") and use.to:contains(player) and not card:hasFlag(self:objectName()) then
			room:setCardFlag(card:getId(), self:objectName())--增加生存周期内的首名目标限制
            local choices = "gjDraw+gjCancel"
            if LinHuiYin:canDiscard(player, "he") then
            	choices = "gjDraw+gjDiscard+gjCancel"
            end
			local choice = room:askForChoice(LinHuiYin, self:objectName(), choices)
			if choice == "gjDraw" then
				LinHuiYin:drawCards(1)
				if not LinHuiYin:isNude() and player:objectName() ~= LinHuiYin:objectName() then
					local card = nil
					if LinHuiYin:getCardCount() > 1 then
						card = room:askForCard(LinHuiYin, "..!", "@lyguijian-give:" .. player:objectName(), data, sgs.Card_MethodNone);
						if not card then
							card = player:getCards("he"):at(math.random(LinHuiYin:getCardCount()))
						end
					else
						card = LinHuiYin:getCards("he"):first()
					end
					player:obtainCard(card)
				end
			elseif choice == "gjDiscard" then
				local to_throw = room:askForCardChosen(LinHuiYin, player, "he", self:objectName(), false, sgs.Card_MethodDiscard)
				room:throwCard(sgs.Sanguosha:getCard(to_throw), player, LinHuiYin)
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end,
}

lyyingzao = sgs.CreateTriggerSkill{
	name = "lyyingzao",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TargetConfirming, sgs.CardsMoveOneTime},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.TargetConfirming then
			local use = data:toCardUse()
			local card = use.card
			if not card or use.from:objectName() == player:objectName() then return end
			local ids = sgs.IntList()
			if card:isVirtualCard() then
				ids = card:getSubcards()
			else
				ids:append(card:getEffectiveId())
			end
			if ids:isEmpty() then return end
			for _, id in sgs.qlist(ids) do
				if room:getCardPlace(id) ~= sgs.Player_PlaceTable then return end
			end
			if card:isKindOf("BasicCard") and card:isBlack() and player:askForSkillInvoke(self:objectName(), data) then
				use.to:removeOne(player)
				data:setValue(use)
				room:setCardFlag(card:getEffectiveId(), self:objectName())
				return use.to:isEmpty()
			end
		else
			local move = data:toMoveOneTime()
			if move.from_places:contains(sgs.Player_PlaceTable) and (move.to_place == sgs.Player_DiscardPile)
					and (move.reason.m_reason == sgs.CardMoveReason_S_REASON_USE) then
				local card = sgs.Sanguosha:getCard(move.card_ids:first())
					if card:hasFlag(self:objectName()) then
					newCard = sgs.Sanguosha:cloneCard("indulgence", sgs.Card_SuitToBeDecided, -1)
					newCard:setSkillName(self:objectName())
					newCard:addSubcard(card)
					for _, c in sgs.qlist(player:getJudgingArea()) do
						if c:isKindOf("Indulgence") then return end
					end
					if player:isLocked(newCard) or not newCard:isAvailable(player) then return end
					room:useCard(sgs.CardUseStruct(newCard, player, player))
					move.card_ids = sgs.IntList()
					data:setValue(move)
					--return true
				end
			end
		end
		return false
	end
}

lyyingzaoProhibit = sgs.CreateProhibitSkill{
	name = "#lyyingzao-prohibit",
	is_prohibited = function(self, from, to, card)
		return from:objectName()~=to:objectName() and to:hasSkill(self:objectName()) and card:isKindOf("BasicCard") and card:isBlack() and to:getJudgingArea():length() > 0
	end
}

lyyingzaoFilter = sgs.CreateFilterSkill{
	name = "#lyyingzaoFilter",
	view_filter = function(self, to_select)
		local room = sgs.Sanguosha:currentRoom()
		return to_select:getSuit() == sgs.Card_Diamond and room:getCardPlace(to_select:getEffectiveId()) == sgs.Player_PlaceJudge
	end,
	view_as = function(self, card)
		local id = card:getEffectiveId()
		local new_card = sgs.Sanguosha:getWrappedCard(id)
		new_card:setSkillName(self:objectName())
		new_card:setSuit(sgs.Card_Heart)
		new_card:setModified(true)
		return new_card
	end
}

adchengshiCard = sgs.CreateSkillCard{
	name = "adchengshiCard",
	will_throw = false,
	handling_method = sgs.Card_MethodNone,
	target_fixed = true,
	on_use = function(self, room, source, targets)
		local pile = source:getPile("codes")
		local subCards = self:getSubcards()
		local to_handcard = sgs.IntList()
		local to_pile = sgs.IntList()
		local set = source:getPile("codes")
		for _,id in sgs.qlist(subCards) do
			set:append(id)
		end
		for _,id in sgs.qlist(set) do
			if not subCards:contains(id) then
				to_handcard:append(id)
			elseif not pile:contains(id) then
				to_pile:append(id)
			end
		end
		assert(to_handcard:length() == to_pile:length())
		if to_pile:length() == 0 or to_handcard:length() ~= to_pile:length() then return end
		room:notifySkillInvoked(source, "adchengshi")
		source:addToPile("codes", to_pile, false)
		local to_handcard_x = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		for _,id in sgs.qlist(to_handcard) do
			to_handcard_x:addSubcard(id)
		end
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_EXCHANGE_FROM_PILE, source:objectName())
		room:obtainCard(source, to_handcard_x, reason, false)
	end,
}

adchengshiVS = sgs.CreateViewAsSkill{
	name = "adchengshi", 
	n = 998,
	response_pattern = "@@adchengshi",
	expand_pile = "codes",
	view_filter = function(self, selected, to_select)
		if sgs.Self:property("codeask"):toInt() == 1 then
			return #selected == 0 and sgs.Sanguosha:matchExpPattern(sgs.Self:property("codeok"):toString(), sgs.Self, to_select)
		end
		if #selected < sgs.Self:getPile("codes"):length() then
			return not to_select:isEquipped()
		end
		return false
	end,
	view_as = function(self, cards)
		if sgs.Self:property("codeask"):toInt() == 1 then
			return cards[1]
		end
		if #cards == sgs.Self:getPile("codes"):length() then
			local c = adchengshiCard:clone()
			for _,card in ipairs(cards) do
				c:addSubcard(card)
			end
			return c
		end
		return nil
	end,
}

adchengshi = sgs.CreateTriggerSkill{
	name = "adchengshi",
	events = {sgs.DrawInitialCards,sgs.AfterDrawInitialCards,sgs.Damaged,sgs.EventPhaseEnd},
	view_as_skill = adchengshiVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.DrawInitialCards then
			room:sendCompulsoryTriggerLog(player, "adchengshi")
			data:setValue(data:toInt() + 2)
		elseif event == sgs.AfterDrawInitialCards then
			local exchange_card = room:askForExchange(player, "adchengshi", 2, 2)
			player:addToPile("codes", exchange_card:getSubcards(), false)
			exchange_card:deleteLater()
		elseif event == sgs.Damaged then
			while true do
				local pattern = {}
				for _,cid in sgs.qlist(player:getPile("codes")) do
					local c = sgs.Sanguosha:getCard(cid)
					if c:isAvailable(player) then
						table.insert(pattern, c:toString())
					end
				end
				if #pattern == 0 then break end
				room:setPlayerProperty(player, "codeask", sgs.QVariant(1))
				room:setPlayerProperty(player, "codeok", sgs.QVariant(table.concat(pattern, "#").."|.|.|codes"))
				local card = room:askForUseCard(player, "@@adchengshi", "@adchengshiUse")
				if not card then break end
			end
			if room:askForSkillInvoke(player, self:objectName().."dmgexc", data) then
				player:removePileByName("codes")
				local ids = room:getNCards(2, false)
				player:addToPile("codes", ids, false)
			end
		elseif event == sgs.EventPhaseEnd then
			if player:getPile("codes") == 0 then return false end
			if player:getPhase() ~= sgs.Player_Judge then return false end
			room:setPlayerProperty(player, "codeask", sgs.QVariant(2))
			room:askForUseCard(player, "@@adchengshi", "@adchengshi-exchange", -1, sgs.Card_MethodNone)
		end
		return false
	end,
}

adxunhuanCard = sgs.CreateSkillCard{
	name = "adxunhuanCard",
	will_throw = true,
	target_fixed = true,
	on_use = function(self, room, source, targets)
		local cid = self:getSubcards():first()
		room:setPlayerMark(source, "adxunhuan", 1)
		room:setPlayerProperty(source, "adxunhuanmark", sgs.QVariant(cid))
		source:drawCards(1)
		source:turnOver()
	end,
}

adxunhuanCardB = sgs.CreateSkillCard{
	name = "adxunhuanCardB",
	will_throw = false ,
	filter = function(self, targets, to_select)
		local card = sgs.Sanguosha:getCard(sgs.Self:property("adxunhuanmark"):toInt())
		local plist = sgs.PlayerList()
		for i = 1, #targets do plist:append(targets[i]) end
		return card and card:targetFilter(plist, to_select, sgs.Self) and not sgs.Self:isProhibited(to_select, card, plist)
	end ,
	feasible = function(self, targets)
		local card = sgs.Sanguosha:getCard(sgs.Self:property("adxunhuanmark"):toInt())
		local plist = sgs.PlayerList()
		for i = 1, #targets do plist:append(targets[i]) end
		return card and card:targetsFeasible(plist, sgs.Self)
	end,
	on_validate = function(self, cardUse)
		cardUse.m_isOwnerUse = false
		local user = cardUse.from
		return sgs.Sanguosha:cloneCard(sgs.Sanguosha:getCard(user:property("adxunhuanmark"):toInt()))
	end
}

adxunhuanVS = sgs.CreateViewAsSkill{
	name = "adxunhuan", 
	n = 1,
	response_pattern = "@@adxunhuan",
	expand_pile = "codes",
	view_filter = function(self, selected, to_select)
		local flag = false
		if sgs.Self:getMark("adxunhuan") > 0 then return false end
		for _,id in sgs.qlist(sgs.Self:getPile("codes")) do
			if id == to_select:getId() then 
				flag = true
				break
			end
		end
		return flag and (to_select:isKindOf("BasicCard") or to_select:isNDTrick()) and to_select:isAvailable(sgs.Self)
	end,
	view_as = function(self, cards)
		if #cards == 1 then
			local c = adxunhuanCard:clone()
			c:addSubcard(cards[1])
			return c
		elseif #cards == 0 and sgs.Self:getMark("adxunhuan") > 0 then
			return adxunhuanCardB:clone()
		end
		return nil
	end,
}

adxunhuan = sgs.CreateTriggerSkill{
	name = "adxunhuan",
	events = {sgs.EventPhaseStart,sgs.EventPhaseEnd},
	view_as_skill = adxunhuanVS,
	can_trigger = function(self, player)
		return player and player:isAlive()
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() ~= sgs.Player_RoundStart then return false end
			for _,sp in sgs.qlist(room:getAlivePlayers()) do room:setPlayerMark(sp, "adxunhuan", 0) end
			for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
				if sp:hasSkill(self:objectName()) and sp:faceUp() and not sp:getPile("codes"):isEmpty() then
					room:askForUseCard(sp, "@@adxunhuan", "@adxunhuan-ask", -1, sgs.Card_MethodNone)
				end
			end
		elseif event == sgs.EventPhaseEnd then
			if player:getPhase() ~= sgs.Player_Draw and player:getPhase() ~= sgs.Player_Play then return false end
			for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
				if sp:getMark("adxunhuan") > 0 then
					local sc = sgs.Sanguosha:getCard(sp:property("adxunhuanmark"):toInt())
					room:askForUseCard(sp, "@@adxunhuan", "@adxunhuan-askb:"..sc:objectName(), -1, sgs.Card_MethodNone)
				end
			end
		end
		return false
	end,
}

mgliansuo = sgs.CreateTriggerSkill{
	name = "mgliansuo" ,
	events = {sgs.CardsMoveOneTime, sgs.AfterDrawInitialCards} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardsMoveOneTime then
			local move = data:toMoveOneTime()
			if move.to and (move.to:objectName() == player:objectName())
					and ((not move.from) or move.from:objectName() ~= player:objectName())
					and (move.card_ids:length() >= 2)
					and (player:getMark("liansuoON") > 0)
					and (move.reason.m_reason ~= sgs.CardMoveReason_S_REASON_PREVIEWGIVE) then
				local invoke = room:askForSkillInvoke(player, self:objectName(), data)
				if invoke then
					room:fillAG(move.card_ids)
					room:getThread():delay(1000)
					local pt = {}
					for i = 1,18,1 do pt[i] = 0 end
					local flag = false
					for _,id in sgs.qlist(move.card_ids) do
						local n = sgs.Sanguosha:getCard(id):getNumber()
						for i = n,n+4,1 do
							if pt[i] == 1 then
								flag = true
								break
							end
						end
						if flag then break end
						pt[n+2] = 1
					end
					room:clearAG()
					if flag then room:drawCards(player, 2) end
				end
			end
		else
			room:setPlayerMark(player, "liansuoON", 1)
		end
		return false
	end
}

mgbianyiVS = sgs.CreateViewAsSkill{
	name = "mgbianyi",
	n = 1,
	view_filter = function(self, selected, to_select)
		if #selected == 0 then
			return to_select:isKindOf("EquipCard") or to_select:isKindOf("DelayedTrick")
		end
		return false
	end,
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local suit = card:getSuit()
			local point = card:getNumber()
			local id = card:getId()
			local peach = sgs.Sanguosha:cloneCard("drosophila", suit, point)
			peach:setSkillName(self:objectName())
			peach:addSubcard(id)
			return peach
		end
		return nil
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@mgbianyi"
	end
}

mgbianyi = sgs.CreateTriggerSkill{
	name = "mgbianyi",
	events = {sgs.EventPhaseEnd},
	view_as_skill = mgbianyiVS,
	can_trigger = function(self, player)
		return player and player:isAlive()
	end,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseEnd then
			if player:getPhase() ~= sgs.Player_Finish then return false end
			for _,sp in sgs.qlist(room:getOtherPlayers(player)) do
				if sp:hasSkill(self:objectName()) then
					local tothrow = room:askForExchange(sp, self:objectName(), 999, 1, true, "mgbianyiask", true, "BasicCard")
					if tothrow then
						local log = sgs.LogMessage()
							log.type = "#TriggerSkill"
							log.from = sp
							log.arg = self:objectName()
							room:sendLog(log)
						local n = tothrow:getSubcards():length()
						room:throwCard(tothrow, sp, sp)
						room:drawCards(sp, n)
						room:askForUseCard(sp, "@@mgbianyi", "@mgbianyiprompt")
					end
				end
			end
		end
		return false
	end,
}

zasuxu = sgs.CreateTriggerSkill{
	name = "zasuxu" ,
	events = {sgs.EventPhaseStart,sgs.EventPhaseEnd} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart and player:getPhase() == sgs.Player_RoundStart then
			local count = 0
			local players = room:getAlivePlayers()
			local general_names = {}
			for _,p in sgs.qlist(players) do
				table.insert(general_names, p:getGeneralName())
			end
			local all_generals = sgs.Sanguosha:getLimitedGeneralNames()
			local shu_generals = {}
			local females = {}
			for _,name in ipairs(all_generals) do
				local general = sgs.Sanguosha:getGeneral(name)
				if general:isFemale() then
					if not table.contains(general_names, name) then
						table.insert(shu_generals, name)
					end
				end
			end
			local index = 1
			while index <= 3 do
				local n=math.random(1,#shu_generals)
				if shu_generals[n]~=nil then
					females[index]=shu_generals[n]
					table.remove(shu_generals,n)
					index = index+1
				end
			end
			local selectedskill = {}
			local slfemale = {}
			local discnt = 0
			for _,cid in sgs.qlist(player:handCards()) do
				if player:canDiscard(player, cid) then discnt = discnt +1 end
			end
			if discnt == 0 then return false end
			if not room:askForSkillInvoke(player, self:objectName()) then return false end
			while #females > 0 and count < 2 and count < discnt do
				local general_name = room:askForGeneral(player, table.concat(females,"+"))
				local general = sgs.Sanguosha:getGeneral(general_name)
				assert(general)
				local skill_names = {}
				for _,skill in sgs.qlist(general:getVisibleSkillList())do
					if skill:isLordSkill() or skill:getFrequency() == sgs.Skill_Limited or skill:getFrequency() == sgs.Skill_Wake then
						continue
					end
					if (not table.contains(selectedskill, skill:objectName())) and not table.contains(skill_names,skill:objectName()) then
						table.insert(skill_names,skill:objectName())
					end
				end
				if #skill_names == 0 then break end
				local skill_name = room:askForChoice(player,"zasuxu",table.concat(skill_names,"+").."+cancel");
				if skill_name ~= "cancel" then
					count = count + 1 
					table.insert(selectedskill,skill_name)
					table.insert(slfemale,general_name)
					if #skill_names == 1 then table.removeOne(females, general_name) end
				else
					break
				end
			end
			if count == 0 then return false end
			room:askForDiscard(player, self:objectName(), count, count, false, false)
			player:setTag("suxuSkill",sgs.QVariant(table.concat(selectedskill,"|")))
			for i,sk in ipairs(selectedskill) do 
				local jsonValue = {
					9,
					player:objectName(),
					sgs.Sanguosha:getGeneral(slfemale[i]):objectName(),
					sk,
				}
				room:doBroadcastNotify(sgs.CommandType.S_COMMAND_LOG_EVENT, json.encode(jsonValue))
			end
			room:handleAcquireDetachSkills(player, table.concat(selectedskill,"|"), true)
			if count == 1 or slfemale[1] == slfemale[2] then
				room:setPlayerMark(player, "@suxucnt", player:getMark("@suxucnt")+1)
			else
				room:setPlayerMark(player, "@suxucnt", player:getMark("@suxucnt")+2)
			end
		elseif event == sgs.EventPhaseEnd and player:getPhase() == sgs.Player_Finish then
			local huashen_skill = player:getTag("suxuSkill"):toString()
			if huashen_skill ~= "" then
				player:drawCards(1)
				local bb = huashen_skill:split("|")
				for _,hs in ipairs(bb) do
					room:handleAcquireDetachSkills(player, "-"..hs, true)
				end
			end
			player:setTag("suxuSkill",sgs.QVariant(""))
		end
		return false
	end
}

zasuxuDetach = sgs.CreateTriggerSkill{
	name = "#zasuxu-clear",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.EventLoseSkill},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local skill_name = data:toString()
		if skill_name == "zasuxu" then
			local huashen_skill = player:getTag("suxuSkill"):toString()
			if  huashen_skill ~= "" then
				room:detachSkillFromPlayer(player, huashen_skill, false, true)
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end,
}

extension:insertRelatedSkills("zasuxu", "#zasuxu-clear")

zawurenCard = sgs.CreateSkillCard{
	name = "zawurenCard",
	target_fixed = false,
	will_throw = false,
	filter = function(self, targets, to_select)
		local cd = sgs.Card_Parse(sgs.Self:property("wurensuit"):toString())
	--	local usefrom = sgs.Self:property("wurenfrom"):toPlayer()
		local usefrom
		for _,p in sgs.qlist(sgs.Self:getAliveSiblings()) do
			if p:getPhase() ~= sgs.Player_NotActive then
				usefrom = p
				break
			end
		end
		if usefrom:isProhibited(to_select, cd) then return false end
		if (cd:targetFixed()) then
			if cd:isKindOf("Peach") and not (to_select:isWounded()) then return false end
		else
			if not cd:targetFilter(sgs.PlayerList(), to_select, usefrom) then return false end
		end
		if #targets == 0 then
			return to_select:getMark("wurenFilter") == 0 and to_select:objectName() ~= sgs.Self:objectName()
		end
		return false
	end,
	on_effect = function(self, effect)
		local source = effect.from
		local target = effect.to
		local room = source:getRoom()
		room:showCard(effect.from, self:getSubcards():first())
		room:setPlayerMark(target, "wurenT", 1)
		if sgs.Sanguosha:getCard(self:getSubcards():first()):isRed() then
			room:setPlayerMark(source, "@wurenR", 1)
		else
			room:setPlayerMark(source, "@wurenB", 1)
		end
	end
}

zawurenVS = sgs.CreateViewAsSkill{
	name = "zawuren",
	n = 1,
	view_filter = function(self, selected, to_select)
		local cd = sgs.Card_Parse(sgs.Self:property("wurensuit"):toString())
		return ((cd:isRed() and to_select:isRed()) or (cd:isBlack() and to_select:isBlack())) and not to_select:isEquipped()
	end,
	view_as = function(self, cards)
		if #cards == 1 then
			local juejiCard = zawurenCard:clone()
			juejiCard:addSubcard(cards[1])
			return juejiCard
		end
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@zawuren"
	end
}

zawuren = sgs.CreateTriggerSkill{
	name = "zawuren",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.CardUsed,sgs.EventPhaseStart},
	view_as_skill = zawurenVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardUsed then
			local use = data:toCardUse()
			local trick = use.card
			if trick and (trick:isNDTrick() or trick:isKindOf("BasicCard")) and use.to:length() > 0 and use.from:objectName() == room:getCurrent():objectName() then
				if use.from:getMark("wurenFlag") > 0 then return false end
			--	room:writeToConsole("A")
				room:setPlayerMark(use.from,"wurenFlag",1)
				local sp = room:findPlayerBySkillName(self:objectName())
				for _,p in sgs.qlist(use.to) do
					room:setPlayerMark(p,"wurenFilter",1)
				end
				if not sp then
					for _,p in sgs.qlist(room:getAlivePlayers()) do
						room:setPlayerMark(p,"wurenFilter",0)
					end
					return false 
				end
			--	room:writeToConsole("B")
				if use.from:objectName() ~= sp:objectName() then
					if trick:isRed() and sp:getMark("@wurenR") > 0 then return false end
					if trick:isBlack() and sp:getMark("@wurenB") > 0 then return false end
					room:setPlayerProperty(sp, "wurensuit", sgs.QVariant(trick:toString()))
					local dt = sgs.QVariant()
					dt:setValue(use.from)
					room:setPlayerProperty(sp, "wurenfrom", dt)
			--		room:writeToConsole("C"..sp:objectName()..trick:objectName())
					room:setPlayerMark(use.from, "wurenExtra", 1)
					if room:askForUseCard(sp, "@@zawuren", "@zawurencard") then
						for _,p in sgs.qlist(room:getOtherPlayers(sp)) do
							if p:getMark("wurenT") > 0 then
								room:setPlayerMark(p,"wurenT",0)
								use.to:append(p)
							end
						end
						data:setValue(use)
					end
					room:setPlayerMark(use.from, "wurenExtra", 0)
			--		room:writeToConsole("D")
				end
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					room:setPlayerMark(p,"wurenFilter",0)
				end
			end
		else		
			if player:getPhase() == sgs.Player_RoundStart then
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					room:setPlayerMark(p,"wurenFlag",0)
				end
				if player:hasSkill(self:objectName()) then
					room:setPlayerMark(player, "@wurenR", 0)
					room:setPlayerMark(player, "@wurenB", 0)
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

zawurenTargetMod = sgs.CreateTargetModSkill{
	name = "zawurenTargetMod" ,
	pattern = "BasicCard,TrickCard+^DelayedTrick" ,
	distance_limit_func = function(self, from)
		if (from:getMark("wurenExtra")>0) then
			return 1000
		end
		return 0
	end
}

zahongye = sgs.CreateTriggerSkill{
	name = "zahongye" ,
	events = {sgs.TargetConfirmed} ,
	frequency = sgs.Skill_Wake ,
	can_trigger = function(self, target)
		return target and target:hasSkill(self:objectName()) and target:isAlive() and target:getMark(self:objectName()) == 0
	end ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		if use.card:isRed() and use.to:contains(player) and player:getMark("@suxucnt") > 2 then
		else return false end
        room:addPlayerMark(player, self:objectName(), 1)
        if room:changeMaxHpForAwakenSkill(player) and player:getMark(self:objectName()) > 0 then
			player:drawCards(2)
            room:handleAcquireDetachSkills(player, "zawuren")
        end
		return false
	end
}

swmougongCard = sgs.CreateSkillCard{
	name = "swmougongCard",
	will_throw = false,
	handling_method = sgs.Card_MethodNone,
	filter = function(self, targets, to_select)
		local card = sgs.Self:getTag("swmougong"):toCard()
		card:addSubcards(sgs.Self:getHandcards())
		card:setSkillName(self:objectName())
		if card and card:targetFixed() then
			return false
		end
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		return card and card:targetFilter(qtargets, to_select, sgs.Self) 
			and not sgs.Self:isProhibited(to_select, card, qtargets)
	end,
	feasible = function(self, targets)
		local card = sgs.Self:getTag("swmougong"):toCard()
		card:addSubcards(sgs.Self:getHandcards())
		card:setSkillName(self:objectName())
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		if card and card:canRecast() and #targets == 0 then
			return false
		end
		return card and card:targetsFeasible(qtargets, sgs.Self)
	end,	
	on_validate = function(self, card_use)
		local xunyou = card_use.from
		local room = xunyou:getRoom()
		local use_card = sgs.Sanguosha:cloneCard(self:getUserString())
		use_card:setSkillName(self:objectName())
		local available = true
		for _,p in sgs.qlist(card_use.to) do
			if xunyou:isProhibited(p,use_card)	then
				available = false
				break
			end
		end
		available = available and use_card:isAvailable(xunyou)
		if not available then return nil end
		return use_card		
	end,
}

swmougongVS = sgs.CreateViewAsSkill{
	name = "swmougong",
	n = 0,
	view_filter = function(self, selected, to_select)
		return false
	end,
	view_as = function(self, cards)
		local c = sgs.Self:getTag("swmougong"):toCard()
		if c then
			local card = swmougongCard:clone()
			card:setUserString(c:objectName())	
			return card
		end
		return nil
	end,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@swmougong"
	end
}

swmougong = sgs.CreateTriggerSkill{
	name = "swmougong" ,
	events = {sgs.EventPhaseStart} ,
	view_as_skill = swmougongVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Finish then
				room:askForUseCard(player, "@@swmougong", "@swmougong-card")
			end
		end
		return false
	end
}
swmougong:setGuhuoDialog("!r")

swbingzhuCard = sgs.CreateSkillCard{
	name = "swbingzhuCard" ,
	will_throw = false,
	target_fixed = true,
	on_use = function(self, room, source, targets)
		room:showCard(source, self:getSubcards():at(0))
		room:showCard(source, self:getSubcards():at(1))
		local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, source:objectName(), nil, "swbingzhu", nil)
		room:moveCardTo(sgs.Sanguosha:getCard(self:getSubcards():at(0)), source, nil ,sgs.Player_DrawPile, reason, false)
		room:moveCardTo(sgs.Sanguosha:getCard(self:getSubcards():at(1)), source, nil ,sgs.Player_DrawPile, reason, false)
		room:setPlayerMark(source, "swmougong", 1)
		room:handleAcquireDetachSkills(source, "swmougong")
	end
}

swbingzhuVS = sgs.CreateViewAsSkill{
	name = "swbingzhu" ,
	n = 2,
	view_filter = function(self, selected, to_select)
		if #selected == 1 then
			return to_select:isKindOf("BasicCard") and to_select:isRed() == selected[1]:isRed()
		end
		return (#selected < 2) and to_select:isKindOf("BasicCard")
	end ,
	view_as = function(self, cards)
		if #cards ~= 2 then return nil end
		local card = swbingzhuCard:clone()
		card:addSubcard(cards[1])
		card:addSubcard(cards[2])
		return card
	end ,
	enabled_at_play = function(self, player)
		return false
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@swbingzhu"
	end
}

swbingzhu = sgs.CreateTriggerSkill{
	name = "swbingzhu" ,
	events = {sgs.EventPhaseStart, sgs.BeforeCardsMove, sgs.CardsMoveOneTime} ,
	view_as_skill = swbingzhuVS,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Play then
				room:askForUseCard(player, "@@swbingzhu", "@swbingzhu-card")
			end
		elseif event == sgs.BeforeCardsMove then
			local move = data:toMoveOneTime()
			if (not move.from) or move.from:objectName() ~= player:objectName() then return end
			local reason = move.reason.m_reason
			local reasonx = bit32.band(reason, sgs.CardMoveReason_S_MASK_BASIC_REASON)
			local Yes = reasonx == sgs.CardMoveReason_S_REASON_DISCARD
			or reasonx == sgs.CardMoveReason_S_REASON_USE or reasonx == sgs.CardMoveReason_S_REASON_RESPONSE
			if Yes then
				local card
				for i,id in sgs.qlist(move.card_ids) do
					card = sgs.Sanguosha:getCard(id)
					if move.from_places:at(i) == sgs.Player_PlaceHand
						or move.from_places:at(i) == sgs.Player_PlaceEquip then
						if card and room:getCardOwner(id):getSeat() == player:getSeat() and card:isKindOf("BasicCard") then
							player:addMark(self:objectName())
						end
					end
				end
			end
		else
			local move = data:toMoveOneTime()
			if (not move.from) or move.from:objectName() ~= player:objectName() then return end
			if player:getMark(self:objectName())>0 and player:getMark("swmougong")>0 then
				room:setPlayerMark(player, "swmougong", 0)
				room:handleAcquireDetachSkills(player, "-swmougong")
				player:drawCards(1)
			end
			player:setMark(self:objectName(), 0)
		end
		return false
	end
}

swjunyanCard = sgs.CreateSkillCard{
	name = "swjunyanCard" ,
	will_throw = false,
	target_fixed = true,
	filter = function(self, targets, to_select)
		local slash = sgs.Sanguosha:cloneCard("analeptic", sgs.Card_NoSuit, 0)
		local plist = sgs.PlayerList()
		for i = 1, #targets, 1 do
			plist:append(targets[i])
		end
		return slash:targetFilter(plist, to_select, sgs.Self)
	end ,
	on_validate = function(self, cardUse) --这是0610新加的哦~~~~
		cardUse.m_isOwnerUse = false
		local asker = cardUse.from
		local targets = cardUse.to
		room = asker:getRoom()
		local slash = nil
		for _,sunwu in sgs.qlist(room:getAlivePlayers()) do
			if not sunwu:hasSkill("swjunyan") then continue end
			for _, target in sgs.qlist(targets) do
				target:setFlags("swjunyanTarget")
			end
			slash = room:askForCard(sunwu, "BasicCard", "@junyan-ask:" .. asker:objectName(), sgs.QVariant(), sgs.Card_MethodNone) --未处理胆守
			if slash then
				for _, target in sgs.qlist(targets) do
					target:setFlags("-swjunyanTarget")
				end
				local analeptic = sgs.Sanguosha:cloneCard("Analeptic", sgs.Card_NoSuit, 0)
				analeptic:setSkillName("swjunyan")
				room:setPlayerMark(asker, "junyanused", 1)
				asker:addMark("junyanfrom"..sunwu:objectName())
				room:showCard(sunwu, slash:getEffectiveId())
				local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, sunwu:objectName(), nil, "swjunyan", nil)
				room:moveCardTo(slash, sunwu, nil ,sgs.Player_DrawPile, reason, false)
				return analeptic
			end
			for _, target in sgs.qlist(targets) do
				target:setFlags("-swjunyanTarget")
			end
			room:setPlayerFlag(asker, "Global_junyanFailed")
			return nil
		end
	end
}

hasSunwu = function(player)
	for _, p in sgs.qlist(player:getSiblings()) do
		if p:isAlive() and (p:hasSkill("swjunyan")) then
			return true
		end
	end
	if player:hasSkill("swjunyan") then return true end
	return false
end

swjunyanAsk = sgs.CreateViewAsSkill{
	name = "swjunyanAsk",
	n = 0 ,
	view_as = function()
		return swjunyanCard:clone()
	end ,
	enabled_at_play = function(self, player)
		local newanal = sgs.Sanguosha:cloneCard("analeptic", sgs.Card_NoSuit, 0)
		if player:isCardLimited(newanal, sgs.Card_MethodUse) or player:isProhibited(player, newanal) then return false end
		return player:usedTimes("Analeptic") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, player , newanal)
			and hasSunwu(player)
			and (not player:hasFlag("Global_junyanFailed"))
	end ,
	enabled_at_response = function(self, player, pattern)
		return hasSunwu(player)
			and string.find(pattern, "analeptic")
			and (not player:hasFlag("Global_junyanFailed"))
	end
}

swjunyan = sgs.CreateTriggerSkill{
	name = "swjunyan",
	events = {sgs.GameStart, sgs.DamageCaused, sgs.EventPhaseChanging},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.GameStart and player:hasSkill(self:objectName()) then
			local others = room:getAlivePlayers()
			for _,p in sgs.qlist(others) do
				room:attachSkillToPlayer(p, "swjunyanAsk")
			end
		elseif event == sgs.DamageCaused then
			local dmg = data:toDamage()
			if dmg.from and dmg.from:isAlive() then room:setPlayerMark(dmg.from, "junyandmg", 1) end
		elseif event == sgs.EventPhaseChanging and data:toPhaseChange().to == sgs.Player_NotActive then
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:getMark("junyandmg") == 0 and p:getMark("junyanused") > 0 then
					for _,sunwu in sgs.qlist(room:getAlivePlayers()) do
						if p:getMark("junyanfrom"..sunwu:objectName()) > 0 then
							room:loseHp(sunwu, p:getMark("junyanfrom"..sunwu:objectName()))
						end
						room:setPlayerMark(p, "junyanfrom"..sunwu:objectName(), 0)
					end
				end
				room:setPlayerMark(p, "junyanused", 0)
				room:setPlayerMark(p, "junyandmg", 0)
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end
}

tktestTGCard = sgs.CreateSkillCard{
	name = "tktestTGCard", 
	target_fixed = false, 
	will_throw = false,
	filter = function(self, targets, to_select)
		local c = sgs.Sanguosha:getCard(sgs.Self:getMark("tktestRecord"))
		local tgs = nil
		for _,p in sgs.qlist(sgs.Self:getAliveSiblings()) do
			if p:getSeat() == sgs.Self:getMark("tktestRecordP") then
				tgs = p
				break
			end
		end
		if c and c:targetFixed() then
			return false
		end
		local qtargets = sgs.PlayerList()
		for _, pe in ipairs(targets) do
			qtargets:append(pe)
		end
		return tgs and c:targetFilter(qtargets, to_select, tgs)
	end,
	feasible = function(self, targets)
		local card = sgs.Sanguosha:getCard(sgs.Self:getMark("tktestRecord"))
		local tgs = nil
		for _,p in sgs.qlist(sgs.Self:getAliveSiblings()) do
			if p:getSeat() == sgs.Self:getMark("tktestRecordP") then
				tgs = p
				break
			end
		end
		card:setSkillName(self:objectName())
		local qtargets = sgs.PlayerList()
		for _, p in ipairs(targets) do
			qtargets:append(p)
		end
		if card and card:canRecast() and #targets == 0 then
			return false
		end
		return card and (card:isKindOf("EquipCard") or card:targetsFeasible(qtargets, tgs))
	end,	
	on_use = function(self, room, source, targets)
		local card = sgs.Sanguosha:getCard(source:getMark("tktestRecord"))
		if card:getSubtype() == "aoe" then
			for _, target in sgs.qlist(room:getOtherPlayers(source)) do
				room:setPlayerMark(target, "tktestTo", 1)
			end
		elseif card:getSubtype() == "global_effect" then
			for _, target in sgs.qlist(room:getAllPlayers()) do
				room:setPlayerMark(target, "tktestTo", 1)
			end
		elseif (card:targetFixed() or #targets == 0) then
			for _,p in sgs.qlist(room:getAllPlayers()) do
				if p:getSeat() == source:getMark("tktestRecordP") then
					room:setPlayerMark(p, "tktestTo", 1)
				end
			end
		else
			for _, target in ipairs(targets) do
				room:setPlayerMark(target, "tktestTo", 1)
			end
		end
	end,
}

tktestCard = sgs.CreateSkillCard{
	name = "tktestCard", 
	target_fixed = false, 
	will_throw = false,
	filter = function(self, targets, to_select)
		local c = sgs.Sanguosha:getCard(self:getSubcards():first())
		return #targets == 0 and to_select:objectName() ~= sgs.Self:objectName() and c:isAvailable(to_select)
	end ,
	on_use = function(self, room, source, targets)
		room:setPlayerMark(source, "tktestRecord", self:getSubcards():first())
		room:setPlayerMark(source, "tktestRecordP", targets[1]:getSeat())
		local cs = room:askForUseCard(source, "@@tktest", "@tktest")
		if cs then
			local tgs = sgs.SPlayerList()
			targets[1]:obtainCard(sgs.Sanguosha:getCard(self:getSubcards():first()))
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if p:getMark("tktestTo") > 0 then
					tgs:append(p)
					room:setPlayerMark(p, "tktestTo", 0)
				end
			end
			if room:askForSkillInvoke(targets[1], "tktest", sgs.QVariant("tkprompt")) then
				local use = sgs.CardUseStruct()
				use.card = sgs.Sanguosha:getCard(self:getSubcards():first())
				use.from = targets[1]
				for _,p in sgs.qlist(tgs) do
					use.to:append(p)
				end
				room:useCard(use)
			else
				room:damage(sgs.DamageStruct("tktest", source, targets[1]))
			end
		end
		room:setPlayerMark(source, "tktestRecord", 0)
		room:setPlayerMark(source, "tktestRecordP", 0)
	end
}

tktest = sgs.CreateViewAsSkill{
	name = "tktest", 
	n = 1, 
	view_filter = function(self, selected, to_select)
		return (not to_select:isEquipped()) and sgs.Sanguosha:getCurrentCardUseReason() == sgs.CardUseStruct_CARD_USE_REASON_PLAY
	end,
	view_as = function(self, cards)
		local a = 0
		local trick = tktestTGCard:clone()
		local flag = sgs.Sanguosha:getCurrentCardUsePattern() == "@@tktest"
		if #cards > 0 then
			trick = tktestCard:clone()
			flag = true
			for _,card in pairs(cards) do
				trick:addSubcard(card)
			end
			trick:setSkillName(self:objectName())
		end
		if flag then
			return trick
		end
	end,
	enabled_at_play = function(self, player)
		return true
	end,
	enabled_at_response = function(self, player, pattern)
		return pattern == "@@tktest"
	end
}

tester:addSkill(tktest)
---------------------
--新模式
---------------------

local weatherlist = {"tkbaofengxue","tkthunder","tkbingbao","tksuddenrain","tktyphoon","tksnow","tkfoggy","tkbigwind","tkrain","tkmist","tkcloud","tksunny","tkhotter","tksandfly","tkhotsun","tkhotdisaster","tkdry","tksandstorm","tkelnino"}

askweather = sgs.CreateTriggerSkill{
	name = "askweather",
	frequency = sgs.Skill_Compulsory, 
	global = true,
	events = {sgs.GameStart}, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local lord = room:getLord()
		if not lord then return false end
		if lord:getMark("askweather") == 0 then
			local agree = 0
			local disagree = 0
			local all = room:getAllPlayers()
			for _,t in sgs.qlist(all) do
				if t:getState() ~= "robot" then
					local result = room:askForChoice(t, self:objectName(), "agree+disagree")
					if result == "agree" then
						agree = agree + 1
						local log = sgs.LogMessage()
						log.type = "#weather_ask"
						log.from = t
						log.arg = result
						room:sendLog(log)
					else
						disagree = disagree + 1
						local log = sgs.LogMessage()
						log.type = "#weather_ask"
						log.from = t
						log.arg = result
						room:sendLog(log)
					end
				end
			end
			if agree >= disagree then
				local n = math.random(1,#weatherlist)
				room:setPlayerMark(lord,"@"..weatherlist[n],1)
				local skill = sgs.Sanguosha:getTriggerSkill("weatherchange")
				room:getThread():addTriggerSkill(skill)
				local skill2 = sgs.Sanguosha:getTriggerSkill("weathereffect")
				room:getThread():addTriggerSkill(skill2)
				local skill3 = sgs.Sanguosha:getTriggerSkill("weathereffectB")
				room:getThread():addTriggerSkill(skill3)
				local skill4 = sgs.Sanguosha:getTriggerSkill("weathereffectC")
				room:getThread():addTriggerSkill(skill4)
				local log = sgs.LogMessage()
				log.type = "#weather_yes"
				log.arg = agree
				log.arg2 = disagree
				room:sendLog(log)
			else
				local log = sgs.LogMessage()
				log.type = "#weather_no"
				log.arg = agree
				log.arg2 = disagree
				room:sendLog(log)
			end
			room:setPlayerMark(lord,"askweather",1)
		end
	end,
	can_trigger = function(self, target)
		return target
	end,
}

weatherchange = sgs.CreateTriggerSkill{
	name = "weatherchange",
	frequency = sgs.Skill_Compulsory, 
	events = {sgs.EventPhaseChanging}, 
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseChanging then 
			local change = data:toPhaseChange()
			if change.to == sgs.Player_Start then 
				if player:getRole() == "lord" then
					local n = 0
					for i = 1,#weatherlist,1 do
						if player:getMark("@"..weatherlist[i]) > 0 then
							n = i
						end
					end
					if n > 0 then
						local to = math.random(math.max(1,n-room:alivePlayerCount()),math.min(n+room:alivePlayerCount(),#weatherlist))
						room:setPlayerMark(player,"@"..weatherlist[n],0)
						room:setPlayerMark(player,"@"..weatherlist[to],1)
						if n == to then
							local log = sgs.LogMessage()
							log.type = "#weather_keep"
							log.arg = "@"..weatherlist[n]
							room:sendLog(log)
						else 
							local log = sgs.LogMessage()
							log.type = "#weather_change"
							log.arg = "@"..weatherlist[n]
							log.arg2 = "@"..weatherlist[to]
							room:doLightbox("@"..weatherlist[to].."effe", 3500)
							room:sendLog(log)
						end
					end
				end
			end
		end
	end,
	can_trigger = function(self, target)
		return target
	end,
}

tkEffectInform = function(weather, card, ok, room)
	local log = sgs.LogMessage()
	if ok then
		log.type = "#tkeinform"
	else
		log.type = "#tkxinform"
	end
	log.arg = "@"..weather
	log.arg2 = "#tkgaoliang"
	local mscard = sgs.Sanguosha:cloneCard("jink", sgs.Card_NoSuit, -1)
	mscard:addSubcard(card)
	log.card_str = mscard:subcardString()
	room:sendLog(log)
end

weathereffect = sgs.CreateTriggerSkill{
	name = "weathereffect",
	frequency = sgs.Skill_Compulsory,
	events = {sgs.DrawNCards,sgs.EventPhaseStart,sgs.EventPhaseEnd,sgs.DamageCaused,sgs.SlashProceed,sgs.CardEffected,sgs.PreHpRecover,sgs.CardsMoveOneTime, sgs.BeforeCardsMove},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local lord = room:getLord()
		if event == sgs.DrawNCards then
			if lord:getMark("@tkrain") == 1 or lord:getMark("@tkcloud") == 1 then
				local count = data:toInt() + 1
				local log = sgs.LogMessage()
				log.type = "#weather_draw"
				log.from = player
				room:sendLog(log)
				data:setValue(count)
			elseif lord:getMark("@tkdry") == 1 then
				local count = data:toInt() - 1
				local log = sgs.LogMessage()
				log.type = "#weather_nodraw"
				log.from = player
				room:sendLog(log)
				data:setValue(count)
			end
		elseif event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_Finish then
				if lord:getMark("@tkbigwind") == 1 then
					local log = sgs.LogMessage()
					log.type = "#weather_wind"
					log.from = player
					room:sendLog(log)
					room:askForDiscard(player, self:objectName(), 1, 1, false, true)
				end
			elseif player:getPhase() == sgs.Player_Start then
				if lord:getMark("@tkthunder") == 1 then
					local id1 = room:drawCard()
					local card1 = sgs.Sanguosha:getCard(id1)
					local move = sgs.CardsMoveStruct()
					move.card_ids:append(id1)
					move.to_place = sgs.Player_PlaceTable
					local log = sgs.LogMessage()
					log.type = "#weather_thunder"
					log.from = player
					room:sendLog(log)
					room:moveCardsAtomic(move, true)
					room:getThread():delay(1500)
					if card1:isBlack() then
						tkEffectInform("tkthunder", card1, true, room)
						if card1:getSuit() == sgs.Card_Spade then
							room:damage(sgs.DamageStruct(self:objectName(), nil, player, 2, sgs.DamageStruct_Thunder))
						else
							room:damage(sgs.DamageStruct(self:objectName(), nil, player, 1, sgs.DamageStruct_Thunder))
						end
					else
						tkEffectInform("tkthunder", card1,false, room)
					end
				elseif lord:getMark("@tkelnino") == 1 then
					if not player:isLord() then return false end
					local n = room:alivePlayerCount()
					local log = sgs.LogMessage()
					log.type = "#weather_elnino"
					room:sendLog(log)
					for i = 1,2*n,1 do
						local a = math.random(1,n)
						local b = math.random(1,n)
						while a == b do
							a = math.random(1,n)
						end
						local pa = nil
						local pb = nil
						for _,t in sgs.qlist(room:getAlivePlayers()) do
							if t:getSeat() == a then
								pa = t
							end
							if t:getSeat() == b then
								pb = t
							end
						end
						if pa ~= nil and pb ~= nil then
							room:swapSeat(pa, pb)
						end
					end
				end
			elseif player:getPhase() == sgs.Player_Draw then
				if lord:getMark("@tksnow") == 1 then
					local log = sgs.LogMessage()
					log.type = "#weather_snow"
					log.from = player
					room:sendLog(log)
					room:showAllCards(player)
				end
			elseif player:getPhase() == sgs.Player_Play then
				if lord:getMark("@tkbingbao") == 1 then
					local log = sgs.LogMessage()
					log.type = "#weather_bingbao"
					log.from = player
					room:sendLog(log)
					local dis = room:askForCard(player, "EquipCard", "@tkbingbaoask", sgs.QVariant(), sgs.Card_MethodDiscard)
					if not dis then
						room:damage(sgs.DamageStruct(self:objectName(), nil, player, 1))
					end
				end
			end
		elseif event == sgs.EventPhaseEnd then
			if player:getPhase() == sgs.Player_Draw then
				if lord:getMark("@tkcloud") == 1 then 
					if player:isNude() then return false end
					local card1 = room:askForExchange(player, self:objectName(), 1,1, true, "@tkcloudask")
					local moveA = sgs.CardsMoveStruct()
					moveA.card_ids:append(card1:getEffectiveId())
					moveA.to_place = sgs.Player_DrawPile
					room:moveCardsAtomic(moveA, false)
					local log = sgs.LogMessage()
					log.type = "#weather_cloud"
					log.from = player
					room:sendLog(log)
				end
			elseif player:getPhase() == sgs.Player_Finish then
				if lord:getMark("@tkelnino") == 1 then
					if not player:isLord() then return false end
					local n = room:alivePlayerCount()
					local log = sgs.LogMessage()
					log.type = "#weather_elnino"
					room:sendLog(log)
					for i = 1,2*n,1 do
						local a = math.random(1,n)
						local b = math.random(1,n)
						while a == b do
							a = math.random(1,n)
						end
						local pa = nil
						local pb = nil
						for _,t in sgs.qlist(room:getAlivePlayers()) do
							if t:getSeat() == a then
								pa = t
							end
							if t:getSeat() == b then
								pb = t
							end
						end
						if pa ~= nil and pb ~= nil then
							room:swapSeat(pa, pb)
						end
					end
				end
			end
		elseif event == sgs.DamageCaused then
			local damage = data:toDamage()
			if lord:getMark("@tksuddenrain") == 1 then
				if damage.nature == sgs.DamageStruct_Fire then
					local id1 = room:drawCard()
					local card1 = sgs.Sanguosha:getCard(id1)
					local move = sgs.CardsMoveStruct()
					move.card_ids:append(id1)
					move.to_place = sgs.Player_PlaceTable
					room:moveCardsAtomic(move, true)
					room:getThread():delay(1500)
					if card1:getSuit() ~= sgs.Card_Heart then
						local log = sgs.LogMessage()
						log.type = "#weather_suddenrain"
						log.from = damage.from
						log.to:append(damage.to)
						log.arg = damage.damage
						log.arg2 = damage.damage - 1
						room:sendLog(log)
						damage.damage = damage.damage - 1
						if damage.damage < 1 then
							return true
						end
						data:setValue(damage)
					end
				end
			elseif lord:getMark("@tkhotter") == 1 then
				if damage.nature == sgs.DamageStruct_Fire then
					local log = sgs.LogMessage()
					log.type = "#weather_hotter"
					log.from = damage.from
					log.to:append(damage.to)
					log.arg = damage.damage
					log.arg2 = damage.damage + 1
					room:sendLog(log)
					damage.damage = damage.damage + 1
					data:setValue(damage)
				else
					local id1 = room:drawCard()
					local card1 = sgs.Sanguosha:getCard(id1)
					local move = sgs.CardsMoveStruct()
					move.card_ids:append(id1)
					move.to_place = sgs.Player_PlaceTable
					local log = sgs.LogMessage()
					log.type = "#weather_hotterb"
					log.from = damage.from
					log.to:append(damage.to)
					log.arg = damage.damage
					log.arg2 = damage.damage + 1
					room:sendLog(log)
					room:moveCardsAtomic(move, true)
					room:getThread():delay(1500)
					if card1:isRed() then
						tkEffectInform("tkhotter", card1, true, room)
						damage.damage = damage.damage + 1
						data:setValue(damage)
					else
						tkEffectInform("tkhotter", card1,false, room)
					end
				end
			elseif lord:getMark("@tksandstorm") == 1 then
				if damage.damage > 1 then
					local log = sgs.LogMessage()
					log.type = "#weather_sandstorm"
					log.from = damage.from
					log.to:append(damage.to)
					log.arg = damage.damage
					log.arg2 = damage.damage - 1
					room:sendLog(log)
					damage.damage = damage.damage - 1
					if damage.damage < 1 then
						return true
					end
					data:setValue(damage)
				end
			end
		elseif event == sgs.SlashProceed then
			local effect = data:toSlashEffect()
			if lord:getMark("@tkfoggy") == 1 then
				if not effect.to:inMyAttackRange(effect.from) then
					if effect.card then
						local log = sgs.LogMessage()
						log.type = "#weather_foggy"
						log.from = effect.from
						log.to:append(effect.to)
						room:sendLog(log)
						local id1 = room:drawCard()
						local card1 = sgs.Sanguosha:getCard(id1)
						local move = sgs.CardsMoveStruct()
						move.card_ids:append(id1)
						move.to_place = sgs.Player_PlaceTable
						room:moveCardsAtomic(move, true)
						room:getThread():delay(1500)
						if card1:isBlack() == effect.card:isBlack() then
							tkEffectInform("tkfoggy", card1, true, room)
							room:slashResult(effect, nil)	  
							return true
						else
							tkEffectInform("tkfoggy", card1,false, room)
						end
					end
				end
			end
		elseif event == sgs.CardEffected then
			local effect = data:toCardEffect()
			local card = effect.card
			if card and lord:getMark("@tksunny") == 1 and card:isKindOf("Slash") and (not effect.to:inMyAttackRange(effect.from)) then
				local id1 = room:drawCard()
				local card1 = sgs.Sanguosha:getCard(id1)
				local move = sgs.CardsMoveStruct()
				move.card_ids:append(id1)
				move.to_place = sgs.Player_PlaceTable
				local log = sgs.LogMessage()
				log.type = "#weather_sunny"
				log.from = effect.from
				log.to:append(effect.to)
				room:sendLog(log)
				room:moveCardsAtomic(move, true)
				room:getThread():delay(1500)
				if card1:isBlack() ~= card:isBlack() then
					tkEffectInform("tksunny", card1, true, room)
					return true
				else
					tkEffectInform("tksunny", card1,false, room)
				end
			end
		elseif event == sgs.PreHpRecover then
			local rec = data:toRecover()
			local peach = rec.card
			if peach and lord:getMark("@tkhotdisaster") == 1 then
				if peach:isKindOf("Peach") or peach:isKindOf("C6") then
					local log = sgs.LogMessage()
					log.type = "#weather_hotdisaster"
					log.to:append(rec.who)
					log.arg = rec.recover
					log.arg2 = rec.recover + 1
					room:sendLog(log)
					rec.recover = rec.recover + 1
					data:setValue(rec)
				end
			end
		elseif event == sgs.BeforeCardsMove then
			local move = data:toMoveOneTime()
			if lord:getMark("@tkhotsun") == 1 then
				--[[if move.to_place == sgs.Player_PlaceTable or move.to_place == sgs.Player_DiscardPile or move.to_place == sgs.Player_PlaceEquip then return false end
				if move.from_place == sgs.Player_PlaceTable then return false end
				local ids = move.card_ids
				room:fillAG(ids)
				room:getThread():delay(900/room:alivePlayerCount())
				--room:askForAG(myself:getNext(),ids,false,self:objectName())
				--room:doLightbox("blue$", 8000)
				--room:broadcastInvoke("animate", "lightbox:blue$")
				room:clearAG()]]--
				for _,b in sgs.qlist(move.open) do
					room:writeToConsole(type(b))
					if b then 
						room:writeToConsole("tkOP")
					end
				end
				room:writeToConsole("tksun")
				move.open = sgs.BoolList()
				for _,c in sgs.qlist(move.card_ids) do
					move.open:append(true)
				end
				data:setValue(move)
			end
		elseif event == sgs.CardsMoveOneTime then
			local move = data:toMoveOneTime()
			if lord:getMark("@tkbaofengxue") == 1 then
				if move.to_place == sgs.Player_DiscardPile then
					local reason = move.reason.m_reason
					local flag = false
					if reason == sgs.CardMoveReason_S_REASON_USE then
						flag = true
					end
					local mcard = sgs.Sanguosha:getCard(move.card_ids:at(0))
					if not move.from then return false end
					if move.from:objectName() == room:getCurrent():objectName() and flag and lord:getMark("baofengflag")~=mcard:getEffectiveId() then
						local log = sgs.LogMessage()
						log.type = "#weather_baofengxue"
						log.from = room:getCurrent()
						local mscard = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, -1)
						mscard:addSubcard(mcard)
						log.card_str = mscard:subcardString()
						room:sendLog(log)
						local id1 = room:drawCard()
						local card1 = sgs.Sanguosha:getCard(id1)
						local move1 = sgs.CardsMoveStruct()
						move1.card_ids:append(id1)
						move1.to_place = sgs.Player_PlaceTable
						room:moveCardsAtomic(move1, true)
						room:getThread():delay(1500)
						if card1:getSuit() == mcard:getSuit() then
							room:setPlayerMark(lord,"baofengflag",0)
							tkEffectInform("tkbaofengxue", card1, true, room)
							room:throwEvent(sgs.TurnBroken)
						else
							tkEffectInform("tkbaofengxue", card1,false, room)
							room:setPlayerMark(lord,"baofengflag",mcard:getEffectiveId())
						end
					end
				end
			end
			return false
		end
	end,
	can_trigger = function(self, target)
		return target
	end,
}

weathereffectB = sgs.CreateProhibitSkill{
	name = "weathereffectB", 
	is_prohibited = function(self, from, to, card)
		local a = nil
		if from:isLord() then
			a = from
		else
			local all = from:getAliveSiblings()
			for _,t in sgs.qlist(all) do
				if t:isLord() then
					a = t
				end
			end
		end
		if a ~= nil then
			return a:getMark("@tktyphoon") == 1 and card:isNDTrick()
		end
	end
}

weathereffectC = sgs.CreateAttackRangeSkill{
	name = "weathereffectC",
	extra_func = function(self, player, include_weapon)
		local a = nil
		if player:isLord() then
			a = player
		else
			local all = player:getAliveSiblings()
			for _,t in sgs.qlist(all) do
				if t:isLord() then
					a = t
				end
			end
		end
		if a ~= nil then
			if a:getMark("@tksandfly") == 1 then
				local x = player:getHp()
				return -x
			end
		end
	end,
}

weatheradjust = sgs.CreateTriggerSkill{
	name = "weatheradjust",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.EventPhaseStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if room:getCurrent():getPhase() ~= sgs.Player_Start then return false end
		local splayer = room:findPlayerBySkillName(self:objectName())
		local lord = room:getLord()
		for i = 1,#weatherlist,1 do
			room:setPlayerMark(lord,"@"..weatherlist[i],0)
		end
		local stri = table.concat(weatherlist, "+@")
		stri = "@"..stri
		if splayer then
			local choice = room:askForChoice(splayer, self:objectName(), stri)
			room:setPlayerMark(lord,choice,1)
		end
		return false
	end,
	can_trigger = function(self, target)
		return target
	end,
}
weatherer:addSkill(weatheradjust)

SurveyAnjiang = sgs.General(extension, "SurveyAnjiang", "god", 5, true, true, true)

surveyStart = sgs.CreateTriggerSkill{
	name = "#surveyStart",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.GameStart, sgs.BeforeCardsMove, sgs.CardsMoveOneTime},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.GameStart then
			local n = 0
			for _,p in sgs.qlist(room:getAlivePlayers()) do
				if (table.contains(science,p:getGeneralName()) or (p:getGeneral2() and table.contains(science,p:getGeneral2Name()))) and p:getMark("surveyasked") == 0 then
					n = n - 0.5
					if room:askForSkillInvoke(p, "surveyStart") then
						local log = sgs.LogMessage()
							log.type = "#survey_ask"
							log.from = p
							room:sendLog(log)
						n = n + 1
					end
				--	room:writeToConsole("surveyasking")
					room:setPlayerMark(p,"surveyasked",1)
				end
			end
			if n > 0 then
				room:doLightbox("$WelcomeTosurvey", 3000)	--显示全屏信息特效
				local msg = sgs.LogMessage()
				msg.type = "#surveyModeStart"
				room:sendLog(msg) --发送提示信息
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					room:acquireSkill(p, "#surveyDraw") 
					if table.contains(science,p:getGeneralName()) or (p:getGeneral2() and table.contains(science,p:getGeneral2Name())) then
						room:acquireSkill(p, "#surveyArgue")
					else
						room:acquireSkill(p, "#surveyWar") 
					end
				end
			elseif not player:hasSkill("#surveyDraw") then
				local buriedcard = {"Huiyibl", "Enjoyeat", "Skillbuy", "Knowspread"}
				room:setPlayerFlag(player, "survey_InTempMoving")
				for _,id in sgs.qlist(room:getDrawPile()) do
					if table.contains(buriedcard, sgs.Sanguosha:getCard(id):getClassName()) then
						player:addToPile("#surveyBuried", id, false)
					end
				end
				for _,p in sgs.qlist(room:getAlivePlayers()) do
					for _,c in ipairs(buriedcard) do
						room:setPlayerCardLimitation(p, "use,response", c, false)
					end
				end
				room:setPlayerFlag(player, "-survey_InTempMoving")
			end
		else
			for _, p in sgs.qlist(room:getAllPlayers()) do
				if p:hasFlag("survey_InTempMoving") then return true end
			end
			return false
		end
	end,
	priority = 10,
}

surveyDraw = sgs.CreateTriggerSkill{
	name = "#surveyDraw",
	frequency = sgs.Skill_NotFrequent,
	events = {sgs.TurnStart},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local alives = room:getAlivePlayers()
		for _,p in sgs.qlist(alives) do
			if p:getNextAlive():objectName() == player:objectName() then
				if room:askForSkillInvoke(p, "surveyDraw") then
					local log = sgs.LogMessage()
						log.type = "#survey_draw"
						log.from = p
						room:sendLog(log)
					room:drawCards(p, 1)
				end
			end
		end
	end,
	priority = 3,
}

surveyArgue = sgs.CreateTriggerSkill{
	name = "#surveyArgue" ,
	frequency = sgs.Skill_NotFrequent ,
	events = {sgs.EventPhaseEnd} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Finish then
			if room:askForSkillInvoke(player, "surveyArgue") then
				local log = sgs.LogMessage()
					log.type = "#survey_argue"
					log.from = player
					room:sendLog(log)
				local alives = room:getOtherPlayers(player)
				for _,p in sgs.qlist(alives) do
					room:drawCards(p, 1)
				end
				local nm = sgs.Sanguosha:cloneCard("huiyibl", sgs.Card_NoSuit, 0)
				nm:setSkillName(self:objectName())
				if not nm:isAvailable(player) then nm = nil return end
				room:useCard(sgs.CardUseStruct(nm, player, nil))
			end
		end
		return false
	end,
	priority = 2,
}

surveyWar = sgs.CreateTriggerSkill{
	name = "#surveyWar" ,
	frequency = sgs.Skill_NotFrequent ,
	events = {sgs.EventPhaseEnd, sgs.Damage} ,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseEnd then
			if player:getPhase() == sgs.Player_Finish and player:hasSkill(self:objectName()) then
				if room:askForSkillInvoke(player, "surveyWar") then
					local alives = room:getAlivePlayers()
					room:setPlayerFlag(player,"surveyWaring")
					local log = sgs.LogMessage()
						log.type = "#survey_war"
						log.from = player
						room:sendLog(log)
					for _,p in sgs.qlist(alives) do
						room:drawCards(p, 1)
					end
					for _,p in sgs.qlist(alives) do
						local pattern = {}
						for _,c in sgs.qlist(p:getCards("h")) do
							if c:isAvailable(p) then
								table.insert(pattern, c:toString())
							end
						end
						if #pattern ~= 0 then
							if (p:getState() ~= "robot") and (p:getState() ~= "offline") then
								room:askForUseCard(p, table.concat(pattern, "#"), "@surveyWar")
							else
								room:askForUseCard(p, "surveyWarforAI", "@surveyWar")
							end
						end
						--"Slash#TrickCard|black!";
					end
					for _,p in sgs.qlist(alives) do
						if p:hasFlag("surveyWared") then
							room:setPlayerFlag(p, "-surveyWared")
							room:askForDiscard(p, self:objectName(), 1, 1, false, true, "@surveyWardis")
						end
					end
					room:setPlayerFlag(player,"-surveyWaring")
				end
			end
		else
			if room:getCurrent():hasFlag("surveyWaring") then
				room:setPlayerFlag(player,"surveyWared")
			end
		end
		return false
	end,
	priority = 2,
	can_trigger = function(self, target)
		return target
	end,
}

SurveyAnjiang:addSkill(surveyStart)
SurveyAnjiang:addSkill(surveyDraw)
SurveyAnjiang:addSkill(surveyArgue)
SurveyAnjiang:addSkill(surveyWar)
local svgenerals = sgs.Sanguosha:getLimitedGeneralNames()
for _,name in ipairs(svgenerals) do
	local general = sgs.Sanguosha:getGeneral(name)
	if general and not general:isTotallyHidden() then
		general:addSkill("#surveyStart")
	end
end

local acidsuit = {sgs.Card_Heart,sgs.Card_Diamond,sgs.Card_Spade,sgs.Card_Club}
local acidnumber = {1,2,3,4,5,6,7,8,9,10,11,12,13}
addAimedCard = function(cardname, suitpoint, number)
	local temp_card = cardname:clone()
	temp_card:setSuit(acidsuit[suitpoint])
	temp_card:setNumber(acidnumber[number])
	temp_card:setParent(extension)
end

for i=1, 12, 1 do
	local temp_card = acid:clone()
	temp_card:setSuit(acidsuit[math.mod(i,4)+1])
	temp_card:setNumber(acidnumber[i])
	temp_card:setParent(extension)
end
addAimedCard(acid,2,7)
addAimedCard(acid,1,1)
addAimedCard(acid,1,12)
addAimedCard(acid,4,5)
addAimedCard(acid,3,8)
for i=1, 13, 1 do
	local temp_card = alkali:clone()
	temp_card:setSuit(acidsuit[4-math.mod(i,4)])
	temp_card:setNumber(acidnumber[i])
	temp_card:setParent(extension)
end
addAimedCard(alkali,3,13)
addAimedCard(alkali,4,12)
addAimedCard(alkali,1,3)
addAimedCard(alkali,4,6)
for i=1, 3, 1 do
	local temp_card = acidfly:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[14-i])
	temp_card:setParent(extension)
end
for i=1, 3, 1 do
	local temp_card = alkalifly:clone()
	temp_card:setSuit(acidsuit[i+1])
	temp_card:setNumber(acidnumber[14-i])
	temp_card:setParent(extension)
end
for i=1, 11, 1 do
	local temp_card = c6:clone()
	temp_card:setSuit(acidsuit[math.mod(i,2)+1])
	temp_card:setNumber(acidnumber[i])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = wangshui:clone()
	temp_card:setSuit(acidsuit[3*i-2])
	temp_card:setNumber(acidnumber[4*i+5])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = zuhua:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[i+6])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = sizao:clone()
	if i == 3 then
		temp_card:setSuit(acidsuit[4])
	else
		temp_card:setSuit(acidsuit[5-i])
	end
	temp_card:setNumber(acidnumber[i+2])
	temp_card:setParent(extension)
end
for i=1, 3, 1 do
	local temp_card = laman:clone()
	temp_card:setSuit(acidsuit[5*i/2-i*i/2+1])
	temp_card:setNumber(acidnumber[i+7])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = lengning:clone()
	temp_card:setSuit(acidsuit[i+2])
	temp_card:setNumber(acidnumber[i+5])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = ejump:clone()
	temp_card:setSuit(acidsuit[math.mod(i,4)+1])
	temp_card:setNumber(acidnumber[i+1])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = shiguan:clone()
	temp_card:setSuit(acidsuit[i+1])
	temp_card:setNumber(acidnumber[6-2*i])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = bolisai:clone()
	temp_card:setSuit(acidsuit[6-2*i])
	temp_card:setNumber(acidnumber[i+1])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = phji:clone()
	temp_card:setSuit(acidsuit[i+2])
	temp_card:setNumber(acidnumber[2*i+2])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = fhf:clone()
	temp_card:setSuit(acidsuit[2*i-1])
	temp_card:setNumber(acidnumber[5*i-3])
	temp_card:setParent(extension)
end
for i=1,3,1 do
	local temp_card = jieziq:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[14-i])
	temp_card:setParent(extension)
end
for i=1,4,1 do
	local temp_card = zhihuanfy:clone()
	temp_card:setSuit(acidsuit[5-i])
	temp_card:setNumber(acidnumber[9-i])
	temp_card:setParent(extension)
end
for i=1,3,1 do
	local temp_card = fireup:clone()
	temp_card:setSuit(acidsuit[math.mod(i-1,2)+1])
	temp_card:setNumber(acidnumber[i+8])
	temp_card:setParent(extension)
end
for i=1,3,1 do
	local temp_card = yimi:clone()
	temp_card:setSuit(acidsuit[4-math.mod(i,2)])
	temp_card:setNumber(acidnumber[i])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = jiujingdeng:clone()
	temp_card:setSuit(acidsuit[2])
	temp_card:setNumber(acidnumber[9*i-5])
	temp_card:setParent(extension)
end
for i=1, 3, 1 do
	local temp_card = hetongbh:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[i+9])
	temp_card:setParent(extension)
end
for i=1, 2, 1 do
	local temp_card = mianyy:clone()
	temp_card:setSuit(acidsuit[2*i])
	temp_card:setNumber(acidnumber[15-7*i])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = zheshe:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[math.mod(4*i+6,13)])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = zheshe:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[3*i+1])
	temp_card:setParent(extension)
end
aciddd:setParent(extension)
alkalidd:setParent(extension)
addAimedCard(peaceagree,4,12)
addAimedCard(zslengjing,3,10)
for i=1, 4, 1 do
	local temp_card = allocate:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[i+1])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = drosophila:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[math.mod(8*i-5,13)])
	temp_card:setParent(extension)
end
for i=1, 4, 1 do
	local temp_card = huiyibl:clone()
	temp_card:setSuit(acidsuit[i])
	temp_card:setNumber(acidnumber[4*i-3])
	temp_card:setParent(extension)
end

--acidsuit = {sgs.Card_Heart,sgs.Card_Diamond,sgs.Card_Spade,sgs.Card_Club}

--k2cr2o7:setParent(extension)
--edta:setParent(extension)
--beilo:setParent(extension) 
addAimedCard(enjoyeat,2,2)
addAimedCard(enjoyeat,2,4)
addAimedCard(enjoyeat,2,9)
addAimedCard(enjoyeat,1,13)
for i=1, 3, 1 do
	local temp_card = skillbuy:clone()
	temp_card:setSuit(acidsuit[4-math.mod(i,2)])
	temp_card:setNumber(acidnumber[5*i-4])
	temp_card:setParent(extension)
end
addAimedCard(skillbuy,1,8)
addAimedCard(knowspread,4,3)
addAimedCard(knowspread,1,5)
addAimedCard(knowspread,2,10)
addAimedCard(knowspread,1,11)

local sgskills = sgs.SkillList()
if not sgs.Sanguosha:getSkill("k2cr2o7Clear") then 
	sgskills:append(k2cr2o7Clear) 
end
if not sgs.Sanguosha:getSkill("edta_trigger") then 
	sgskills:append(edta_trigger) 
end
if not sgs.Sanguosha:getSkill("edta_vs") then 
	sgskills:append(edta_vs) 
end
if not sgs.Sanguosha:getSkill("shiguanJdg") then 
	sgskills:append(shiguanJdg) 
end
if not sgs.Sanguosha:getSkill("bolisaiRe") then 
	sgskills:append(bolisaiRe) 
end
if not sgs.Sanguosha:getSkill("phjiJdg") then 
	sgskills:append(phjiJdg) 
end
if not sgs.Sanguosha:getSkill("fhfskill") then 
	sgskills:append(fhfskill) 
end
if not sgs.Sanguosha:getSkill("beiloVS") then 
	sgskills:append(beiloVS) 
end
if not sgs.Sanguosha:getSkill("leishe") then 
	sgskills:append(leishe) 
end
if not sgs.Sanguosha:getSkill("tntfac") then 
	sgskills:append(tntfac) 
end
if not sgs.Sanguosha:getSkill("yimiclear") then 
	sgskills:append(yimiclear) 
end
if not sgs.Sanguosha:getSkill("jiujingdengVS") then 
	sgskills:append(jiujingdengVS) 
end
if not sgs.Sanguosha:getSkill("askweather") then 
	sgskills:append(askweather) 
end
if not sgs.Sanguosha:getSkill("weatherchange") then 
	sgskills:append(weatherchange) 
end
if not sgs.Sanguosha:getSkill("weathereffect") then 
	sgskills:append(weathereffect) 
end
if not sgs.Sanguosha:getSkill("weathereffectB") then 
	sgskills:append(weathereffectB) 
end
if not sgs.Sanguosha:getSkill("weathereffectC") then 
	sgskills:append(weathereffectC) 
end
if not sgs.Sanguosha:getSkill("wkzhongxingive") then 
	sgskills:append(wkzhongxingive) 
end
if not sgs.Sanguosha:getSkill("mianyyclear") then 
	sgskills:append(mianyyclear) 
end
if not sgs.Sanguosha:getSkill("peacepunished") then 
	sgskills:append(peacepunished) 
end
if not sgs.Sanguosha:getSkill("peacebroke") then 
	sgskills:append(peacebroke) 
end
if not sgs.Sanguosha:getSkill("zheshetri") then 
	sgskills:append(zheshetri) 
end
if not sgs.Sanguosha:getSkill("zslengjingVS") then 
	sgskills:append(zslengjingVS) 
end
if not sgs.Sanguosha:getSkill("edcankaosecond") then 
	sgskills:append(edcankaosecond) 
end
if not sgs.Sanguosha:getSkill("kpxingyun") then 
	sgskills:append(kpxingyun) 
end
if not sgs.Sanguosha:getSkill("stdrive") then 
	sgskills:append(stdrive) 
end
if not sgs.Sanguosha:getSkill("mtliebianTargetMod") then 
	sgskills:append(mtliebianTargetMod) 
end
if not sgs.Sanguosha:getSkill("skillbuyclear") then 
	sgskills:append(skillbuyclear) 
end
if not sgs.Sanguosha:getSkill("krenergysecond") then 
	sgskills:append(krenergysecond) 
end
if not sgs.Sanguosha:getSkill("liqingtilianMaxCards") then 
	sgskills:append(liqingtilianMaxCards) 
end
if not sgs.Sanguosha:getSkill("mdzhumaPro") then 
	sgskills:append(mdzhumaPro) 
end
if not sgs.Sanguosha:getSkill("bnbigmath") then 
	sgskills:append(bnbigmath) 
end
if not sgs.Sanguosha:getSkill("noisetri") then 
--	sgskills:append(noisetri) 
end
if not sgs.Sanguosha:getSkill("adfengongTargetMod") then 
	sgskills:append(adfengongTargetMod) 
end
if not sgs.Sanguosha:getSkill("zawuren") then 
	sgskills:append(zawuren) 
end
if not sgs.Sanguosha:getSkill("zawurenTargetMod") then 
	sgskills:append(zawurenTargetMod) 
end
if not sgs.Sanguosha:getSkill("swmougong") then 
	sgskills:append(swmougong) 
end
if not sgs.Sanguosha:getSkill("swjunyanAsk") then 
	sgskills:append(swjunyanAsk) 
end

sgs.Sanguosha:addSkills(sgskills)
weile:addSkill(youjihecheng)
weile:addSkill(tongfenyigou)
houdebang:addSkill(madejian)
houdebang:addSkill(madejianTargetMod)
lawaxi:addSkill(wuzhishouheng)
lawaxi:addSkill(lwxyanghua)
huangminglong:addSkill(hmlhuanyuan)
msjuli:addSkill(liqingtilian)
msjuli:addSkill(jltanlei)
baichuan:addSkill(bccanza)
baichuan:addSkill(bcdaodian)
nuobeier:addSkill(boom)
nuobeier:addSkill(brodie)
daoerdun:addSkill(Drfenya)
daoerdun:addSkill(Dratoms)
daoerdun:addSkill(atomsget)
menjieliefu:addSkill(mjyuce)
menjieliefu:addSkill(zhouqibiao)
david:addSkill(dvceran)
david:addSkill(dvdianjie)
david:addSkill(dvdianjieStart)
david:addSkill(dvdianjieAvoid)
shele:addSkill(slransu)
shele:addSkill(slmoyan)
mulis:addSkill(mlspcr)
mulis:addSkill(mlspcrTag)
nash:addSkill(nsboyi)
nash:addSkill(nsjunheng)
fuke:addSkill(fkbai)
fuke:addSkill(fkbaiStart)
fuke:addSkill(fkwoliu)
fuke:addSkill(fkhuizhuan)
--beir:addSkill(brtongxin)
--beir:addSkill(brtongxinclear)
mitena:addSkill(mtliebian)
wosenklk:addSkill(wkluoxuan)
wosenklk:addSkill(wkzhongxin)
ndgirl:addSkill(ndhuli)
ndgirl:addSkill(ndfengdeng)
ndgirl:addSkill(ndcongyi)
ndgirl:addSkill(ndfengdengTargetMod)
jialowa:addSkill(jlqunlun)
jialowa:addSkill(jlsidou)
jialowa:addSkill(jlqunlunex)
yuanlongping:addSkill(lpfengshou)
yuanlongping:addSkill(lpyusui)
fiman:addSkill(fmchongzheng)
fiman:addSkill(fmtugou)
zuchongzhi:addSkill(czyingkui)
zuchongzhi:addSkill(czyingkuimark)
zuchongzhi:addSkill(czzhuishu)
akubr:addSkill(akqusu)
akubr:addSkill(akqusuGive)
akubr:addSkill(akzhouxiang)
borzm:addSkill(brshuyun)
borzm:addSkill(brshangbian)
tesla:addSkill(tsjiaobian)
tesla:addSkill(tswuxian)
yinssk:addSkill(ysbengdong)
eldes:addSkill(edkanlun)
eldes:addSkill(edcankao)
eldes:addSkill(edliuxi)
--eldes:addSkill(edcankaosecond)
kaipl:addSkill(kpxingtu)
kaipl:addSkill(kpguance)
stevens:addSkill(sttransport)
hodgkin:addSkill(hglaser)
hodgkin:addSkill(hglaserFakeMove)
hodgkin:addSkill(hgjiejing)
hesmu:addSkill(hskefa)
hesmu:addSkill(hsxianhe)
hesmu:addSkill(hsxianheStart)
karvin:addSkill(krcircle)
karvin:addSkill(krcirclePass)
karvin:addSkill(krenergy)
karvin:addSkill(krenergyb)
morton:addSkill(mdmazui)
morton:addSkill(mdzhuma)
ebhaus:addSkill(abcuojue)
ebhaus:addSkill(abforget)
lipum:addSkill(lpyuqing)
bonuli:addSkill(bnrepeat)
bonuli:addSkill(bnrepeatRes)
bonuli:addSkill(bnrepeat_global)
bonuli:addSkill(bncaidu)
bonuli:addSkill(bncaiduExtra)
boer:addSkill(bryueqian)
boer:addSkill(brqingpu)
keluolf:addSkill(klweixing)
keluolf:addSkill(kltiance)
adamsmi:addSkill(adfengong)
adamsmi:addSkill(adshuifu)
lidaoyuan:addSkill(ldshexian)
lidaoyuan:addSkill(ldannotate)
lidaoyuan:addSkill(ldshexianP)
chenyinke:addSkill(cyyuanshi)
chenyinke:addSkill(cyyuanshiKeep)
chenyinke:addSkill(cymingdao)
linhuiyin:addSkill(lymiansu)
linhuiyin:addSkill(lyguijian)
linhuiyin:addSkill(lyyingzao)
linhuiyin:addSkill(lyyingzaoProhibit)
linhuiyin:addSkill(lyyingzaoFilter)
adlovelace:addSkill(adchengshi)
adlovelace:addSkill(adxunhuan)
morgan:addSkill(mgliansuo)
morgan:addSkill(mgbianyi)
zhangailin:addSkill(zasuxu)
zhangailin:addSkill(zahongye)
sunwu:addSkill(swbingzhu)
sunwu:addSkill(swjunyan)

sgs.LoadTranslationTable{
	["designer:weile"] = "wvikenggod",
	["designer:houdebang"] = "wvikenggod",
	["designer:lawaxi"] = "wvikenggod",
	["designer:huangminglong"] = "wvikenggod",
	["designer:msjuli"] = "wvikenggod",
	["designer:baichuan"] = "wvikenggod",
	["designer:nuobeier"] = "wvikenggod",
	["designer:daoerdun"] = "wvikenggod",
	["designer:menjieliefu"] = "wvikenggod",
	["designer:david"] = "wvikenggod",
	["designer:shele"] = "wvikenggod",
	["designer:mulis"] = "wvikenggod",
	["designer:nash"] = "wvikenggod",
	["designer:fuke"] = "wvikenggod",
	["designer:mitena"] = "wvikenggod",
	["designer:wosenklk"] = "wvikenggod",
	["designer:ndgirl"] = "wvikenggod",
	["designer:jialowa"] = "wvikenggod",
	["designer:yuanlongping"] = "wvikenggod",
	["designer:fiman"] = "wvikenggod",
	["designer:zuchongzhi"] = "wvikenggod",
	["designer:akubr"] = "wvikenggod",
	["designer:borzm"] = "wvikenggod",
	["designer:tesla"] = "wvikenggod",
	["designer:yinssk"] = "Monkey、基尔兽、wingvikenggod",
	["designer:eldes"] = "wvikenggod",
	["designer:kaipl"] = "wvikenggod",
	["designer:stevens"] = "wvikenggod",
	["designer:hodgkin"] = "wvikenggod",
	["designer:hesmu"] = "wvikenggod",
	["designer:karvin"] = "wvikenggod",
	["designer:morton"] = "wvikenggod",
	["designer:ebhaus"] = "wvikenggod",
	["designer:lipum"] = "wvikenggod",
	["designer:bonuli"] = "wvikenggod",
	["designer:boer"] = "wvikenggod",
	["designer:keluolf"] = "wvikenggod",
	["designer:adamsmi"] = "wvikenggod",
	["designer:lidaoyuan"] = "绫洛叶蓁、青堰居士",
	["designer:chenyinke"] = "绫洛叶蓁、wvikenggod",
	["designer:linhuiyin"] = "青堰居士| 代码:Dabble",
	["designer:adlovelace"] = "wvikenggod",
	["designer:morgan"] = "Dabble",
	["designer:zhangailin"] = "青堰居士、Dabble",
	
	["cv:weile"] = "Assassins' Creed Eternity",
	["cv:houdebang"] = "000191750",
	["cv:lawaxi"] = "Assassins' Creed Eternity",
	["cv:msjuli"] = "Assassins' Creed Eternity",
	["cv:nuobeier"] = "Assassins' Creed Eternity",
	["cv:daoerdun"] = "Assassins' Creed Eternity",
	["cv:menjieliefu"] = "Assassins' Creed Eternity",
	["cv:david"] = "Assassins' Creed Eternity",
	["cv:shele"] = "Assassins' Creed Eternity",
	["cv:mnlis"] = "Assassins' Creed Eternity",
	["cv:nash"] = "Assassins' Creed Eternity",
	["cv:mitena"] = "Assassins' Creed Eternity",
	["cv:ndgirl"] = "Assassins' Creed Eternity",
	["cv:jialowa"] = "Assassins' Creed Eternity",
	["cv:yuanlongping"] = "果静林(电影《袁隆平》)",
	["cv:fiman"] = "000191750",
	["cv:zuchongzhi"] = "龙凤包",
	["cv:akubr"] = "Assassins' Creed Eternity",
	["cv:stevens"] = "Assassins' Creed Eternity",
	["cv:hodgkin"] = "Assassins' Creed Eternity",
	["cv:ebhaus"] = "Assassins' Creed Eternity",
	["cv:lipum"] = "Assassins' Creed Eternity",
	
	["illustrator:weile"] = "所有武将卡牌制图：青堰居士",
	["illustrator:huangminglong"] = "赵进武",
	["illustrator:david"] = "约翰·林内尔(1792年-1882年)",
	["illustrator:shele"] = "《氧：关于“追认诺贝尔奖”的二幕话剧》剧照(皮肤)",
	["illustrator:jialowa"] = "《极限空间》剧照",
	["illustrator:zuchongzhi"] = "《三国智》钟繇插画(皮肤1)",
	["illustrator:kaipl"] = "图源:大航海时代5|合成:日月小辰",
	["illustrator:hesmu"] = "玉素甫·哈斯·哈吉甫的画像",
	["illustrator:morton"] = "Ernest Board(1877–1934)",
	["illustrator:chenyinke"] = "人像摄影:周裕隆|合成:青堰居士",
	["illustrator:adlovelace"] = "Alfred Edward Chalon(1780-1860)",
}

sgs.LoadTranslationTable{
	["techkill"] = "学科杀",
	
	["acid"] = "酸",
	[":acid"] = "基本牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：攻击范围内的一名其他角色<br /><b>效果</b>：<font color=\"green\"><b>出牌阶段限一次，</b></font>令其选择：1.打出一张【碱】；2.受到来自你的一点伤害。（【酸】、【碱】使用次数同时计算）",
	["@alkalitoacid"] = "有人对你使用了【酸】，请打出一张【碱】",
	["alkali"] = "碱",
	[":alkali"] = "基本牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：攻击范围内的一名其他角色<br /><b>效果</b>：<font color=\"green\"><b>出牌阶段限一次，</b></font>令其选择：1.打出一张【酸】；2.受到来自你的一点伤害。（【酸】、【碱】使用次数同时计算）",
	["@acidtoalkali"] = "有人对你使用了【碱】，请打出一张【酸】",
	["c6"] = "葡萄糖",
	[":c6"] = "基本牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：自己<br /><b>效果</b>：若自己已受伤，则回复1点体力；若自己未受伤，则摸一张牌。",
	
	["acidfly"] = "硫酸飞溅",
	[":acidfly"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：所有其他角色<br /><b>效果</b>：每名目标角色须打出一张【碱】，否则受到1点伤害。（能被【藤甲】抵抗）",
	["@alkalitoacidfly"] = "有人使用了【硫酸飞溅】，请打出一张【碱】",
	["alkalifly"] = "万碱齐发",
	[":alkalifly"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：所有其他角色<br /><b>效果</b>：每名目标角色须打出一张【酸】，否则受到1点伤害。（能被【藤甲】抵抗）",
	["@acidtoalkalifly"] = "有人使用了【万碱齐发】，请打出一张【酸】",
	["wangshui"] = "王水",
	[":wangshui"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：任意一名有牌的其他角色<br /><b>效果</b>：目标展示所有牌，并弃置其中一种花色的所有牌，若以此法弃置的牌不少于两张，你受到来自自己的1点伤害。",
	["zuhua"] = "负催化剂",
	[":zuhua"] = "延时锦囊牌<br />出牌时机：出牌阶段<br />使用目标：一名其他角色。<br /><b>效果</b>：将【负催化剂】置于目标角色判定区内。目标角色下个判定阶段进行一次判定；若判定结果不为♦，则其获得该判定牌并将武将牌翻面。",
	["sizao"] = "硅藻土",
	[":sizao"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：任意一名其他角色<br /><b>效果</b>：目标须打出一张【酸】或【碱】，否则你对其造成1点伤害；如目标能打出，此后，你与目标依次打出一张此前目标打出的那张牌，无法打出者受到来自对方的1点伤害。",
	["@sizao_start"] = "有人对你使用了 硅藻土 ，请打出一张【酸】或【碱】！",
	["@sizao_askAcid"] = "你须打出一张【酸】！",
	["@sizao_askAlkali"] = "你须打出一张【碱】！",
	["laman"] = "拉曼光谱",
	[":laman"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：任意一名有手牌的其他角色<br /><b>效果</b>：观看目标所有牌，并弃置其中一个点数的所有牌。",
	["lengning"] = "冷凝回流",
	[":lengning"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：任意一名有牌的其他角色<br /><b>效果</b>：你选择一张目标的牌并观看，若该牌是装备牌，则你获得之，否则将其置于牌堆顶。",
	["ejump"] = "电子跃迁",
	[":ejump"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：两名选中的座次相邻其他角色（不能选择两名“基态”目标）中的上家<br /><b>效果</b>：你将位置移到两名选中的角色中间。",
	["special_trick"] = "特殊锦囊",
	["jieziq"] = "芥子气",
	[":jieziq"] = "延时锦囊牌<br />出牌时机：出牌阶段<br />使用目标：一名其他角色。<br /><b>效果</b>：将【芥子气】置于目标角色判定区内。目标角色下个判定阶段进行一次判定；若判定结果点数为12或13，则弃置此锦囊，该角色及其上、下家各流失1点体力（每名角色仅结算一次）；否则此锦囊移至其下家的判定区。",
	["zhihuanfy"] = "置换反应",
	[":zhihuanfy"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：所有角色<br /><b>效果</b>：你摸一张牌，然后所有目标依次将一张牌交给下家。（被无懈的目标无须给牌）",
	["@zhihuanask"] = "请交给你的下家一张牌",
	["fireup"] = "点燃",
	[":fireup"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：任意一名有牌的其他角色<br /><b>效果</b>：你选择一种花色，然后目标选择：1.弃置一张该花色的牌；2.受到来自你的1点火焰伤害。",
	["@fireupask"] = "请弃置一张 %src 牌，否则你将受到来自 %dest 的1点火焰伤害。",
	["yimi"] = "乙醚",
	[":yimi"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：任意一名其他角色<br /><b>效果</b>：目标无法使用或打出其手牌，直到其受到伤害或本回合结束。",
	["@yimi"] = "乙醚",
	["hetongbh"] = "合同变换",
	[":hetongbh"] = "延时锦囊牌<br />出牌时机：出牌阶段<br />使用目标：一名其他角色。<br /><b>效果</b>：将【合同变换】置于目标角色判定区内。目标角色下个判定阶段进行一次判定并获得判定牌；若判定结果不为黑桃，则其须展示所有手牌，然后其他有手牌的角色可以依次将一张手牌与其中的一张牌交换。",
	["@hetongaskprompt"] = "你可以将一张手牌与 %src 的一张手牌交换",
	["mianyy"] = "免疫抑制",
	[":mianyy"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：一名其他角色<br /><b>效果</b>：令其一项武将技能无效，直到其下回合开始。\
	Ps.根据规则，已知【祸首】不会失效",
	["#mianyylog"] = "受 %from 使用 %card 的影响，%to 在下回合开始前，其技能 %arg 失效。",
	["zheshe"] = "折射",
	[":zheshe"] = "基本牌<br /><b>时机</b>：一名其他角色的基本牌指定你为目标时<br /><b>目标</b>：一名不为该基本牌目标且与你座位相邻的角色<br /><b>效果</b>：目标角色代替你成为该基本牌的目标。",
	["@zheshe"] = "你现在可以使用【折射】响应 %src 的 %dest",
	["huiyibl"] = "会议辩论",
	[":huiyibl"] = "锦囊牌 <font color=\"brown\">（只有在索尔维会议模式下才会加入游戏）</font> <br /><b>时机</b>：出牌阶段<br /><b>目标</b>：所有其他角色<br /><b>效果</b>：每名目标角色须打出一张点数不小于上一名目标角色以此法打出的牌的手牌（若没有则为点数为0），否则其受到上一名目标角色的1点伤害。",
	["@huiyiaskbl"] = "你需要打出一张手牌响应“会议辩论”",
	["enjoyeat"] = "旅馆用餐",
	[":enjoyeat"] = "锦囊牌 <font color=\"brown\">（只有在索尔维会议模式下才会加入游戏）</font> <br /><b>时机</b>：出牌阶段<br /><b>目标</b>：一名使用科学家的角色<br /><b>效果</b>：目标摸四张牌，弃三张牌。若其弃置的牌类型均不同，其可视为对一名其他科学家使用此牌。\
	◆这张牌可以被重铸。",
	["@enjoyeat-extra"] = "你可以选择一名科学家，视为对其使用【旅馆用餐】",
	["enjoyeatDis"] = "请弃置三张牌以响应“旅馆用餐”",
	["skillbuy"] = "科技引进",
	[":skillbuy"] = "锦囊牌 <font color=\"brown\">（只有在索尔维会议模式下才会加入游戏）</font> <br /><b>时机</b>：出牌阶段<br /><b>目标</b>：一名使用科学家的其他角色<br /><b>效果</b>：目标摸一张牌，然后选择:1.受到来自你的1点伤害;2.获得你的一张牌，令你获得由你选择的其科学家的一项技能（限定技、觉醒技、主公技除外），且其该技能无效，直至其下家回合开始前。\
	◆这张牌可以被重铸。\
	◆获得技能和技能无效的效果同时消失。",
	["skillsell"] = "获得其一张牌并将技能交给该角色",
	["denyskillbuy"] = "受到1点伤害",
	["#skillbuyrequest"] = "%from 请求引进技能 %arg ",
	["#skillreturnlog"] = "%from 召回了此前被 %to 引进的技能 %arg",
	["knowspread"] = "知识传播",
	[":knowspread"] = "锦囊牌 <font color=\"brown\">（只有在索尔维会议模式下才会加入游戏）</font> <br /><b>时机</b>：出牌阶段<br /><b>目标</b>：一名使用未科学家的其他角色<br /><b>效果</b>：你摸一张牌，然后令目标观看你的手牌，其可以展示并获得其中的任意张锦囊牌，若如此做，其可立即使用其中任意张锦囊牌。\
	◆这张牌可以被重铸。",
	["@knowusing"] = "你现在可以使用这些锦囊牌",
	["allocate"] = "资产分配",
	[":allocate"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：一名有手牌的其他角色<br /><b>效果</b>：你获得目标的所有手牌，然后交给其等量的牌。",
	["allocateprompt"] = "你现在需要选择等量的牌交给该角色",
	["drosophila"] = "白眼果蝇",
	[":drosophila"] = "锦囊牌<br /><b>时机</b>：出牌阶段<br /><b>目标</b>：一名角色<br /><b>效果</b>：目标选择：1.摸一张牌；2.你令其回复1点体力。选择后，其弃置半数的手牌并摸等量的牌（向上取整）。",
	["drorecov"] = "回复1点体力",
	["drodraw"] = "摸一张牌",
	
	--装备
	
	["shiguan"] = "试管",
	[":shiguan"] = "装备牌·武器<br />攻击范围：2<br />武器特效：<font color=\"blue\"><b>锁定技，</b></font>当你的【酸】或【碱】被目标的【酸】或【碱】抵消时，你进行判定，若为红色，则你回复1点体力。",
	["shiguanJdg"] = "试管",
	["aciddd"] = "酸式滴定管",
	[":aciddd"] = "装备牌·武器<br />攻击范围：1<br />武器特效：你使用【酸】无次数限制。",
	["alkalidd"] = "碱式滴定管",
	[":alkalidd"] = "装备牌·武器<br />攻击范围：1<br />武器特效：你使用【碱】无次数限制。",
	["bolisai"] = "玻璃塞",
	[":bolisai"] = "装备牌·防具<br />防具效果：<font color=\"blue\"><b>锁定技，</b></font>当你受到伤害后，本回合内受到来自角色的伤害前，防止该伤害。",
	["phji"] = "ph计",
	[":phji"] = "装备牌·武器<br />攻击范围：3<br />武器特效：当你的【酸】或【碱】指定目标后，你可以进行判定，若判定点数为1~7（对应【酸】）或7~13（对应【碱】），则该【酸】或【碱】不可被目标的【碱】或【酸】抵消。",
	["phjiJdg"] = "ph计·判定",
	["fhf"] = "防化服",
	[":fhf"] = "装备牌·防具<br />防具效果：<font color=\"blue\"><b>锁定技，</b></font>【酸】、【碱】、【硫酸飞溅】、【万碱齐发】对你无效；你不能使用【酸】、【碱】。",
	["jiujingdeng"] = "酒精灯",
	[":jiujingdeng"] = "装备牌·武器<br />攻击范围：3<br />武器特效：你可以将一张红桃牌当做【点燃】使用。\
	<font color=\"brown\">Ps.技能发动按钮在武将头像的左上角。</font>",
	["jiujingdengVS"] = "酒精灯",
	["peaceagree"] = "和平协议",
	[":peaceagree"] = "装备牌·防具<br />防具效果：出牌阶段，你可以弃置装备区内的这张牌，并摸一张牌。\
	<font color=\"blue\"><b>锁定技，</b></font>回合结束阶段开始时，场上所有体力值比你多的就角色流失1点体力并摸一张牌，所有体力值比你少的角色回复一点体力并弃一张牌。\
	<font color=\"blue\"><b>锁定技，</b></font>杀死你的角色获得这张装备。",
	["peacebroke"] = "撕毁协议",
	["peacepunished"] = "和平审判",
	["#peacelog"] = "%from 的 %arg 被触发！",
	["zslengjing"] = "棱镜",
	[":zslengjing"] = "装备牌·防具<br />防具效果：你可以将一张黑色手牌当作【折射】使用或打出。",
	["zslengjingVS"] = "棱镜·折射",
	
	--武将
	
	["#weile"] = "有机突破者",
	["weile"] = "维勒",
	["youjihecheng"] = "有机合成",
	[":youjihecheng"] = "出牌阶段，你可以将两张牌当做【葡萄糖】使用。",
	["tongfenyigou"] = "同分异构",
	[":tongfenyigou"] = "<font color=\"green\"><b>出牌阶段限一次，</b></font>若你有手牌，你可以展示手牌并翻开牌堆顶上X+2张牌，获得其中花色与你手牌均不同或名字与你任一手牌相同的牌。（X为你已损失的体力）",
	["tongfenyigouCard"] = "同分异构",
	["$tongfenyigou1"] = "事情可能比你想象的要复杂。",
	["$youjihecheng1"] = "如果我把这些字母后移三位，然后调换……",
	
	["#houdebang"] = "天朝重化开拓者",
	["houdebang"] = "侯德榜",
	["madejian"] = "制碱",
	[":madejian"] = "你可以将两张非装备牌或一张装备牌当做【碱】使用或打出；<font color=\"blue\"><b>锁定技，</b></font>你使用的【碱】攻击距离+1，你在出牌阶段内使用【碱】的数量上限+1，你回合内使用的第一张【碱】可额外指定一名目标。",
	["$madejian1"] = "我的一切发明，都属于祖国！",
	["$madejian2"] = "我是马命，马是站着死的，只要一息尚存，就要工作！",
	["~houdebang"] = "从来有志空留恨，刀锯余生已几年。",
	
	["#lawaxi"] = "近代化学之父",
	["lawaxi"] = "拉瓦锡",
	["wuzhishouheng"] = "物质守恒",
	[":wuzhishouheng"] = "你在回合外失去牌时，可以将牌堆顶的一张牌置于你的武将牌上，称为“物质”。你的回合开始阶段开始时，你可以弃置任意数量的“物质”，并令等量的角色各摸一张牌。",
	["things"] = "物质",
	["lwxyanghua"] = "氧化",
	[":lwxyanghua"] = "你的回合外，当有角色受到伤害时，若你不为受伤角色，你可以令其与你拼点，若其没赢，则其获得两张拼点牌，并使该伤害+1。",
	["@wzsh-card"] = "你现在可以使用【物质守恒】令目标摸牌",
	["~wuzhishouheng"] = "选择摸牌的角色->确定",
	["$wuzhishouheng1"] = "希望这一切永远也不会改变。",
	["$lwxyanghua1"] = "我发现了！当然，我真是个天才！",
	
	["#huangminglong"] = "甾族化工先驱",
	["huangminglong"] = "黄鸣龙",
	["hmlhuanyuan"] = "还原",
	[":hmlhuanyuan"] = "当有一名角色受到伤害时，若你不为伤害来源，你可与伤害来源拼点，若你赢，则伤害来源获得你的拼点牌，且伤害-1；若你没赢，则你获得伤害来源的拼点牌。",
	
	["#msjuli"] = "放射性物质之研究",
	["msjuli"] = "玛丽·居里",
	["liqingtilian"] = "沥青提炼",
	[":liqingtilian"] = "其他角色的回合结束阶段开始时，若你的“沥青提炼”标记不超过2个，你可以获得一个“沥青提炼”标记，令其摸3张牌并将一张牌置于其武将牌上，称为“辐射残渣”。<font color=\"blue\"><b>锁定技，</b></font>其他角色的回合开始阶段开始时，若其武将牌上有“辐射残渣”，其须连续判定至多X次，直至结果为黑色，若出现黑色，则其受到1点伤害。<font color=\"blue\"><b>锁定技，</b></font>其手牌上限-X。（X为“辐射残渣”牌数）",
	["@tilian"] = "沥青提炼",
	["radiation"] = "辐射残渣",
	["jltanlei"] = "探镭",
	[":jltanlei"] = "<font color=\"purple\"><b>觉醒技，</b></font>回合开始时，若你拥有不少于3个的“沥青提炼”标记，你须失去1点体力上限，获得技能“镭射”。\
	<font color=\"brown\"><b>镭射</b></font>：你的回合结束阶段结束时，若你拥有“沥青提炼”标记，你可以失去所有“沥青提炼”标记，并弃置场上所有“辐射残渣”，每当一名角色被弃置一张“辐射残渣”，视为你对其使用一张【雷杀】，该【雷杀】造成伤害时，其摸一张牌。",
	["leishe"] = "镭射",
	[":leishe"] = "你的回合结束阶段结束时，若你拥有“沥青提炼”标记，你可以失去所有“沥青提炼”标记，并弃置场上所有“辐射残渣”，每当一名角色被弃置一张“辐射残渣”，视为你对其使用一张【雷杀】，该【雷杀】造成伤害时，其摸一张牌。",
	["$liqingtilian1"] = "干得好！",
	["$liqingtilian2"] = "将你的成就转化为我们的优势！",
	["$jltanlei1"] = "尽力而为，心存信念。",
	["$leishe1"] = "这些都是世上遗失的知识，我们应当找回。",
	
	["#baichuan"] = "塑料电子学之门",
	["baichuan"] = "白川英树",
	["bccanza"] = "掺杂",
	[":bccanza"] = "当你受到伤害后，你可以将所有X张手牌背面朝上放在牌堆顶，然后按任意顺序重新排列等量的牌堆顶的牌，并获得牌堆底的X+2张牌。\
	<font color=\"brown\">Ps.与邓艾之类的武将双将时，因此技能失去牌仍然能发动【屯田】，但因为此时还未重新排列，判定牌可能是扣置手牌中的任意一张。</font>",
	["bcdaodian"] = "导电高分子",
	[":bcdaodian"] = "其他角色的回合结束阶段开始时，若其在本回合内造成过伤害，则你可以判定，并令该角色弃置一张与判定牌花色不同的手牌，否则其获得判定牌，受到来自你的1点雷电伤害。",
	["@daodian_card"] = "请选择一张符合条件的牌",
	
	["#nuobeier"] = "爆破达人",
	["nuobeier"] = "诺贝尔",
	["boom"] = "炸药",
	[":boom"] = "出牌阶段，你可以将任意张牌置于一名其他角色的武将牌上，称为“炸药”（每名角色最多有2张“炸药”）。一名角色的判定阶段开始时，若其武将牌上有炸药，则将其全部弃置，每弃置一张“炸药”，该角色须弃置一张与其颜色相同的牌，否则受到来自你的1点火焰伤害。",
	["tnt"] = "炸药",
	["@boom_card"] = "请弃置一张牌来响应“炸药”",
	["brodie"] = "牺牲",
	[":brodie"] = "<font color=\"purple\"><b>觉醒技，</b></font>当一名角色因受到“炸药”的伤害而死亡时，你须失去1点体力上限，获得技能“设厂”。\
	<font color=\"brown\"><b>设厂</b></font>：你的回合结束阶段结束时，你可将手牌补至体力上限，然后弃置X-1张牌（X为场上“炸药”数，且至少为1）。若你的手牌因此减少，你使所有角色立刻进行“炸药”判定。",
	["tntfac"] = "设厂",
	[":tntfac"] = "你的回合结束阶段结束时，你可将手牌补至体力上限，然后弃置X-1张牌（X为场上“炸药”数）。若你的手牌因此减少，你使所有角色立刻进行“炸药”判定。",
	["$brodie1"] = "兄弟！",
	["$tntfac1"] = "本来一切都可以避免，而我的弟弟也本应活着！",
	
	["#daoerdun"] = "世间万物皆原子",
	["daoerdun"] = "道尔顿",
	["Drfenya"] = "分压",
	[":Drfenya"] = "当其他角色的基本牌或非延时锦囊牌以你为唯一目标时，你可以令该角色除外的其他至多X+1名你攻击范围内的角色各摸一张牌，并也成为该牌的目标。（X为你已损失的体力值）",
	["Dratoms"] = "原子",
	[":Dratoms"] = "一名角色的回合结束阶段开始时，若其于本回合内造成过伤害，你可以将牌堆顶的一张牌置于你的武将牌上，称为“原子”。当其他角色的一张牌因使用或打出而进入弃牌堆时，若该牌不为【闪】，其结算完成后，你可以弃置任意张点数之和不小于该牌的“原子”，并获得该牌。（若有不止一张牌进入弃牌堆，则你只能获得其中一张。）\
	<font color=\"brown\">Ps.比如其他角色用【酸】响应【碱】，先询问是否获得【碱】，再询问【酸】。</font>",
	["atoms"] = "原子",
	["#atomsget"] = "获得原子",
	["@Drfenya"] = "你现在可以发动“分压”，拖别人下水",
	["~Drfenya"] = "选择目标角色->【确定】",
	["drfenya"] = "分压",
	["$Drfenya1"] = "我不想掺和这件事。",
	
	["#menjieliefu"] = "化学之门",
	["menjieliefu"] = "门捷列夫",
	["mjyuce"] = "预测",
	[":mjyuce"] = "判定牌翻开前，你可以展示一张手牌，若判定牌与该牌花色相同，你摸一张牌；若不同且判定角色不为你，则判定角色摸一张牌并交给你一张牌，若该牌与你展示的牌及判定牌花色均不同，你用展示的牌代替判定牌。",
	["zhouqibiao"] = "周期表",
	[":zhouqibiao"] = "花色或点数奇偶性不同的牌属于不同的“主族”。你成为其他角色的基本牌或非延时锦囊牌的目标时，你可以翻开牌堆顶的三张牌，若你没有这三张牌的“主族”记录，你可以记录下它们的“主族”。出牌阶段，若你拥有八个“主族”的记录，你可以清空记录，对任意名角色造成1点伤害。",
	["@zhuzuspade1"] = "第一主族·氢族",
	["@zhuzuspade0"] = "第二主族·碱土",
	["@zhuzudiamond1"] = "第三主族·硼族",
	["@zhuzudiamond0"] = "第四主族·碳族",
	["@zhuzuheart1"] = "第五主族·氮族",
	["@zhuzuheart0"] = "第六主族·氧族",
	["@zhuzuclub1"] = "第七主族·卤素",
	["@zhuzuclub0"] = "第零主族·稀有",
	["@mjyuce-ask"] = "请交给门捷列夫一张牌，若该牌不是 %src 或 %dest 牌，则判定牌将被改为 %dest %arg 的 %arg2 .",
	["$mjyuce1"] = "我想请教您一点事。",
	
	["#david"] = "从电能到元素",
	["david"] = "戴维",
	["dvceran"] = "测燃",
	[":dvceran"] = "回合结束时，你可以摸一张牌，若如此做，场上所有无属性伤害均视为火焰伤害，直到你的下回合开始。一名角色受到火焰伤害时，其可以摸一张牌并交给你一张牌。",
	["@ceran"] = "戴维测燃灯",
	["dvcerangive"] = "测燃给牌",
	["dvdianjie"] = "电解",
	[":dvdianjie"] = "<font color=\"red\"><b>限定技，</b></font>你用非延时锦囊牌指定至少包括一名其他角色为目标后，你可以令该锦囊无效并交给一名角色，对该锦囊所有目标（不包括你）造成1点雷电伤害。",
	["@electricbreak"] = "电解",
	["@ceranask"] = "请交给戴维一张牌",
	["$dvceran1"] = "快点，我们还有很多工作。",
	["$dvceran2"] = "跟我来。",
	["$dvdianjie1"] = "（电击声）",
	
	["#shele"] = "燃素之余温",
	["shele"] = "舍勒",
	["slransu"] = "燃素",
	[":slransu"] = "摸牌阶段，你可以放弃摸牌，翻开牌堆顶的三张牌。若这三张牌颜色相同，则你获得这些牌；若颜色不全相同，则你获得其中颜色相同的两张牌，并视为对一名其他角色使用一张【点燃】。",
	["slmoyan"] = "末宴",
	[":slmoyan"] = "当你处于濒死状态时，你可以将所有牌交给一名其他角色。",
	["$slmoyan1"] = "和诸位在一起的日子是愉快的。",
	
	["#mulis"] = "一条抑或一片",
	["mulis"] = "穆利斯",
	["mlspcr"] = "扩增",
	[":mlspcr"] = "出牌阶段，你可以将任意张花色与你此阶段内上一张使用的基本牌或锦囊牌相同且点数和不小于该牌的牌当做该牌使用。（【无懈可击】除外）",
	["$mlspcr1"] = "还有没有其他的模板？",
	
	["#nash"] = "美丽心灵",
	["nash"] = "纳什",
	["nsboyi"] = "博弈",
	[":nsboyi"] = "你的基本牌或非延时锦囊牌指定唯一目标后，你可以令一名不是该牌目标的角色与你同时展示一张手牌，若类型相同，则你弃置你展示的牌，并令该角色也成为该牌目标。",
	["nsboyi-invoke"] = "请选择“博弈”的目标",
	["nsjunheng"] = "均衡",
	[":nsjunheng"] = "你在回合外失去牌时，你可以令当前回合的角色选择：1.弃一张牌；2.令你摸一张牌。",
	["nsjunhengask"] = "请弃置一张牌，否则 %src 将摸一张牌。 ",
	["$nsboyi1"] = "两个本应是朋友的人，为了这东西而你死我活。",
	["$nsjunheng1"] = "先生，非常高兴和您聊天。",
	
	["#fuke"] = "脚下在旋转",
	["fuke"] = "傅科",
	["fkbai"] = "单摆",
	[":fkbai"] = "<font color=\"green\"><b>每名角色回合限一次，</b></font>【杀】或非延时锦囊指定唯一目标后，若你为该牌使用者或目标，且你拥有“上/下摆”，你可以令该牌目标的上/下家也成为该牌目标，并将标记转化为“下/上摆”。<font color=\"blue\"><b>锁定技，</b></font>游戏开始时，你获得一个“下摆”标记。",
	["@fkbaidown"] = "下摆",
	["@fkbaiup"] = "上摆",
	["fkwoliu"] = "涡流",
	[":fkwoliu"] = "回合开始时，你可以令两名座次相邻的角色交换位置，然后将武将牌翻面。你的武将牌翻面时，你可以视为对一名攻击范围内的角色使用一张雷【杀】。",
	["@fkwoliu"] = "你现在可以发动“涡流”，令两名相邻角色交换位置。",
	["~fkwoliu"] = "选择两名相邻角色->确定",
	["fkwoliu-invoke"] = "你现在可以发动“涡流”，视为对一名角色使用雷【杀】",
	["fkhuizhuan"] = "回转",
	[":fkhuizhuan"] = "出牌阶段，你可以重置“单摆”的使用次数，并流失1点体力。",
	
	["#mitena"] = "破裂的铀核",
	["mitena"] = "迈特纳",
	["mtliebian"] = "裂变",
	[":mtliebian"] = "<font color=\"green\"><b>出牌阶段限一次，</b></font>你可以弃置任意张不同种类的牌，然后翻开并获得牌堆顶的牌，重复之，直至你以此法获得的牌的点数和大于弃置的牌的点数和。若你以此法获得不超过两张牌，你可以视为对至多X名角色使用一张【杀】。（X为你弃置的牌数）",
	["mtliebiansl"] = "裂变",
	["@mtliebian"] = "你现在可以视为对 %src 名角色使用一张杀",
	["~mtliebian"] = "选择角色->确定",
	["mtliebianCard"] = "裂变",
	["$mtliebian1"] = "我的好书都在后面呢。",
	
	["#wosenklk"] = "两条螺旋",
	["wosenklk"] = "沃森＆克里克",
	["wkluoxuan"] = "螺旋分子",
	[":wkluoxuan"] = "一名角色的回合开始时，你可以弃一张手牌，并任意排列该角色此回合判定、摸牌、出牌、弃牌阶段的顺序。",
	["#wkluoxuanphase"] = "%from 对 %to 使用了 %arg ，修改了执行阶段的顺序",
	["#wkluoxuanphase1"] = "前两个阶段将会分别是 %arg 阶段和 %arg2 阶段",
	["#wkluoxuanphase2"] = "后两个阶段将会分别是 %arg 阶段和 %arg2 阶段",
	["wkzhongxin"] = "中心法则",
	[":wkzhongxin"] = "其他角色的出牌阶段开始时，你可以弃一张非装备牌，然后该角色选择：1.弃置一张与该牌花色相同的牌，此回合内可以将该花色的牌当做该牌使用；2.获得并可立刻使用该牌。",
	["wkzhongxingive"] = "中心法则·翻译",
	["@wkluoxuan"] = "你现在可以弃一张手牌，对 %src 发动“螺旋分子”",
	["~wkluoxuan"] = "选择一张手牌->确定->按次序选择阶段",
	["@wkzhongxin"] = "你可以弃置一张非装备牌，对 %src 发动“中心法则”",
	["~wkzhongxin"] = "选择一张牌->确定",
	["@wkzhongxinask"] = "你现在可以弃置一张 %src 牌，则你可以在本回合内将 %src 牌当做 %dest 使用；否则你将获得这张 %dest ，并可立即使用它",
	["@wkzhongxingive"] = "你现在可以使用这张 %src ",
	
	["#ndgirl"] = "白衣天使",
	["ndgirl"] = "南丁格尔",
	["ndhuli"] = "护理",
	[":ndhuli"] = "你造成伤害时，可以防止该伤害并令一名已受伤的角色回复等量体力，若造成伤害的牌为锦囊牌，则你本回合内不能再次使用该技能。",
	["ndfengdeng"] = "风灯",
	[":ndfengdeng"] = "一名角色进入濒死阶段时，若你武将牌背面朝上，你可以将一张手牌当做无距离限制的【杀】使用。",
	["ndcongyi"] = "从医",
	[":ndcongyi"] = "你需要使用或打出一张【桃】时，若你武将牌正面朝上，你可将武将牌翻面，视为使用或打出一张【桃】。",
	["@ndfengdeng"] = "现在 %src 进入了濒死阶段，你可以将一张牌当做【杀】使用",
	["~ndfengdeng"] = "选择【杀】的目标->确定",
	["$ndhuli1"] = "我可以让他持续现状几天，或者一周。",
	["$ndfengdeng1"] = "慢慢起来。",
	["$ndcongyi1"] = "我想知道，如何才能拯救我们的人民……",
	
	["#jialowa"] = "早逝的英才",
	["jialowa"] = "伽罗瓦",
	["jlqunlun"] = "群论",
	[":jlqunlun"] = "当你使用或打出一张牌时，若其与你上一张使用或打出的牌类型相同，你可以将牌堆顶的一张牌置于武将牌上，称为“群论”牌。<font color=\"green\"><b>出牌阶段限X+1次，</b></font>你可以将一张“群论”牌交给一名角色。（<font color=\"green\"><b>X</b></font>为已损失体力值）<font color=\"blue\"><b>锁定技，</b></font>每存在一张“群论”牌，你的手牌上限+1。\
	<font color=\"brown\">Ps.丈八蛇矛【杀】、八卦阵【闪】、夏侯渊【神速】等也可触发</font>",
	["jlsidou"] = "死斗",
	[":jlsidou"] = "<font color=\"blue\"><b>锁定技，</b></font>回合结束阶段开始时，你须选择一名体力值最多的其他角色，视为其对你使用一张【决斗】（不能被【无懈可击】）。若你因此对该角色造成伤害，防止该伤害，并摸一张牌。",
	["qunlunpile"] = "群论",
	["@jlqunlunequip"] = "群论·装备",
	["@jlqunluntrick"] = "群论·锦囊",
	["@jlqunlunbasic"] = "群论·基本",
	["$jlsidou1"] = "有时候逻辑可不是解决问题的唯一方法。",
	["$jlqunlunGot"] = "%to 获得了 %from 的 %arg 牌 %card",
	
	["#yuanlongping"] = "杂交水稻之父",
	["yuanlongping"] = "袁隆平",
	["lpfengshou"] = "丰收",
	[":lpfengshou"] = "出牌阶段，你可以将X+1张花色不同的牌当做【五谷丰登】使用，你以此法使用的【五谷丰登】在翻开牌后可以减少至多X个目标。（X为你此阶段已使用此技能的次数。）",
	["@lpfengshou"] = "你现在可以选择 %src 名角色不成为此【五谷丰登】目标",
	["~lpfengshou"] = "选择角色->确定",
	["lpyusui"] = "育穗",
	[":lpyusui"] = "<font color=\"green\"><b>每阶段限一次，</b></font>你使用【五谷丰登】时，可以翻开牌堆顶X张牌，将其中一种花色的所有牌交给一名角色，其余牌以任意顺序置于牌堆顶。（X为场上存活角色数）",
	["$lpfengshou1"] = "我觉得我有权利也有义务，让这个地球上有限的土地收获更多的粮食，让人类远离饥饿。",
	["$lpfengshou2"] = "我估摸着，这能收四百多万公斤每亩地，起码能种两百多万亩地。",
	["$lpyusui1"] = "实际上，它们是天然的杂交稻，是个不折不扣的杂种！",
	
	["#fiman"] = "微小的机器",
	["fiman"] = "费曼",
	["fmchongzheng"] = "重整化",
	[":fmchongzheng"] = "<font color=\"green\"><b>出牌阶段限一次，</b></font>你可以获得牌堆顶与其他角色各一张牌，然后交给因此失去牌的角色各一张牌。",
	["fmchongzhenggive"] = "请交给 %src 一张牌",
	["fmchongzhengCard"] = "重整化",
	["$fmchongzheng1"] = "我们可不能让这种事情发生。",
	["fmpicture"] = "图",
	["fmtugou"] = "图构",
	[":fmtugou"] = "出牌阶段，你可以将一张手牌扣置于一名其他角色的武将牌旁，称为“图”。<font color=\"blue\"><b>锁定技，</b></font>一名武将牌旁有“图”的角色的牌在其回合内因使用或打出而进入弃牌堆时，你须展示该角色的“图”，若与该牌种类相同，你获得该牌；若种类不同，你摸一张牌并将武将牌翻面。然后你获得该“图”并重新扣置一张“图”。你的回合开始时，你获得场上所有“图”。\
	<font color=\"brown\">Ps.转化后的牌进入弃牌堆时，按转化后种类执行此技能</font>",
	["fmtugougive"] = "你须将一张牌作为“图”置于 %src 的武将牌旁",
	["$fmtugou1"] = "看起来漂亮多了。",
	["$fmtugou2"] = "物理就像啪啪啪！",
	["$fmtugou3"] = "我们可以把它画出来。",
	
	["#zuchongzhi"] = "从圆周率谈起",
	["zuchongzhi"] = "祖冲之",
	["czyingkui"] = "盈亏",
	[":czyingkui"] = "游戏开始时，你获得一个“盈·亏”标记，并将“亏”面朝上。出牌阶段，你可以将该标记翻面，若如此做，你在本回合内不能使用“盈亏”，直到你下次使用“缀术”。",
	["@czying"] = "盈（偶）",
	["@czkui"] = "亏（奇）",
	["#czmarkturn"] = "%from 将标记由 %arg 面翻到 %arg2 面！",
	["czzhuishu"] = "缀术",
	[":czzhuishu"] = "出牌阶段，若你的标记“亏”面/“盈”面朝上，你可以将一张点数为2X+1/12-2X的牌当作任意一张非延时锦囊牌使用，若如此做，你在本回合内不能使用该锦囊。（X为本回合你已使用结算完毕的牌数）",
	["@czsuanchou"] = "缀术",
	["$czzhuishu1"] = "让我算一算。",
	
	["#akubr"] = "光速前进",
	["akubr"] = "阿库别瑞",
	["akqusu"] = "曲速",
	[":akqusu"] = "结束阶段开始时，你可以令一名角色摸一张牌，若其武将牌正面朝上且不为你，其在此回合结束后进行一个额外回合，并于额外回合结束时将武将牌翻至背面朝上。",
	["akzhouxiang"] = "轴向扭折",
	[":akzhouxiang"] = "一名角色出牌阶段开始时，你可以弃置其区域内至多X+1张牌（若你已受伤，每个区域至多弃X张，X为你已损失的体力值）。若如此做，此阶段结束时，若其此阶段未对你造成过伤害，其选择：1.弃一张牌并依次弃置你等量牌；2.摸等量牌。",
	["akdiscard"] = "弃牌",
	["@akzhouxiang-askdis"] = "你现在可以弃一张牌，然后弃置 %src 的 %dest 张牌，否则你将摸 %dest 张牌",
	["akqusu-invoke"] = "你现在可以对一名角色发动“曲速”",
	["$akqusu1"] = "最好快去工作，时间宝贵啊。",
	
	["#borzm"] = "混乱增长",
	["borzm"] = "玻尔兹曼",
	["brshuyun"] = "输运",
	[":brshuyun"] = "一名角色的结束阶段开始时，你可以观看其两张牌并依次置于牌堆顶，然后你弃置一张装备牌或令该角色选择：1.对你造成1点伤害；2.令你回复1点体力。",
	["@brshuyuneq"] = "你可以弃置一张装备牌来响应“输运”",
	["brrecov"] = "回复1点体力",
	["brdamage"] = "造成1点伤害",
	["brshangbian"] = "熵变",
	[":brshangbian"] = "你的体力值或体力上限改变时，你可以摸一张牌。",
	
	["#tesla"] = "电光震荡",
	["tesla"] = "特斯拉",
	["tsjiaobian"] = "交变",
	[":tsjiaobian"] = "一名角色受到雷电伤害后，你可以执行下列选项中的一项：1.将正面朝上的武将牌翻面并摸X-1张牌；2.弃X张牌；然后若你的武将牌正/背面朝上，你对其上/下家造成1点雷电伤害。（X为你的体力值）",
	["tsjiaobiandis"] = "为了响应“交变”，你现在可以弃置 %src 张牌，否则你将武将牌翻面并摸 %dest 张牌。",
	["tsjiaobiandisb"] = "你现在可以弃置 %src 张牌，对 %dest 造成1点雷电伤害",
	["tswuxian"] = "无线输能",
	[":tswuxian"] = "出牌阶段，你可以将一张手牌置于一名其他角色的武将牌上，称为“驻波”（每名角色至多一张）。你即将受到伤害时，可令一名武将牌上有“驻波”的角色选择：1.其获得“驻波”，并受到来自你的1点雷电伤害；2.弃置其“驻波”并展示一张与其相同颜色的手牌，令你此次受到伤害-1。",
	["tswuxian-invoke"] = "你现在可以对一名有“驻波”的角色使用“无线输能”",
	["@tswuxian-show"] = "你现在须展示一张 %src 牌以响应“无线输能”，否则你将获得一张 %dest ，并受到1点雷电伤害。",
	["tszhubo"] = "驻波",
	["#tswuxian-dfs"] = "%from 的 “%arg” 被触发，防止了此次伤害",
	
	["#yinssk"] = "钠与钾的流驶",
	["yinssk"] = "因斯·斯寇",
	["ysbengdong"] = "泵动",
	[":ysbengdong"] = "一名角色出牌阶段开始时，你可以用一张手牌替换最后一张进入弃牌堆的基本牌或非延时锦囊牌。若类型相同，你可令一名其他角色获得你失去的牌。",
	["ysbengdongask"] = "请用一张手牌替换你将捡回的牌",
	
	["#eldes"] = "数字情种",
	["eldes"] = "埃尔德什",
	["edkanlun"] = "刊论",
	[":edkanlun"] = "出牌阶段限一次，你可以将一张非装备牌作为“论文”置于武将牌上，或获得一张自己的“论文”。回合结束时，你可以令X+1名其他角色获得“参考”直到下回合结束。（X为你已损失体力值）",
	["edarticle"] = "论文",
	["edcankao"] = "参考",
	[":edcankao"] = "你可以将与场上一张“论文”花色相同的牌当做该“论文”使用或打出（每回合每张“论文”限一次）。",
	["edliuxi"] = "流徙",
	[":edliuxi"] = "你受到一次伤害后，可以将至少X张手牌交给一名手牌数不多于你的其他角色，然后若你手牌数比该角色少，你回复1点体力。（X为你的体力值）",
	["@edkanlung"] = "你可以令其他角色获得“参考”",
	["~edkanlun"] = "选择数名其他角色->确定",
	["@edcankaoaskforc"] = "请选择一张对应花色的牌并指定目标",
	["~edcankaosecond"] = "选择一张牌->选择目标->确定",
	["edcankaosecond"] = "参考",
	["@edliuxiask"] = "你现在可以发动“流徙”",
	["~edliuxi"] = "选择数张手牌->选择一名其他角色->确定",
	
	["#kaipl"] = "天空立法者",
	["kaipl"] = "开普勒",	
	["kpxingtu"] = "星图",
	[":kpxingtu"] = "当一名角色的牌将因使用、打出或弃置而进入弃牌堆时，若该角色为你，你可以将这些牌置于武将牌上，称为“星”；若不为你，你可以将一张“星”置于牌堆顶。",
	["kpguance"] = "观测",
	[":kpguance"] = "<font color=\"purple\"><b>觉醒技，</b></font>回合开始时，若你的“星”不少于手牌数，你失去1点体力上限并获得技能“星运”（一名距离在1以内的角色的准备阶段结束时，你可以用一张“星”替换合理位置的一张牌）。",
	["kpxingyun"] = "星运",
	[":kpxingyun"] = "一名距离在1以内的角色的准备阶段结束时，你可以用一张“星”替换合理位置的一张牌",
	["kpstar"] = "星",
	["@kpxingtuask"] = "你现在可以将一张“星”置于牌堆顶",
	["~kpxingtu"] = "选择要放置的“星”->确定",
	["@kpxingyunuse"] = "你现在可以用一张“星”替换合理位置的一张牌",
	["~kpxingyun"] = "选择要用来替换的“星”->选择对应角色->确定",
	
	["#stevens"] = "铁路机车之父",
	["stevens"] = "史蒂芬孙",
	["sttransport"] = "机车运输",
	[":sttransport"] ="分发起始手牌时，你额外摸三张牌，将三张牌置于武将牌上，称为“铁道”。准备阶段开始时，你可在任意名角色武将牌上各放置一张牌作为“铁道”（每人至多三张），并翻开牌堆顶等量牌，获得其中任一种类的牌。\
	任意角色出牌阶段，若其有“铁道”，其可将任意手牌交给另一名有“铁道”的角色；\
	若其“铁道”不少于2张，其可将任意张装备区的牌置入另一名“铁道”不少于2张的角色的装备区；\
	若其有3张“铁道”，其可流失1点体力，令另一名有3张“铁道”的角色回复1点体力。",
	["stdrive"] = "发车",
	[":stdrive"] = "你可以利用史蒂芬孙发明的火车运输物资。",
	["@sttransportask"] = "你可以在任意名“铁道”少于3张的角色的武将牌上各放置1张牌作为“铁道”。",
	["~sttransport"] = "选择任意张牌->选择角色->确定",
	["strail"] = "铁道",
	["$sttransport1"] = "别担心，你不是一个人在战斗！",
	
	["#hodgkin"] = "用射线来分析",
	["hodgkin"] = "霍奇金",
	["hglaser"] = "射线测定",
	[":hglaser"] = "你受到一次伤害后，可以观看伤害来源的手牌并弃置其区域内每种类型至多1张牌。\
	<font color=\"brown\">Ps.种类即基本牌、锦囊牌、装备牌。</font>",
	["hgjiejing"] = "结晶",
	[":hgjiejing"] = "一名角色的回合内，你的牌使用结算结束时，你可以弃置X张牌并获得之（X为你此回合使用并结算结束的牌数）；然后若你为场上手牌最少的角色（之一），你摸一张牌。\
	<font color=\"brown\">Ps.此处的X包括将要获得的这张（些）牌。</font>",
	["@hgjiejingask"] = "你可以弃置 %src 张牌，然后获得刚才使用的牌",
	["hgdiscard"] = "继续弃牌",
	["$hglaser1"] = "我从没见过这样的东西……",
	["$hgjiejing1"] = "这一切，都很好。",
	
	["#hesmu"] = "第一名科学家",
	["hesmu"] = "海什木",
	["hskefa"] = "科法",
	[":hskefa"] = "一名其他角色回合开始时，你可以声明一个牌的类型，并询问其本回合是否会使用此类型的牌。若如此做，该回合结束时，若其言行不一，你对其造成1点伤害；否则你可弃置任意张该类型的牌并摸等量牌。",
	["hsxianhe"] = "先河",
	[":hsxianhe"] = "<font color=\"red\"><b>限定技，</b></font>出牌阶段或你进入濒死状态时，可以将武将牌替换为任意一名未上场的科学家，将体力值回复至3点并获得技能“科法”。若如此做，从你的下回合开始，你的每回合结束时，你流失1点体力。",
	["@hsxianheMark"] = "先河",
	["hskefaask"] = "你现在可以弃置任意张 %src ，并摸等量牌",
	["@hsxianhe"] = "你现在可以发动“先河”",
	["~hsxianhe"] = "点击技能按钮",
	["hsxianheDie"] = "先河·体力流失",
	["#hskefaAnnounce"] = "%from 宣称本回合内 %arg 使用或打出 %arg2",
	["hswill"] = "会",
	["hsunwill"] = "不会",
	["hskefad:BasicCard"] = "海什木询问你本回合是否会使用基本牌？是则确定，否则取消。",
	["hskefad:TrickCard"] = "海什木询问你本回合是否会使用锦囊牌？是则确定，否则取消。",
	["hskefad:EquipCard"] = "海什木询问你本回合是否会使用装备牌？是则确定，否则取消。",
	
	["#karvin"] = "无尽暗反应",
	["karvin"] = "卡尔文",
	["krcircle"] = "碳循环",
	[":krcircle"] = "你的牌于出牌阶段外将进入弃牌堆时，你可将其作为“碳化物”移出游戏。摸牌阶段摸牌时，你可以少摸任意张牌并获得等量的“碳化物”。你死亡时，可将所有碳化物交给一名角色。",
	["Carbon"] = "碳化物",
	["krenergy"] = "植物能源",
	[":krenergy"] = "一名角色出牌阶段开始时，你可弃一张牌并弃置“碳化物”中所有与其颜色不同的牌，令该角色本回合使用牌无视距离，若弃置“碳化物”不少于两张，该角色可视为使用任意一张基本牌(不计入出牌阶段使用次数)。",
	["krcirclePass"] = "碳循环·落叶归根",
	["krenergysecond"] = "植物能源",
	["@krenergy"] = "你现在可以弃置一张牌，对 %src 发动“植物能源”",
	["@krenergyaskforc"] = "请为该基本牌指定目标",
	["~krenergysecond"] = "选择目标（有的基本牌无需选择）->确定",
	
	["#morton"] = "科学战胜疼痛",
	["morton"] = "威廉·莫顿",
	["mdmazui"] = "麻醉",
	[":mdmazui"] = "一名角色出牌阶段开始时，你可以令一名角色获得你的一张手牌，并视为你对其使用一张【乙醚】。",
	["@mdmazuiask"] = "%src 的出牌阶段开始，你可以使用麻醉",
	["mdzhuma"] = "注麻",
	[":mdzhuma"] = "一名角色【乙醚】效果结束时，你可将一张牌当做【乙醚】对其使用。一名其他角色对处于【乙醚】效果的角色造成伤害时，其可防止之，并将受伤角色的一张牌正面朝上交给你。\
	<font color=\"brown\">Ps.先于【乙醚】取消条件的判定。</font>",
	["@mdzhumaask"] = "%src 的乙醚效果结束，你可以再次麻醉",
	["~mdmazui"] = "选择目标->确定",
	["~mdzhuma"] = "选择一张牌->确定",
	
	["#ebhaus"] = "记忆先驱",
	["ebhaus"] = "艾宾浩斯",
	["abcuojue"] = "错觉",
	[":abcuojue"] = "其他角色使用非装备牌指定目标后，若一名角色上下家体力均不大于其且其中有该牌目标，你可弃一张牌，令该角色也成为目标;若一名目标的上下家体力均不小于其，你可以弃一张牌并取消该目标。(每张牌限X次，X为此时使用者与你的距离且至少为1。)\
	<font color=\"brown\">Ps.延时锦囊不能额外指定目标。</font>",
	["abforget"] = "遗忘",
	[":abforget"] = "<font color=\"blue\"><b>锁定技，</b></font>回合结束时，若你已受伤，你翻开牌堆顶的一张牌并获得之。你下回合开始前，你不能使用或打出该花色的手牌。",
	["@abcuojueask"] = "%src 使用了一张牌，你还可以发动 %dest 次“错觉”",
	["#abcuojueAdd"] = "受“错觉”影响，%from 使用的 %card 额外指定 %to 为目标！",
	["#abcuojueRemove"] = "受“错觉”影响，%from 使用的 %card 取消了目标 %to ！",
	["#abcuojueFinish"] = "“错觉”影响结束，%from 使用的 %card 目标修改为 %to !",
	["~abcuojue"] = "选择一张牌-选择目标角色-确定",
	["$abforget1"] = "一堆记忆有什么用，我们只是沉沦在自己的故事里！",
	
	["#lipum"] = "第七部分报纸",
	["lipum"] = "李普曼",
	["lpyuqing"] = "舆情",
	[":lpyuqing"] = "摸牌阶段开始时，你可以选择一名角色，令所有手牌数不多于其的角色（不包括该角色）选择一项:1.摸一张牌；2.弃置该角色区域内一张牌。",
	["lpyqdraw"] = "摸一张牌",
	["lpyqdis"] = "弃置该角色区域内一张牌",
	["lpyuqingask"] = "你现在可以选择一名角色，发动“舆情”",
	["$lpyuqing1"] = "不介意告诉我们你去哪儿了吧？",
	
	["#bonuli"] = "猜度之术",
	["bonuli"] = "雅各布·伯努利",
	["&bonuli"] = "J.伯努利",
	["bnrepeat"] = "重复实验",
	[":bnrepeat"] = "出牌阶段，你可流失1点体力并视为使用本回合上一张基本牌或非延时锦囊牌，以此法使用牌无次数限制且对你无效。结算后你进行判定，若与该牌颜色不同，你摸一张牌并明置之且本回合不能使用该技能。",
	["bncaidu"] = "猜度",
	[":bncaidu"] = "<font color=\"green\"><b>每阶段限一次，</b></font>一名角色判定时，你可以明置一张手牌。<font color=\"blue\"><b>锁定技，</b></font>你的明置手牌不计入上限。<font color=\"purple\"><b>觉醒技，</b></font>回合开始时，若你明置手牌多于未明置且你已受伤，你失去1点体力上限并获得“大数定理”。\
	<font color=\"brown\"><b>大数定理</b></font>：一名角色回合开始时，你可观看牌堆顶X+2张牌，将其中一张置于身份牌上，所有判定生效前，你可暗置一张手牌，使之按该牌结算，回合结束时弃置身份牌上该牌。（X为其已损失体力值。）",
	["bnbigmath"] = "大数定理",
	[":bnbigmath"] = "一名角色回合开始时，你可观看牌堆顶的X+2张牌，将其中一张置于身份牌上，所有判定结果生效前，你可暗置一张手牌，使之按该牌结算，回合结束时弃置身份牌上该牌。（X为其已损失体力值。）",
	["bigmath"] = "大数",
	["bnrepeatshow"] = "眀置牌",
	["bnrepeathand"] = "暗置的牌",
	["bnrepeatpile"] = "眀置的牌",
	["$MoveToShowcardPile"] = "%from 眀置了 %card",
	["$MoveToHidecardPile"] = "%from 暗置了 %card",
	["@bncaidushow"] = "现在 %src 即将判定，你可以发动“猜度”眀置一张手牌",
	["@bncaiduhide"] = "现在 %src 的判定即将生效，你可以发动“大数”暗置一张手牌来改判",
	
	["#boer"] = "量子诠释",
	["boer"] = "玻尔",
	["bryueqian"] = "跃迁",
	[":bryueqian"] = "<font color=\"blue\"><b>锁定技，</b></font>回合结束时，你须选择两名座位相邻的其他角色，称为“基态”。后一名“基态”回合开始时，视为你对前一名使用【电子跃迁】（不能被【无懈可击】）。一名“基态”死亡时，你须重新选择“基态”。除此法外，两名“基态”不能成为【电子跃迁】的目标。",
	["brqingpu"] = "氢光谱",
	[":brqingpu"] = "你的上下家体力值或上限改变时，你可将体力牌竖置。你需要使用或打出基本牌时，若体力牌竖置，你可横置之并将一张牌作为该基本牌使用或打出。你的上下家濒死结算后，你本回合不能使用该技能。",
	["@bryueqian"] = "你现在可以发动“跃迁”，选择“基态”",
	["~bryueqian"] = "选择角色->确定",
	
	["#keluolf"] = "苏联航天之父",
	["keluolf"] = "科罗廖夫",
	["klweixing"] = "卫星",
	[":klweixing"] = "出牌阶段开始时，若你的武将牌上没有“卫星”，你可将一张牌作为“卫星”置于武将牌上。一名其他角色使用或打出与“卫星”花色相同的牌进入弃牌堆前，你可将“卫星”置于其武将牌上，并选择：视为对其使用【点燃】，或摸一张牌；然后你可将一张牌作为“卫星”置于武将牌上。一名角色判定阶段开始时，若其武将牌上有“卫星”，依次获得之。",
	["kltiance"] = "天测",
	[":kltiance"] = "其他角色使用非装备牌指定你为目标（之一）时，若其上或下家有“卫星”，你可选择一张移到其武将牌上，然后令该牌无效，失去“卫星”的角色可令其摸一张牌。",
	["@satellitelaunch"] = "你现在可以将一张牌作为“卫星”置于武将牌上",
	["@satellite_move"] = "你现在可以对 %src 发动技能，即：将“卫星”置于其武将牌上，并选择：视为对其使用【点燃】，或摸一张牌",
	["~klweixing"] = "选择一张“卫星”->确定",
	["satellite"] = "卫星",
	["kltiance-invoke"] = "你现在可以发动“天测”，移动一张“卫星”并令该牌无效",
	["kldmg"] = "视为使用【点燃】",
	["kldraw"] = "摸一张牌",
	["kltiance:poi"] = "你可令 %src 摸一张牌",
	
	["#adamsmi"] = "国富论",
	["adamsmi"] = "亚当·斯密",
	["adfengong"] = "分工",
	[":adfengong"] = "出牌阶段限一次，你可以令任意名角色选择是否展示一张手牌，若如此做，其下回合出牌阶段，只能使用该种类的牌，使用该种类牌无距离限制，并于结算后摸一张牌。",
	["adshuifu"] = "税赋",
	[":adshuifu"] = "其他角色回合结束时，若其该回合使用过指定你为唯一目标的牌，你可视为对其使用一张【资产分配】。",
	["@fengong_prepare"] = "待工",
	["@fengong_effect"] = "分工",
	["adfengong-show"] = "你可以展示一张手牌以响应亚当·斯密的“分工”",
	
	["#lidaoyuan"] = "山水之叙",
	["lidaoyuan"] = "郦道元",
	["ldshexian"] = "涉险",
	[":ldshexian"] = "<font color=\"blue\"><b>锁定技，</b></font>你于回合外拥有“看破”；当你的体力值为全场唯一最低且手牌不多于体力值时，你不能成为黑色非装备牌的目标。",
	["ldannotate"] = "水经注解",
	[":ldannotate"] = "其他角色的非延时锦囊于其回合内因使用进入弃牌堆时，你可将一张点数不小于其的手牌作为其使用。回合结束时，该角色可令你摸X-1张牌，X为你本回合发动此技能的次数且至少为1。",
	["@ldannotateprompt"] = "你现在可以使用“水经注解”，将一张点数较大的牌当做该牌使用",
	["~ldannotate"] = "点击“水经注解”->选一张牌->使用",
	["ldannotatea"] = "水经注解·摸牌",
	
	["#chenyinke"] = "松高风逸",
	["chenyinke"] = "陈寅恪",
	["cyyuanshi"] = "渊识",
	[":cyyuanshi"] = "摸牌阶段结束时，你可展示任意数量的手牌，每有一种类型，你摸一张牌，每有一种花色，你本回合手牌上限便+1。本回合以此法展示过的类型或花色的牌，下回合不可以此法展示。",
	["cymingdao"] = "名导",
	[":cymingdao"] = "<font color=\"blue\"><b>锁定技，</b></font>其他角色回合结束时，若你手牌数大于体力上限且上回合发动过“渊识”，你弃置手牌至相等，然后令至多X名有手牌的其他角色依次展示一张手牌，若此牌与你弃置牌中的任一张花色/点数相同，其/你摸一张牌。 （X为你因此弃置的牌数）",
	["@cymingdao"] = "你现在需要弃置一定数量的牌并选择至多等量其他角色，发动“名导”",
	["~cymingdao"] = "选择手牌至“确定”亮起->选择角色->确定",
	["cyyuanshiprompt"] = "你现在可以展示任意数量符合条件的手牌以发动“渊识”",
	
	["#linhuiyin"] = "人间四月天",
	["linhuiyin"] = "林徽因",
	[":lymiansu"] = "弃牌阶段开始时，你可以将一张红色手牌当做【乐不思蜀】使用，并将武将牌横置/重置，若为重置则流失1点体力；然后你可重复此流程。",
	["lymiansu"] = "缅愫",
	["lyguijian"] = "闺笺",
	[":lyguijian"] = "一名角色成为一张延时锦囊牌的首名目标后，你可以选择一项：摸一张牌并交给其一张牌；或弃置其一张牌。",
	["lyyingzao"] = "营造",
	[":lyyingzao"] = "当你成为其他角色黑色基本牌的目标时，你可以取消之，若如此做，该牌进入弃牌堆时，你将其作为【乐不思蜀】对自己使用。<font color=\"blue\"><b>锁定技，</b></font>你的♦判定牌视为红桃。你的判定区有牌时，你不能成为其他角色黑色基本牌的目标。",
	["@lyguijian-give"] = "你现在需要交给 %src 一张牌",
	["@lymiansu-card"] = "你现在可以发动“缅愫”，将红色手牌当做【乐不思蜀】使用",
	["gjDraw"] = "摸一张牌并交给其一张牌",
	["gjDiscard"] = "弃置其一张牌",
	["gjCancel"] = "不发动“闺笺”",
	
	["#adlovelace"] = "数字女王",
	["adlovelace"] = "阿达·洛芙莱斯",
	["adchengshi"] = "程式",
	[":adchengshi"] = "游戏开始时，你额外摸两张牌，并将两张牌扣置于武将牌上，称为“码”。受到伤害后，你可使用任意张“码”，然后可将剩余的“码”置入弃牌堆并用牌堆顶的两张牌代替之。判定阶段结束时，你可以用手牌替换任意张“码”。",
	["codes"] = "码",
	["@adchengshiUse"] = "你现在可以使用任意张“码”",
	["@adchengshi-exchange"] = "你现在可以重新扣置等量“码”",
	["~adchengshi"] = "选牌->确定",
	["adchengshidmgexc"] = "程式·补充“码”",
	["adxunhuan"] = "循环",
	[":adxunhuan"]= "其他角色回合开始时，若你武将牌正面朝上，你可以弃置一张基本牌“码”或非延时锦囊“码”，并摸一张牌。若如此做，将武将牌翻面，本回合摸牌/出牌阶段结束时，你可以视为使用该“码”。",
	["@adxunhuan-ask"] = "你可以用一张“码”发动“循环”",
	["@adxunhuan-askb"] = "你现在可以视为使用一张 %src",
	["~adxunhuan"] = "选牌/目标->确定",
	
	["#morgan"] = "蝇室生辉",
	["morgan"] = "摩尔根",
	["mgliansuo"] = "遗传连锁",
	[":mgliansuo"] = "你一次获得至少两张牌后，可以展示之，若其中有点数差不大于2的两张牌，你摸两张牌。",
	["mgbianyi"] = "基因变异",
	[":mgbianyi"] = "其他角色回合结束时，你可以弃置至少一张基本牌并摸等量的牌，若如此做，你可将一张延时锦囊牌或装备牌当【白眼果蝇】使用。",
	["mgbianyiask"] = "你现在可以弃置任意张基本牌，以发动“基因变异”",
	["@mgbianyiprompt"] = "你现在可以将一张延时锦囊牌或装备牌当【白眼果蝇】使用",
	
	["#zhangailin"] = "人间遗华",
	["zhangailin"] = "张爱玲",
	["zasuxu"] = "俗叙",
	[":zasuxu"] = "回合开始时，你可以观看未上场或已死亡的三张随机女武将牌，弃置零至二张手牌以获得其中等量技能（限定技、觉醒技、主公技除外），直至回合结束。若因此获得技能，回合结束前你摸一张牌。",
	["zahongye"] = "红靥",
	[":zahongye"] = "<font color=\"purple\"><b>觉醒技，</b></font>你成为红色牌的目标后，若因“俗叙”获得过大于两名角色的技能，你减1点体力上限，摸两张牌，然后获得“<font color=\"brown\"><b>悟人</b></font>”。\
	<font color=\"brown\"><b>悟人</b></font>：一名其他角色于回合内首次使用基本牌或非延时锦囊牌指定目标时，你可以展示一张该颜色的牌，令一名其他角色成为该牌额外目标（无距离限制），若如此做，你在你下回合开始前不能以此法展示该颜色的牌。",
	["zawuren"] = "悟人",
	[":zawuren"] = "一名其他角色于回合内首次使用基本牌或非延时锦囊牌指定目标时，你可以展示一张该颜色的牌，令一名其他角色成为该牌额外目标（无距离限制），若如此做，你在你下回合开始前不能以此法展示该颜色的牌。",
	["@suxucnt"] = "俗叙计数",
	["@zawurencard"] = "你现在可以展示一张手牌以发动“悟人”",
	["~zawuren"] = "选择手牌->选择额外目标->确定",
}
	
sgs.LoadTranslationTable{	
	["#weather_ask"] = "%from 选择了 %arg",
	["#weather_yes"] = "%arg 人同意，%arg2 人不同意，天气模式开启！ ",
	["#weather_no"] = "%arg 人同意，%arg2 人不同意，天气模式未开启！",
	["#weather_keep"] = "天气持续！仍然是 %arg 。",
	["#weather_change"] = "天气由 %arg 变为 %arg2 ！",
	["#weather_draw"] = "受天气影响， %from 将额外摸一张牌！",
	["#weather_nodraw"] = "受干旱天气影响，%from 将少摸一张牌！",
	["#weather_wind"] = "受大风天气影响，%from 将弃置一张牌！",
	["#weather_thunder"] = "受雷暴天气影响，%from 将进行一次判定，若为黑桃，则其将受到2点伤害；若为梅花则为1点！",
	["#weather_elnino"] = "受厄尔尼诺影响，所有人将重新排列座位！",
	["#weather_snow"] = "受大雪天气影响，%from 将展示所有手牌！",
	["#weather_bingbao"] = "受冰雹天气影响，%from 须弃置一张装备牌，否则将受到1点伤害！",
	["#weather_cloud"] = "受微云天气影响，%from 将把一张牌置于牌堆顶！",
	["#weather_suddenrain"] = "受骤雨天气影响，%from 对 %to 造成的 %arg 点火焰伤害将降为 %arg2 点！",
	["#weather_hotter"] = "受燥热天气影响，%from 对 %to 造成的 %arg 点火焰伤害将上升为 %arg2 点！",
	["#weather_hotterb"] = "受燥热天气影响，%from 对 %to 造成的 %arg 点伤害将有几率上升为 %arg2 点！",
	["#weather_sandstorm"] = "受沙暴天气影响，%from 对 %to 造成的 %arg 点伤害有几率降为 %arg2 点！",
	["#weather_foggy"] = "受浓雾天气影响，%from 对 %to 使用的【杀】有几率无法用【闪】响应！",
	["#weather_sunny"] = "受晴岚天气影响，%from 对 %to 使用的【杀】有几率失效！",
	["#weather_hotdisaster"] = "受酷暑天气影响，%from 此次回复的体力将从 %arg 点上升为 %arg2 点！",
	["#weather_baofengxue"] = "受暴风雪天气影响，由于使用了%card ，结算结束后 %from 有几率结束回合。",
	["#weatherer"] = "【平常对局禁用】",
	["weatherer"] = "气象调试员",
	["weatheradjust"] = "变天",
	[":weatheradjust"] = "<b>锁定技，</b></font>一名角色的回合开始时，你必须强行开启天气模式，并指定一个天气。",
	["#tester"] = "【平常对局禁用】",
	["tester"] = "程序测试",
	["tktest"] = "测试",
	[":tktest"] = "出牌阶段，你可以运行写好的代码。",
	["@tkbaofengxue"] = "暴风雪",
	["@tkbigwind"] = "大风",
	["@tkbingbao"] = "冰雹",
	["@tkcloud"] = "微云",
	["@tkdry"] = "干旱",
	["@tkelnino"] = "厄尔尼诺",
	["@tkfoggy"] = "浓雾",
	["@tkhotdisaster"] = "酷暑",
	["@tkhotsun"] = "烈日",
	["@tkhotter"] = "燥热",
	["@tkmist"] = "薄雾",
	["@tkrain"] = "细雨",
	["@tksandfly"] = "扬沙",
	["@tksandstorm"] = "沙暴",
	["@tksnow"] = "大雪",
	["@tksuddenrain"] = "骤雨",
	["@tksunny"] = "晴岚",
	["@tkthunder"] = "雷暴",
	["@tktyphoon"] = "台风",
	["askweather"] = "是否同意开启天气模式",
	["agree"] = "同意",
	["disagree"] = "不同意",
	["weathereffect"] = "天气效果",
	["@tkbingbaoask"] = "受 冰雹 天气影响，你须弃置一张装备牌，否则将受到1点伤害！",
	["@tkcloudask"] = "受 微云 天气影响，你须将一张牌置于牌堆顶！",
	["#tkeinform"] = "%arg2 翻开的牌是 %card , %arg 效果触发！",
	["#tkxinform"] = "%arg2 翻开的牌是 %card , %arg 效果未触发！",
	["#tkgaoliang"] = "<font color=\"#00BFFF\"><b>★★</b></font>",
	["@tkbaofengxueeffe"] = "天气名称：暴风雪\
	天气效果：角色的牌在回合内因\
	使用而进入弃牌堆并结算后，翻\
	开牌堆顶的一张牌，若与该牌花\
	色相同，则其立即结束该回合。",
	["@tkbigwindeffe"] = "天气名称：大风\
	天气效果：回合结束阶段开始时，\
	当前角色弃一张牌。",
	["@tkbingbaoeffe"] = "天气名称：冰雹\
	天气效果：出牌阶段开始时，\
	当前角色须弃一张装备牌，\
	否则受到1点伤害。",
	["@tkcloudeffe"] = "天气名称：微云\
	天气效果：摸牌阶段额外\
	摸一张牌，\
	并在该阶段结束后将一张牌置于牌堆顶。",
	["@tkdryeffe"] = "天气名称：干旱\
	天气效果：摸牌阶段少摸一张牌。",
	["@tkelninoeffe"] = "天气名称：厄尔尼诺\
	天气效果：主公回合开始/结束时，\
	全场所有人随机排位。",
	["@tkfoggyeffe"] = "天气名称：浓雾\
	天气效果：对攻击范围不包括自己的\
	角色使用杀后，翻开牌堆顶一张牌，\
	颜色相同则不能用【闪】响应。",
	["@tkhotdisastereffe"] = "天气名称：酷暑\
	天气效果：使用【桃】额外回复\
	1点体力。",
	["@tkhotsuneffe"] = "天气名称：烈日\
	天气效果：场上所有牌的流动都\
	会被看见。",
	["@tkhottereffe"] = "天气名称：燥热\
	天气效果：火焰伤害+1；造成非火\
	焰伤害时翻开牌堆顶一张牌，\
	为红则伤害+1。",
	["@tkmisteffe"] = "天气名称：薄雾\
	天气效果：无",
	["@tkraineffe"] = "天气名称：细雨\
	天气效果：摸牌阶段额外摸一张牌。",
	["@tksandflyeffe"] = "天气名称：扬沙\
	天气效果：攻击范围-X，X为体力值。",
	["@tksandstormeffe"] = "天气名称：沙暴\
	天气效果：大于1点的伤害-1。",
	["@tksnoweffe"] = "天气名称：大雪\
	天气效果：摸牌阶段开始时展示手牌。",
	["@tksuddenraineffe"] = "天气名称：骤雨\
	天气效果：造成火焰伤害时翻开牌堆\
	顶一张牌，不为红桃则伤害-1。",
	["@tksunnyeffe"] = "天气名称：晴岚\
	天气效果：对攻击范围不包括自己\
	的角色使用杀后，翻开牌堆顶一张牌\
	，颜色不同则失效。",
	["@tkthundereffe"] = "天气名称：雷暴\
	天气效果：回合开始时判定，若为黑\
	则受到1-2点雷电伤害。",
	["@tktyphooneffe"] = "天气名称：台风\
	天气效果：不能使用非延时锦囊。",
	
	["surveyStart"] = "支持索尔维会议",
	["#survey_ask"] = "%from 表示支持索尔维会议",
	["#surveyModeStart"] = "<font color=\"yellow\"><b>索尔维会议开始！</b></font>",
	["$WelcomeTosurvey"] = "欢迎来到索尔维会议模式！",
	["surveyDraw"] = "索尔维会议·摸牌",
	["surveyWar"] = "索尔维会议·战乱",
	["surveyArgue"] = "索尔维会议·学派交锋",
	["@surveyWar"] = "你现在可以使用一张手牌",
	["@surveyWardis"] = "你现在须弃置一张牌",
	["#survey_draw"] = "%from <font color=\"#B7FF4A\">进行了会议的筹备工作！</font>",
	["#survey_war"] = "%from <font color=\"#FF9D6F\">试图在会议期间挑起战争！</font>",
	["#survey_argue"] = "%from <font color=\"#FF95CA\">在会议上提出的观点引起了争论！</font>",
	["#surveyWar"] = "战乱",
}
