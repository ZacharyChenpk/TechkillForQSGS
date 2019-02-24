sgs.dynamic_value.control_usecard.Zuhua = true
sgs.dynamic_value.damage_card.Acid = true
sgs.dynamic_value.damage_card.Alkali = true
sgs.dynamic_value.control_card.Wangshui = true
sgs.dynamic_value.control_card.Laman = true
sgs.dynamic_value.control_card.Lengning = true
sgs.dynamic_value.damage_card.Sizao = true
sgs.dynamic_value.damage_card.Fireup = true
sgs.dynamic_value.benefit.Zhihuanfy = true
sgs.dynamic_value.benefit.C6 = true
sgs.dynamic_value.lucky_chance.Jieziq = true
sgs.dynamic_value.control_usecard.Hetongbh = true
sgs.dynamic_value.control_card.Mianyy = true
sgs.ai_keep_value.Jieziq = -1

sgs.weapon_range.aciddd = 1
sgs.ai_use_priority.aciddd = sgs.ai_use_priority.Crossbow
sgs.weapon_range.alkalidd = 1
sgs.ai_use_priority.alkalidd = sgs.ai_use_priority.Crossbow
sgs.weapon_range.shiguan = 2
sgs.ai_use_priority.shiguan = 2.683
sgs.weapon_range.phji = 3
sgs.ai_use_priority.phji = 2.689
sgs.weapon_range.jiujingdeng = 3
sgs.ai_use_priority.jiujingdeng = 2.7

sgs.ai_use_priority.bolisai = 0.81
sgs.ai_use_priority.fhf = 0.91
sgs.ai_use_priority.lengjing = 0.79
sgs.ai_use_priority.peaceagree = 1.1

tableIndexOf = function(theqlist, theitem)
	local index = 0
	for _, item in ipairs(theqlist) do
		if item == theitem then return index end
		index = index + 1
	end
end

function SmartAI:useCardC6(card, use)
	if self.player:isWounded() then
		use.card = card
	end
	return
end

sgs.ai_card_intention.C6 = -80
sgs.ai_keep_value.C6 = 3.9
sgs.ai_use_value.C6 = 10
sgs.ai_use_priority.C6 = 5

function SmartAI:useCardAcid(acid, use)
	if not(self.player:usedTimes("Acid") + self.player:usedTimes("Alkali") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, self.player , acid) or (self.player:getWeapon() and self.player:getWeapon():isKindOf("aciddd"))) then return end
	if self.player:getArmor() and self.player:getArmor():isKindOf("fhf") then return end
	local targets = sgs.SPlayerList()
	for _, enemy in ipairs(self.enemies) do
		if not self.room:isProhibited(self.player, enemy,acid)
		--and sgs.isGoodTarget(enemy, self.enemies, self, false) 
		then
			if self:damageIsEffective(enemy,sgs.DamageStruct_Normal,self.player) and (not enemy:hasFlag("bls"))  then --*
				if self.player:distanceTo(enemy)<= self.player:getAttackRange() + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_DistanceLimit,self.player, acid)
				and not(enemy:getArmor() and enemy:getArmor():isKindOf("fhf")) then
					targets:append(enemy)
				end
			end
		end
	end
	if targets:length() == 0 then return end
	local dfs = function(a, b)
		local v1 = getCardsNum("Alkali", a) + a:getHp()
		local v2 = getCardsNum("Alkali", b) + b:getHp()

		if (not self:isWeak(a)) and a:hasSkill("jianxiong") and not self.player:hasSkill("jueqing") then v1 = v1 + 10 end
		if (not self:isWeak(b)) and b:hasSkill("jianxiong") and not self.player:hasSkill("jueqing") then v2 = v2 + 10 end

		if self:needToLoseHp(a) then v1 = v1 + 5 end
		if self:needToLoseHp(b) then v2 = v2 + 5 end

		if self:hasSkills(sgs.masochism_skill, a) then v1 = v1 + 7 end
		if self:hasSkills(sgs.masochism_skill, b) then v2 = v2 + 7 end

		return v1 < v2
	end
	targets = sgs.QList2Table(targets)
	table.sort(targets, dfs)
	for _, enemy in ipairs(targets) do
		target = enemy
		break
	end
	use.card = acid
	if use.to then
		use.to:append(target)
	end
	--[[while use.to:length() < sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, self.player, acid) and (not targets:isEmpty()) do
		table.removeOne(targets,target)
		for _, enemy in ipairs(targets) do
			target = enemy
			break
		end
		if use.to then
			use.to:append(target)
		end
	end]]--
end

sgs.ai_skill_cardask["@alkalitoacid"]=function(self) -- 仅仅用到了第一个参数 self，后面的都可以省略
	local cards = sgs.QList2Table(self.player:getHandcards()) -- 获得手牌的表
	local card_id = "."
	for _, cd in ipairs(cards) do
		if cd:isKindOf("Alkali") then
			card_id = "$" .. cd:getId()
		end
	end
	if (not self:damageIsEffective(self.player,sgs.DamageStruct_Normal,self.room:getCurrent()))
	or self.player:hasFlag("bls") then return "." end
	return card_id
end

sgs.ai_skill_cardask["@acidtoalkali"]=function(self) -- 仅仅用到了第一个参数 self，后面的都可以省略
	local cards = sgs.QList2Table(self.player:getHandcards()) -- 获得手牌的表
	local card_id = "."
	for _, cd in ipairs(cards) do
		if cd:isKindOf("Acid") then
			card_id = "$" .. cd:getId()
		end
	end
	if (not self:damageIsEffective(self.player,sgs.DamageStruct_Normal,self.room:getCurrent()))
	or self.player:hasFlag("bls") then return "." end
	return card_id
end

sgs.ai_skill_cardask["@alkalitoacidfly"]=function(self) -- 仅仅用到了第一个参数 self，后面的都可以省略
	local cards = sgs.QList2Table(self.player:getHandcards()) -- 获得手牌的表
	local card_id = "."
	for _, cd in ipairs(cards) do
		if cd:isKindOf("Alkali") then
			card_id = "$" .. cd:getId()
		end
	end
	if (not self:damageIsEffective(self.player,sgs.DamageStruct_Normal,self.room:getCurrent()))
	or self.player:hasFlag("bls") then return "." end
	return card_id
end

sgs.ai_skill_cardask["@acidtoalkalifly"]=function(self) -- 仅仅用到了第一个参数 self，后面的都可以省略
	local cards = sgs.QList2Table(self.player:getHandcards()) -- 获得手牌的表
	local card_id = "."
	for _, cd in ipairs(cards) do
		if cd:isKindOf("Acid") then
			card_id = "$" .. cd:getId()
		end
	end
	if (not self:damageIsEffective(self.player,sgs.DamageStruct_Normal,self.room:getCurrent()))
	or self.player:hasFlag("bls") then return "." end
	return card_id
end

sgs.ai_skill_use.Zheshe = function(self, prompt)
	local hasenemy = false
	local hasfriend = false
	local useto = nil
	local usec = nil
	local enemylist = {}
	local friendlist = {}
	local zheshes = self:getCards("Zheshe")
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if p:getSeat() == math.mod(self.player:getSeat(),self.player:aliveCount())+1 or self.player:getSeat() == math.mod(p:getSeat(),self.player:aliveCount())+1 then
			if self:isFriend(p) then
				hasfriend = true
				table.insert(friendlist,p)
			else
				hasenemy = true
				table.insert(enemylist,p)
			end
		end
	end
	local use = self.player:property("zhesheing"):toCardUse()
	if use.card:isKindOf("Peach") or use.card:isKindOf("Analeptic") or use.card:isKindOf("C6") then return "." end
	local notdmged = function(pl)
		return (not self:damageIsEffective(pl,sgs.DamageStruct_Normal,use.from)) and (not self:damageIsEffective(pl,sgs.DamageStruct_Fire,use.from)) and (not self:damageIsEffective(self.player,sgs.DamageStruct_Thunder,use.from))
	end
	if notdmged(self.player) then return "." end
	if hasenemy then
		if #enemylist > 1 then
			if (self:isWeak(enemylist[1]) and (not self:isWeak(enemylist[2]))) or notdmged(enemylist[2]) then
				if (not notdmged(enemylist[1])) and not ((use.card:isKindOf("Slash") and getCardsNum("Jink", self.player) >= 1) or (use.card:isKindOf("Acid") and getCardsNum("Alkali", self.player) >= 1) or (use.card:isKindOf("Alkali") and getCardsNum("Acid", self.player) >= 1)) then
					useto = enemylist[1]
				end
			else
				useto = enemylist[2]
			end
		elseif #enemylist == 1 then
			useto = enemylist[1]
		end
	else
		if (use.card:isKindOf("Slash") and getCardsNum("Jink", self.player) >= 1) or (use.card:isKindOf("Acid") and getCardsNum("Alkali", self.player) >= 1) or (use.card:isKindOf("Alkali") and getCardsNum("Acid", self.player) >= 1) then
			return "."
		else
			if notdmged(friendlist[1]) then
				useto = friendlist[1]
			elseif notdmged(friendlist[2]) then
				useto = friendlist[2]
			else
				if not self:isWeak(self.player) then
					return "."
				else
					if self:isWeak(friendlist[1]) and self:isWeak(friendlist[2]) then
						return "."
					elseif not self:isWeak(friendlist[1]) then
						useto = friendlist[1]
					else
						useto = friendlist[2]
					end
				end
			end
		end
	end
	for _,zs in ipairs(zheshes) do
		if not self.room:isProhibited(self.player, useto, zs) then usec = zs:toString() break end
	end
	if useto and usec then return usec .. "->" .. useto:objectName() end
	return "."
end

sgs.ai_use_value.Zheshe = 9.5
sgs.ai_keep_value.Zheshe = 7.7

function SmartAI:useCardAlkali(acid, use)
	use.to = sgs.SPlayerList()
	if not(self.player:usedTimes("Alkali") + self.player:usedTimes("Acid") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, self.player , acid) or (self.player:getWeapon() and self.player:getWeapon():isKindOf("alkalidd"))) then return end
	if self.player:getArmor() and self.player:getArmor():isKindOf("fhf") then return end
	local targets = sgs.SPlayerList()
	for _, enemy in ipairs(self.enemies) do
		if not self.room:isProhibited(self.player, enemy,acid)
		--and sgs.isGoodTarget(enemy, self.enemies, self, false) 
		then
			if self:damageIsEffective(enemy,sgs.DamageStruct_Normal,self.player) and (not enemy:hasFlag("bls")) then --*
				if self.player:distanceTo(enemy)<= self.player:getAttackRange() + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_DistanceLimit,self.player, acid)
				and not(enemy:getArmor() and enemy:getArmor():isKindOf("fhf")) then
					targets:append(enemy)
				end
			end
		end
	end
	if targets:length() == 0 then return end
	local dfs = function(a, b)
		local v1 = getCardsNum("Acid", a) + a:getHp()
		local v2 = getCardsNum("Acid", b) + b:getHp()

		if (not self:isWeak(a)) and a:hasSkill("jianxiong") and not self.player:hasSkill("jueqing") then v1 = v1 + 10 end
		if (not self:isWeak(b)) and b:hasSkill("jianxiong") and not self.player:hasSkill("jueqing") then v2 = v2 + 10 end

		if self:needToLoseHp(a) then v1 = v1 + 5 end
		if self:needToLoseHp(b) then v2 = v2 + 5 end

		if self:hasSkills(sgs.masochism_skill, a) then v1 = v1 + 7 end
		if self:hasSkills(sgs.masochism_skill, b) then v2 = v2 + 7 end

		return v1 < v2
	end
	targets = sgs.QList2Table(targets)
	table.sort(targets, dfs)
	if #targets == 0 then return end
	use.card = acid
	if use.to then
		for _, enemy in ipairs(targets) do
			if use.to:length() <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, self.player, acid) then
				use.to:append(enemy)
			end
		end
	end
	return
end

sgs.ai_use_value.Acid = 4.5
sgs.ai_keep_value.Acid = 4.55
sgs.ai_use_priority.Acid = 3.5

sgs.ai_use_value.Alkali = 4.6
sgs.ai_keep_value.Alkali = 4.54
sgs.ai_use_priority.Alkali = 3.6

function SmartAI:useCardZuhua(card, use)
	local enemies = {}
	if self.room:isProhibited(self.player, self.player, card) then return end

	if #self.enemies == 0 then
		if sgs.turncount <= 1 and self.role == "lord" and not sgs.isRolePredictable()
			and sgs.evaluatePlayerRole(self.player:getNextAlive()) == "neutral"
			and not (self.player:hasLordSkill("shichou") and self.player:getNextAlive():getKingdom() == "shu") then
			enemies = self:exclude({self.player:getNextAlive()}, card)
		end
	else
		enemies = self:exclude(self.enemies, card)
	end

	local zhanghe = self.room:findPlayerBySkillName("qiaobian")
	local zhanghe_seat = zhanghe and zhanghe:faceUp() and not zhanghe:isKongcheng() and not self:isFriend(zhanghe) and zhanghe:getSeat() or 0

	local sb_daqiao = self.room:findPlayerBySkillName("yanxiao")
	local yanxiao = sb_daqiao and not self:isFriend(sb_daqiao) and sb_daqiao:faceUp() and
					(getKnownCard(sb_daqiao, self.player, "diamond", nil, "he") > 0
					or sb_daqiao:getHandcardNum() + self:ImitateResult_DrawNCards(sb_daqiao, sb_daqiao:getVisibleSkillList(true)) > 3
					or sb_daqiao:containsTrick("YanxiaoCard"))

	if #enemies == 0 then return end

	local getvalue = function(enemy)
		if enemy:containsTrick("Zuhua") or enemy:containsTrick("zuhua") or enemy:hasSkill("neojushou") or enemy:hasSkill("jushou") or enemy:hasSkill("toudu") or enemy:hasSkill("renxin") then return -100 end
		if enemy:hasSkill("qiaobian") and not enemy:containsTrick("supply_shortage") and not enemy:containsTrick("indulgence") then return -100 end
		if zhanghe_seat > 0 and (self:playerGetRound(zhanghe) <= self:playerGetRound(enemy) and self:enemiesContainsTrick() <= 1 or not enemy:faceUp()) then
			return -100 end
		if yanxiao and (self:playerGetRound(sb_daqiao) <= self:playerGetRound(enemy) and self:enemiesContainsTrick(true) <= 1 or not enemy:faceUp()) then
			return -100 end

		local value = 2 + (enemy:getHandcardNum()/2) - enemy:getHp()
		
		if enemy:hasSkills("noslijian|lijian|fanjian|neofanjian|dimeng|jijiu|jieyin|anxu|yongsi|zhiheng|manjuan|nosrende|rende|qixi|jixi") then value = value + 10 end
		if enemy:hasSkills("houyuan|qice|guose|duanliang|yanxiao|nosjujian|luoshen|nosjizhi|jizhi|jilve|wansha|mingce") then value = value + 5 end
		if enemy:hasSkills("jiushi|sizhan") then value = value - 10 end
		if self:isWeak(enemy) then value = value + 3 end
		if enemy:isLord() then value = value + 3 end

		if self:objectiveLevel(enemy) < 3 then value = value - 10 end
		if enemy:hasSkills("keji|shensu|conghui") then value = value - enemy:getHandcardNum() end
		if enemy:hasSkills("guanxing|xiuluo") then value = value - 5 end
		if enemy:hasSkills("lirang|longluo") then value = value - 5 end
		if enemy:hasSkills("tuxi|noszhenlie|guanxing|qinyin|zongshi|tiandu") then value = value - 3 end
		if enemy:hasSkill("conghui") then value = value - 20 end
		if self:needBear(enemy) then value = value - 20 end
		if not sgs.isGoodTarget(enemy, self.enemies, self) then value = value - 1 end
		value = value + (self.room:alivePlayerCount() - self:playerGetRound(enemy)) / 2
		return value
	end

	local cmp = function(a,b)
		return getvalue(a) > getvalue(b)
	end

	table.sort(enemies, cmp)

	local target = enemies[1]
	if getvalue(target) > -100 then
		use.card = card
		if use.to then use.to:append(target) end
		return
	end
end

sgs.ai_use_value.Zuhua = 9
sgs.ai_use_priority.Zuhua = 0.7
sgs.ai_card_intention.Zuhua = 120
sgs.ai_keep_value.Zuhua = 3.9

function SmartAI:useCardWangshui(card, use)
	local enemies = {}
	if self.room:isProhibited(self.player, self.player, card) then return end

	if #self.enemies == 0 then
		return
	else
		enemies = self:exclude(self.enemies, card)
	end

	local getvalue = function(enemy,selp)
		if enemy:isNude() then return -100 end
		local value = 0
		if (enemy:getHandcardNum() + enemy:getEquips():length()) > 1 then
			value = 1
			if (enemy:getHandcardNum() + enemy:getEquips():length()) > 4 then
				value = 2
				if enemy:hasSkill("jieyuan") and enemy:getHp()<selp:getHp() then value = value - 2 end
				if enemy:hasSkill("nosdanshou") then value = value - (2 - selp:getHandcardNum() + selp:getHp()) end
				if enemy:hasSkills("kuanggu|kofkuanggu") and enemy:distanceTo(selp) <= 1 and enemy:isWounded() then value = value - 2 end
				if enemy:hasSkill("zhiman") then value = value - 1 end
			end
			if self:isWeak(selp) and (not self.player:hasFlag("bls")) then return -100 end
		else
			value = 1
		end
		
		if self:hasSkills(sgs.masochism_skill, selp) then value = value + 2 end
		
		if enemy:hasSkill("tuntian|wuzhishouheng") then value = value - 3 end
		if enemy:hasSkills("lirang|longluo") then value = value - 4 end
		if not sgs.isGoodTarget(enemy, self.enemies, self) then value = value - 1 end
		return value
	end

	local cmp = function(a,b)
		return getvalue(a,self.player) > getvalue(b,self.player)
	end

	table.sort(enemies, cmp)

	local target = enemies[1]
	if getvalue(target) > 0 then
		use.card = card
		if use.to then use.to:append(target) end
		return
	end
end

sgs.ai_use_value.Wangshui = 6.5
sgs.ai_use_priority.Wangshui = 4.35
sgs.ai_keep_value.Wangshui = 3.3
sgs.ai_card_intention.FireAttack = 100

function SmartAI:useCardSizao(sizao, use)
	if self.room:isProhibited(self.player, self.player, sizao) then return end
	if self.player:hasSkill("wuyan") and not self.player:hasSkill("jueqing") then return end
	if self.player:hasSkill("noswuyan") then return end

	local enemies = self:exclude(self.enemies, sizao)
	local friends = self:exclude(self.friends_noself, sizao)
	local n1 = getCardsNum("Acid",self.player) + getCardsNum("Alkali",self.player)
	local huatuo = self.room:findPlayerBySkillName("jijiu")
	local targets = {}

	local canUsesizaoTo=function(target)
		return self:hasTrickEffective(sizao, target) and self:damageIsEffective(target,sgs.DamageStruct_Normal) and not self.room:isProhibited(self.player, target, sizao) and (not target:hasFlag("bls"))
	end

	for _, friend in ipairs(friends) do
		if (not use.current_targets or not table.contains(use.current_targets, friend:objectName()))
			and friend:hasSkill("jieming") and canUsesizaoTo(friend) and self.player:hasSkill("nosrende") and (huatuo and self:isFriend(huatuo)) then
			table.insert(targets, friend)
		end
	end

	for _, enemy in ipairs(enemies) do
		if (not use.current_targets or not table.contains(use.current_targets, enemy:objectName()))
			and canUsesizaoTo(enemy) then
			table.insert(targets, enemy)
		end
	end

	local cmp = function(a, b)
		local v1 = getCardsNum("Acid", a) + getCardsNum("Alkali", a) + a:getHp()
		local v2 = getCardsNum("Alkali", b) + getCardsNum("Acid", b) + b:getHp()

		if self:getDamagedEffects(a, self.player) then v1 = v1 + 20 end
		if self:getDamagedEffects(b, self.player) then v2 = v2 + 20 end

		if not self:isWeak(a) and a:hasSkill("jianxiong") and not self.player:hasSkill("jueqing") then v1 = v1 + 10 end
		if not self:isWeak(b) and b:hasSkill("jianxiong") and not self.player:hasSkill("jueqing") then v2 = v2 + 10 end

		if self:needToLoseHp(a) then v1 = v1 + 5 end
		if self:needToLoseHp(b) then v2 = v2 + 5 end

		if self:hasSkills(sgs.masochism_skill, a) then v1 = v1 + 5 end
		if self:hasSkills(sgs.masochism_skill, b) then v2 = v2 + 5 end
		
		if self:isFriend(a) then return true end

		if v1 == v2 then return math.abs(getCardsNum("acid", a) - getCardsNum("alkali", a)) < math.abs(getCardsNum("acid", b) - getCardsNum("alkali", b)) end

		return v1 < v2
	end

	table.sort(targets, cmp) 
	local target = targets[1]
	if (not self:isWeak(self.player)) and target then
		use.card = sizao
		if use.to then use.to:append(target) end
		return
	end
end

sgs.ai_use_value.Sizao = 4.1
sgs.ai_use_priority.Sizao = 3.11
sgs.ai_keep_value.Sizao = 3.47
sgs.ai_card_intention.FireAttack = 110

function SmartAI:useCardLengning(card, use)
	if self.room:isProhibited(self.player, self.player, card) then return end
	local players = self.room:getOtherPlayers(self.player)
	local tricks
	local isDiscard = false
	local usecard = false

	local targets = {}
	local targets_num = isSkillCard and 1 or (1 + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, self.player, card))
	if use.isDummy and use.extra_target then targets_num = targets_num + use.extra_target end
	local lx = self.room:findPlayerBySkillName("huangen")

	local addTarget = function(player, cardid)
		if not table.contains(targets, player:objectName())
			and (not use.current_targets or not table.contains(use.current_targets, player:objectName()))
			and not (use.to and use.to:length() > 0 and player:hasSkill("danlao"))
			and not (use.to and use.to:length() > 0 and lx and self:isEnemy(lx) and lx:getHp() > targets_num / 2)
			then
			if not usecard then
				use.card = card
				usecard = true
			end
			table.insert(targets, player:objectName())
			if usecard and use.to and use.to:length() < targets_num then
				use.to:append(player)
				if not use.isDummy then
					if use.to:length() == 1 then self:speak("hostile", self.player:isFemale()) end
				end
			end
			if #targets == targets_num then return true end
		end
	end

	players = self:exclude(players, card)
	
	local enemies = {}
	if #self.enemies == 0 and self:getOverflow() > 0 then
		local lord = self.room:getLord()
		for _, player in ipairs(players) do
			if not self:isFriend(player) then
				if lord and self.player:isLord() then
					local kingdoms = {}
					if lord:getGeneral():isLord() then table.insert(kingdoms, lord:getGeneral():getKingdom()) end
					if lord:getGeneral2() and lord:getGeneral2():isLord() then table.insert(kingdoms, lord:getGeneral2():getKingdom()) end
					if not table.contains(kingdoms, player:getKingdom()) and not lord:hasSkill("yongsi") then table.insert(enemies, player) end
				elseif lord and player:objectName() ~= lord:objectName() then
					table.insert(enemies, player)
				elseif not lord then
					table.insert(enemies, player)
				end
			end
		end
		enemies = self:exclude(enemies, card)
		local temp = {}
		for _, enemy in ipairs(enemies) do
			if enemy:hasSkills("tuntian+guidao") and enemy:hasSkills("zaoxian|jixi|zhiliang|leiji|nosleiji") then continue end
			if self:hasTrickEffective(card, enemy) or isSkillCard then
				table.insert(temp, enemy)
			end
		end
		enemies = temp
		self:sort(enemies, "defense")
		enemies = sgs.reverse(enemies)
	else
		enemies = self:exclude(self.enemies, card)
		local temp = {}
		for _, enemy in ipairs(enemies) do
			if enemy:hasSkills("tuntian+guidao") and enemy:hasSkills("zaoxian|jixi|zhiliang|leiji|nosleiji") then continue end
			if self:hasTrickEffective(card, enemy) or isSkillCard then
				table.insert(temp, enemy)
			end
		end
		enemies = temp
		self:sort(enemies, "defense")
	end

	if self:slashIsAvailable() then
		local dummyuse = { isDummy = true, to = sgs.SPlayerList() }
		self:useCardSlash(sgs.Sanguosha:cloneCard("slash"), dummyuse)
		if not dummyuse.to:isEmpty() then
			local tos = self:exclude(dummyuse.to, card)
			for _, to in ipairs(tos) do
				if to:getHandcardNum() == 1 and to:getHp() <= 2 and self:hasLoseHandcardEffective(to) and not to:hasSkills("kongcheng|tianming")
					and (not self:hasEightDiagramEffect(to) or IgnoreArmor(self.player, to)) then
					if addTarget(to, to:getRandomHandCardId()) then return end
				end
			end
		end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:isNude() then
			local dangerous = self:getDangerousCard(enemy)
			if dangerous and (not isDiscard or self.player:canDiscard(enemy, dangerous)) then
				if addTarget(enemy, dangerous) then return end
			end
		end
	end

	self:sort(self.friends_noself, "defense")
	local friends = self:exclude(self.friends_noself, card)
	local hasLion, target
	for _, friend in ipairs(friends) do
		if (self:hasTrickEffective(card, friend) or isSkillCard) and self:needToThrowArmor(friend) and (not isDiscard or self.player:canDiscard(friend, friend:getArmor():getEffectiveId())) then
			hasLion = true
			target = friend
		end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:isNude() then
			local valuable = self:getValuableCard(enemy)
			if valuable and (not isDiscard or self.player:canDiscard(enemy, valuable)) then
				if addTarget(enemy, valuable) then return end
			end
		end
	end

	for _, enemy in ipairs(enemies) do
		local cards = sgs.QList2Table(enemy:getHandcards())
		local flag = string.format("%s_%s_%s", "visible", self.player:objectName(), enemy:objectName())
		if #cards <= 2 and not enemy:isKongcheng() and not self:doNotDiscard(enemy, "h", true) then
			for _, cc in ipairs(cards) do
				if (cc:hasFlag("visible") or cc:hasFlag(flag)) and (cc:isKindOf("Peach") or cc:isKindOf("Analeptic")) then
					if addTarget(enemy, self:getCardRandomly(enemy, "h")) then return end
				end
			end
		end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:isNude() then
			if enemy:hasSkills("jijiu|qingnang|jieyin") then
				local cardchosen
				local equips = { enemy:getDefensiveHorse(), enemy:getArmor(), enemy:getOffensiveHorse(), enemy:getWeapon() }
				for _, equip in ipairs(equips) do
					if equip and (not enemy:hasSkill("jijiu") or equip:isRed()) and (not isDiscard or self.player:canDiscard(enemy, equip:getEffectiveId())) then
						cardchosen = equip:getEffectiveId()
						break
					end
				end

				if not cardchosen and enemy:getDefensiveHorse() and (not isDiscard or self.player:canDiscard(enemy, enemy:getDefensiveHorse():getEffectiveId())) then cardchosen = enemy:getDefensiveHorse():getEffectiveId() end
				if not cardchosen and enemy:getArmor() and not self:needToThrowArmor(enemy) and (not isDiscard or self.player:canDiscard(enemy, enemy:getArmor():getEffectiveId())) then
					cardchosen = enemy:getArmor():getEffectiveId()
				end
				if not cardchosen and not enemy:isKongcheng() and enemy:getHandcardNum() <= 3 and (not isDiscard or self.player:canDiscard(enemy, "h")) then
					cardchosen = self:getCardRandomly(enemy, "h")
				end

				if cardchosen then
					if addTarget(enemy, cardchosen) then return end
				end
			end
		end
	end

	for _, enemy in ipairs(enemies) do
		if enemy:hasArmorEffect("eight_diagram") and not self:needToThrowArmor(enemy)
			and (not isDiscard or self.player:canDiscard(enemy, enemy:getArmor():getEffectiveId())) then
			addTarget(enemy, enemy:getArmor():getEffectiveId())
		end
	end

	for i = 1, 2 + (isJixi and 3 or 0), 1 do
		for _, enemy in ipairs(enemies) do
			if not enemy:isNude() and not (self:needKongcheng(enemy) and i <= 2) and not self:doNotDiscard(enemy) then
				if (enemy:getHandcardNum() == i and sgs.getDefenseSlash(enemy, self) < 6 + (isJixi and 6 or 0) and enemy:getHp() <= 3 + (isJixi and 2 or 0)) then
					local cardchosen
					if self.player:distanceTo(enemy) == self.player:getAttackRange() + 1 and enemy:getDefensiveHorse() and not self:doNotDiscard(enemy, "e")
						and (not isDiscard or self.player:canDiscard(enemy, enemy:getDefensiveHorse():getEffectiveId()))then
						cardchosen = enemy:getDefensiveHorse():getEffectiveId()
					elseif enemy:getArmor() and not self:needToThrowArmor(enemy) and not self:doNotDiscard(enemy, "e")
						and (not isDiscard or self.player:canDiscard(enemy, enemy:getArmor():getEffectiveId()))then
						cardchosen = enemy:getArmor():getEffectiveId()
					elseif not isDiscard or self.player:canDiscard(enemy, "h") then
						cardchosen = self:getCardRandomly(enemy, "h")
					end
					if cardchosen then
						if addTarget(enemy, cardchosen) then return end
					end
				end
			end
		end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:isNude() then
			local valuable = self:getValuableCard(enemy)
			if valuable and (not isDiscard or self.player:canDiscard(enemy, valuable)) then
				if addTarget(enemy, valuable) then return end
			end
		end
	end

	if hasLion and (not isDiscard or self.player:canDiscard(target, target:getArmor():getEffectiveId())) then
		if addTarget(target, target:getArmor():getEffectiveId()) then return end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:isKongcheng() and not self:doNotDiscard(enemy, "h")
			and enemy:hasSkills(sgs.cardneed_skill) and (not isDiscard or self.player:canDiscard(enemy, "h")) then
			if addTarget(enemy, self:getCardRandomly(enemy, "h")) then return end
		end
	end

	for _, enemy in ipairs(enemies) do
		if enemy:hasEquip() and not self:doNotDiscard(enemy, "e") then
			local cardchosen
			if enemy:getDefensiveHorse() and (not isDiscard or self.player:canDiscard(enemy, enemy:getDefensiveHorse():getEffectiveId())) then
				cardchosen = enemy:getDefensiveHorse():getEffectiveId()
			elseif enemy:getArmor() and not self:needToThrowArmor(enemy) and (not isDiscard or self.player:canDiscard(enemy, enemy:getArmor():getEffectiveId())) then
				cardchosen = enemy:getArmor():getEffectiveId()
			elseif enemy:getOffensiveHorse() and (not isDiscard or self.player:canDiscard(enemy, enemy:getOffensiveHorse():getEffectiveId())) then
				cardchosen = enemy:getOffensiveHorse():getEffectiveId()
			elseif enemy:getWeapon() and (not isDiscard or self.player:canDiscard(enemy, enemy:getWeapon():getEffectiveId())) then
				cardchosen = enemy:getWeapon():getEffectiveId()
			end
			if cardchosen then
				if addTarget(enemy, cardchosen) then return end
			end
		end
	end

	if name == "lengning" or self:getOverflow() > 0 then
		for _, enemy in ipairs(enemies) do
			local equips = enemy:getEquips()
			if not enemy:isNude() and not self:doNotDiscard(enemy, "he") then
				local cardchosen
				if not equips:isEmpty() and not self:doNotDiscard(enemy, "e") then
					cardchosen = self:getCardRandomly(enemy, "e")
				else
					cardchosen = self:getCardRandomly(enemy, "h") end
				if cardchosen then
					if addTarget(enemy, cardchosen) then return end
				end
			end
		end
	end
end

sgs.ai_choicemade_filter.cardChosen.lengning = sgs.ai_choicemade_filter.cardChosen.snatch

sgs.ai_use_value.Lengning = 8
sgs.ai_use_priority.Lengning = 4.44
sgs.ai_keep_value.Lengning = 3.51
sgs.ai_card_intention.Lengning = 100

function SmartAI:useCardLaman(card, use)
	if self.room:isProhibited(self.player, self.player, card) then return end
	local enemies = {}

	if #self.enemies == 0 then
		return
	else
		enemies = self:exclude(self.enemies, card)
	end

	local getvalue = function(enemy,selp)
		if enemy:isKongcheng() then return -100 end
		if not self:hasTrickEffective(card, enemy) then return -101 end
		local value = 1 + math.floor(enemy:getHandcardNum()/5)
		if enemy:hasSkills("lianying|noslianying") and (enemy:getHandcardNum() == 1) then value = value - 1 end
		if enemy:hasSkills("tuntian|wuzhishouheng") then value = value - 3 end
		if enemy:hasSkill("kongcheng") and (enemy:getHandcardNum() == 1) then value = value - 3 end
		
		if not enemy:containsTrick("indulgence") then value = value + 1.5 end
		if selp:hasSkill("juece") and (enemy:getHandcardNum() == 1) then value = value + 2 end
		if not sgs.isGoodTarget(enemy, self.enemies, self) then value = value - 1 end
		if self:isWeak(enemy) then value = value + 1 end
		return value
	end

	local cmp = function(a,b)
		return getvalue(a,self.player) > getvalue(b,self.player)
	end

	table.sort(enemies, cmp)

	local target = enemies[1]
	if getvalue(target,self.player) > 0 then
		use.card = card
		if use.to then use.to:append(target) end
		return
	end
end

sgs.ai_skill_choice.laman = function(self, choices, data)
	local target = data:toPlayer()
	local mat = {}
	for _,cd in sgs.qlist(target:handCards()) do
		if not table.contains(mat,sgs.Sanguosha:getCard(cd):getNumberString()) then
			table.insert(mat,sgs.Sanguosha:getCard(cd):getNumberString())
		end
	end
	local count = function(a,tar)
		local b = 0
		for _,cd in sgs.qlist(tar:handCards()) do
			if sgs.Sanguosha:getCard(cd):getNumberString() == a then
				b = b + 1
			end
		end 
		return b
	end
	local cmp = function(a,b)
		return count(a,target) > count(b,target)
	end
	table.sort(mat, cmp)
	return mat[1]
end

sgs.ai_use_value.Laman = 8
sgs.ai_use_priority.Laman = 5.67
sgs.ai_keep_value.Laman = 3.38
sgs.ai_card_intention.FireAttack = 100

function SmartAI:willUseJieziqi(card)
	if not card then self.room:writeToConsole(debug.traceback()) return false end
	if self.room:isProhibited(self.player, self.player, card) then return end

	local function hasDangerousFriend()
		local hashy = false
		for _, aplayer in ipairs(self.enemies) do
			if aplayer:hasSkill("hongyan") then hashy = true break end
		end
		for _, aplayer in ipairs(self.enemies) do
			if aplayer:hasSkill("guanxing") or (aplayer:hasSkill("gongxin") and hashy)
			or aplayer:hasSkill("xinzhan") then
				if self:isFriend(aplayer:getNextAlive()) or self:isFriend(aplayer:getNextAlive():getNextAlive()) then return true end
			end
		end
		for _, aplayer in ipairs(self.friends) do
			local ene = aplayer:getNextAlive()
			if ene:hasSkill("guanxing") or (ene:hasSkill("gongxin") and hashy) or ene:hasSkill("xinzhan") then return true end
		end
		return false
	end

	if self:getFinalRetrial(self.player) == 2 then
	return
	elseif self:getFinalRetrial(self.player) == 1 then
		return true
	elseif not hasDangerousFriend() then
		local players = self.room:getAllPlayers()
		players = sgs.QList2Table(players)

		local friends = 0
		local enemies = 0

		for _,player in ipairs(players) do
			if self:objectiveLevel(player) >= 4 and not player:hasSkill("hongyan") and not player:hasSkill("wuyan") then
				enemies = enemies + 1
			elseif self:isFriend(player) and not player:hasSkill("hongyan") and not player:hasSkill("wuyan") then
				friends = friends + 1
			end
		end

		local ratio

		if friends == 0 then ratio = 999
		else ratio = enemies/friends
		end

		if ratio > 1.3 then
			return true
		end
	end
end

function SmartAI:useCardJieziq(card, use)
	if not self:willUseJieziqi(card) then return end
	local a = math.random(1,self.player:getAliveSiblings():length())
	if a == 1 and self.player:getAliveSiblings():at(0):hasSkill("weimu") then return end
	local target = self.room:getOtherPlayers(self.player):at(a-1)
	while target:hasSkill("weimu") and card:isBlack() do
		a = math.random(1,self.player:getAliveSiblings():length())
		target = self.room:getOtherPlayers(self.player):at(a-1)
	end
	if target then
		use.card = card
		if use.to then use.to:append(target) end
		return
	end
end

sgs.ai_keep_value.Jieziq = -1
sgs.ai_use_priority.Jieziq = 0

function SmartAI:useCardZhihuanfy(card, use)
	local n = 1
	for _, aplayer in ipairs(self.enemies) do
		if aplayer:hasSkills("wuzhishouheng|tuntian") then n = n - 10 end
	end
	for _, aplayer in ipairs(self.friends) do
		if aplayer:hasSkills("wuzhishouheng|tuntian") then n = n + 10 end
	end
	local p = self.player
	for i = 1, self.player:aliveCount(), 1 do
		if self:isFriend(p) then
			n = n + (self.player:aliveCount()-i)/2
		elseif self:isEnemy(p) then
			n = n - (self.player:aliveCount()-i)/2
		end
		p = p:getNextAlive()
	end
	if n > 0 then
		use.card = card
	end
	return
end

sgs.ai_use_value.Zhihuanfy = 2.95
sgs.ai_keep_value.Zhihuanfy = -0.98
sgs.ai_use_priority.Zhihuanfy = 1.2

function SmartAI:useCardFireup(fire_attack, use)
	if self.player:hasSkill("wuyan") and not self.player:hasSkill("jueqing") then return end
	if self.player:hasSkill("noswuyan") then return end

	self:sort(self.enemies, "defense")

	local can_attack = function(enemy)
		local damage = 1
		if not self.player:hasSkill("jueqing") and not enemy:hasArmorEffect("silver_lion") then
			if enemy:hasArmorEffect("vine") then damage = damage + 1 end
			if enemy:getMark("@gale") > 0 then damage = damage + 1 end
		end
		if not self.player:hasSkill("jueqing") and enemy:hasSkill("mingshi") and self.player:getEquips():length() <= enemy:getEquips():length() then
			damage = damage - 1
		end
		return self:objectiveLevel(enemy) > 3 and damage > 0 and not self.room:isProhibited(self.player, enemy, fire_attack)
				and self:damageIsEffective(enemy, sgs.DamageStruct_Fire, self.player) and not self:cantbeHurt(enemy, self.player, damage) and (not enemy:hasFlag("bls"))
				and self:hasTrickEffective(fire_attack, enemy)
				and sgs.isGoodTarget(enemy, self.enemies, self)
				and (self.player:hasSkill("jueqing")
					or (not (enemy:hasSkill("jianxiong") and not self:isWeak(enemy))
						and not (self:getDamagedEffects(enemy, self.player))
						and not (enemy:isChained() and not self:isGoodChainTarget(enemy, self.player, sgs.DamageStruct_Fire, nil, fire_attack))))
	end

	local enemies, targets = {}, {}
	for _, enemy in ipairs(self.enemies) do
		if (not use.current_targets or not table.contains(use.current_targets, enemy:objectName())) and can_attack(enemy) and (not enemy:isNude()) then
			table.insert(enemies, enemy)
		end
	end
	
	local cards = self.player:getHandcards()
	local canDis = {}
	for _, card in sgs.qlist(cards) do
		if card:getEffectiveId() ~= fire_attack:getEffectiveId() then
			table.insert(canDis, card)
		end
	end

	local can_FireAttack_self
	for _, card in ipairs(canDis) do
		if (not isCard("Peach", card, self.player) or self:getCardsNum("Peach") >= 3)
			and (not isCard("Analeptic", card, self.player) or self:getCardsNum("Analeptic") >= 2) then
			can_FireAttack_self = true
		end
	end

	if (not use.current_targets or not table.contains(use.current_targets, self.player:objectName()))
		and self.role ~= "renegade" and can_FireAttack_self and self.player:isChained() and self:isGoodChainTarget(self.player, self.player, sgs.DamageStruct_Fire, nil, fire_attack)
		and self.player:getHandcardNum() > 1 and not self.player:hasSkill("jueqing") and not self.player:hasSkill("mingshi")
		and not self.room:isProhibited(self.player, self.player, fire_attack)
		and self:damageIsEffective(self.player, sgs.DamageStruct_Fire, self.player) and not self:cantbeHurt(self.player)
		and self:hasTrickEffective(fire_attack, self.player) then

		if self.player:hasSkill("niepan") and self.player:getMark("@nirvana") > 0 then
			table.insert(targets, self.player)
		elseif hasBuquEffect(self.player)then
			table.insert(targets, self.player)
		else
			local leastHP = 1
			if self.player:hasArmorEffect("vine") then leastHP = leastHP + 1 end
			if self.player:getMark("@gale") > 0 then leastHP =leastHP + 1 end
			local jxd = self.room:findPlayerBySkillName("wuling")
			if jxd and jxd:getMark("@wind") > 0 then leastHP = leastHP + 1 end
			if self.player:getHp() > leastHP then
				table.insert(targets, self.player)
			elseif self:getCardsNum("Peach") + self:getCardsNum("Analeptic") > self.player:getHp() - leastHP then
				table.insert(targets, self.player)
			end
		end
	end

	for _, enemy in ipairs(enemies) do
		local damage = 1
		if not enemy:hasArmorEffect("silver_lion") then
			if enemy:hasArmorEffect("vine") then damage = damage + 1 end
			if enemy:getMark("@gale") > 0 then damage = damage + 1 end
		end
		if not self.player:hasSkill("jueqing") and enemy:hasSkill("mingshi") and self.player:getEquips():length() <= enemy:getEquips():length() then
			damage = damage - 1
		end
		if (not use.current_targets or not table.contains(use.current_targets, enemy:objectName()))
			and not self.player:hasSkill("jueqing") and self:damageIsEffective(enemy, sgs.DamageStruct_Fire, self.player) and damage > 1 then
			if not table.contains(targets, enemy) then table.insert(targets, enemy) end
		end
	end
	for _, enemy in ipairs(enemies) do
		if (not use.current_targets or not table.contains(use.current_targets, enemy:objectName())) and not table.contains(targets, enemy) then table.insert(targets, enemy) end
	end

	if #targets > 0 then
		local godsalvation = self:getCard("GodSalvation")
		if godsalvation and godsalvation:getId() ~= fire_attack:getId() and self:willUseGodSalvation(godsalvation) then
			local use_gs = true
			for _, p in ipairs(targets) do
				if not p:isWounded() or not self:hasTrickEffective(godsalvation, p, self.player) then break end
				use_gs = false
			end
			if use_gs then
				use.card = godsalvation
				return
			end
		end

		local targets_num = 1 + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, self.player, fire_attack)
		if use.isDummy and use.extra_target then targets_num = targets_num + use.extra_target end
		local lx = self.room:findPlayerBySkillName("huangen")
		use.card = fire_attack
		for i = 1, #targets, 1 do
			if use.to and not (use.to:length() > 0 and targets[i]:hasSkill("danlao"))
				and not (use.to:length() > 0 and lx and self:isFriend(lx, targets[i]) and self:isEnemy(lx) and lx:getHp() > targets_num / 2) then
				use.to:append(targets[i])
				if use.to:length() == targets_num then return end
			end
		end
	end
end

function sgs.ai_skill_suit.fireup(self)
	local map = {0, 0, 1, 1, 3, 3, 2, 2}
	local suit = map[math.random(1, 8)]
	local tg = nil
	for _, enemy in ipairs(self.enemies) do
		if enemy:objectName() == self.room:getTag("fireupto"):toString() then tg = enemy end
	end
	if tg then
		local suits = {}
		local maxnum, maxsuit = 0
		for _, c in sgs.qlist(tg:getHandcards()) do
			local flag = string.format("%s_%s_%s", "visible", self.player:objectName(), tg:objectName())
			if c:hasFlag(flag) or c:hasFlag("visible") then
				if not suits[c:getSuitString()] then suits[c:getSuitString()] = 1 else suits[c:getSuitString()] = suits[c:getSuitString()] + 1 end
				if suits[c:getSuitString()] > maxnum then
					maxnum = suits[c:getSuitString()]
					maxsuit = c:getSuit()
				end
			end
		end
		if tg:hasSkill("hongyan") then return sgs.Card_Spade end
		if maxsuit then
			return maxsuit
		else
			return suit
		end
	end
end

sgs.ai_use_value.Fireup = 5.12
sgs.ai_keep_value.Fireup = 3.46
sgs.ai_use_priority.Fireup = sgs.ai_use_priority.FireAttack + 0.1
sgs.ai_card_intention.Fireup = 90

function SmartAI:useCardEjump(card, use)
	if self.player:getHandcardNum() > self.player:getHp() then
		use.card = card
	end
	return
end

sgs.ai_use_value.Ejump = 4.03
sgs.ai_keep_value.Ejump = 2.98
sgs.ai_use_priority.Ejump = 1

function SmartAI:useCardMianyy(card, use)
	if self.room:alivePlayerCount() == 2 then
		local only_enemy = self.room:getOtherPlayers(self.player):first()
		if only_enemy:getLostHp() < 3 then return end
	end
	local target
	self:sort(self.enemies, "hp")
	for _, enemy in ipairs(self.enemies) do
		if self:getFriendNumBySeat(self.player, enemy) >= 1 then
			if enemy:getHp() < 1 and enemy:hasSkill("nosbuqu", true) and enemy:getMark("Qingchengnosbuqu") == 0 then
				target = enemy
				break
			end
			if self:isWeak(enemy) then
				for _, askill in ipairs((sgs.exclusive_skill .. "|" .. sgs.save_skill):split("|")) do
					if enemy:hasSkill(askill, true) and enemy:getMark("Qingcheng" .. askill) == 0 and self:hasTrickEffective(card, enemy) and (not self.room:isProhibited(self.player, enemy, card)) then
						target = enemy
						break
					end
				end
				if target then break end
			end
			for _, askill in ipairs(("noswuyan|weimu|wuyan|guixin|fenyong|liuli|yiji|jieming|neoganglie|fankui|fangzhu|enyuan|nosenyuan|" ..
			"vsganglie|ganglie|langgu|qingguo|luoying|guzheng|jianxiong|longdan|xiangle|renwang|huangen|tianming|yizhong|bazhen|jijiu|" ..
			"beige|longhun|gushou|buyi|mingzhe|danlao|qianxun|jiang|yanzheng|juxiang|huoshou|anxian|zhichi|feiying|" ..
			"tianxiang|xiaoji|xuanfeng|nosxuanfeng|xiaoguo|guhuo|guidao|guicai|nosshangshi|lianying|sijian|mingshi|" ..
			"yicong|zhiyu|lirang|xingshang|shushen|shangshi|leiji|wusheng|wushuang|tuntian|quanji|kongcheng|jieyuan|" ..
			"jilve|wuhun|kuangbao|tongxin|shenjun|ytchengxiang|sizhan|toudu|xiliang|tanlan|shien|bcdaodian|bdcanza|wuzhishouheng|lwxyanghua|hmlhuanyuan|Dratoms|mjyuce|nsjunheng|fkbai|wkluoxuan|wkzhongxin|ndhuli|ndfengdeng|ndcongyi"):split("|")) do
				if enemy:hasSkill(askill, true) and enemy:getMark("Qingcheng" .. askill) == 0 and self:hasTrickEffective(card, enemy) and (not self.room:isProhibited(self.player, enemy, card)) then
					target = enemy
					break
				end
			end
			if target then break end
		end
	end
	if not target then
		for _, friend in ipairs(self.friends_noself) do
			if friend:hasSkill("shiyong", true) and friend:getMark("Qingchengshiyong") == 0 and self:hasTrickEffective(card, friend) and not self.room:isProhibited(self.player, friend, card) then
				target = friend
				break
			end
		end
	end

	if not target then return end
	use.card = card
	if use.to then
		use.to:append(target)
	end
	return
end

sgs.ai_skill_choice.mianyy = function(self, choices, data)
	local target = data:toPlayer()
	if self:isFriend(target) then
		if target:hasSkill("shiyong", true) and target:getMark("Qingchengshiyong") == 0 then return "shiyong" end
	end
	if target:getHp() < 1 and target:hasSkill("buqu", true) and target:getMark("Qingchengbuqu") == 0 then return "buqu" end
	if self:isWeak(target) then
		for _, askill in ipairs((sgs.exclusive_skill .. "|" .. sgs.save_skill):split("|")) do
			if target:hasSkill(askill, true) and target:getMark("Qingcheng" .. askill) == 0 then
				return askill
			end
		end
	end
	for _, askill in ipairs(("noswuyan|weimu|wuyan|guixin|fenyong|liuli|yiji|jieming|neoganglie|fankui|fangzhu|enyuan|nosenyuan|" ..
		"ganglie|vsganglie|langgu|qingguo|luoying|guzheng|jianxiong|longdan|xiangle|renwang|huangen|tianming|yizhong|bazhen|jijiu|" ..
		"beige|longhun|gushou|buyi|mingzhe|danlao|qianxun|jiang|yanzheng|juxiang|huoshou|anxian|zhichi|feiying|" ..
		"tianxiang|xiaoji|xuanfeng|nosxuanfeng|xiaoguo|guhuo|guidao|guicai|nosshangshi|lianying|sijian|mingshi|" ..
		"yicong|zhiyu|lirang|xingshang|shushen|shangshi|leiji|wusheng|wushuang|tuntian|quanji|kongcheng|jieyuan|" ..
		"jilve|wuhun|kuangbao|tongxin|shenjun|ytchengxiang|sizhan|toudu|xiliang|tanlan|shien|bcdaodian|bdcanza|wuzhishouheng|lwxyanghua|hmlhuanyuan|Dratoms|mjyuce|nsjunheng|fkbai|wkluoxuan|wkzhongxin|ndhuli|ndfengdeng|ndcongyi"):split("|")) do
		if target:hasSkill(askill, true) and target:getMark("Qingcheng" .. askill) == 0 then
			return askill
		end
	end
end

sgs.ai_use_value.Mianyy = 7.865
sgs.ai_keep_value.Mianyy = 4.49
sgs.ai_use_priority.Mianyy = 5.68

function SmartAI:useCardHetongbh(card, use)
	local enemies = self:exclude(self.enemies, card)

	local zhanghe = self.room:findPlayerBySkillName("qiaobian")
	local zhanghe_seat = zhanghe and zhanghe:faceUp() and not zhanghe:isKongcheng() and not self:isFriend(zhanghe) and zhanghe:getSeat() or 0

	local sb_daqiao = self.room:findPlayerBySkillName("yanxiao")
	local yanxiao = sb_daqiao and not self:isFriend(sb_daqiao) and sb_daqiao:faceUp() and
					(getKnownCard(sb_daqiao, self.player, "diamond", nil, "he") > 0
					or sb_daqiao:getHandcardNum() + self:ImitateResult_DrawNCards(sb_daqiao, sb_daqiao:getVisibleSkillList(true)) > 3
					or sb_daqiao:containsTrick("YanxiaoCard"))

	if #enemies == 0 then return end

	local getvalue = function(enemy)
		if (not self:hasTrickEffective(card, enemy)) or self.room:isProhibited(self.player, enemy, card) then return -100 end
		if enemy:containsTrick("hetongbh") or enemy:containsTrick("YanxiaoCard") or enemy:containsTrick("supply_shortage") then return -100 end
		if enemy:getMark("juao") > 0 then return -100 end
		if enemy:hasSkill("qiaobian") and not enemy:containsTrick("hetongbh") and not enemy:containsTrick("indulgence") then return -100 end
		if zhanghe_seat > 0 and (self:playerGetRound(zhanghe) <= self:playerGetRound(enemy) and self:enemiesContainsTrick() <= 1 or not enemy:faceUp()) then
			return - 100 end
		if yanxiao and (self:playerGetRound(sb_daqiao) <= self:playerGetRound(enemy) and self:enemiesContainsTrick(true) <= 1 or not enemy:faceUp()) then
			return -100 end

		local value = 0 - ((enemy:getHandcardNum()+1)*(2-(#self.friends/#self.enemies)))

		if self:hasSkills("yongsi|haoshi|tuxi|noslijian|lijian|fanjian|neofanjian|dimeng|jijiu|jieyin|manjuan|beige|slransu",enemy)
		  or (enemy:hasSkill("zaiqi") and enemy:getLostHp() > 1)
			then value = value + 10
		end
		if self:hasSkills(sgs.cardneed_skill,enemy) or self:hasSkills("zhaolie|tianxiang|qinyin|yanxiao|zhaoxin|toudu|renjie",enemy)
			then value = value + 5
		end
		if self:hasSkills("yingzi|shelie|xuanhuo|buyi|jujian|jiangchi|mizhao|hongyuan|chongzhen|duoshi",enemy) then value = value + 1 end
		if enemy:hasSkill("zishou") then value = value + enemy:getLostHp() end
		if self:isWeak(enemy) then value = value + 5 end
		if enemy:isLord() then value = value + 3 end

		if self:objectiveLevel(enemy) < 3 then value = value - 10 end
		if not enemy:faceUp() then value = value - 10 end
		if self:hasSkills("keji|shensu|qingyi", enemy) then value = value - (enemy:getHandcardNum()-1) end
		if self:hasSkills("guanxing|xiuluo|tiandu|guidao|noszhenlie", enemy) then value = value - 5 end
		if not sgs.isGoodTarget(enemy, self.enemies, self) then value = value - 1 end
		if self:needKongcheng(enemy) then value = value - 1 end
		if enemy:getMark("@kuiwei") > 0 then value = value - 2 end
		return value
	end

	local cmp = function(a,b)
		return getvalue(a) > getvalue(b)
	end

	table.sort(enemies, cmp)

	local target = enemies[1]
	if getvalue(target) > -100 then
		use.card = card
		if use.to then use.to:append(target) end
		return
	end
end

sgs.ai_skill_askforag["hetongbh-get"] = function(self, card_ids)
	local who = nil
	for _, victim in sgs.qlist(self.room:getAllPlayers()) do
		if victim:objectName() == self.room:getTag("htto"):toString() then who = victim end
	end

	local wulaotai = self.room:findPlayerBySkillName("buyi")
	local Need_buyi = wulaotai and who:getHp() == 1 and self:isFriend(who, wulaotai)

	local cards, except_Equip, except_Key = {}, {}, {}
	for _, card_id in ipairs(card_ids) do
		local card = sgs.Sanguosha:getCard(card_id)
		if self.player:hasSkill("zhijian") and not card:isKindOf("EquipCard") then
			table.insert(except_Equip, card)
		end
		if not card:isKindOf("Peach") and not card:isKindOf("Jink") and not card:isKindOf("Analeptic") and
			not card:isKindOf("Nullification") and not (card:isKindOf("EquipCard") and self.player:hasSkill("zhijian")) then
			table.insert(except_Key, card)
		end
		table.insert(cards, card)
	end

	if self:isFriend(who) then

		if Need_buyi then
			local buyicard1, buyicard2
			self:sortByKeepValue(cards)
			for _, card in ipairs(cards) do
				if card:isKindOf("TrickCard") and not buyicard1 then
					buyicard1 = card:getEffectiveId()
				end
				if not card:isKindOf("BasicCard") and not buyicard2 then
					buyicard2 = card:getEffectiveId()
				end
				if buyicard1 then break end
			end
			if buyicard1 or buyicard2 then
				return buyicard1 or buyicard2
			end
		end

		local peach_num, peach, jink, analeptic, slash = 0
		for _, card in ipairs(cards) do
			if card:isKindOf("Peach") then peach = card:getEffectiveId() peach_num = peach_num + 1 end
			if card:isKindOf("Jink") then jink = card:getEffectiveId() end
			if card:isKindOf("Analeptic") then analeptic = card:getEffectiveId() end
			if card:isKindOf("Slash") then slash = card:getEffectiveId() end
		end
		if peach then
			if peach_num > 1
				or (self:getCardsNum("Peach") >= self.player:getMaxCards())
				or (self.player:getHp() < getBestHp(self.player) and who:getHp() > self.player:getHp()) then
					return peach
			end
		end
		if self:isWeak(self.player) and (jink or analeptic) then
			return jink or analeptic
		end

		for _, card in ipairs(cards) do
			if not card:isKindOf("EquipCard") then
				for _, askill in sgs.qlist(who:getVisibleSkillList(true)) do
					local callback = sgs.ai_cardneed[askill:objectName()]
					if type(callback)=="function" and callback(self.player, card, self) then
						return card:getEffectiveId()
					end
				end
			end
		end

		if jink or analeptic then
			return jink or analeptic
		end

		for _, card in ipairs(cards) do
			if not card:isKindOf("EquipCard") and not card:isKindOf("Peach") then
				return card:getEffectiveId()
			end
		end

	else

		if Need_buyi then
			for _, card in ipairs(cards) do
				if card:isKindOf("Slash") then
					return card:getEffectiveId()
				end
			end
		end

		for _, card in ipairs(cards) do
			if card:isKindOf("EquipCard") and self.player:hasSkill("zhijian") then
				local Cant_Zhijian = true
				for _, friend in ipairs(self.friends) do
					if not self:getSameEquip(card, friend) then
						Cant_Zhijian = false
					end
				end
				if not Cant_Zhijian then
					return card:getEffectiveId()
				end
			end
		end

		local new_cards = (#except_Key > 0 and except_Key) or (#except_Equip > 0 and except_Equip) or cards

		self:sortByKeepValue(new_cards)
		local valueless, slash
		for _, card in ipairs (new_cards) do
			if card:isKindOf("Lightning") and self:hasSkills(sgs.wizard_harm_skill, self.player) then
				return card:getEffectiveId()
			end

			if not valueless and not card:isKindOf("Peach") then
				for _, askill in sgs.qlist(self.player:getVisibleSkillList(true)) do
					local callback = sgs.ai_cardneed[askill:objectName()]
					if (type(callback)=="function" and callback(self.player, card, self)) or callback then
						valueless = card:getEffectiveId()
						break
					end
				end
			end
		end

		if valueless then
			return valueless
		end

		return new_cards[1]:getEffectiveId()
	end


	return card_ids[1]
end

function IdTable2CardTable(ids)
	local cards = {}
	for _,id in ipairs(ids) do
		table.insert(cards,sgs.Sanguosha:getCard(id))
	end
	return cards
end

sgs.ai_skill_discard.hetongbh = function(self, discard_num, optional, include_equip)
	if self.player:isKongcheng() then return {} end
	local who = nil
	for _, victim in sgs.qlist(self.room:getAllPlayers()) do
		if victim:objectName() == self.room:getTag("htto"):toString() then who = victim end
	end
	if not who then return {} end
	local cards = self.player:getHandcards()
	if self:isFriend(who) then
		local heneed = {}
		local ret = {}
		for _, card in sgs.qlist(cards) do
			if type(callback)=="function" and callback(who, card, self) then
				table.insert(heneed, card:getEffectiveId())
			end
		end
		if #heneed == 0 then return {} end
		for _, acard in ipairs(heneed) do
			local bcard = sgs.Sanguosha:getCard(acard)
			if self:cardNeed(bcard)>11 and (not who:isWeak()) and (not bcard:inherits("Peach")) and (not bcard:inherits("C6") and (not bcard:inherits("ExNihilo"))) then
				table.removeOne(heneed, acard)
			end
		end
		if #heneed == 0 then return {} end
		self:sortByUseValue(IdTable2CardTable(heneed), who:isSkipped(sgs.Player_Play))
		table.insert(ret,heneed[1])
		return ret
	else
		local henotneed = {}
		local ret = {}
		for _, card in sgs.qlist(cards) do
			if not( type(callback)=="function" and callback(who, card, self))or not callback then
				table.insert(henotneed, card:getEffectiveId())
			end
		end
		if #henotneed == 0 then return {} end
		for _, acard in ipairs(henotneed) do
			local bcard = sgs.Sanguosha:getCard(acard)
			if (type(callback)=="function" and callback(self.player, bcard, self)) or bcard:inherits("Peach") or bcard:inherits("C6") or bcard:inherits("ExNihilo") then
				table.removeOne(henotneed, acard)
			end
		end
		if #henotneed == 0 then return {} end
		self:sortByUseValue(IdTable2CardTable(henotneed))
		table.insert(ret,henotneed[1])
		return ret
	end
end 

sgs.ai_use_value.Hetongbh = 6.7
sgs.ai_keep_value.Hetongbh = 3.36
sgs.ai_use_priority.Hetongbh = 0.48
sgs.ai_card_intention.Hetongbh = 105

function SmartAI:useCardAllocate(card, use)
	local enemies = self:exclude(self.enemies, card)
	local friends = self:exclude(self.friends_noself, card)
	local gongmou_target
	if self.player:hasSkill("manjuan") then return nil end
	self:sort(friends, "defense", true)
	for _, friend in ipairs(friends) do
		if friend:isKongcheng() then continue end
		if friend:hasSkill("enyuan") then
			gongmou_target = friend
		elseif friend:hasSkill("manjuan") then
			gongmou_target = friend
		end
	end

	self:sort(enemies, "defense", true)
	for _, enemy in ipairs(enemies) do
		if gongmou_target then break end
		if (not enemy:isKongcheng()) and not self:needKongcheng(enemy) and not self:hasSkills("manjuan|qiaobian", enemy) then
			gongmou_target = enemy
		end
	end
	if gongmou_target then
		use.card = card
		if use.to then use.to:append(gongmou_target) end
		return
	end
end

sgs.ai_skill_discard.allocate = function(self, discard_num, optional, include_equip)
	local cards = sgs.QList2Table(self.player:getHandcards())
	local to_discard = {}
	local compare_func = function(a, b)
		return self:getKeepValue(a) + self:getUseValue(a) < self:getKeepValue(b) + self:getUseValue(b)
	end
	table.sort(cards, compare_func)
	for _, card in ipairs(cards) do
		if #to_discard >= discard_num then break end
		table.insert(to_discard, card:getId())
	end

	return to_discard
end

sgs.ai_use_value.Allocate = 5.1
sgs.ai_keep_value.Allocate = 3.33
sgs.ai_use_priority.Allocate = 7.7

function SmartAI:useCardDrosophila(card, use)
	local arr1, arr2 = self:getWoundedFriend(false, true)
	local target = nil

	if #arr1 > 0 and arr1[1]:getHp() < getBestHp(arr1[1]) and not(arr1[1]:hasSkill("manjuan") and arr1[1]:getHp()>1) then target = arr1[1] end
	if target then
		use.card = card
		if use.to then use.to:append(target) end
		return
	end
	if #arr2 > 0 then
		for _, friend in ipairs(arr2) do
			if not friend:hasSkills("hunzi|longhun|manjuan") then
				use.card = card
				if use.to then use.to:append(friend) end
				return
			end
		end
	end
end
sgs.ai_use_value.Drosophila = 7.9
sgs.ai_keep_value.Drosophila = 4.33
sgs.ai_use_priority.Drosophila = 3.56


local science = {"weile","houdebang","lawaxi","huangminglong","msjuli","baichuan","nuobeier","daoerdun","menjieliefu","david","shele","mulis","nash","fuke","mitena","wosenklk","ndgirl","jialowa","yuanlongping","fiman","zuchongzhi","akubr","borzm","tesla","yinssk","eldes","kaipl","stevens","hodgkin","hesmu","karvin","morton","ebhaus","lipum","bonuli","boer","keluolf","adamsmi","lidaoyuan","chenyinke","linhuiyin","adlovelace","morgan","zhangailin"}

IOoutput = function(output)
	assert(type(output) == "string")
	local ouf = assert(io.open("IOoutputdata.txt", "a"))
	ouf:write(output)
	ouf:write("\n")
	io.close(ouf)
end

function SmartAI:useCardEnjoyeat(card, use)
	local targets = {}
	local hasenemycz = false
	local hasfriendcz = false
	for _,f in ipairs(self.friends) do
		if (table.contains(science,f:getGeneralName()) or (f:getGeneral2() and table.contains(science,f:getGeneral2Name()))) and self:hasTrickEffective(card, f) and not self.room:isProhibited(self.player, f, card) then
			if (not self.DummyEnjoyeat) or f:objectName() ~= self.player:objectName() then
				table.insert(targets, f)
			end
		end
		if f:hasSkills("luoying|shenxian") then hasfriendcz = true end
	end
	if #targets == 0 and (not self.DummyEnjoyeat) then use.card = card return end
	--self.room:writeToConsole("ejf")
	--IOoutput("finding CZ")
	for _,e in ipairs(self.enemies) do
		if e:hasSkills("luoying|shenxian") then hasenemycz = true end
	end
	local getvalue = function(who)
		local value = 0.5
		if who:containsTrick("indulgence") then
			value = value - 1 
			if who:getOverflow() > 0 then value = value - 1 end
		end
		if hasfriendcz then value = value + 1 end
		if hasenemycz then value = value - 0.9 end
		if who:getEquips():length() ~= 0 then value = value + 1.1 end
		if getCardsNum("EquipCard", who) > 0 then value = value + 1.2 end
		if self:needToThrowArmor(who) then value = value + 0.5 end
		if who:hasSkills("tuntian|wuzhishouheng|nsjunheng|mingzhe") then value = value + 1.4 end
		if self.room:getCurrent():objectName() ~= who:objectName() and who:hasSkills("manjuan") then value = value - 8 end
		if who:hasSkill("noslonghun") then value = value - 3 end
		return value
	end
	--self.room:writeToConsole("ejd")
	local cmp = function(a,b)
		return getvalue(a) > getvalue(b)
	end
	use.card = card
	if #targets > 1 then
		table.sort(targets, cmp)
	end
	--IOoutput("sorted")
	if getvalue(targets[1]) >= 0 then
		if use.to then 
			use.to:append(targets[1])
			--IOoutput("useto")
		end
	end
	return
end

sgs.ai_skill_discard.enjoyeat = function(self, discard_num, optional, include_equip)
	local todis = {}
	local eqlist = {}
	local bclist = {}
	local trlist = {}
	local cd = sgs.Sanguosha:getCard(self.player:getMark("enjoyid"))
	self.room:setPlayerMark(self.player, "enjoyid", 0)
	local cards = self.player:getCards("he")
	cards = sgs.QList2Table(cards)
	local cmpa = function (a, b)
		return self:getKeepValue(a) + self:getUseValue(a) < self:getKeepValue(b) + self:getUseValue(b) or (self:getKeepValue(a) + self:getUseValue(a) == self:getKeepValue(b) + self:getUseValue(b) and self:getKeepValue(a) < self:getKeepValue(b))
	end
	table.sort(cards, cmpa)
	for _,card in ipairs(cards) do
		if card:isKindOf("BasicCard") then
			table.insert(bclist, card)
		elseif card:isKindOf("TrickCard") then
			table.insert(trlist, card)
		else
			table.insert(eqlist, card)
		end
	end
	--IOoutput("listed")
	if #cards < 3 then 
		local list = {}
		for _,card in ipairs(cards) do
			table.insert(list, card:getEffectiveId())
		end
		return list 
	end
	--IOoutput("listed3")
	if #bclist * #trlist * #eqlist == 0 then return {cards[1]:getEffectiveId(),cards[2]:getEffectiveId(),cards[3]:getEffectiveId()} end
	--IOoutput("listed2")
	if (self:getUseValue(bclist[1]) + self:getUseValue(trlist[1]) + self:getUseValue(eqlist[1]) > self:getUseValue(cards[1]) + self:getUseValue(cards[2]) + self:getUseValue(cards[3]) + 5) or (self:getKeepValue(bclist[1]) + self:getKeepValue(trlist[1]) + self:getKeepValue(eqlist[1]) > self:getKeepValue(cards[1]) + self:getKeepValue(cards[2]) + self:getKeepValue(cards[3]) + 5) then
		--IOoutput("listed4")
		return {cards[1]:getEffectiveId(),cards[2]:getEffectiveId(),cards[3]:getEffectiveId()}
	end
	--IOoutput("predummyuse")
	self.DummyEnjoyeat = true
	local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
	self:useCardByClassName(cd, dummy_use)
	self.DummyEnjoyeat = false
	if dummy_use.to and dummy_use.to:length() == 0 then return {} end
	self.room:setPlayerMark(self.player, "enjoyid", cd:getEffectiveId())
	--self.room:writeToConsole("eja")
	--IOoutput("predis")
	return {bclist[1]:getEffectiveId(),trlist[1]:getEffectiveId(),eqlist[1]:getEffectiveId()} 
end

sgs.ai_skill_playerchosen.enjoyeat = function(self, targets)
	local cd = sgs.Sanguosha:getCard(self.player:getMark("enjoyid"))
	self.room:setPlayerMark(self.player, "enjoyid", 0)
	--IOoutput("player about choose")
	self.DummyEnjoyeat = true
	local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
	self:useCardByClassName(cd, dummy_use)
	self.DummyEnjoyeat = false
	if dummy_use.to and dummy_use.to:length() == 0 then return nil end
	if not targets:contains(dummy_use.to:first()) then return nil end
	--IOoutput("playerchosen")
	return dummy_use.to:first()
end

sgs.ai_card_intention.Enjoyeat = -80

sgs.ai_keep_value.Enjoyeat = 4
sgs.ai_use_value.Enjoyeat = 9
sgs.ai_use_priority.Enjoyeat = 8.7

sgs.dynamic_value.benefit.Enjoyeat = true

ScSkillValue = function(name, who, self)
	local n = 0
	assert(type(name) == "string")
	if name == "youjihecheng" then
		n = math.min(who:getLostHp() * 2, who:getHandcardNum() + 2)
	elseif name == "tongfenyigou" then
		local suitlist = {}
		if not who:isKongcheng() then
			local cards = who:getHandcards()
			for _,c in sgs.qlist(cards) do
				if not table.contains(suitlist, c:getSuitString()) then
					table.insert(suitlist, c:getSuitString())
				end
			end
			n = ((4 - #suitlist)*(who:getLostHp() + 2))/4
		end
	elseif name == "madejian" then
		if who:getHandcardNum() >= 3 then 
			n = 3.5
		else
			n = 2.5
		end
	elseif name == "wuzhishouheng" then
		n = math.min(who:getPile("things"):length(), #self:getFriends(who)) + 2
	elseif name == "lwxyanghua" or name == "hmlhuanyuan" or name == "mlspcr" or name == "ndfengdeng" then
		n = who:getHandcardNum() * 1.5
	elseif name == "liqingtilian" then
		for _,f in ipairs(self:getFriends(who)) do
			n = (n - 2) + (0.5)^(f:getPile("radiation"):length() - 1)
		end
		for _,e in ipairs(self:getEnemies(who)) do
			n = (n + 2) - (0.5)^(f:getPile("radiation"):length() - 1)
		end
	elseif name == "leishe" or name == "bcdaodian" or name == "mjyuce" or name == "zhouqibiao" or name == "wkzhongxin" or name == "fmchongzheng" or name == "akzhouxiang" or name == "brshuyun" or name == "edliuxi" then
		n = 2
	elseif name == "bccanza" or name == "fkbai" or name == "mtliebian" then
		n = 3
	elseif name == "boom" then
		n = math.min(#self:getEnemies(who) * 1.3, who:getHandcardNum() + 1.3)
	elseif name == "tntfac" then
		local alives = self.room:getAlivePlayers()
		for _,p in sgs.qlist(alives) do
			 if p:getPile("tnt"):length() > 0 then
				n = n + p:getPile("tnt"):length()
			 end
		end 
		n = who:getMaxHp() - (who:getHandcardNum() + n - 1)
	elseif name == "Drfenya" then
		n = who:getLostHp()
	elseif name == "Dratoms" then
		n = self.room:getAlivePlayers():length() * 0.6
	elseif name == "dvceran" then
		n = #self:getFriends(who) * 1.5 + 1
	elseif name == "slransu" or name == "nsboyi" or name == "fkwoliu" or name == "wkluoxuan" or name == "ndhuli" or name == "brshangbian" or name == "tswuxian" or name == "kpxingtu" or name == "hglaser" then
		n = 2.5
	elseif name == "slmoyan" then
		if self:isWeak(who) then 
			n = math.max(who:getCards("he"):length() - 2, 0.5)
		else
			n = 0.5
		end
	elseif name == "nsjunheng" then
		n = math.min(#self:getEnemies(who) * 1.2, who:getHandcardNum() - 1)
	elseif name == "ndcongyi" then
		n = who:faceUp() and 2.5 or 0.5
	elseif name == "jlqunlun" then
		n = who:getPile("qunlunpile"):length() * 0.5 + who:getLostHp() * 0.5 + who:getHandcardNum() * 0.4
	elseif name == "jlsidou" then
		n = self:isWeak(who) and -2 or -1
	elseif name == "lpfengshou" then
		n = #self:getFriends(who) - #self:getEnemies(who)
	elseif name == "lpyusui" then
		n = self.room:getAlivePlayers():length() * 0.3
	elseif name == "fmtugou" then	
		local alives = self.room:getAlivePlayers()
		for _,p in sgs.qlist(alives) do
			 if p:getPile("fmpicture"):length() > 0 and not self:willSkipPlayPhase(who) then
				n = n + p:getPile("fmpicture"):length()
			 end
		end 
		n = n + 1
	elseif name == "czzhuishu" then
		if who:hasSkill("czyingkui") and not self:willSkipPlayPhase(who) then
			n = who:getHandcardNum() * 1.6
		else
			n = who:getHandcardNum()
		end
	elseif name == "czyingkui" then
		if who:hasSkill("czzhuishu") and not self:willSkipPlayPhase(who) then
			n = who:getHandcardNum() * 0.6
		else
			n = 0
		end
	elseif name == "akqusu" then
		n = 1.4
	elseif name == "tsjiaobian" then
		if who:hasSkill("tswuxian") then
			n = 0.5 + who:getHandcardNum() * 0.8
		else
			n = 0.5
		end
	elseif name == "ysbengdong" then
		if #self:getFriends(who) > 1 then
			n = math.min(self.room:getAlivePlayers():length() * 0.6, who:getHandcardNum() * 0.8)
		else
			n = who:getHandcardNum() * 0.2
		end
	elseif name == "edcankao" then
		n = 1
		local alives = self.room:getAlivePlayers()
		for _,p in sgs.qlist(alives) do
			 if p:getPile("edarticle"):length() > 0 then
				n = n + p:getPile("edarticle"):length()
			 end
		end 
	elseif name == "edkanlun" then
		n = ScSkillValue("edcankao", who, self) * (#self:getFriends(who) - 1) / 2
		n = n + 1
	elseif name == "kpxingyun" then
		local alives = self.room:getAlivePlayers()
		for _,p in sgs.qlist(alives) do
			if p:distanceTo(who) <= 1 then
				n = n + 1.1
			end
		end 
	elseif name == "sttransport" then
		local alives = self.room:getAlivePlayers()
		for _,p in sgs.qlist(alives) do
			if p:getPile("strail"):length() > 0 then
				n = n + p:getPile("strail"):length() * 0.4
			 end
		end
	elseif name == "hgjiejing" then
		n = 1 + who:getHandcardNum() * 0.6 + who:getEquips():length() * 0.4
	elseif name == "hskefa" then
		n = #self:getEnemies(who) * 0.8
	end
	return n
end

function SmartAI:useCardSkillbuy(card, use)
	use.card = card 
	if use.to then
		return 
	end
end
--11.18注：这里的 ai出了一些问题，现暂时使用重铸策略代替，留以后解决
--[[
function SmartAI:useCardSkillbuy(card, use)
	local targets = {}
	local alives = self.room:getAlivePlayers()
	for _,f in sgs.qlist(alives) do
		if (table.contains(science,f:getGeneralName()) or (f:getGeneral2() and table.contains(science,f:getGeneral2Name()))) and self:hasTrickEffective(card, f) and not self.room:isProhibited(self.player, f, card) then
			if f:objectName() ~= self.player:objectName() and (self:damageIsEffective(f,sgs.DamageStruct_Normal,self.player) or not self:isEnemy(f)) then
				table.insert(targets, f)
			end
		end
	end
--	self.room:writeToConsole("targeted")
	if #targets == 0 then 
		use.card = card 
		if use.to then
			return 
		end
	end
	if not self.SkillToGet then self.SkillToGet = "" end
--	self.room:writeToConsole("to get value")
	local getvalue = function(who)
		local n = 0
		local isFirstHero = table.contains(science,who:getGeneralName())
		local isSecondaryHero = who:getGeneral2() and table.contains(science,who:getGeneral2Name())
		local other = who:getGeneral()
		if isFirstHero then 
			if isSecondaryHero or (not who:getGeneral2()) then
				other = nil
			else
				other = who:getGeneral2()
			end
		end
		local skill_list = {}
		local Qingchenglist = who:getTag("SkillBuy"):toString():split("+") or {}
		local boughtlist = self.player:getTag("SkillBuyGet"):toString():split("+") or {}
		for _,skill in sgs.qlist(who:getVisibleSkillList()) do
			if (not table.contains(skill_list,skill:objectName())) and (not table.contains(Qingchenglist,skill:objectName())) and ((not other) or (not other:hasSkill(skill:objectName()))) and (not (skill:isLordSkill() or skill:getFrequency() == sgs.Skill_Limited or skill:getFrequency() == sgs.Skill_Wake)) then
				table.insert(skill_list,skill:objectName())
			end
		end
		local toadd = nil
		if self:isFriend(who) then
			for _,sk in ipairs(skill_list) do
				local a = 1 - ScSkillValue(sk, who, self) + ScSkillValue(sk, self.player, self)
				if a > n then 
					n = a
					if self.toGetSkillReady then
						toadd = sk
					end
				end
			end
		elseif self:isEnemy(who) then
			for _,sk in ipairs(skill_list) do
				local a = ScSkillValue(sk, who, self) + ScSkillValue(sk, self.player, self) - 4
				if a > n then 
					n = a
					if self.toGetSkillReady then
						toadd = sk
					end
				end
			end
		end
		if toadd then
			local ab = self.SkillToGet:split("+") or {}
			table.insert(ab, toadd)
			self.SkillToGet = table.concat(ab, "+")
		end
		return n
	end
--	self.room:writeToConsole("pre cmp")
	local cmp = function(a,b)
		return getvalue(a) > getvalue(b)
	end
	if #targets > 1 then table.sort(targets, cmp) end
--	self.room:writeToConsole("sorted")
	if getvalue(targets[1]) > 1 then
	--	self.room:writeToConsole("pre use")
		use.card = card
		if use.to then 
		--	self.room:writeToConsole("pre use2")
			self.toGetSkillReady = true
			local x = getvalue(targets[1])
			self.toGetSkillReady = false
			use.to:append(targets[1])
		--	self.room:writeToConsole("to use " .. self.SkillToGet)
			return
		end
	else
	--	self.room:writeToConsole("so sad!")
		if sgs.ai_use_priority.Skillbuy == 7 then
			sgs.ai_use_priority.Skillbuy = 2.5
		--	self.room:writeToConsole("not found target")
		else
			sgs.ai_use_priority.Skillbuy = 7
			use.card = card
		--	self.room:writeToConsole("to recast")
			return
		end
	end
end]]--

sgs.ai_skill_choice.skillbuy = function(self,choices)
	local a = self.SkillToGet:split("+")
--	self.room:writeToConsole("choose begin " .. self.SkillToGet)
	sgs.SkillToGet = ""
	for _,sk in ipairs(a) do
		if table.contains(choices, sk) then 
		--	self.room:writeToConsole("buy ".. sk)
			return sk 
		end
	end
end

sgs.ai_skill_choice.skillbuyask = function(self,choices)
	local sk = nil
	local user = nil
	for _,p in sgs.qlist(self.room:getAlivePlayers())do
		if p:getMark("skilltoget") > 0 then 
			sk = p:property("skilltoget"):toString() 
			user = p
			break 
		end
	end
	if sk and user then
	--	self.room:writeToConsole("to choice")
		if self:isFriend(user) or (self.player:getHp() == 1 and self:damageIsEffective(user, sgs.DamageStruct_Normal, self.player)) then
			return "skillsell"
		else
			if ScSkillValue(sk, self.player, self) + ScSkillValue(sk, user, self) > 3.5 + user:getEquips():length() then
				return "denyskillbuy"
			else
				return "skillsell"
			end
		end
	end
end

sgs.ai_use_value.Skillbuy = 6
sgs.ai_keep_value.Skillbuy = 3.4
sgs.ai_use_priority.Skillbuy = 7

local listknowspreadto = "mingzhe|tuntian|nsjunheng|jizhi|nosjizhi|yicai|mieji|qicai|nosqicai"
local listknowspreadfrom = "wuyan|shien"

function SmartAI:useCardKnowspread(card, use)
	local targets = {}
	local alives = self.room:getAlivePlayers()
	for _,f in sgs.qlist(alives) do
		if (not (table.contains(science,f:getGeneralName()) or (f:getGeneral2() and table.contains(science,f:getGeneral2Name())))) and self:hasTrickEffective(card, f) and self:isFriend(f) and not self.room:isProhibited(self.player, f, card) then
			if f:objectName() ~= self.player:objectName() then
				table.insert(targets, f)
			end
		end
	end
--	IOoutput("targeted")
	if #targets == 0 then 
		use.card = card 
	--	IOoutput("targets = 0")
		if use.to then 
			use.to = sgs.SPlayerList() 
		end
		return 
	end
--	IOoutput("have target")
	local cards = self.player:getHandcards()
	local tricks = sgs.IntList()
	for _, acard in sgs.qlist(cards) do
		if acard:isKindOf("TrickCard") and acard:getClassName() ~= "Knowspread" then
			tricks:append(acard:getId())
		end
	end
--	IOoutput("pre get value")
	local getvalue = function(who)
		local abletricks = sgs.IntList()
		for _, tk in sgs.qlist(tricks) do
			if sgs.Sanguosha:getCard(tk):isAvailable(who) and not abletricks:contains(tk) then
				abletricks:append(tk)
			end
		end
		local n = 1
		if who:hasSkill("manjuan") then n = n - 200 end
		if who:hasSkill("noslonghun") then n = n - 20 end
		for _,sk in ipairs(listknowspreadto:split("|")) do
			if who:hasSkill(sk) then n = n + abletricks:length() end
			if self.player:hasSkill(sk) then n = n - abletricks:length() * 0.95 end
		end
		if who:hasSkills("qicai|nosqicai") then n = n - 0.5 * abletricks:length() end
		if self.player:hasSkills("qicai|nosqicai") then n = n - 0.475 * abletricks:length() end
		if self.player:hasSkills("wuyan|shien") then n = n + abletricks:length() end
		if who:hasSkills("wuyan|shien") then n = n - abletricks:length() * 0.8 end
		--[[IOoutput("pre fordo")
		for _, atk in sgs.qlist(abletricks) do
			local tgs = {}
			local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
			local fg = true
			while dummy_use.to and fg do
				dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
				dummy_use.current_targets = tgs
				IOoutput("count " .. #tgs)
				self:useCardByClassName(sgs.Sanguosha:getCard(atk), dummy_use)
				if dummy_use.to and dummy_use.to:length() > 0 then
					for _, p in sgs.qlist(dummy_use.to) do
						table.insert(tgs, p:objectName())
					end
					dummy_use.to = sgs.SPlayerList()
				else
					fg = false
				end
			end
			local tgsa = {}
			IOoutput("selfused")
			local selfp = self
			selfp.player = who
			fg = true
			local dummy_usea = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
			while dummy_usea.to and fg do
				dummy_usea = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
				dummy_usea.current_targets = tgsa
				IOoutput("acount " .. #tgsa)
				selfp:useCardByClassName(sgs.Sanguosha:getCard(atk), dummy_usea)
				if dummy_usea.to and dummy_usea.to:length() > 0 then
					for _, p in sgs.qlist(dummy_usea.to) do
						table.insert(tgsa, p:objectName())
					end
					dummy_usea.to = sgs.SPlayerList()
				else
					fg = false
				end
			end
			local flag = 0.6
			for _,tg in sgs.qlist(dummy_use.to) do
				if not dummy_usea:contains(tg) then flag = 0.3 end
			end
			n = n + flag * (#tgsa - #tgs)
			IOoutput("flag" .. n)
		end]]--
		return n
	end
--	IOoutput("precmp")
	local cmp = function(a,b)
		return getvalue(a) > getvalue(b)
	end
	if #targets > 1 then
	--	IOoutput("presort")
		table.sort(targets, cmp)
	end
--	IOoutput("sorted")
	if getvalue(targets[1]) > 1 then
	--	IOoutput("so good!")
		use.card = card
		if use.to then 
			use.to:append(targets[1])
		--	IOoutput("to use")
		end
		return
	else
	--	IOoutput("so sad!")
		if sgs.ai_use_priority.Knowspread == 9.18 then
			sgs.ai_use_priority.Knowspread = 2.4
		else
			sgs.ai_use_priority.Knowspread = 9.18
			use.card = card
		--	IOoutput("to recast")
			return
		end
	end
end

sgs.ai_skill_askforag.knowspread = function(self, card_ids)
	if self.player:hasSkill("manjuan|noslonghun") then return -1 end
	local available = {}
	for _,card in ipairs(card_ids) do
		if sgs.Sanguosha:getCard(card):isAvailable(self.player) and sgs.Sanguosha:getCard(card):isKindOf("TrickCard") then
			table.insert(available, card)
		end
	end
	if #available > 0 then
		return available[1]
	end
	return -1
end

sgs.ai_skill_use["knowspreadforAI"] = function(self, prompt)
	local cards = sgs.QList2Table(self.player:getCards("he"))
	local touse = {}
	for _,c in ipairs(cards) do 
		if c:isAvailable(self.player) and sgs.Sanguosha:matchExpPattern(prompt, self.player, c) then
		--	IOoutput("match")
			table.insert(touse, c)
		end
	end
	if #touse > 0 then
		self:sortByDynamicUsePriority(touse)
		local cd = touse[1]
		local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
		self:useCardByClassName(cd, dummy_use)
		if dummy_use.card then
		--	IOoutput("to use")
			if dummy_use.to:isEmpty() then
				return dummy_use.card:toString()
			else
				local target_objectname = {}
				for _, p in sgs.qlist(dummy_use.to) do
					table.insert(target_objectname, p:objectName())
				end
				return dummy_use.card:toString() .. "->" .. table.concat(target_objectname, "+")
			end
		end
	end
	return "."
end

sgs.ai_use_priority.Knowspread = 9.18
sgs.ai_use_value.Knowspread = 6
sgs.ai_keep_value.Knowspread = 3.7

sgs.ai_skill_invoke.phjiJdg = function(self, data)
	local use = data:toCardUse()
	local flag = true
	for _, enemy in sgs.qlist(use.to) do
		if self:isFriend(enemy) then flag = false end
	end
	return flag
end

function sgs.ai_weapon_value.jiujingdeng(self, enemy)
	if enemy and (enemy:hasArmorEffect("vine") or enemy:getMark("@gale") > 0) then return 4.89 end
end

local jiujingdengVS_skill={}
jiujingdengVS_skill.name="jiujingdengVS"
table.insert(sgs.ai_skills,jiujingdengVS_skill)
jiujingdengVS_skill.getTurnUseCard=function(self,inclusive) 
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	local red_card
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	for _,card in ipairs(cards) do
		if card:getSuit() == sgs.Card_Heart 
		and not card:inherits("Fireup")
		and not card:inherits("C6")
		and not isCard("Peach", card, self.player)
		and not isCard("ExNihilo", card, self.player)
			and ((self:getUseValue(card)<sgs.ai_use_value.Fireup) or inclusive) then
			-- 如果卡牌为红色，且不是【点燃】、【葡萄糖】和【桃】，且使用价值比【点燃】要低或者没有手牌
			red_card = card
			break -- 记录这一张卡牌并跳出循环
		end
	end

	if red_card then -- 若找到了合适的卡牌作为子卡	
		local suit = red_card:getSuitString()
		local number = red_card:getNumberString()
		local card_id = red_card:getEffectiveId()
		local card_str = ("fireup:jiujingdengVS[%s:%s]=%d"):format(suit, number, card_id)
		local slash = sgs.Card_Parse(card_str)
		assert(slash) -- 验证 slash 不为 nil
		return slash
	end
end

function sgs.ai_cardneed.jiujingdengVS(to, card)
	return to:getHandcardNum() < 5 and card:getSuit() == sgs.Card_Heart
end

function sgs.ai_armor_value.bolisai(player, self)
	local n = 4.5
	for _,p in ipairs(self:getEnemies(player)) do
		if p:inMyAttackRange(player) then
			n = n - 1.5
		else
			n = n + 0.5
		end
		n = n + p:getHandcardNum() * 0.6
	end
	return n
end

function PeaceAgreePower(player, self)
	local eneprofit = 0
	local friprofit = 0
	for _,p in ipairs(self:getEnemies(player)) do
		if self:isFriend(p) then
			if p:getHp()>player:getHp() then
				friprofit = friprofit - 1
				if p:getRole() == "lord" 
				and (player:getRole() == "loyalist" 
				or (player:getRole() == "renegade") and self.room:alivePlayerCount() ~= 2) and self:isWeak(p) then
					friprofit = friprofit - 100 
				end
				if self:needKongcheng(p,true) and p:isKongcheng() then
					friprofit = friprofit - 1
				end
			elseif p:getHp()<player:getHp() and p:isWounded() then
				friprofit = friprofit + 1
				if self:isWeak(p) or p:isNude() then
					friprofit = friprofit + 1
				end
			end
		else
			if p:getHp()>player:getHp() then
				eneprofit = eneprofit - 1
				if self:needKongcheng(p,true) and p:isKongcheng() then
					eneprofit = eneprofit - 1
				end
			elseif p:getHp()<player:getHp() and p:isWounded() then
				eneprofit = eneprofit + 1
				if self:isWeak(p) or p:isNude() then
					eneprofit = eneprofit + 1
				end
			end
		end
	end
	return (friprofit - eneprofit)
end

function sgs.ai_armor_value.peaceagree(player, self)
	if player:getArmor() then 
		if not player:getArmor():isKindOf("peaceagree") then
			return PeaceAgreePower(player, self) - 10
		else
			return PeaceAgreePower(player, self)
		end
	end
	return 5
end

local peacebroke_skill={}
peacebroke_skill.name="peacebroke"
table.insert(sgs.ai_skills,peacebroke_skill)

peacebroke_skill.getTurnUseCard = function(self)
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)
	local arcard = false
	for _,card in ipairs(cards) do
		if card:isKindOf("Armor") and sgs.ai_armor_value[card:getClassName()] and sgs.ai_armor_value[card:getClassName()] > 0 then arcard = true end
	end
	local a = arcard and 10 or 0
	if self.player:getArmor() and self.player:getArmor():isKindOf("peaceagree") and PeaceAgreePower(self.player, self) < a then return sgs.Card_Parse("#peacebrokeCard=.") end
end

sgs.ai_skill_use_func.peacebrokeCard = function(card, use, self)
	use.card = self.player:getArmor()
	return
end

sgs.ai_use_priority["peacebroke"] = 6.9

local youjihecheng_skill={}
youjihecheng_skill.name="youjihecheng"
table.insert(sgs.ai_skills,youjihecheng_skill)
youjihecheng_skill.getTurnUseCard=function(self,inclusive) 
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	local val
	if self:isWeak(self.player) then 
		val = 1.3
	elseif (not self.player:isWounded()) then
		val = 2
	else
		val = 1.65
	end
	local hoc = nil
	local twc = nil
	for _,card in ipairs(cards) do
		if (not card:inherits("C6"))
		and not isCard("Peach", card, self.player)
		and not isCard("ExNihilo", card, self.player)
			and (((self:getUseValue(card)*val)<sgs.ai_use_value.C6) or inclusive) then
			if hoc then
				twc = card
				break
			else
				hoc = card
			end
			table.removeOne(cards, card)
		end
	end

	if twc then -- 若找到了合适的卡牌作为子卡	
		local card_str = ("C6:youjihecheng[%s:%s]=%d+%d"):format("to_be_decided", 0, hoc:getId(), twc:getId())
		local slash = sgs.Card_Parse(card_str)
		assert(slash) -- 验证 slash 不为 nil
		return slash
	end
end

sgs.ai_view_as.zslengjingVS = function(card, player, card_place)
	local suit = card:getSuitString()
	local number = card:getNumberString()
	local card_id = card:getEffectiveId()
	if card:isBlack() and card_place == sgs.Player_PlaceHand then
		return ("zheshe:zslengjingVS[%s:%s]=%d"):format(suit, number, card_id)
	end
end

function sgs.ai_cardneed.zslengjingVS(to, card)
	return to:getCards("h"):length() < 2 and card:isBlack()
end

function sgs.ai_armor_value.lengjing(player, self)
	if player:hasSkill("gushou") then
		return 4.5 + getKnownCard(player, self.player, "black", false, "he") + 1
	end
	return 4.5 + getKnownCard(player, self.player, "black", false, "he")
end

sgs.ai_skill_choice.drosophila = function(self, choice)
	if self.player:getHp() < self.player:getMaxHp() then return "recover" end
	if self:needKongcheng(self.player, true) then return "recover" end
	return "draw"
end

local tongfenyigou_skill={}
tongfenyigou_skill.name="tongfenyigou"
table.insert(sgs.ai_skills,tongfenyigou_skill)
tongfenyigou_skill.getTurnUseCard=function(self,inclusive)
	local suitlist = {}
	if not self.player:isKongcheng() then
		local cards = self.player:getHandcards()
		for _,c in sgs.qlist(cards) do
			if not table.contains(suitlist, c:getSuitString()) then
				table.insert(suitlist, c:getSuitString())
			end
		end
		if (not self.player:hasUsed("#tongfenyigouCard"))
		and (((4 - #suitlist)*(self.player:getLostHp() + 2))/4) > (cards:length()/3) then 
			local card_str = ("#tongfenyigouCard:.:")
			return sgs.Card_Parse(card_str) 
		end
	end
end

sgs.ai_skill_use_func["#tongfenyigouCard"]=function(card,use,self)
	use.card = card
end

sgs.ai_use_value["tongfenyigouCard"] = 8
sgs.ai_use_priority["tongfenyigouCard"] = 3.9

local madejian_skill={}
madejian_skill.name="madejian"
table.insert(sgs.ai_skills,madejian_skill)
madejian_skill.getTurnUseCard=function(self,inclusive) 
	local cards = self.player:getCards("he")
	local newanal = sgs.Sanguosha:cloneCard("alkali", sgs.Card_NoSuit, 0)
	if self.player:isCardLimited(newanal, sgs.Card_MethodUse) or self.player:isProhibited(self.player, newanal) then return nil end
	if not (self.player:usedTimes("Alkali") + self.player:usedTimes("Acid") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, self.player , newanal) or (self.player:getWeapon() and self.player:getWeapon():isKindOf("alkalidd"))) then return nil end
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
--	self.room:writeToConsole("mj Handcard Got")
	local isequip = false
	local hoc = nil
	local twc = nil
	local val = 1.5
	for  _,enemy in ipairs(self.enemies) do
		if self:isWeak(enemy) and val > 0.75 then
			val = val - 0.15
		end
	end
	for _,card in ipairs(cards) do
		if (not card:inherits("Alkali"))
		and not isCard("Peach", card, self.player)
		and not isCard("ExNihilo", card, self.player)
		and (not card:inherits("C6")) then
			if (not isequip) and card:isKindOf("EquipCard") then
				if self:getUseValue(card) + self:getUseValue(card,self.kept) < (4 * sgs.ai_use_value.Alkali) / val then
					hoc = card
				--	self.room:writeToConsole("mj Good Equip")
					isequip = true
					break
				end
			elseif (not isequip) and (not card:isKindOf("EquipCard")) then
				if self:getUseValue(card) * val < sgs.ai_use_value.Alkali then
				--	self.room:writeToConsole("mj Good noEquip")
					if hoc then
						twc = card
						break
					else
						hoc = card
					end
				end
			end
		end
	end
--	self.room:writeToConsole("mj Carded")
	if hoc then -- 若找到了合适的卡牌作为子卡	
		local slash = nil
	--	self.room:writeToConsole("mj Will Use")
		if twc then
			local card_str = ("alkali:madejian[%s:%s]=%d+%d"):format("to_be_decided", 0, hoc:getId(), twc:getId())
			slash = sgs.Card_Parse(card_str)
			assert(slash) -- 验证 slash 不为 nil
		elseif hoc:isKindOf("EquipCard") then
			local suit = hoc:getSuitString()
			local number = hoc:getNumberString()
			local card_id = hoc:getEffectiveId()
			local card_str = ("alkali:madejian[%s:%s]=%d"):format(suit, number, card_id)
			slash = sgs.Card_Parse(card_str)
			assert(slash) -- 验证 slash 不为 nil
		end
		if slash then
		--	self.room:writeToConsole("mj Pre CD")
			return slash
		end
	end
end

sgs.ai_cardneed.madejian = function(to, card, self)
	return to:getHandcardNum() >= 3 and not to:isCardLimited(sgs.Sanguosha:cloneCard("alkali", sgs.Card_NoSuit, 0), sgs.Card_MethodUse)
end

sgs.ai_skill_invoke.wuzhishouheng = function(self, data)
	return true 
end

sgs.ai_skill_use["@@wuzhishouheng"] = function(self, prompt)
	if self:needBear() then return "." end
	self:sort(self.friends, "handcard")
	local n = 0
	local flist = ""
	for _, friend in ipairs(self.friends) do
		if not(self:needKongcheng(friend) and friend:getHandcardNum() == 0 
		or friend:hasSkill("manjuan") or friend:hasSkill("noslonghun")) then
			if n == 0 then
				flist = flist .. friend:objectName()
			else
				flist = flist .. "+" .. friend:objectName()
			end
			n = n + 1
		end
		if n == self.player:getPile("things"):length() then break end
	end
	if n > 0 then
		return "#wuzhishouhengCard:.:->" .. flist
	else
		return "."
	end
end

sgs.ai_skill_invoke.lwxyanghua = function(self, data)
	local damage = data:toDamage()
	local target = damage.to
	if not self:isEnemy(target) then return false end
	if target:hasArmorEffect("silver_lion") then return false end
	local cards = sgs.QList2Table(self.player:getHandcards())
	local onlypeach = true
	local peachnum = 13
	local trytopeach = true
	for _, card in ipairs(cards) do
		if not(card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic") or card:isKindOf("ExNihilo")) then
			onlypeach = false
		elseif card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic") then
			if card:getNumber()<peachnum then
				peachnum = card:getNumber()
			end
		end
	end	
	for _, card in sgs.qlist(target:getHandcards()) do
		if not(card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic")) then
			trytopeach = false
		end
	end	
	if onlypeach then
		return (trytopeach and peachnum <6)
	else
		return true
	end
end

function sgs.ai_skill_pindian.lwxyanghua(minusecard, self, requestor, maxcard)
	local cards, maxcard = sgs.QList2Table(self.player:getHandcards())
	local function compare_func(a, b)
		return a:getNumber() > b:getNumber()
	end
	table.sort(cards, compare_func)
	for _, card in ipairs(cards) do
		if self:getUseValue(card) < 3.5 and not self:isWeak(self.player) then maxcard = card break end
	end
	return maxcard or cards[1]
end

sgs.ai_skill_invoke.hmlhuanyuan = function(self, data)
	local damage = data:toDamage()
	local target = damage.from
	if not self:isFriend(damage.to) then return false end
	if damage.to:hasArmorEffect("silver_lion") and damage.damage > 1 then return false end
	local cards = sgs.QList2Table(self.player:getHandcards())
	local onlypeach = true
	local peachnum = 13
	local trytopeach = true
	for _, card in ipairs(cards) do
		if not(card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic") or card:isKindOf("ExNihilo")) then
			onlypeach = false
		elseif card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic") then
			if card:getNumber()<peachnum then
				peachnum = card:getNumber()
			end
		end
	end	
	for _, card in sgs.qlist(target:getHandcards()) do
		if not(card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic")) then
			trytopeach = false
		end
	end	
	if onlypeach then
		return (trytopeach and peachnum <6)
	else
		return true
	end
end

sgs.ai_skill_invoke.bccanza = function(self, data)
	if self.player:isKongcheng() and (not self:needKongcheng(self.player)) then return true end
	local recnum = 0
	local totalvalue = 0
	for _, card in sgs.qlist(self.player:getHandcards()) do
		totalvalue = totalvalue + (self:getUseValue(card) + self:getKeepValue(card))/2
		if card:isKindOf("Peach") or card:isKindOf("C6") or card:isKindOf("Analeptic") then
			recnum = recnum + 1
		elseif card:isKindOf("Jink") then
			recnum = recnum + 0.3
		end
	end	
	return (recnum * 9 < self.player:getHandcards():length()+1) and (totalvalue < (self.player:getHandcards():length()+2)*5)
end

sgs.ai_skill_invoke.bcdaodian = function(self, data)
	local flag = true
	if self.room:getCurrent():isChained() then
		for _, friend in ipairs(self.friends) do
			if friend:isChained() and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then flag = false end
		end
	end
	return (not self:isFriend(self.room:getCurrent())) and flag
end

local boom_skill={}
boom_skill.name="boom"
table.insert(sgs.ai_skills,boom_skill)
boom_skill.getTurnUseCard=function(self,inclusive)
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	local enemies = self.enemies
	local cmp = function(a, b)
		return (a:getHp() + (a:getHandcardNum() / 3)) < (b:getHp() + (b:getHandcardNum() / 3))
	end
	table.sort(enemies, cmp)
	local card_id = nil
	local tar = nil
	for _,card in ipairs(cards) do
		if self:getOverflow() > 0 then
			card_id = card:getEffectiveId()
		end
		for _, enemy in ipairs(enemies) do
			if enemy:getPile("tnt"):length() < 2 and self:damageIsEffective(enemy, sgs.DamageStruct_Fire, self.player) then
				if card_id then
					tar = enemy:objectName()
				elseif self:isWeak(enemy) then
					card_id = cards[1]:getEffectiveId()
					tar = enemy:objectName()
				end
			end
		end
	end
	if card_id and tar then 
		local card_str = ("#boomCard:.:")
		return sgs.Card_Parse(card_str) 
	end
end

sgs.ai_skill_use_func["#boomCard"]=function(card,use,self)
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	local enemies = self.enemies
	local cmp = function(a, b)
		return (a:getHp() + (a:getHandcardNum() / 3)) < (b:getHp() + (b:getHandcardNum() / 3))
	end
	table.sort(enemies, cmp)
	local card_id = nil
	for _,acard in ipairs(cards) do
		if self:getOverflow() > 0 then
			card_id = acard:getId()
			break
		end
	end
	if not card_id then return end
	use.card = sgs.Card_Parse("#boomCard:"..card_id..":")
	for _, enemy in ipairs(enemies) do
		if enemy:getPile("tnt"):length() < 2 and self:damageIsEffective(enemy, sgs.DamageStruct_Fire, self.player) then
			if card_id then
				if use.to then 
					use.to:append(enemy)
					return
				end
			elseif self:isWeak(enemy) then
				card_id = cards[1]:getEffectiveId()
				if use.to then 
					use.to:append(enemy)
					return 
				end
			end
		end
	end
end

sgs.ai_use_priority.boomCard = 2.1
sgs.ai_use_value.boomCard = 5.5

sgs.ai_skill_invoke.tntfac = function(self, data)
	local n = 0
	local alives = self.room:getAlivePlayers()
	for _,p in sgs.qlist(alives) do
		 if p:getPile("tnt"):length() > 0 then
			n = n + p:getPile("tnt"):length()
		 end
	end 
	return n - 2 < self.player:getMaxHp()-self.player:getHandcardNum() 
end

sgs.ai_skill_use["@@Drfenya"] = function(self, prompt)
	local usedata = self.room:getTag("fenyac"):toCardUse()
	local usec = usedata.card
	local tolist = {}
	if usec:isKindOf("Peach") or usec:isKindOf("C6") or usec:isKindOf("ExNihilo") or usec:isKindOf("GodSalvation") then
		for _,friend in ipairs(self.friends_noself) do
			if not (friend:hasFlag("cardfrom") or (self:needKongcheng(friend) and friend:isKongcheng())) then
				table.insert(tolist,friend:objectName())
			end
			if #tolist > self.player:getLostHp() then break end
		end
	elseif (usec:isKindOf("FireAttack") and self:isFriend(usedata.from)) then
		for _,friend in ipairs(self.friends_noself) do
			if (not friend:hasFlag("cardfrom")) and (not self:damageIsEffective(friend,sgs.DamageStruct_Fire,usedata.from)) then
				table.insert(tolist,friend:objectName())
			end
			if #tolist > self.player:getLostHp() then break end
		end
	elseif usec:isKindOf("FireAttack") then
		return "."
	else
		if not usec:isKindOf("Dismantlement") then
			for _,enemy in ipairs(self.enemies) do
				if (not enemy:hasFlag("cardfrom")) and not ((enemy:hasSkill("yuce") or not self:damageIsEffective(enemy)) and (usec:isKindOf("Slash") or usec:isKindOf("Acid") or usec:isKindOf("Alkali") or usec:isKindOf("Duel") or usec:isKindOf("Sizao") or usec:isKindOf("Fireup"))) then
					table.insert(tolist,enemy:objectName())
				end
				if #tolist > self.player:getLostHp() then break end
			end
		end
	end
	if #tolist == 0 then
		return "."
	else
		return "#DrfenyaCard:.:->" .. table.concat(tolist, "+")
	end
end

sgs.ai_skill_invoke.Dratoms = function(self, data)
	local move = data:toMoveOneTime()
	local n = 0
	for i = 1,self.player:getPile("atoms"):length(),1 do
		n = n + sgs.Sanguosha:getCard(self.player:getPile("atoms"):at(i-1)):getNumber()
	end
	local canget = false
	for _,card_id in sgs.qlist(move.card_ids) do
		local carda = sgs.Sanguosha:getCard(card_id)
		if carda:getNumber() <= n and (self:getUseValue(carda) + self:getKeepValue(carda)) > 10 then
			canget = true
		end
	end
	return canget
end

sgs.ai_skill_askforag["Dratomstoget"] = function(self, card_ids)
	local cardtable = card_ids
	local cmp = function(a, b)
		local ac = sgs.Sanguosha:getCard(a)
		local bc = sgs.Sanguosha:getCard(b)
		if self:getUseValue(ac) + self:getKeepValue(ac) == self:getUseValue(bc) + self:getKeepValue(bc) then return ac:getNumber()<bc:getNumber() end
		return self:getUseValue(ac) + self:getKeepValue(ac) > self:getUseValue(bc) + self:getKeepValue(bc)
	end
	table.sort(cardtable, cmp)
	return cardtable[1]
end

sgs.ai_skill_askforag["Dratoms"] = function(self, card_ids)
	local ton = self.room:getTag("atomstogetnum"):toInt()
	local plusnum = 0
	local finalnum = 20
	local checknum = 0
	local findedlist = {}
	local pluslist = {}
	local finalist = {}
	while checknum < 10 do
		local pluss = 0
		while plusnum <= ton do
			local x = math.random(1,#card_ids)
			if not table.contains(pluslist,card_ids[x]) then
				plusnum = plusnum + sgs.Sanguosha:getCard(card_ids[x]):getNumber()
				pluss = pluss + sgs.Sanguosha:getCard(card_ids[x]):getEffectiveId()
				table.insert(pluslist,card_ids[x])
			end
		end
		if plusnum < finalnum then
			finalnum = plusnum
			finalist = pluslist
		end
		if not table.contains(findedlist,pluss) then
			table.insert(findedlist,pluss)
			if finalnum == plusnum then
				checknum = 0
			end
		else
			if finalnum == plusnum then
				checknum = checknum + 1
			end
		end
		plusnum = 0
		pluslist = {}
	end
	return finalist[1]
end

sgs.ai_skill_invoke["#atomsget"] = function(self, data)
	return true 
end

sgs.ai_skill_invoke.zhouqibiao = function(self, data)
	return (self.player:getMark("@zhuzuspade0") + self.player:getMark("@zhuzuspade1") +self.player:getMark("@zhuzudiamond0") + self.player:getMark("@zhuzudiamond1") + self.player:getMark("@zhuzuheart1") + self.player:getMark("@zhuzuheart0") + self.player:getMark("@zhuzuclub0") + self.player:getMark("@zhuzuclub1")) < 8 or ((self.room:getCurrent():hasSkill("guanxing") or self.room:getCurrent():hasSkill("xinzhan")) and self:isEnemy(self.room:getCurrent()))
end

local zhouqibiao_skill={}
zhouqibiao_skill.name="zhouqibiao"
table.insert(sgs.ai_skills,zhouqibiao_skill)
zhouqibiao_skill.getTurnUseCard=function(self,inclusive)
	if self.player:getMark("@zhuzuspade0") + self.player:getMark("@zhuzuspade1") +self.player:getMark("@zhuzudiamond0") + self.player:getMark("@zhuzudiamond1")+self.player:getMark("@zhuzuheart1")+self.player:getMark("@zhuzuheart0")+self.player:getMark("@zhuzuclub0")+self.player:getMark("@zhuzuclub1") == 8 then
		if self.enemies then
			local card_str = ("#zhouqibiaoCard:.:")
			return sgs.Card_Parse(card_str) 
		end
	end
end

local function can_be_selected_as_target_zhouqi(self, card, who)
	-- validation of strategy
	if self:isEnemy(who) and self:damageIsEffective(who) and not self:cantbeHurt(who) and not self:getDamagedEffects(who) and not self:needToLoseHp(who) then
		if not self.player:hasSkill("jueqing") then
			if who:hasSkill("guixin") and (self.room:getAliveCount() >= 4 or not who:faceUp()) and not who:hasSkill("manjuan") then return false end
			if (who:hasSkill("ganglie") or who:hasSkill("neoganglie")) and (self.player:getHp() == 1 and self.player:getHandcardNum() <= 2) then return false end
			if who:hasSkill("jieming") then
				for _, enemy in ipairs(self.enemies) do
					if enemy:getHandcardNum() <= enemy:getMaxHp() - 2 and not enemy:hasSkill("manjuan") then return false end
				end
			end
			if who:hasSkill("fangzhu") then
				for _, enemy in ipairs(self.enemies) do
					if not enemy:faceUp() then return false end
				end
			end
			if who:hasSkill("yiji") then
				local huatuo = self.room:findPlayerBySkillName("jijiu")
				if huatuo and self:isEnemy(huatuo) and huatuo:getHandcardNum() >= 3 then
					return false
				end
			end
		end
		return true
	elseif self:isFriend(who) then
		if who:hasSkill("yiji") and not self.player:hasSkill("jueqing") then
			local huatuo = self.room:findPlayerBySkillName("jijiu")
			if (huatuo and self:isFriend(huatuo) and huatuo:getHandcardNum() >= 3 and huatuo ~= self.player)
				or (who:getLostHp() == 0 and who:getMaxHp() >= 3) then
				return true
			end
		end
		if who:hasSkill("hunzi") and who:getMark("hunzi") == 0
		  and who:objectName() == self.player:getNextAlive():objectName() and who:getHp() == 2 then
			return true
		end
		return false
	end
	return false
end

sgs.ai_skill_use_func["#zhouqibiaoCard"] = function(card, use, self)
	self:sort(self.enemies)
	local to_use = false
	for _, enemy in ipairs(self.enemies) do
		if can_be_selected_as_target_zhouqi(self, card, enemy) then
			to_use = true
			break
		end
	end
	if not to_use then
		for _, friend in ipairs(self.friends_noself) do
			if can_be_selected_as_target_zhouqi(self, card, friend) then
				to_use = true
				break
			end
		end
	end
	if to_use then
		use.card = card
		if use.to then
			for _, enemy in ipairs(self.enemies) do
				if can_be_selected_as_target_zhouqi(self, card, enemy) then
					use.to:append(enemy)
				end
			end
			for _, friend in ipairs(self.friends_noself) do
				if can_be_selected_as_target_zhouqi(self, card, friend) then
					use.to:append(friend)
				end
			end
			assert(use.to:length() > 0)
		end
	end
end

sgs.ai_use_value.zhouqibiaoCard = 4.5
sgs.ai_use_priority.zhouqibiaoCard = 2.35

sgs.ai_skill_invoke.mjyuce = function(self, data)
	local judge = data:toJudge()
	local cards = sgs.QList2Table(self.player:getCards("h"))
	local card_id = self:getRetrialCardId(cards, judge)
	if card_id ~= -1 then
		return true
	end
	return false
end

sgs.ai_cardshow.mjyuce = function(self, requestor)
	local judge = self.room:getTag("mjyucestruct"):toJudge()
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)
	self:sortByUseValue(cards,true)
	local result = cards[1]
	local card_id = self:getRetrialCardId(cards, judge)
	if card_id ~= -1 then
		result = sgs.Sanguosha:getCard(card_id)
	end
	return result -- 返回结果
end

sgs.ai_skill_discard.mjyuce = function(self, discard_num, optional, include_equip)
	local judge = self.room:getTag("mjyucestruct"):toJudge()
	local gets1 = self.room:getTag("mjyucegets1"):toCard():getSuitString()
	local gets2 = self.room:getTag("mjyucegets2"):toCard():getSuitString()
	local gets = {}
	table.insert(gets, gets1)
	table.insert(gets, gets2)
	local tochange = {}
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards)
	local mj = self.room:findPlayerBySkillName("mjyuce")
	self:sortByUseValue(cards,true)
	if self:isFriend(mj) then
		if judge:isGood(self.room:getTag("mjyucegets1"):toCard()) == judge:isGood(self.room:getTag("mjyucegets2"):toCard()) then
			for _, card in ipairs(cards) do
				if table.contains(gets,card:getSuitString()) then
					table.insert(tochange, card:getEffectiveId())
					break
				end
			end
		else
			for _, card in ipairs(cards) do
				if not table.contains(gets,card:getSuitString()) then
					table.insert(tochange, card:getEffectiveId())
					break
				end
			end
		end
	else
		if judge:isGood(self.room:getTag("mjyucegets1"):toCard()) == judge:isGood(self.room:getTag("mjyucegets2"):toCard()) then
			for _, card in ipairs(cards) do
				if not table.contains(gets,card:getSuitString()) then
					table.insert(tochange, card:getEffectiveId())
					break
				end
			end
		else
			for _, card in ipairs(cards) do
				if table.contains(gets,card:getSuitString()) then
					table.insert(tochange, card:getEffectiveId())
					break
				end
			end
		end
	end
	if #tochange == 0 then table.insert(tochange, cards[1]:getEffectiveId()) end
	return tochange
end

sgs.ai_skill_invoke.dvdianjie = function(self, data)
	if self.player:getMark("@electricbreak") == 0 then return false end
	local use = data:toCardUse()
	local djvalue = function(victim)
		if not self:damageIsEffective(victim, sgs.DamageStruct_Thunder, self.player) then return 0 end
		local basvalue = 1
		if self:isWeak(victim) then basvalue = basvalue + 0.75 end
		if victim:hasSkills("fankui|jieming|yiji|ganglie|enyuan|fangzhu|guixin") and (not self.player:hasSkill("jueqing")) then basvalue = basvalue - 1 end
		return basvalue
	end
	local goodv = 0
	local badv = 0 
	for _, p in sgs.qlist(use.to) do
		if self:isFriend(p) then
			badv = badv + djvalue(p)
		else
			goodv = goodv + djvalue(p)
		end
	end
	return goodv > (badv+0.5)
end

sgs.ai_skill_playerchosen.dvdianjie = function(self, targets)
	local targetable =sgs.QList2Table(targets)
	local val = function(who) 
		if (not self:isFriend(who)) then return -100 end
		if who:hasSkill("manjuan") then return -95 end
		if who:isJilei(sgs.Sanguosha:getCard(self.room:getTag("Dianjie"):toInt())) then return -90 end
		if self:needKongcheng(who) and who:getHandcardNum() == 0 then return -50 end
		if who:hasSkills("jizhi|jianying") then return 2 end
		return 1
	end
	local cmp = function(a, b)
		if val(a) == val(b) then
			return a:getHandcardNum() < b:getHandcardNum()
		end
		return val(a) > val(b)
	end
	table.sort(targetable, cmp)
	return targetable[1]
end

sgs.ai_skill_invoke.dvceran = function(self, data)
	local flag = 0
	for _,enemy in ipairs(self.enemies) do
		if enemy:hasArmorEffect("vine") and self:damageIsEffective(enemy, sgs.DamageStruct_Fire) then flag = flag + 1 end
	end
	for _,friend in ipairs(self.friends) do
		if friend:hasArmorEffect("vine") and self:damageIsEffective(friend, sgs.DamageStruct_Fire) then flag = flag - 1 end
	end
	if flag + 1 > 0 then 
		return true
	elseif not (flag + 2 < 0) then
		if #(self:getChainedFriends()) < #(self:getChainedEnemies()) and
		#(self:getChainedFriends()) + #(self:getChainedEnemies()) > 1 then return true end
	end
	return false
end

sgs.ai_skill_invoke.dvcerangive = function(self, data)
	local splayer = self.room:findPlayerBySkillName("dvceran")
	return splayer and self:isFriend(splayer) and not (self:needKongcheng(splayer) and splayer:getHandcardNum() == 0)
end

sgs.ai_skill_discard.dvceran = function(self, discard_num, optional, include_equip)
	local card
	local togive = {}
	if self:needToThrowArmor() then
		card = self.player:getArmor()
	end
	if not card then
		local hcards = self.player:getCards("h")
		hcards = sgs.QList2Table(hcards)
		self:sortByUseValue(hcards, true)

		for _, hcard in ipairs(hcards) do
			if hcard:isKindOf("C6") and not self:isWeak(self.player) then
				card = hcard
				break
			elseif hcard:isKindOf("Slash") then
				if self:getCardsNum("Slash") > 1 then
					card = hcard
					break
				else
					local dummy_use = { isDummy = true, to = sgs.SPlayerList() }
					self:useBasicCard(hcard, dummy_use)
					if dummy_use and dummy_use.to and (dummy_use.to:length() == 0
							or dummy_use.to:length() == 1 and not self:hasHeavySlashDamage(self.player, hcard, dummy_use.to:first())) then
						card = hcard
						break
					end
				end
			elseif hcard:isKindOf("EquipCard") then
				card = hcard
				break
			end
		end
	end
	if not card then
		local ecards = self.player:getCards("e")
		ecards = sgs.QList2Table(ecards)

		for _, ecard in ipairs(ecards) do
			if ecard:isKindOf("Weapon") or ecard:isKindOf("OffensiveHorse") then
				card = ecard
				break
			end
		end
	end
	if card then
		table.insert(togive,card:getEffectiveId())
	end
	return togive
end

sgs.ai_skill_invoke.slransu = function(self, data)
	return self:ImitateResult_DrawNCards(self.player, self.player:getVisibleSkillList(true)) <= 3 and #self:getEnemies(self.player) > 0
end

sgs.ai_skill_playerchosen.slransu = function(self, targets)
	self:sort(self.enemies, "defense")
	local fire_attack = sgs.Sanguosha:cloneCard("fireup", sgs.Card_NoSuit, 0)
	local can_attack = function(enemy)
		local damage = 1
		if not self.player:hasSkill("jueqing") and not enemy:hasArmorEffect("silver_lion") then
			if enemy:hasArmorEffect("vine") then damage = damage + 1 end
			if enemy:getMark("@gale") > 0 then damage = damage + 1 end
		end
		if not self.player:hasSkill("jueqing") and enemy:hasSkill("mingshi") and self.player:getEquips():length() <= enemy:getEquips():length() then
			damage = damage - 1
		end
		return self:objectiveLevel(enemy) > 3 and damage > 0 and not self.room:isProhibited(self.player, enemy, fire_attack)
				and self:damageIsEffective(enemy, sgs.DamageStruct_Fire, self.player) and not self:cantbeHurt(enemy, self.player, damage) and (not enemy:hasFlag("bls"))
				and self:hasTrickEffective(fire_attack, enemy)
				and sgs.isGoodTarget(enemy, self.enemies, self)
				and (self.player:hasSkill("jueqing")
					or (not (enemy:hasSkill("jianxiong") and not self:isWeak(enemy))
						and not (self:getDamagedEffects(enemy, self.player))
						and not (enemy:isChained() and not self:isGoodChainTarget(enemy, self.player, sgs.DamageStruct_Fire, nil, fire_attack))))
	end

	local targetes = {}
	local enemies = {}
	for _, p in sgs.qlist(targets) do
		if not self:isFriend(p) then
			table.insert(enemies,p)
		end
	end

	for _, enemy in ipairs(enemies) do
		local damage = 1
		if not enemy:hasArmorEffect("silver_lion") then
			if enemy:hasArmorEffect("vine") then damage = damage + 1 end
			if enemy:getMark("@gale") > 0 then damage = damage + 1 end
		end
		if not self.player:hasSkill("jueqing") and enemy:hasSkill("mingshi") and self.player:getEquips():length() <= enemy:getEquips():length() then
			damage = damage - 1
		end
		if not self.player:hasSkill("jueqing") and self:damageIsEffective(enemy, sgs.DamageStruct_Fire, self.player) and damage > 1 then
			if not table.contains(targetes, enemy) then table.insert(targetes, enemy) end
		end
	end
	for _, enemy in ipairs(enemies) do
		if not table.contains(targetes, enemy) then table.insert(targetes, enemy) end
	end

	if #targetes > 0 then
		return targetes[1]
	end
end

sgs.ai_skill_invoke.slmoyan = function(self, data)
	local peach_num = self:getCardsNum("Peach")-- + self:getCardsNum("Analeptic")
	local ana = self:getCardsNum("Analeptic")
	local basicn = self.player:getHandcardNum()
	local wgt = nil 
	local jia = nil
	local hasfriend = false
	if self.player:isNude() then return false end
	for _, p in sgs.qlist(self.room:getAlivePlayers()) do
		if self:isFriend(p) then
			hasfriend = true
		end
		if p:hasSkill("buyi") and self:isFriend(p) then
			wgt = p
		end
		if p:hasSkill("wansha") and self.room:getCurrent():objectName() == p:objectName() then
			jia = p
		end
	end
	for _, card in sgs.qlist(self.player:getHandcards()) do
		if card:isKindOf("BasicCard") then
			basicn = basicn - 1
		end
	end
	if wgt and basicn ~= 0 then return false end
	if jia and peach_num > 0 then return false end
	if ana > 0 then return false end
	if self.player:getMark("Global_PreventPeach") == 0 and peach_num ~= 0 then return false end
	return hasfriend 
end

sgs.ai_skill_playerchosen.slmoyan = function(self, targets)
	local c,p = self:getCardNeedPlayer(sgs.QList2Table(self.player:getHandcards()))
	if p then
		return p 
	end
	return self.friends[1]
end

local mlspcr_skill={}
mlspcr_skill.name="mlspcr"
table.insert(sgs.ai_skills,mlspcr_skill)
mlspcr_skill.getTurnUseCard=function(self,inclusive) 
	local cdsuit = self.player:property("CDsuit"):toInt()
	local cdnum = self.player:property("CDnum"):toInt()
	local cdname = self.player:property("CDname"):toString()
	local trick = sgs.Sanguosha:cloneCard(cdname, cdsuit, cdnum)
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	if self.player:hasFlag("mlspcrCan") and trick:isAvailable(self.player) then
		local csname = self.player:property("CDainame"):toString()
		local cdlist = {}
		local n = 0
		local totalvalue = 0
		self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
		for _,card in ipairs(cards) do
			if not card:inherits("C6")
			and not isCard("Peach", card, self.player)
			and not isCard("ExNihilo", card, self.player)
				and (((self:getUseValue(card) + totalvalue)<(sgs.ai_use_value[csname])*1.3) or inclusive)
				and card:getSuit() == cdsuit then
				table.insert(cdlist,card:getEffectiveId())
				n = n + card:getNumber()
				totalvalue = totalvalue + self:getUseValue(card)
				if not (n < cdnum) then
					break -- 跳出循环
				end
			end
		end

		if #cdlist>0 and not (n < cdnum) then -- 若找到了合适的卡牌作为子卡	
			local suit
			if cdsuit == sgs.Card_Spade then
				suit = "spade"
			elseif cdsuit == sgs.Card_Club then
				suit = "club"
			elseif cdsuit == sgs.Card_Heart then
				suit = "heart"
			else 
				suit = "diamond"
			end
			local nn = string.lower(cdname)
			local card_str = ("%s:mlspcr[%s:%s]=%s"):format(nn, suit, cdnum, table.concat(cdlist, "+"))
			local slash = sgs.Card_Parse(card_str)
			assert(slash) -- 验证 slash 不为 nil
		--	self.player:speak("666")
			return slash
		end
	end
end

sgs.ai_skill_invoke.nsboyi = function(self, data)
	local flag = true
	local use = data:toCardUse()
	local card = use.card
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)
	self:sortByUseValue(cards,true)
	local vl = cards[1]
	if self:getUseValue(vl) > self:getUseValue(card) * 0.8 then flag = false end
--[[	local targets = sgs.SPlayerList()
	local prepare = sgs.SPlayerList()
	for _, p in sgs.qlist(self.room:getOtherPlayers(use.from)) do
		if (not p:isKongcheng()) and (p:objectName() ~= use.from:objectName()) and (not use.to:contains(p)) then
			targets:append(p)
		end
	end
	if card:isKindOf("Peach") then 
		for _, p in sgs.qlist(targets) do
			if self:isFriend(p) and p:isWounded() then
				prepare:append(p:objectName())
				flag = true
			end
		end
	elseif card:isKindOf("ExNihilo") or card:isKindOf("C6") or card:isKindOf("Analeptic") then
		for _, p in sgs.qlist(targets) do
			if self:isFriend(p) then
				prepare:append(p:objectName())
				flag = true
			end
		end
	else
		for _, p in sgs.qlist(targets) do
			if self:isEnemy(p) then
				prepare:append(p:objectName())
				flag = true
			end
		end
	end]]--
	local preto
	local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
	for _, p in sgs.qlist(use.to) do
		table.insert(dummy_use.current_targets, p:objectName())
--		self.room:writeToConsole(p:objectName())
	end
	self:useCardByClassName(use.card, dummy_use)
	if dummy_use.card and dummy_use.to:length() > 0 and (not dummy_use.to:first():isKongcheng()) and dummy_use.to:first():objectName() ~= use.from:objectName() then
--		self.room:writeToConsole(dummy_use.to:first():objectName())
		preto = dummy_use.to:first()
	else
		flag = false
	end
	self.player:setTag("nsboyiai", sgs.QVariant(vl:getEffectiveId()))
	local tag = sgs.QVariant()
	tag:setValue(dummy_use.to:first())
	self.player:setTag("nsboyiuse", tag)
--	self.room:writeToConsole("tagset")
--	self.player:setTag("nsboyiai", sgs.QVariant(table.concat(QList2Table(prepare), "+")))
--	self.player:setTag("nsboyiispeach", sgs.QVariant(card:isKindOf("Peach")))
	return flag
end

sgs.ai_skill_playerchosen.nsboyi = function(self, targets)
	local prepare = self.player:getTag("nsboyiai"):toInt()
	local ispeach = self.player:getTag("nsboyiuse"):toPlayer()
--	self.room:writeToConsole("666"..ispeach:objectName())
	return ispeach
	--[[local preparing = sgs.SPlayerList()
	for _, p in sgs.qlist(targets) do
		if table.contains(prepare, p:objectName()) then
			preparing:append(p)
		end
	end
	if self:isFriend(preparing:at(0)) then 
		if ispeach then
			local getCmpHp = function(p)
				local hp = p:getHp()
				if p:isLord() and self:isWeak(p) then hp = hp - 10 end
				if p:objectName() == self.player:objectName() and self:isWeak(p) and p:hasSkill("qingnang") then hp = hp - 5 end
				if p:hasSkill("buqu") and p:getPile("buqu"):length() > 0 then hp = hp + math.max(0, 5 - p:getPile("buqu"):length()) end
				if p:hasSkill("nosbuqu") and p:getPile("nosbuqu"):length() > 0 then hp = hp + math.max(0, 5 - p:getPile("nosbuqu"):length()) end
				if p:hasSkills("nosrende|rende|kuanggu|kofkuanggu|zaiqi") and p:getHp() >= 2 then hp = hp + 5 end
				return hp
			end
			local cmp = function (a, b)
				if getCmpHp(a) == getCmpHp(b) then
					return sgs.getDefenseSlash(a, self) < sgs.getDefenseSlash(b, self)
				else
					return getCmpHp(a) < getCmpHp(b)
				end
			end
			preparing = QList2Table(preparing)
			table.sort(preparing, cmp)
			return preparing[1]
		else
			local getCmp = function(p)
				if p:getHandcardNum() == 1 and self:needKongcheng(p) then return 100 end
				if p:containsTrick("indulgence") then return 100 end
				return p:getHandcardNum()
			end
			local cmp = function (a, b)
				return getCmp(a) < getCmp(b)
			end
			preparing = QList2Table(preparing)
			table.sort(preparing, cmp)
			return preparing[1]
		end
	else
		
	end]]--
end

sgs.ai_cardshow.nsboyi = function(self, requestor)
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)
	self:sortByUseValue(cards,true)
	local result = cards[1]
	local prepare = self.player:getTag("nsboyiai"):toInt()
	if prepare then
		result = sgs.Sanguosha:getCard(prepare)
	end
	return result -- 返回结果
end

sgs.ai_skill_invoke.nsjunheng = function(self, data)
	return not (self.player:isKongcheng() and self:needKongcheng(self.player,true))
end

sgs.ai_skill_cardask["nsjunhengask"]=function(self, data) 
	local ns = data:toMoveOneTime().from
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards)
	self:sortByUseValue(cards,true)
	if self:isFriend(ns) then return "." end
	for _, card in ipairs(cards) do
		if (card:isKindOf("Slash") and self:getCardsNum("Slash") > 1)
			or (card:isKindOf("Jink") and self:getCardsNum("Jink") > 2)
			or card:isKindOf("Disaster")
			or (card:isKindOf("EquipCard") and not self:hasSkills(sgs.lose_equip_skill))
			or (not self.player:hasSkills("nosjizhi|jizhi") and (card:isKindOf("Collateral") or card:isKindOf("GodSalvation")
			or card:isKindOf("FireAttack") or card:isKindOf("IronChain") or card:isKindOf("AmazingGrace"))) then
			return "$" .. card:getEffectiveId()
		end
	end
	return "."
end

local mtliebian_skill={}
mtliebian_skill.name="mtliebian"
table.insert(sgs.ai_skills,mtliebian_skill)
mtliebian_skill.getTurnUseCard=function(self,inclusive)
	if self.enemies and sgs.Slash_IsAvailable(self.player) and (not self.player:hasUsed("#mtliebianCard")) and (not self.player:isNude()) then
		local card_str = ("#mtliebianCard:.:")
		return sgs.Card_Parse(card_str) 
	end
end

sgs.ai_skill_use_func["#mtliebianCard"] = function(card, use, self)
	self.mtliebianTarget = nil
	local target = {}
	local lbvalue = function(victim)
		local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		if not self:damageIsEffective(victim, sgs.DamageStruct_Normal, self.player) then return 0 end
		if not self.player:canSlash(victim, nil, false) then return 0 end
		if not self:slashIsEffective(slash, victim) then return 0 end
		local n = 1
		if self:hasHeavySlashDamage(self.player, slash, victim) then n = n + 2 end
		if self:isWeak(victim) then n = n + 1 end
		if self:hasSkills(sgs.masochism_skill, victim) then n = n - 0.75 end
		return n
	end
	local cmp = function (a, b)
		return lbvalue(a) > lbvalue(b)
	end
	local cmpa = function (a, b)
		return a:getNumber() < b:getNumber() or (a:getNumber() == b:getNumber() and self:getKeepValue(a) + self:getUseValue(a) < self:getKeepValue(b) + self:getUseValue(b))
	end
	local cmpb = function (a, b)
		return a:getNumber() > b:getNumber() or (a:getNumber() == b:getNumber() and self:getKeepValue(a) + self:getUseValue(a) < self:getKeepValue(b) + self:getUseValue(b))
	end
	local enemies = self.enemies
	table.sort(enemies, cmp)
	local flag = false
	local tokill = 0
	for _,p in ipairs(self.enemies) do
		local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		slash:setSkillName("mtliebian")
		if lbvalue(p) > 1.5 and slash:targetFilter(sgs.PlayerList(), p, self.player) then
			flag = true
			tokill = tokill + 1
			table.insert(target,p)
		end
	end
	table.sort(target, cmp)
	local cards = self.player:getCards("he")
	cards = sgs.QList2Table(cards)
	local touse = {}
	local typed = {}
	self.mtliebianTarget = target
	if flag then
		table.sort(cards, cmpa)
		sgs.ai_use_priority.mtliebianCard = sgs.ai_use_priority.Slash - 0.1
		for _,c in ipairs(cards) do
			if #touse < tokill and self:getKeepValue(c) < self:getKeepValue(sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)) * 1.5 and (#typed == 0 or (not table.contains(typed,c:getTypeId())))then
				table.insert(touse,c:getEffectiveId())
				table.insert(typed,c:getTypeId())
			end
		end
	else
		table.sort(cards, cmpb)
		sgs.ai_use_priority.mtliebianCard = sgs.ai_use_priority.Slash + 1
		for _,c in ipairs(cards) do
			if self:getKeepValue(c) + self:getUseValue(c) < 10 and (#typed == 0 or (not table.contains(typed,c:getTypeId())))then
				table.insert(touse,c:getEffectiveId())
				table.insert(typed,c:getTypeId())
			end
		end
	end
	if #touse > 0 then
		use.card = sgs.Card_Parse("#mtliebianCard:"..table.concat(touse,"+")..":")
	end
	return
end

sgs.ai_skill_use["@@mtliebian"] = function(self, prompt)
	local tgs = self.mtliebianTarget
	local useto = sgs.SPlayerList()
	local tar = {}
	local a = self.player:getMark("liebianslashmk")
	for i = 1,a,1 do
		if i <= #tgs then
			useto:append(tgs[i])
		end
	end
	while useto:length() < a do
		local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
		for _, p in sgs.qlist(useto) do
			table.insert(dummy_use.current_targets, p:objectName())
		end
		local sl = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
		sl:setSkillName("mtliebian")
		self:useCardByClassName(sl, dummy_use)
		if dummy_use.card and dummy_use.to and dummy_use.to:length() > 0 then
			useto:append(dummy_use.to:at(0))
		else
			break
		end
	end
	for _,t in sgs.qlist(useto) do
		table.insert(tar, t:objectName())
	end
	return "#mtliebianslCard:.:->" .. table.concat(tar,"+")
end

sgs.ai_use_value.mtliebianCard = sgs.ai_use_value.Slash + 0.2
sgs.ai_use_priority.mtliebianCard = sgs.ai_use_priority.Slash + 1

sgs.ai_skill_use["@@wkluoxuan"] = function(self, prompt)
	local current = self.room:getCurrent()
	self.wkluoxuanString = nil
	local flag = false
	local cards = self.player:getCards("h")
	cards = sgs.QList2Table(cards)
	local cmpa = function (a, b)
		return self:getKeepValue(a) + self:getUseValue(a) < self:getKeepValue(b) + self:getUseValue(b) or (self:getKeepValue(a) + self:getUseValue(a) == self:getKeepValue(b) + self:getUseValue(b) and self:getKeepValue(a) < self:getKeepValue(b))
	end
	table.sort(cards, cmpa)
	if not self.player:isKongcheng() then
		local todis = cards[1]
		if (not current:getJudgingArea():isEmpty()) and (current:containsTrick("indulgence") or current:containsTrick("supply_shortage") or current:containsTrick("hetongbh") or current:containsTrick("zuhua")) and not current:containsTrick("YanxiaoCard") and (self:isFriend(current) or current:objectName() == self.player:objectName()) and self:getKeepValue(todis) < 10 then
			flag = true
		--	self.room:writeToConsole("cc")
			if self:getOverflow(current) > 0 then
				self.wkluoxuanString = {"draw","play","discard","judge"}
			else
				self.wkluoxuanString = {"discard","draw","play","judge"}
			end
		elseif self:isEnemy(current) and self:getOverflow(current) > 1 then
			flag = true
		--	self.room:writeToConsole("dd")
			self.wkluoxuanString = {"judge","draw","discard","play"}
		elseif current:hasSkill("yongsi") and (self:isFriend(current) or current:objectName() == self.player:objectName()) then
			flag = true
			self.wkluoxuanString = {"discard","draw","play","judge"}
		end
		if flag then
		--	self.room:writeToConsole("ee")
			return "#wkluoxuan:"..todis:getEffectiveId()..":"
		end
	end
end

sgs.ai_skill_choice.wkluoxuan=function(self,choices)
	local order = self.wkluoxuanString
	local tochoose = order[1]
	table.removeOne(order, tochoose)
	self.wkluoxuanString = order
	return tochoose
end

sgs.ai_skill_use["@@wkzhongxin"] = function(self, prompt)
	local current = self.room:getCurrent()
	local cards = self.player:getCards("h")
	cards = sgs.QList2Table(cards)
	local ablecards = {}
	for _,c in ipairs(cards) do
		if not c:isKindOf("EquipCard") then
			table.insert(ablecards, c)
		end
	end
	if self:isFriend(current) and #ablecards > 0 then
	--	self.room:writeToConsole("1")
		local flag = nil
		if self:isWeak(current) and (not self:isWeak(self.player)) and (not current:hasFlag("Global_PreventPeach")) then
			local peaches = {}
			for _,c in ipairs(ablecards) do
				if c:isKindOf("Peach") or c:isKindOf("C6") then
					table.insert(peaches, c)
				end
			end
			if #peaches > 0 then
			--	self.room:writeToConsole("2")
				self:sortByCardNeed(peaches)
				flag = peaches[1]
			end
		elseif (not self:isWeak(self.player)) or self.player:containsTrick("indulgence") or self:getOverflow(self.player) > 4 then
			local cds = {}
			for _,c in ipairs(ablecards) do
				local willrende = false
				local dummyto = self.room:getOtherPlayers(self.player)
				dummyto:removeOne(current)
				dummyto = sgs.QList2Table(dummyto)
				local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = dummyto }
			--	self.room:writeToConsole("5")
				sgs.ai_skill_use_func.NosRendeCard(c, dummy_use, self)
				if self:getKeepValue(c) < sgs.ai_keep_value.Jink / 1.2 and dummy_use.to and dummy_use.to:length() > 0 then
					table.insert(cds, c)
				end
			end
			if #cds > 0 then
			--	self.room:writeToConsole("3")
				self:sortByCardNeed(cds)
				flag = cds[1]
			end
		end
		if flag then
		--	self.room:writeToConsole("4")
			return "#wkzhongxin:"..flag:getEffectiveId()..":"
		end
	end
end

sgs.ai_skill_cardask["@wkzhongxinask"]=function(self, data)
	local toid = data:toInt()
	local tomake = sgs.Sanguosha:getCard(toid)
	local todis = nil
	local cards = self.player:getCards("h")
	cards = sgs.QList2Table(cards)
	local cmpa = function (a, b)
		return self:getKeepValue(a) + self:getUseValue(a) < self:getKeepValue(b) + self:getUseValue(b) or (self:getKeepValue(a) + self:getUseValue(a) == self:getKeepValue(b) + self:getUseValue(b) and self:getKeepValue(a) < self:getKeepValue(b))
	end
	table.sort(cards, cmpa)
	for _,c in ipairs(cards) do
		if c:getSuit() == tomake:getSuit() then 
			todis = c 
			break
		end
	end
	if todis then
	table.removeOne(cards, todis)
		local losevalue = self:getUseValue(todis) + self:getKeepValue(todis) + self:getUseValue(tomake) + self:getKeepValue(tomake)
		for _,c in ipairs(cards) do
			if c:getSuit() == tomake:getSuit() then 
				losevalue = losevalue + self:getUseValue(c) + self:getKeepValue(c) - 1.2 * (self:getUseValue(tomake) + self:getKeepValue(tomake))
			end
		end
		if losevalue <= 0 then return "$"..todis:getEffectiveId() end
	end
	return "."
end

sgs.ai_view_as.wkzhongxingive = function(card, player, card_place)
	local suit = card:getSuitString()
	local number = card:getNumberString()
	local card_id = card:getEffectiveId()
	local to = sgs.Sanguosha:getCard(player:getMark("zhongxinrecord"))
	local trick = sgs.Sanguosha:cloneCard(to:getClassName(),to:getSuit(),to:getNumber())
	if card_place ~= sgs.Player_PlaceSpecial and card:getSuit() == to:getSuit() and self:getKeepValueValue(card) <= sgs.ai_use_value[to:getClassName()] and not card:isKindOf("Peach") and not card:hasFlag("using") then
		local nn = string.lower(to:getClassName())
		return ("%s:wkzhongxingive[%s:%s]=%d"):format(nn, suit, number, card_id)
	end
end

local wkzhongxingive_skill={}
wkzhongxingive_skill.name="wkzhongxingive"
table.insert(sgs.ai_skills,wkzhongxingive_skill)
wkzhongxingive_skill.getTurnUseCard=function(self,inclusive) 
	local to = sgs.Sanguosha:getCard(self.player:getMark("zhongxinrecord"))
	local trick = sgs.Sanguosha:cloneCard(to:getClassName(),to:getSuit(),to:getNumber())
	local cards = self.player:getCards("he")
	local touse = nil
	cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
	if trick:isAvailable(self.player) then
		self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
		for _,card in ipairs(cards) do
			if card:getSuit() == trick:getSuit() then
				if self:getUseValue(card) + 0.5 * self:getKeepValueValue(card) < 0.9 * sgs.ai_keep_value[to:getClassName()] + 0.4 * sgs.ai_use_value[to:getClassName()] then
					touse = card
					break
				end
			end
		end
		if touse then -- 若找到了合适的卡牌作为子卡	
			local nn = string.lower(to:getClassName())
			local card_str = ("%s:wkzhongxingive[%s:%s]=%s"):format(nn, to:getSuitString(), to:getNumber(), touse:getEffectiveId())
			local slash = sgs.Card_Parse(card_str)
			assert(slash) -- 验证 slash 不为 nil
			return slash
		end
	end
end

sgs.ai_skill_invoke.ndhuli = function(self, data)
	local needhelps, noneed = self:getWoundedFriend(false)
	local damage = data:toDamage()
	local card = damage.card
	if #needhelps + #noneed == 0 then return self:isFriend(damage.to) and self:isWeak(damage.to) end
	if card and card:isKindOf("TrickCard") then 
		if card:isKindOf("AOE") then
			return self:isFriend(damage.to) and #needhelps > 0 and table.contains(needhelps, damage.to)
		else
			return self:isFriend(damage.to)
		end
	else
		if self:isFriend(damage.to) then 
			if damage.to:getHp() <= getBestHp(damage.to) then
				return true
			end
		else
			if #needhelps > 0 and (not self:isWeak(damage.to)) and self:isWeak(needhelps[1]) and needhelps[1]:getRole() == "lord" then
				return true
			end
		end
	end
	return false 
end

sgs.ai_skill_playerchosen.ndhuli = function(self, targets)
	local tar = nil
	local tgs = sgs.SPlayerList()
	local needhelps, noneed = self:getWoundedFriend(false, true)
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if p:isWounded() then 
			tgs:append(p)
		end
	end
	for _,f in ipairs(needhelps) do
		if tgs:contains(f) and f:getHp() < getBestHp(f) then return f end
	end
	for _,f in ipairs(noneed) do
		if tgs:contains(f) and f:getHp() < getBestHp(f) then return f end
	end
	for _,f in sgs.qlist(tgs) do
		if self:isFriend(f) then return f end
	end
	for _,e in sgs.qlist(tgs) do
		if not self:isWeak(e) then return e end
	end
	return tgs:at(math.random(1, tgs:length()) - 1)
end

sgs.ai_skill_use["@@ndfengdeng"] = function(self, prompt)
	local who = self.room:getCurrentDyingPlayer()
	if not self:isFriend(who) then return "." end
	local cards = self.player:getCards("h")
	cards = sgs.QList2Table(cards)
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	local ablecards = {}
	local slash = sgs.Sanguosha:cloneCard("slash")
	slash:setSkillName("ndfengdeng")
	for _,c in ipairs(cards) do
		if c:isKindOf("Peach") then
			slash = sgs.Sanguosha:cloneCard("slash", c:getSuit(), c:getNumber())
			local flag = false
			for _,p in ipairs(self.friends_noself) do
				if who:getHp() < 0 and self:hasHeavySlashDamage(self.player, slash, p) and not (who:hasLordSkill("jiuyuan") and self.player:getKingdom() == "wu") then
					flag = true
				end
			end
			if flag then
				table.insert(ablecards, c)
			end
		else
			table.insert(ablecards, c)
		end
	end
	if #ablecards == 0 then return false end
	local touse = ablecards[1]
	slash = sgs.Sanguosha:cloneCard("slash", touse:getSuit(), touse:getNumber())
	slash:setSkillName("ndfengdeng")
	local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
	self:useCardByClassName(slash, dummy_use)
	if dummy_use.card and dummy_use.to:length() ~= 0 then
		local target_objectname = {}
		for _, p in sgs.qlist(dummy_use.to) do
			table.insert(target_objectname, p:objectName())
		end
		return "slash:ndfengdeng[" .. touse:getSuitString() .. ":" .. touse:getNumber() .."]=" .. touse:getId() .. "->" .. table.concat(target_objectname, "+")
	end
	return "."
end

sgs.ai_cardneed.ndfengdeng = function(to, card)
	return not to:faceUp()
end

local ndcongyi_skill = {}
ndcongyi_skill.name = "ndcongyi"
table.insert(sgs.ai_skills, ndcongyi_skill)
ndcongyi_skill.getTurnUseCard = function(self, inclusive)
	if self.player:faceUp() and self.player:getMark("Global_PreventPeach") == 0 then
		if self.player:isWounded() and self:getOverflow(self.player) > 2 then
			local card_str = ("peach:ndcongyi[no_suit:0]=.")
			local card = sgs.Card_Parse(card_str)
			return card
		end
	end
end

sgs.ai_view_as.ndcongyi = function(card, player, card_place)
	if player:faceUp() and player:getMark("Global_PreventPeach") == 0 then
		return ("peach:ndcongyi[no_suit:0]=.")
	end
end

sgs.ai_use_value["ndcongyi"] = sgs.ai_use_value.Peach
sgs.ai_use_priority["ndcongyi"] = sgs.ai_use_priority.Peach - 0.5

sgs.ai_skill_playerchosen.jlsidou = function(self, targets)
	local havesl = self:getCard("Slash")
	local targetable = sgs.QList2Table(targets)
	local duel = sgs.Sanguosha:cloneCard("duel", sgs.Card_NoSuit, 0)
	duel:setSkillName("jlsidou")
	if havesl then
		for _,p in ipairs(targetable) do
			local damage = sgs.DamageStruct()
			damage.from = p
			damage.to = self.player
			damage.card = duel
			if self:isFriend(p) and self:hasTrickEffective(duel, self.player, p) and self:damageIsEffective(damage) then
				return p
			end
		end
		for _,p in ipairs(targetable) do
			if self:isFriend(p) then
				return p
			end
		end
		for _,p in ipairs(targetable) do
			local damage = sgs.DamageStruct()
			damage.from = p
			damage.to = self.player
			damage.card = duel
			if not (self:hasTrickEffective(duel, self.player, p) and self:damageIsEffective(damage)) then
				return p
			end
		end
		local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
		self:useCardByClassName(duel, dummy_use)
		if dummy_use.to and dummy_use.to:length() > 0 then
			return dummy_use.to:at(0)
		end
	else
		local kenglord = self.player:getRole() == "loyalist" and self.player:getHp() == 1
		for _,p in ipairs(targetable) do
			local damage = sgs.DamageStruct()
			damage.from = p
			damage.to = self.player
			damage.card = duel
			if not (self:hasTrickEffective(duel, self.player, p) and self:damageIsEffective(damage)) then
				return p
			end
		end
		if self.player:getRole() == "rebel" and self.player:getHp() == 1 then
			local ft = {}
			for _,p in ipairs(targetable) do
				if self:isFriend(p) and not p:hasSkill("jueqing") then table.insert(ft, p) end
			end
			local pr = sgs.ai_skill_playerchosen.zhuiyi
			if table.contains(ft, pr) then return pr end
			if #ft > 0 then return ft[1] end
		end
		if kenglord then
			local ft = {}
			for _,p in ipairs(targetable) do
				if not p:getRole() == "lord" then table.insert(ft, p) end
			end
			if #ft > 0 then return ft[1] end
		end
	end
	return targets:at(math.random(1, targets:length()) - 1)
end

sgs.ai_skill_invoke.jlqunlun = function(self, data)
	return true 
end

local QLalwaysGet = false

function SmartAI:getQLCardNeedPlayer(cards, include_self)
--	self.room:writeToConsole("QLNstart")
	local c,p = self:getCardNeedPlayer(cards, include_self)
	if c and p then
	--	self.room:writeToConsole("QLNreturn " .. c:getClassName())
		return c,p 
	end
	cards = cards or sgs.QList2Table(self.player:getHandcards())
--	self.room:writeToConsole("QLNa")
	if self.player:getPhase() == sgs.Player_Play and self.player:getPile("qunlunpile"):length() > 0 and self.player:usedTimes("#jlqunlunCard") < (self.player:getLostHp() + 1) then
		self:sortByUseValue(cards)
	--	self.room:writeToConsole("QLNsort")
		if self.player:usedTimes("#jlqunlunCard") == self.player:getLostHp() and self:isWeak(self.player) then
			self.qltuse = true
			local tuse = self:getTurnUse()
			self.qltuse = false
			if #tuse == 0 then
				if #cards > 1 then self:sortByKeepValue(cards) end
			--	self.room:writeToConsole("QLNb")
				return cards[1], self.player
			end
		end
	--	self.room:writeToConsole("QLNc")
		for _,card in ipairs(cards) do -- 遍历所有的可用牌
			local dummy_use = {}
			dummy_use.isDummy = true
			if card:isAvailable(self.player) then
				local type = card:getTypeId()
				self["use" .. sgs.ai_type_name[type + 1] .. "Card"](self, card, dummy_use)
			--	self.room:writeToConsole("QLNdummy")
				if dummy_use.card then return card,self.player end
			end
		end
	end
end

local jlqunlun_skill = {}
jlqunlun_skill.name = "jlqunlun"
table.insert(sgs.ai_skills, jlqunlun_skill)
jlqunlun_skill.getTurnUseCard = function(self)
	if self.qltuse then
	--	self.room:writeToConsole("QLNuseMark")
	else
	--	self.room:writeToConsole("qla")
		local flag = false
		if self.player:getPile("qunlunpile"):length() > 0 then
			local cards = IdTable2CardTable(sgs.QList2Table(self.player:getPile("qunlunpile")))
			local card, p = self:getQLCardNeedPlayer(cards, true)
			if card and card:isAvailable(self.player) and p:objectName() == self.player:objectName() and self.player:getMark("@jlqunlun"..card:getType()) > 0 then
				flag = true
			end
		end
		if self.player:getPile("qunlunpile"):length() > 0 and (self:getOverflow(self.player) == 0 or flag or QLalwaysGet) and self.player:usedTimes("#jlqunlunCard") < (self.player:getLostHp() + 1) then
		--	self.room:writeToConsole("qlJS")
			return sgs.Card_Parse("#jlqunlunCard:.:")
		end
	end
end

sgs.ai_skill_use_func["#jlqunlunCard"] = function(card, use, self)
--	self.room:writeToConsole("qlb")
	local cards = IdTable2CardTable(sgs.QList2Table(self.player:getPile("qunlunpile")))
	local card, p = self:getQLCardNeedPlayer(cards, true)
--	self.room:writeToConsole("qlc")
	local flag = true
	if p and p:objectName() == self.player:objectName() then 
		flag = self.player:getHandcardNum() < self:getOverflow(self.player, true) or (self.player:getHp() <= 2 and self.player:getHandcardNum() < self:getOverflow(self.player, true) * 1.2) or (card and card:isAvailable(self.player) and self.player:getMark("@jlqunlun"..card:getType()) > 0) or (card and (card:isKindOf("Peach") or card:isKindOf("C6")) and card:isAvailable(self.player) and self:isWeak(self.player))
	end
	if (flag or QLalwaysGet) and card and p then
		self.room:writeToConsole(p:getGeneralName() .. " qld " .. card:getId() .. " " .. card:getClassName())
		use.card = sgs.Card_Parse("#jlqunlunCard:" .. card:getId() .. ":")
		if use.to then
		--	self.room:writeToConsole("qlGGAA")
			use.to:append(p)
			self.room:writeToConsole("qlGG")
			return
		end
	--	self.room:writeToConsole("qlEE")
	end
end

sgs.ai_use_priority.jlqunlunCard = 6.5
sgs.ai_use_value.jlqunlunCard = 8.1
sgs.ai_card_intention.jlqunlunCard = -80

function sgs.ai_cardneed.jlqunlun(to, card, self)
	local typestring = "."
	if card:getType() == "basic" then
		typestring = "BasicCard"
	elseif card:getType() == "equip" then
		typestring = "EquipCard"
	elseif card:getType() == "trick" then
		typestring = "TrickCard"
	end
	return to:getMark("@jlqunlun"..card:getType()) > 0 or getKnownCard(to, self.player, typestring) > 0
end

local lpfengshou_skill={}
lpfengshou_skill.name="lpfengshou"
table.insert(sgs.ai_skills,lpfengshou_skill)
lpfengshou_skill.getTurnUseCard=function(self,inclusive) 
	local mark = self.player:getMark("fengshouc")
	local amg = sgs.Sanguosha:cloneCard("amazing_grace", sgs.Card_SuitToBeDecided, 0)
--	self.room:writeToConsole("fsA")
	local toUse = nil
	if self.player:getMark("fengshouDebug") == 0 then
		self.room:setPlayerMark(self.player, "fengshouDebug", 1)
		toUse = self:getTurnUse()
		self.room:setPlayerMark(self.player, "fengshouDebug", 0)
	end
	if mark < 4 then
		if (not self.player:hasFlag("lpyusuiused")) and self.player:hasSkill("lpyusui") then
			sgs.ai_use_value.AmazingGrace = 9
			sgs.ai_use_priority.AmazingGrace = 9.25
		else
			sgs.ai_use_value.AmazingGrace = 3
			sgs.ai_use_priority.AmazingGrace = 1.2
		end
		local cards = self.player:getCards("he")
		cards=sgs.QList2Table(cards) -- 获得包含手牌与装备区的表
		self:sortByUseValue(cards,true)
		local suitlist = {}
		local cdlist = {}
		for _,c in ipairs(cards) do
			if not table.contains(suitlist,c:getSuit()) then
				table.insert(suitlist, c:getSuit())
				table.insert(cdlist, c)
			end
		end
	--	self.room:writeToConsole("fsB " .. self:getUseValue(amg) .. " | " .. self:getUsePriority(amg))
		if #cdlist > mark then 
		--	self.room:writeToConsole("fsC"..cdlist[1]:getClassName())
			self:sortByUseValue(cdlist,true)
			local uselist = {}
			local vl = 0
			for i = 1, mark+1 ,1 do
				table.insert(uselist, cdlist[i])
				vl = vl + self:getUseValue(cdlist[i])
			end
			local des = ((not self.player:hasFlag("lpyusuiused")) and self.player:hasSkill("lpyusui")) and 7.5 or (mark + 2)
			vl = vl / des
			if toUse and #toUse == 0 and self:getOverflow(self.player) > mark then vl = 0 end
		--	self.room:writeToConsole("fsD value!")
			if vl < self:getUseValue(amg) then
				local flag = true
			--	self.room:writeToConsole("fsE")
				if (self.role == "lord" or self.role == "loyalist") and sgs.turncount <= 2 and self.player:getSeat() <= 3 and self.player:aliveCount() > 6 and (self.player:hasFlag("lpyusuiused") or not self.player:hasSkill("lpyusui")) then flag = false end
				local value = 1 - mark
				if toUse and #toUse == 0 and self:getOverflow(self.player) > mark then value = 1 - mark / 3 end
				if (not self.player:hasFlag("lpyusuiused")) and self.player:hasSkill("lpyusui") then value = value + self.player:aliveCount() / 3 end
				local suf, coeff = 0.8, 0.8
				if self:needKongcheng() and self.player:getHandcardNum() == 1 or self.player:hasSkills("nosjizhi|jizhi") then
					suf = 0.6
					coeff = 0.6
				end
				local enenum = 0
				for _, p in sgs.qlist(self.room:getOtherPlayers(self.player)) do
					local index = 0
					if self:hasTrickEffective(amg, p, self.player) then
						if self:isFriend(p) then 
							index = 1 
						elseif self:isEnemy(p) then
							enenum = enenum + 1
							if enenum > mark then
								index = -1
							end
						end
					end
					value = value + index * suf
					suf = suf * coeff
				end
			--	self.room:writeToConsole("fsF " .. value .. " Debug ready")
				if value > 0 and flag then
					assert(amg)
				--	self.room:writeToConsole("fsG")
					for _,c in ipairs(uselist) do
						amg:addSubcard(c)
					end
					amg:setSkillName("lpfengshou")
					return amg
				end
			end
		end
	end
end

sgs.ai_skill_use["@@lpfengshou"] = function(self, prompt)
	local oldc = self.player:getMark("fengshouc")
	local tar = {}
	self:sort(self.enemies)
	local amg = sgs.Sanguosha:cloneCard("amazing_grace", sgs.Card_SuitToBeDecided, 0)
	for _, enemy in ipairs(self.enemies) do
		if #tar < oldc and self:hasTrickEffective(amg, enemy, self.player) and not hasManjuanEffect(enemy)
			and not self:needKongcheng(enemy, true) then
			table.insert(tar, enemy:objectName())
		end
	end
	for _, friend in ipairs(self.friends) do
		if #tar < oldc and self:hasTrickEffective(amg, enemy, self.player) and self:needKongcheng(friend, true) then
			table.insert(tar, friend:objectName())
		end
	end
	return "#lpfengshouCard:.:->" .. table.concat(tar,"+")
end

sgs.ai_skill_invoke.lpyusui = function(self, data)
	return true 
end

sgs.ai_skill_choice.lpyusui=function(self,choices, data)
	local cards = IdTable2CardTable(sgs.QList2Table(data:toIntList()))
	local readysuitlist = {"heart", "diamond", "spade", "club"}
	local suitlist = {false, false, false, false}
	local cmv = function(cdstring)
		if not cdstring then return -1000 end
		local clist = IdTable2CardTable(cdstring:split("+"))
		local n = 0
		for _,c in ipairs(clist) do
			n = n + (#clist - 0.5) * ((self:getUseValue(c) + self:getKeepValue(c) * 0.3 + 2.6) ^ 2)
		end
		return n
	end
	local prest = ""
	local presuit = ""
--	tableIndexOf
--	self.room:writeToConsole("yusuis " .. choices)
	for i,ch in ipairs(readysuitlist) do
		if table.contains(choices:split("+"), ch) then
			local st = {}
			for _,c in ipairs(cards) do
				if c:getSuitString() == ch then
					table.insert(st, c:getEffectiveId())
				end
			end
			st = table.concat(st, "+")
			suitlist[i] = st
		--	self.room:writeToConsole("yusuisuit " .. ch .. " = " .. st)
			prest = st
			presuit = ch
		end
	end
	for i,sp in ipairs(suitlist) do
		if sp then
			local suit = readysuitlist[i]
		--	self.room:writeToConsole("yusuicmping " .. suit .. " vs " .. presuit)
			if cmv(sp) > cmv(prest) then 
			--	self.room:writeToConsole("yusuiWin " .. suit)
				prest = sp 
				presuit = suit
			end
		end
	end
	return presuit
end

sgs.ai_skill_playerchosen.lpyusuiask = function(self, targets)
	local targetable = sgs.QList2Table(self.room:getAlivePlayers())
	local val = function(who) 
		if (not self:isFriend(who)) then return -100 end
		if who:hasSkill("manjuan") and who:getPhase() == sgs.Player_NotActive then return -95 end
		if self:needKongcheng(who, true) then return -50 end
		if who:hasSkills("jizhi|jianying|jlqunlun") then return 2 end
		return 1
	end
	local cmp = function(a, b)
		if val(a) == val(b) then
			if a:getPhase() ~= sgs.Player_NotActive then
				return a:getHandcardNum() < b:getHandcardNum() + 2.5 and not (self:isWeak(b) and not self:isWeak(a))
			else
				return a:getHandcardNum() < b:getHandcardNum()
			end
		end
		return val(a) > val(b)
	end
	table.sort(targetable, cmp)
	return targetable[1]
end

sgs.ai_playerchosen_intention.lpyusui = -60

local fmchongzheng_skill={}
fmchongzheng_skill.name="fmchongzheng"
table.insert(sgs.ai_skills,fmchongzheng_skill)
fmchongzheng_skill.getTurnUseCard=function(self,inclusive)
	local value = 0.5
	local tos = sgs.SPlayerList()
	for _,p in sgs.qlist(self.room:getOtherPlayers(self.player)) do
		if not p:isNude() then
			tos:append(p)
		end
	end
	--getGuixinValue(self, player)
	if not tos:isEmpty() then 
		for _,p in sgs.qlist(tos) do
			if not p:isNude() then
				value = value + getGuixinValue(self, p) - 0.1
			end
			if self:isEnemy(p) then value = value - 0.25 end
		end
	end
	if value > 0 and (not self.player:hasUsed("#fmchongzhengCard")) then 
		local card_str = ("#fmchongzhengCard:.:")
		return sgs.Card_Parse(card_str) 
	end
end

sgs.ai_skill_use_func["#fmchongzhengCard"]=function(card,use,self)
	use.card = card
end

sgs.ai_skill_discard.fmchongzheng = function(self, discard_num, min_num, optional, include_equip)
	local name = self.player:property("fmchongzhengreturnto"):toString()
	local tar = nil
	for _,p in sgs.qlist(self.room:getOtherPlayers(self.player)) do
		if p:objectName() == name then
			tar = p
			break
		end
	end
	if tar then
		local cards = sgs.QList2Table(self.player:getCards("h"))
		if self:isFriend(tar) then
			local c,pl = self:getCardNeedPlayer(cards)
			if pl:objectName() == tar:objectName() then return { c:getEffectiveId() } end
			if self:getCardsNum("Jink") > 1 then
				for _, card in sgs.qlist(self.player:getHandcards()) do
					if isCard("Jink", card, target) then return { card:getEffectiveId() } end
				end
			end
			for _, card in sgs.qlist(self.player:getHandcards()) do
				if not self:isValuableCard(card) then return { card:getEffectiveId() } end
			end
		else
			local to_discard = {}
			local cmp = function(a, b)
				return self:getUseValue(a) + self:getUseValue(a) * 0.5 < self:getUseValue(b) + self:getUseValue(b) * 0.5 or (self:getUseValue(a) + self:getUseValue(a) * 0.5 == self:getUseValue(b) + self:getUseValue(b) and self:getUseValue(a) < self:getUseValue(b))
			end
			table.sort(cards, cmp)
			local card_ids = {}
			for _,card in ipairs(cards) do
				table.insert(card_ids, card:getEffectiveId())
			end

			local temp = table.copyFrom(card_ids)
			for i = 1, #temp, 1 do
				local card = sgs.Sanguosha:getCard(temp[i])
				if self.player:getArmor() and temp[i] == self.player:getArmor():getEffectiveId() and self:needToThrowArmor() then
					table.insert(to_discard, temp[i])
					table.removeOne(card_ids, temp[i])
					if #to_discard == discard_num then
						return to_discard
					end
				end
			end

			temp = table.copyFrom(card_ids)
			for i = 1, #card_ids, 1 do
				local card = sgs.Sanguosha:getCard(card_ids[i])
				table.insert(to_discard, card_ids[i])
				if #to_discard == discard_num then
					return to_discard
				end
			end

			if #to_discard < discard_num then return {} end
		end
	end
	return {}
end

sgs.ai_use_value["fmchongzhengCard"] = 4.6
sgs.ai_use_priority["fmchongzhengCard"] = 4.5

local fmtugou_skill={}
fmtugou_skill.name="fmtugou"
table.insert(sgs.ai_skills,fmtugou_skill)
fmtugou_skill.getTurnUseCard=function(self,inclusive)
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	local tarlist = {}
	local sbdiaochan = self.room:findPlayerBySkillName("lihun")
	local dangerdiaochan = sbdiaochan and (self:isEnemy(sbdiaochan) or sgs.turncount <= 1) and sbdiaochan:faceUp() and not self:willSkipPlayPhase(sbdiaochan)
--	self.room:writeToConsole("fm Sbdc?")
	if #cards > 0 then
		for _,p in sgs.qlist(self.room:getOtherPlayers(self.player)) do
			if p:getPile("fmpicture"):isEmpty() and p:getHandcardNum() > 1 and not self:willSkipPlayPhase(p) then
				table.insert(tarlist, p) 
			--	self.room:writeToConsole("fm target find")
			end
		end
		if #tarlist > 0 then
			local getvalue = function(who)
				local n = who:getHandcardNum()
				local wcards = who:getCards("h")
				for _, id in sgs.qlist(who:getPile("wooden_ox")) do
					wcards:append(sgs.Sanguosha:getCard(id))
					n = n + 1
				end
				local flag = string.format("%s_%s_%s", "visible", self.player:objectName(), who:objectName())
				for _, card in sgs.qlist(wcards) do
					if card:hasFlag("visible") or card:hasFlag(flag) then
						if not card:isAvailable(who) then n = n - 1 end
					end
				end
				return n
			end
			local cmp = function(a, b)
				return getvalue(a) > getvalue(b) and (self:isWeak(b) or not self:isWeak(a))
			end
			table.sort(tarlist, cmp)
			if not dangerdiaochan then 
			--	self.room:writeToConsole("fm no diaochan!")
				local card_str = ("#fmtugouCard:.:")
				return sgs.Card_Parse(card_str) 
			end
		end
	end
end

sgs.ai_skill_use_func["#fmtugouCard"]=function(card,use,self)
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)
	self:sortByUseValue(cards,true) -- 按使用价值从小到大排列卡牌
	local tarlist = {}
	local count = 0
	for _,p in sgs.qlist(self.room:getOtherPlayers(self.player)) do
		if not p:getPile("fmpicture"):isEmpty() then count = count + 1 end
		if p:getPile("fmpicture"):isEmpty() and p:getHandcardNum() > 1 and not self:willSkipPlayPhase(p) then table.insert(tarlist, p) end
	end
--	self.room:writeToConsole("fm use func")
	local getvalue = function(who)
		local n = who:getHandcardNum()
		local wcards = who:getCards("h")
		for _, id in sgs.qlist(who:getPile("wooden_ox")) do
			wcards:append(sgs.Sanguosha:getCard(id))
			n = n + 1
		end
		local flag = string.format("%s_%s_%s", "visible", self.player:objectName(), who:objectName())
		for _, card in sgs.qlist(wcards) do
			if card:hasFlag("visible") or card:hasFlag(flag) then
				if not card:isAvailable(who) then n = n - 1 end
			end
		end
		return n
	end
	local cmp = function(a, b)
		return getvalue(a) > getvalue(b) and (self:isWeak(b) or not self:isWeak(a))
	end
	table.sort(tarlist, cmp)
	local cd = cards[1]
	if (self:getOverflow(self.player) > 0 or self:getUseValue(cd) < 5.5 or count < math.min(self.room:getAlivePlayers():length() / 3, 2)) and self:getUseValue(cd) < 6.5 and (self:getKeepValue(cd) < 4.5 or self:getCardsNum(cd:getClassName()) > 1) then
	--	self.room:writeToConsole("fm will use!")
		use.card = sgs.Card_Parse("#fmtugouCard:"..cd:getEffectiveId()..":")
		if use.to then 
			use.to:append(tarlist[1]) 
		end
		return
	end
end

sgs.ai_use_priority.fmtugouCard = 5
sgs.ai_use_value.fmtugouCard = 6

local function prohibitUseDirectly(card, player)
	if player:isCardLimited(card, card:getHandlingMethod()) then return true end
	if card:isKindOf("Peach") and player:getMark("Global_PreventPeach") > 0 then return true end
	return false
end

sgs.ai_skill_discard.fmtugou = function(self, discard_num, min_num, optional, include_equip)
	local who = self.player:property("fmtugoumove"):toMoveOneTime().from
	if who then
		local tou = who:getHandcardNum() > 1
		local cards = sgs.QList2Table(self.player:getCards("h"))
		self:sortByUseValue(cards,true)
	--	local whoself = who:getAI()
		local wcards = who:getHandcards()
		local acard = {}
		for _, id in sgs.qlist(who:getPile("wooden_ox")) do
			wcards:append(sgs.Sanguosha:getCard(id))
		end
		local flag = string.format("%s_%s_%s", "visible", self.player:objectName(), who:objectName())
		for _, card in sgs.qlist(wcards) do
			if card:hasFlag("visible") or card:hasFlag(flag) then
				if card:isAvailable(who) then table.insert(acard, card) end
			end
		end
		if #acard > 0 then
		--	self.room:writeToConsole("fm have acard!")
			local i = 1
			while i <= #acard do
				if prohibitUseDirectly(acard[i], who) then
					table.remove(acard, i)
				else
					i = i + 1
				end
			end
			local p = self.player
			self.player = who
			for _, skill in ipairs(sgs.ai_skills) do
				if who:hasSkill(skill.name) or who:getMark("ViewAsSkill_" .. skill.name .. "Effect") > 0 then
					local skill_card = skill.getTurnUseCard(self)
					if skill_card and not skill_card:isKindOf("SkillCard") then table.insert(acard, skill_card) end
				end
			end
			self:sortByDynamicUsePriority(acard)
		--	self.room:writeToConsole("fm sorted")
			local preusecard = nil
			for _, card in ipairs(acard) do
				local dummy_use = { isDummy = true }
				self:useCardByClassName(card, dummy_use)
				if dummy_use.card then
					preusecard = card
					break
				end
			end
			self.player = p
			if preusecard then
				if self.player:faceUp() then
					for _, card in ipairs(cards) do
						if card:getType() == preusecard:getType() then
							return {card:getEffectiveId()}
						end
					end
				else
					for _, card in ipairs(cards) do
						if card:getType() ~= preusecard:getType() then
							return {card:getEffectiveId()}
						end
					end
				end
			end
		end	
		if not self.player:faceUp() then
			if tou then
				for _, card in ipairs(cards) do
					if card:isKindOf("EquipCard") then
						return {card:getEffectiveId()}
					end
				end
			end
		end
	end
	return {}
end

sgs.ai_skill_playerchosen.akqusu = function(self, targets)
	local tar = nil
	if sgs.current_mode_players.rebel == 0 then
		local lord = self.room:getLord()
		if lord and self:isFriend(lord) and lord:objectName() ~= self.player:objectName() then
			tar = lord
		end
	end
	local AssistTarget = self:AssistTarget()
	if AssistTarget and not self:willSkipPlayPhase(AssistTarget) then
		tar = AssistTarget
	end
	self:sort(self.friends, "chaofeng")
	for _, target in ipairs(self.friends_noself) do
		if not target:hasSkill("dawu") and target:hasSkills("yongsi|zhiheng|" .. sgs.priority_skill .. "|shensu")
			and (not self:willSkipPlayPhase(target) or target:hasSkill("shensu")) then
			tar = target
		end
	end
	for _, target in ipairs(self.friends) do
		if target:hasSkill("dawu") then
			local use = true
			for _, p in ipairs(self.friends_noself) do
				if p:getMark("@fog") > 0 then use = false break end
			end
			if use then
				tar = target
			end
		end
	end
	if not tar then tar = self.player end
	return tar
end

sgs.ai_skill_invoke.akzhouxiang = function(self, data)
	local who = self.room:getCurrent()
	if self:isFriend(who) then
		return self:needToThrowArmor(who) or self:doNotDiscard(who) or ((not who:getJudgingArea():isEmpty()) and not who:containsTrick("YanxiaoCard"))
	elseif self:isEnemy(who) then
		return not self:doNotDiscard(who)
	end
	return false
end

sgs.ai_skill_choice.akzhouxiang = function(self, choices, data)
	local who = self.room:getCurrent()
	local ans = "cancel"
	if self:isFriend(who) then
		if self:needToThrowArmor(who) or self:doNotDiscard(who) or ((not who:getJudgingArea():isEmpty()) and not who:containsTrick("YanxiaoCard")) then
			ans = "akdiscard"
		end
	elseif self:isEnemy(who) then
	--	IOoutput("AA")
		local cards = sgs.QList2Table(self.player:getCards("he"))
		local n = #cards
		if self:getDangerousCard(who) or self:getValuableCard(who) or data:toInt() > n then
			ans = "akdiscard"
		end
	--	IOoutput("BB"..data:toInt())
		local av = 0
		for _,c in ipairs(cards) do
			av = av + self:getUseValue(c) + self:getKeepValue(c)
		--	IOoutput("233")
			if c:isKindOf("EquipCard") then av = av + 4 * (n - data:toInt()) end
		--	IOoutput("244")
		end
		av = av / (n + 0.1)
	--	IOoutput("CC")
		local dis = sgs.Sanguosha:cloneCard("dismantlement", sgs.Card_NoSuit, 0)
		if not av > self:getUseValue(dis) then ans = "akdiscard" end
	end
--	IOoutput("DD")
	return ans
end

sgs.ai_choicemade_filter.cardChosen.akzhouxiang = sgs.ai_choicemade_filter.cardChosen.snatch

sgs.ai_skill_cardask["@akzhouxiang-askdis"]=function(self, data) 
	local ak = self.room:findPlayerBySkillName("akzhouxiang")
	local cards = self.player:getCards("he")
	cards=sgs.QList2Table(cards)
	self:sortByKeepValue(cards,true)
	if not self:isEnemy(ak) then return "." end
	local flag = false
	if (self:getDangerousCard(ak) or self:getValuableCard(ak)) and self.player:getMark("akzhouxiangmark") < ak:getCards("he"):length() + 2 then flag = true end
	if cards[1] and self:getKeepValue(cards[1]) + self:getUseValue(cards[1]) < 10 then flag = true end
	if self.player:getMark("akzhouxiangmark") == 0 or not cards[1] then flag = false end
	if (not (self:getDangerousCard(ak) or self:getValuableCard(ak))) and self.player:getMark("akzhouxiangmark") > ak:getCards("he"):length() then flag = false end
	if flag	then return "$" .. cards[1]:getId() end
	return "."
end

sgs.ai_skill_invoke.brshangbian = function(self, data)
	return not self:needKongcheng(self.player, true)
end

sgs.ai_skill_invoke.brshuyun = function(self, data)
	local current = self.room:getCurrent()
	sgs.syeqid = false
	if self:isEnemy(current) then
		local haseq = false
		local cards = self.player:getCards("he")
		cards = sgs.QList2Table(cards)
		if self:needToThrowArmor() then
			haseq = true
			sgs.syeqid = self.player:getArmor():getEffectiveId()
		end

		for _, c in ipairs(cards) do
			if c:isKindOf("Weapon") and self:evaluateWeapon(c, self.player) then 
				haseq = true
				sgs.syeqid = c:getEffectiveId() 
			end
		end

		local handcards = self.player:getHandcards()
		handcards = sgs.QList2Table(handcards)
		local has_weapon, has_armor, has_def, has_off = false, false, false, false
		local weapon, armor
		for _, c in ipairs(handcards) do
			if c:isKindOf("Weapon") then
				has_weapon = true
				if not weapon or self:evaluateWeapon(weapon) < self:evaluateWeapon(c) then weapon = c end
			end
			if c:isKindOf("Armor") then
				has_armor = true
				if not armor or self:evaluateArmor(armor) < self:evaluateArmor(c) then armor = c end
			end
			if c:isKindOf("DefensiveHorse") then has_def = c:getEffectiveId() end
			if c:isKindOf("OffensiveHorse") then has_off = c:getEffectiveId() end
		end
		if has_off and self.player:getOffensiveHorse() then 
			haseq = true
			sgs.syeqid = has_off 
		end
		if has_def and self.player:getDefensiveHorse() then 
			haseq = true
			sgs.syeqid = has_def 
		end
		if has_weapon and self.player:getWeapon() then 
			haseq = true
			sgs.syeqid = self:evaluateWeapon(self.player:getWeapon()) <= self:evaluateWeapon(weapon) and self.player:getWeapon():getEffectiveId() or weapon:getEffectiveId()
		end
		if has_armor and self.player:getArmor() then
			haseq = true
			sgs.syeqid = self:evaluateArmor(self.player:getArmor()) <= self:evaluateArmor(armor) and self.player:getArmor():getEffectiveId() or armor:getEffectiveId()
		end
		if haseq then return (not self:doNotDiscard(current, "he", true, 2)) or ((self:getDangerousCard(current) or self:getValuableCard(current)) and not self:doNotDiscard(current, "he", true, 1)) end
		local wgt = self.room:findPlayerBySkillName("lwxyanghua")
		if wgt and self:isFriend(wgt) then wgt = nil end
		if (self.player:getHp() + self:getAllPeachNum() > 2) and (self:getAllPeachNum() == 0 or not self:willSkipPlayPhase(self.player)) and (not wgt) then return (not self:doNotDiscard(current, "he", true, 2)) or ((self:getDangerousCard(current) or self:getValuableCard(current))and not self:doNotDiscard(current, "he", true, 1)) end
	elseif self:isFriend(current) then
		if self:doNotDiscard(current, "he", true, 1) then return true end
		if self:isWeak(self.player) and self.player:isWounded() and (self.player:isLord() or not self:isWeak(current)) then return true end
	end
	return false
end

sgs.ai_skill_choice.brshuyun=function(self,choices)
	local br = self.room:findPlayerBySkillName("brshuyun")
	assert(br)
	if self:isFriend(br) and (not self:needToLoseHp(br, self.player, false, true)) then return "brrecov" end
	return "brdamage"
end

sgs.ai_skill_cardchosen.brshuyunex = nil

sgs.ai_skill_cardchosen.brshuyun = function(self, who, flags)
	if sgs.syeqid or (not self.player:hasSkills("brshangbian|zhiyu|yiji")) then return nil end
	local disabled = sgs.IntList()
	local id = self.room:askForCardChosen(self.player, self.room:getCurrent(), flags, "brshuyunex", false, sgs.Card_MethodDiscard, disabled)
	local original = nil
	if id then 
		disabled:append(id) 
		local c = sgs.Sanguosha:getCard(id)
		self.room:writeToConsole(c:getClassName())
		self.room:setPlayerFlag(self.player, "hglaser_InTempMoving")
		original = self.room:getCardPlace(id)
		self.room:getCurrent():addToPile("#hglaser", id, false)
		
	end
	local ids = self.room:askForCardChosen(self.player, self.room:getCurrent(), flags, "brshuyunex", false, sgs.Card_MethodDiscard, disabled)
	self.room:moveCardTo(sgs.Sanguosha:getCard(id), self.room:getCurrent(), original, false)
	self.room:setPlayerFlag(self.player, "-hglaser_InTempMoving")
	return ids
end

sgs.ai_choicemade_filter.cardChosen.brshuyunex = sgs.ai_choicemade_filter.cardChosen.snatch

sgs.ai_skill_cardask["@brshuyuneq"]=function(self, data) 
	if sgs.syeqid then 
		local a = sgs.syeqid 
		sgs.syeqid = false
		return "$" .. a
	end
	return "."
end

sgs.ai_skill_cardask["@tswuxian-show"]=function(self, data, pattern)
	local damage = data:toDamage()
	local tsl = damage.to
	local cards = sgs.QList2Table(self.player:getHandcards())
	local toshow = nil
	self:sortByKeepValue(cards)
	for _,cd in ipairs(cards) do
		if sgs.Sanguosha:matchExpPattern(pattern, self.player, cd) then toshow = cd break end
	end
	if toshow then
		if self:isFriend(damage.to) then 
			return "$" .. toshow:getId()
		elseif not self:damageIsEffective(self.player, sgs.DamageStruct_Thunder, damage.to) then
			return "."
		elseif (self:hasSkills(sgs.masochism_skill, damage.to) and not self:isWeak(damage.to)) or (self:isWeak(self.player) and damage.damage < damage.to:getHp()) and (not sgs.Sanguosha:getCard(self.player:getPile("tszhubo"):at(0)):isKindOf("Peach")) then
			return "$" .. toshow:getId()
		end
	end
	return "."
end

local tswuxian_skill = {}
tswuxian_skill.name = "tswuxian"
table.insert(sgs.ai_skills, tswuxian_skill)
tswuxian_skill.getTurnUseCard = function(self)
	local flag = false
	for _,p in sgs.qlist(self.room:getOtherPlayers(self.player)) do
		if p:getPile("tszhubo"):isEmpty() then flag = true break end
	end 
	if flag and (not self.player:isNude()) then
		return sgs.Card_Parse("#tswuxianCard:.:")
	end
end

sgs.ai_skill_use_func["#tswuxianCard"] = function(card, use, self)
	local cards = sgs.QList2Table(self.player:getCards("he"))
	local cmpa = function (a, b)
		return self:getKeepValue(a) + self:getUseValue(a)*0.8 < self:getKeepValue(b) + self:getUseValue(b)*0.8
	end
	table.sort(cards, cmpa)
	local c = cards[1]
	local cmpb = function (a, b)
		return (getKnownCard(a, self.player, c:getSuitString(), true) > getKnownCard(b, self.player, c:getSuitString(), true) or (getKnownCard(a, self.player, c:getSuitString(), true) == getKnownCard(b, self.player, c:getSuitString(), true) and a:getHandcardNum() > b:getHandcardNum())) and a:getPile("tszhubo"):isEmpty()
	end
	local cok = false
	local pok = false
	local int = 0
	if self:isWeak(self.player) then int = int + 1 end
	if self:getOverflow(self.player) > 0 then int = int + 2 end
	if int == 0 then
	--	self.room:writeToConsole("healthy")
		if self:getKeepValue(c) + self:getUseValue(c) < 9 then 
			cok = true
			self:sort(self.enemies, "handcard")
			for _, enemy in ipairs(self.enemies) do
				if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):isEmpty() and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) then
					pok = enemy
					break
				end
			end
			if not pok then
				for _, friend in ipairs(self.friends_noself) do
					if (self:needToLoseHp(friend, self.player) or self:hasSkills(sgs.masochism_skill, friend)) and friend:getPile("tszhubo"):isEmpty() and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then
						pok = friend
						break
					end
				end
			end
			if not pok then
				table.sort(self.friends_noself, cmpb)
				if (getKnownCard(self.friends_noself[1], self.player, c:getSuitString(), true) > 0 or math.min(self.friends_noself[1]:getHandcardNum(), self.friends_noself[1]:getHp()) > 1) and self.friends_noself[1]:getPile("tszhubo"):isEmpty() then pok = self.friends_noself[1] end
			end
		end
	elseif int == 1 then
	--	self.room:writeToConsole("weak")
		if not (c:getSubtype() == "defense_card" or c:getSubtype() == "recover_card") then 
			cok = true 
			table.sort(self.friends_noself, cmpb)
			if (getKnownCard(self.friends_noself[1], self.player, c:getSuitString(), true) > 0 or self.friends_noself[1]:getHandcardNum() > 2) and self.friends_noself[1]:getPile("tszhubo"):isEmpty() then pok = self.friends_noself[1] end
			self:sort(self.enemies, "hp")
			if not pok then
				for _, enemy in ipairs(self.enemies) do
					if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):isEmpty() and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) and (getKnownCard(enemy, self.player, c:getSuitString(), true) > 0 or enemy:getHandcardNum() > 2) then
						pok = enemy
						break
					end
				end
			end
			if not pok then
				for _, enemy in ipairs(self.enemies) do
					if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):isEmpty() and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) then
						pok = enemy
						break
					end
				end
			end
			if not pok then
				for _, friend in ipairs(self.friends_noself) do
					if (self:needToLoseHp(friend, self.player) or self:hasSkills(sgs.masochism_skill, friend)) and friend:getPile("tszhubo"):isEmpty() and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then
						pok = friend
						break
					end
				end
			end
		end
	elseif int == 2 then
	--	self.room:writeToConsole("overflow")
		if not (c:isKindOf("Zheshe") or c:isKindOf("Peach") or c:isKindOf("ExNihilo")) then 
			cok = true
			self:sort(self.enemies, "handcard")
			for _, enemy in ipairs(self.enemies) do
				if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):isEmpty() and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) then
					pok = enemy
					break
				end
			end
			if not pok then
				for _, friend in ipairs(self.friends_noself) do
					if (self:needToLoseHp(friend, self.player) or self:hasSkills(sgs.masochism_skill, friend)) and friend:getPile("tszhubo"):isEmpty() and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then
						pok = friend
						break
					end
				end
			end
			if not pok then
				table.sort(self.friends_noself, cmpb)
				if (getKnownCard(self.friends_noself[1], self.player, c:getSuitString(), true) > 0 or math.min(self.friends_noself[1]:getHandcardNum(), self.friends_noself[1]:getHp()) > 1)  and self.friends_noself[1]:getPile("tszhubo"):isEmpty() then pok = self.friends_noself[1] end
			end
		end
	else
	--	self.room:writeToConsole("weak and overflow")
		cok = true
		table.sort(self.friends_noself, cmpb)
		if getKnownCard(self.friends_noself[1], self.player, c:getSuitString(), true) > 0 or self.friends_noself[1]:getHandcardNum() > 2 then pok = self.friends_noself[1] end
		self:sort(self.enemies, "hp")
		if not pok then
			for _, enemy in ipairs(self.enemies) do
				if (not self:needToLoseHp(enemy, self.player)) and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and enemy:getPile("tszhubo"):isEmpty() and not self:hasSkills(sgs.masochism_skill, enemy) and (getKnownCard(enemy, self.player, c:getSuitString(), true) > 0 or enemy:getHandcardNum() > 2) then
					pok = enemy
					break
				end
			end
		end
		if not pok then
			for _, enemy in ipairs(self.enemies) do
				if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):isEmpty() and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) then
					pok = enemy
					break
				end
			end
		end
		if not pok then
			for _, friend in ipairs(self.friends_noself) do
				if (self:needToLoseHp(friend, self.player) or self:hasSkills(sgs.masochism_skill, friend)) and friend:getPile("tszhubo"):isEmpty() and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then
					pok = friend
					break
				end
			end
		end
		if not pok then
			for _, friend in ipairs(self.friends_noself) do
				if friend:getPile("tszhubo"):isEmpty() then
					pok = friend
					break
				end
			end
		end
	end
	if cok and pok then
		use.card = sgs.Card_Parse("#tswuxianCard:" .. c:getId() .. ":")
		if use.to then
			use.to:append(pok)
			return
		end
	end
end

sgs.ai_use_value["tswuxianCard"] = 5.3
sgs.ai_use_priority["tswuxianCard"] = 3

sgs.ai_skill_playerchosen.tswuxian = function(self, targets)
	local pok = nil
	local cmpb = function (a, b)
		if b:getPile("tszhubo"):isEmpty() and a:getPile("tszhubo"):isEmpty() then return a:getHandcardNum() > b:getHandcardNum() end
		if b:getPile("tszhubo"):isEmpty() and not a:getPile("tszhubo"):isEmpty() then return true end
		if a:getPile("tszhubo"):isEmpty() and not b:getPile("tszhubo"):isEmpty() then return false end
		return (getKnownCard(a, self.player, IdTable2CardTable(sgs.QList2Table(a:getPile("tszhubo"):first()))[1]:getSuitString(), true) > getKnownCard(b, self.player, IdTable2CardTable(sgs.QList2Table(b:getPile("tszhubo"):first()))[1]:getSuitString(), true) or (getKnownCard(a, self.player, IdTable2CardTable(sgs.QList2Table(a:getPile("tszhubo"):first()))[1]:getSuitString(), true) == getKnownCard(b, self.player, IdTable2CardTable(sgs.QList2Table(b:getPile("tszhubo"):first()))[1]:getSuitString(), true) and a:getHandcardNum() > b:getHandcardNum()))
	end
	if self:isWeak(self.player) then
		table.sort(self.friends_noself, cmpb)
		if (getKnownCard(self.friends_noself[1], self.player, IdTable2CardTable(sgs.QList2Table(self.friends_noself[1]:getPile("tszhubo"):first()))[1]:getSuitString(), true) > 0 or self.friends_noself[1]:getHandcardNum() > 2) and self.friends_noself[1]:getPile("tszhubo"):length() > 0 then 
			pok = self.friends_noself[1] 
			return pok
		end
		self:sort(self.enemies, "hp")
		for _, enemy in ipairs(self.enemies) do
			if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):length() > 0 and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) and (getKnownCard(enemy, self.player, c:getSuitString(), true) > 0 or enemy:getHandcardNum() > 2) then
				pok = enemy
				return pok
			end
		end
		for _, enemy in ipairs(self.enemies) do
			if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):length() > 0 and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) then
				pok = enemy
				return pok
			end
		end
		for _, friend in ipairs(self.friends_noself) do
			if (self:needToLoseHp(friend, self.player) or self:hasSkills(sgs.masochism_skill, friend)) and friend:getPile("tszhubo"):length() > 0 and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then
				pok = friend
				return pok
			end
		end
	else
		for _, enemy in ipairs(self.enemies) do
			if (not self:needToLoseHp(enemy, self.player)) and enemy:getPile("tszhubo"):length() > 0 and self:damageIsEffective(enemy, sgs.DamageStruct_Thunder, self.player) and not self:hasSkills(sgs.masochism_skill, enemy) then
				pok = enemy
				return pok
			end
		end
		for _, friend in ipairs(self.friends_noself) do
			if (self:needToLoseHp(friend, self.player) or self:hasSkills(sgs.masochism_skill, friend)) and friend:getPile("tszhubo"):length() > 0 and self:damageIsEffective(friend, sgs.DamageStruct_Thunder, self.player) then
				pok = friend
				return pok
			end
		end
		table.sort(self.friends_noself, cmpb)
		if (getKnownCard(self.friends_noself[1], self.player, IdTable2CardTable(sgs.QList2Table(self.friends_noself[1]:getPile("tszhubo"):first()))[1]:getSuitString(), true) > 0 or math.min(self.friends_noself[1]:getHandcardNum(), self.friends_noself[1]:getHp()) > 1) and self.friends_noself[1]:getPile("tszhubo"):length() > 0 then
			pok = self.friends_noself[1] 
			return pok
		end
	end
	return pok
end

sgs.ai_skill_invoke.tsjiaobian = function(self, data)
	local damage = data:toDamage()
	sgs.tsjbdis = false
	local candraw = self.player:faceUp() and self:isEnemy(damage.to:getNextAlive())
	if candraw then
		if (self.player:getHp() >= 3 and not self.player:hasSkill("yongsi")) or self.player:getHp() >= 4 or (damage.to:getNextAlive():getHp() == 1 and self:damageIsEffective(damage.to:getNextAlive(), sgs.DamageStruct_Thunder, self.player)) then return true end
		local upp = nil
		for _,pe in sgs.qlist(self.room:getOtherPlayers(damage.to)) do
			if damage.to:getSeat() == math.mod(pe:getSeat(),damage.to:aliveCount())+1 then upp = pe break end
		end
		if upp and self:isEnemy(upp) and (upp:isWeak() and self:damageIsEffective(upp, sgs.DamageStruct_Thunder, self.player)) and not (damage.to:getNextAlive():getHp() == 1 and self:damageIsEffective(damage.to:getNextAlive(), sgs.DamageStruct_Thunder, self.player)) then candraw = false end
		if self.player:getHp() >= 2 and self:damageIsEffective(damage.to:getNextAlive(), sgs.DamageStruct_Thunder, self.player) then return true end
	end	
	if not candraw then
		local victim = damage.to:getNextAlive()
		if self.player:faceUp() then 
			for _,pe in sgs.qlist(self.room:getOtherPlayers(damage.to)) do
				if damage.to:getSeat() == math.mod(pe:getSeat(),damage.to:aliveCount())+1 then victim = pe break end
			end
		end
		if self:isEnemy(victim) then 
			local needcard_num = self.player:getHp()
			local cards = self.player:getCards("he")
			local to_discard = {}
			cards = sgs.QList2Table(cards)
			self:sortByKeepValue(cards)
			for _, card in ipairs(cards) do
				local keeps = card:isKindOf("Peach") or card:isKindOf("ExNihilo") or (card:isKindOf("C6") and self.room:getCurrent():objectName() == self.player:objectName()) or (card:isKindOf("Analeptic") and self.player:getHp() == 1)
				if (not keeps) or (damage.from:getHp() == 1 and self:damageIsEffective(victim, sgs.DamageStruct_Thunder, self.player)) or (self.room:getCurrent():objectName() == self.player:objectName() and self:getOverflow(self.player) > needcard_num) then
					table.insert(to_discard, card:getEffectiveId())
					if #to_discard == needcard_num then break end
				end
			end
			if #to_discard == needcard_num then
				sgs.tsjbdis = to_discard
				return true
			end
		end
	end
end

sgs.ai_skill_discard.tsjiaobian = function(self, discard_num, optional, include_equip)
	local a = nil
	a = sgs.tsjbdis
	sgs.tsjbdis = false
	if a then 
		return a 
	else
		return {}
	end
end

sgs.ai_skill_invoke.ysbengdong = function(self, data)
	local l = data:toString():split("+")
	sgs.bengdonggive = false
	sgs.bengdongvictim = false
	sgs.bengdongget = false
	self:sortByKeepValue(IdTable2CardTable(l))
	if self.room:getCurrent():objectName() == self.player:objectName() then self:sortByUseValue(IdTable2CardTable(l)) end
	for _,lc in ipairs(l) do
		local samelist = {}
		for _,hc in sgs.qlist(self.player:getHandcards()) do
			if sgs.Sanguosha:getCard(lc):getTypeId() == hc:getTypeId() then table.insert(samelist, hc) end
		end
		local c, friend = self:getCardNeedPlayer(samelist, false)
		if c and friend then 
			sgs.bengdonggive = c
			sgs.bengdongvictim = friend
			sgs.bengdongget = lc
			return true
		end
	end
	for _,lid in ipairs(l) do
		local card = sgs.Sanguosha:getCard(lid)
		local handcards = sgs.QList2Table(self.player:getHandcards())
		if self.room:getCurrent():objectName() ~= self.player:objectName() then
			if hasManjuanEffect(self.player) then return "." end
		--	self.room:writeToConsole("presort ")
			self:sortByKeepValue(handcards)
			for _, card_ex in ipairs(handcards) do
			--	self.room:writeToConsole(card_ex:getClassName() .. " precmp")
				if self:getKeepValue(card_ex) < self:getKeepValue(card) and not self:isValuableCard(card_ex) then
				--	self.room:writeToConsole(card_ex:getClassName() .. " cmped")
					sgs.bengdonggive = card_ex
					sgs.bengdongget = card
					return true
				end
			end
		else
			self.room:writeToConsole("presort ")
			if card:isKindOf("Slash") and not self:slashIsAvailable() then return "." end
			self:sortByUseValue(handcards)
			self.room:writeToConsole("sorted")
			for _, card_ex in ipairs(handcards) do
				self.room:writeToConsole(card_ex:getClassName() .. " precmp")
				if self:getUseValue(card_ex) < self:getUseValue(card) and not self:isValuableCard(card_ex) then
					self.room:writeToConsole(card_ex:getClassName() .. " cmped")
					sgs.bengdonggive = card_ex
					sgs.bengdongget = card
					return true
				end
			end
		end
	end
	return false
end

sgs.ai_skill_askforag["ysbengdong"] = function(self, card_ids)
	local a = nil
	a = sgs.bengdongget
	sgs.bengdongget = false
	if table.contains(card_ids, a) then return a end
	return -1
end

sgs.ai_skill_cardask["ysbengdongask"]=function(self, data) 
	if sgs.bengdonggive then 
		local a = sgs.bengdonggive:getEffectiveId()
		sgs.bengdonggive = false
		return "$" .. a
	end
	return "."
end

sgs.ai_skill_playerchosen.ysbengdong = function(self, targets)
	if sgs.bengdongvictim then 
		local a = sgs.bengdongvictim
		sgs.bengdongvictim = false
		return a
	end
	return nil
end

sgs.ai_skill_invoke.kpxingtu = function(self, data)
	return true 
end

sgs.ai_skill_use["@@kpxingyun"] = function(self, prompt)
	local cards = self.player:getPile("kpstar")
	cards = IdTable2CardTable(sgs.QList2Table(cards))
	self:sortByUseValue(cards,true)
	sgs.xingyunequip = false
	sgs.xingyunjudge = false

	local target
	for _, friend in ipairs(self.friends) do
		if self:hasSkills(sgs.lose_equip_skill, friend) and not friend:getEquips():isEmpty() and not friend:hasSkill("manjuan") then
			for _, card in ipairs(cards) do
				local index = card:getRealCard():toEquipCard():location()
				if friend:getEquip(index) ~= nil then
					target = friend
					sgs.xingyunequip = card
					break
				end
			end
		end
	end
	
	if not target then
		self.room:writeToConsole("No one want equip?")
		for _, enemy in ipairs(self.enemies) do
			if self:getDangerousCard(enemy) then
				target = enemy
				break
			end
		end
	end
	if not target then
		self.room:writeToConsole("No dangerous enemy?")
		for _, friend in ipairs(self.friends) do
			if self:needToThrowArmor(friend) and not friend:hasSkill("manjuan") then
				for _, card in ipairs(cards) do
					if card:getRealCard():toEquipCard():location() == friend:getArmor():location() then
						target = friend
						sgs.xingyunequip = card
						break
					end
				end
			end
		end
	end
	if not target then
		self.room:writeToConsole("No one want throw armor?")
		self:sort(self.enemies, "handcard")
		for _, enemy in ipairs(self.enemies) do
			if self:getValuableCard(enemy) then
				target = enemy
				break
			end
			if target then break end

			local cards = sgs.QList2Table(enemy:getHandcards())
			local flag = string.format("%s_%s_%s", "visible", self.player:objectName(), enemy:objectName())
			if not enemy:isKongcheng() and not enemy:hasSkills("tuntian+zaoxian") then
				for _, cc in ipairs(cards) do
					if (cc:hasFlag("visible") or cc:hasFlag(flag)) and (cc:isKindOf("Peach") or cc:isKindOf("Analeptic")) then
						target = enemy
						break
					end
				end
			end
			if target then break end

			if self:getValuableCard(enemy) then
				target = enemy
				break
			end
			if target then break end
		end
	end
	if not target then
		self.room:writeToConsole("No valuable enemy?")
		for _, friend in ipairs(self.friends_noself) do
			if friend:hasSkills("tuntian+zaoxian") and not friend:hasSkill("manjuan") then
				target = friend
				break
			end
		end
	end
	if not target then
		self.room:writeToConsole("No heartdeng?")
		for _, enemy in ipairs(self.enemies) do
			if not enemy:isNude() and enemy:hasSkill("manjuan") then
				target = enemy
				break
			end
		end
	end
	if not target then 
		self.room:writeToConsole("No dustbin?")
		if self:willSkipPlayPhase(self.player) then self:sortByKeepValue(cards,true) end
		target = self.player 
	end

	if target then
		local willUse
		self.room:writeToConsole("target"..target:getGeneralName())
		if self:isFriend(target) then
			for _, card in ipairs(cards) do
				willUse = card
				break
			end
		elseif target:objectName() == self.player:objectName() then
			if self:willSkipPlayPhase(self.player) then self:sortByKeepValue(cards,true) end
			willUse = cards[#cards]
		else
			for _, card in ipairs(cards) do
				if not isCard("Peach", card, target) and not isCard("Nullification", card, target) then
					willUse = card
					break
				end
			end
		end
		if sgs.xingyunequip then willUse = sgs.xingyunequip end
		if willUse then
			self.room:writeToConsole(willUse:getClassName())
			return "#kpxingyunCard:"..willUse:getId()..":->"..target:objectName()
		end
	end
end

sgs.ai_skill_cardchosen.kpxingyun = function(self, who, flags)
	local equip = sgs.xingyunequip
	sgs.xingyunequip = false
	for _,c in sgs.qlist(who:getEquips()) do
		if c:location() == equip:getRealCard():toEquipCard():location() then
			return c:getEffectiveId()
		end
	end
	return nil
end

local function findEDArticle(self, pattern)
	self.ArticleToCopy = nil
	self.ArticleToCopyone = nil
	local enabled = sgs.IntList()
	local usedp = self.player:property("edcankaoused"):toString()
	local used = usedp:split("+")
	local cards = sgs.QList2Table(self.player:getCards("he"))
	self:sortByKeepValue(cards)
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		local spile = p:getPile("edarticle")
		for _,cid in sgs.qlist(spile) do
			if (sgs.Sanguosha:matchExpPattern(pattern, self.player, sgs.Sanguosha:getCard(cid)) or string.find(pattern,sgs.Sanguosha:getCard(cid):objectName())) and not table.contains(used, tostring(cid)) then
				enabled:append(sgs.Sanguosha:getCard(cid))
			end
		end
	end
	if not enabled:isEmpty() then
		local ready = {}
		local tomake = {}
		self.room:writeToConsole("find")
		for _,ab in sgs.qlist(enabled) do
			for _,cd in ipairs(cards) do
				if cd:getSuit() == ab:getSuit() then
					table.insert(ready, cd)
					table.insert(tomake, ab)
				end
			end
		end
		if #ready ~= 0 then
			local copyone = ready
			self:sortByKeepValue(copyone)
			for _,ef in ipairs(tomake) do
				if tomake:getSuit() == copyone[1]:getSuit() and (self:getKeepValue(copyone[1]) < sgs.ai_keep_value[tomake:getClassName()] * 1.4 or string.find(pattern, "peach")) then
					self.ArticleToCopy = tomake
					self.ArticleToCopyone = copyone[1]
					return copyone[1]
				end
			end
		end
	end
	return nil
end

sgs.ai_skill_invoke.edcankao = function(self, data)
	local pattern = data:toStringList()[1]
	local copyone = findEDArticle(self, pattern)
	return copyone 
end

sgs.ai_skill_askforag["edcankao"] = function(self, card_ids)
	self.room:writeToConsole("preag")
	if table.contains(card_ids, self.ArticleToCopy:getEffectiveId()) then
		self.room:writeToConsole("forag")
		return self.ArticleToCopy:getEffectiveId()
	end
	return card_ids[1]
end

sgs.ai_skill_use["@@edcankaosecond"] = function(self, prompt)
	local card = sgs.Sanguosha:getCard(self.player:property("edcankaoasking"):toInt())
	local todis = self.ArticleToCopyone
	local dummy_use = {isDummy = true, to = sgs.SPlayerList(), current_targets = {}}
	self:useCardByClassName(card, dummy_use)
	self.room:writeToConsole("2nd")
	if dummy_use.card and todis then
		self.room:writeToConsole("dummy")
		if dummy_use.to:isEmpty() then
			return "#edcankaosecond:"..todis:getEffectiveId()..":"
		else
			local target_objectname = {}
			for _, p in sgs.qlist(dummy_use.to) do
				table.insert(target_objectname, p:objectName())
			end
			return "#edcankaosecond:"..todis:getEffectiveId()..":->" .. table.concat(target_objectname, "+")
		end
	end
end

sgs.ai_skill_cardask["@edcankaoaskforc"]=function(self)
	self.room:writeToConsole("perasc")
	if self.ArticleToCopyone then
		self.room:writeToConsole("asc")
		return self.ArticleToCopyone:getId()
	end
	return "."
end

sgs.ai_skill_cardask["@edcankaoask"] = sgs.ai_skill_cardask["@edcankaoaskforc"]

local edcankaoVS_skill={}
edcankaoVS_skill.name="edcankao"
table.insert(sgs.ai_skills,edcankaoVS_skill)
edcankaoVS_skill.getTurnUseCard=function(self,inclusive) 
	local cards = sgs.QList2Table(self.player:getCards("he"))
	self:sortByKeepValue(cards)
	local enabled = {}
	local usedp = self.player:property("edcankaoused"):toString()
	local used = usedp:split("+")
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		local spile = p:getPile("edarticle")
		for _,cid in sgs.qlist(spile) do
			if sgs.Sanguosha:getCard(cid):isAvailable(self.player) and not table.contains(used, tostring(cid)) then
				table.insert(enabled, sgs.Sanguosha:getCard(cid))
			end
		end
	end
	local cmp = function(a, b)
		return sgs.ai_use_priority[a:getClassName()] > sgs.ai_use_priority[b:getClassName()] or (sgs.ai_use_priority[a:getClassName()] == sgs.ai_use_priority[b:getClassName()] and sgs.ai_use_value[a:getClassName()] > sgs.ai_use_value[b:getClassName()])
	end
	table.sort(enabled, cmp)
	if #enabled > 0 then 
		self.room:writeToConsole("456")
		for _,ab in ipairs(enabled) do
			sgs.ai_use_priority["edcankaoCard"] = sgs.ai_use_priority[ab:getClassName()]
			sgs.ai_use_value["edcankaoCard"] = sgs.ai_use_value[ab:getClassName()]
				self.room:writeToConsole("abc")
			for _,cd in ipairs(cards) do
				if cd:getSuit() == ab:getSuit() and self:getUseValue(cd) + self:getKeepValue(cd) < (sgs.ai_use_value[ab:getClassName()] + sgs.ai_keep_value[ab:getClassName()]) * 1.4 then
					self.ArticleToCopy = ab
					self.ArticleToCopyone = cd
					self.room:writeToConsole("clone ready")
					local card_str = ("#edcankao:.:" .. ab:objectName())
					local slash = sgs.Card_Parse(card_str)
					self.room:writeToConsole("clone ok")
					assert(slash)
					return slash
				end
			end
		end
	end
	sgs.ai_use_value["edcankaoCard"] = 10
	sgs.ai_use_priority["edcankaoCard"] = 10
end

sgs.ai_use_value["edcankaoCard"] = 10
sgs.ai_use_priority["edcankaoCard"] = 10

function SmartAI:shouldUseTrainGHC()
	if (self:hasCrossbowEffect() or self:getCardsNum("Crossbow") > 0) and self:getCardsNum("Slash") > 0 then
		self:sort(self.enemies, "defense")
		for _, enemy in ipairs(self.enemies) do
			local inAttackRange = self.player:distanceTo(enemy) == 1 or self.player:distanceTo(enemy) == 2
									and self:getCardsNum("OffensiveHorse") > 0 and not self.player:getOffensiveHorse()
			if inAttackRange and sgs.isGoodTarget(enemy, self.enemies, self) then
				local slashs = self:getCards("Slash")
				local slash_count = 0
				for _, slash in ipairs(slashs) do
					if not self:slashProhibit(slash, enemy) and self:slashIsEffective(slash, enemy) then
						slash_count = slash_count + 1
					end
				end
				if slash_count >= enemy:getHp() then return false end
			end
		end
	end
	for _, enemy in ipairs(self.enemies) do
		if enemy:canSlash(self.player) and not self:slashProhibit(nil, self.player, enemy) then
			if enemy:hasWeapon("guding_blade") and self.player:getHandcardNum() == 1 and getCardsNum("Slash", enemy) >= 1 then
				return false
			elseif self:hasCrossbowEffect(enemy) and getCardsNum("Slash", enemy) > 1 and self:getOverflow() <= 0 then
				return false
			end
		end
	end
	for _, player in ipairs(self.friends_noself) do
		if player:hasSkill("jijiu") then
			return true
		end
	end
	local keepNum = 1
	if not self.player:hasUsed("#stdriveCard") then
		if self.player:getHandcardNum() == 3 then
			keepNum = 2
		end
		if self.player:getHandcardNum() > 3 then
			keepNum = 3
		end
	end
	if self:needKongcheng(self.player) then
		keepNum = 0
	end
	if self:getOverflow() > 0  then
		return true
	end
	if self.player:getHandcardNum() > keepNum  then
		return true
	end
end

function SmartAI:shouldUseTrainGEQ()
	self.TGEQtarget = nil
	self.TGEQcard = nil
	if self.player:getEquips():length() == 0 then return false end
	local equips = {}
	for _, card in sgs.qlist(self.player:getEquips()) do
		if card:isKindOf("Armor") or card:isKindOf("Weapon") then
			local flag = false
			for _, carda in sgs.qlist(self.player:getHandcards()) do
				if card:isKindOf("Armor") == carda:isKindOf("Armor") and card:isKindOf("Weapon") == carda:isKindOf("Weapon") then
					flag = true
				end
			end
			if not flag then
			elseif card:isKindOf("GudingBlade") and self:getCardsNum("Slash") > 0 then
				local HeavyDamage
				local slash = self:getCard("Slash")
				for _, enemy in ipairs(self.enemies) do
					if self.player:canSlash(enemy, slash, true) and not self:slashProhibit(slash, enemy) and
						self:slashIsEffective(slash, enemy) and not self.player:hasSkill("jueqing") and enemy:isKongcheng() then
							HeavyDamage = true
							break
					end
				end
				if not HeavyDamage then table.insert(equips, card) end
			else
				table.insert(equips, card)
			end
		elseif card:getTypeId() == sgs.Card_TypeEquip then
			table.insert(equips, card)
		end
	end

	if #equips == 0 then return end

	local select_equip, target
	for _, friend in ipairs(self.friends_noself) do
		for _, equip in ipairs(equips) do
			if not self:getSameEquip(equip, friend) and self:hasSkills(sgs.need_equip_skill .. "|" .. sgs.lose_equip_skill, friend) and friend:getPile("strail"):length() > 1 then
				target = friend
				select_equip = equip
				break
			end
		end
		if target then break end
		for _, equip in ipairs(equips) do
			if (not self:getSameEquip(equip, friend)) and friend:getPile("strail"):length() > 1 then
				target = friend
				select_equip = equip
				break
			end
		end
		if target then break end
	end
	if target then 
		self.TGEQtarget = target
		self.TGEQcard = select_equip
		return true
	else 
		return false
	end
end

function SmartAI:shouldUseTrainTST()
	self.TSTtarget = nil
	self.TSTtargetSharp = false
	local needhelps, noneed = self:getWoundedFriend(false, true)
	local needhelp = {}
	for _,p in ipairs(needhelps) do
		if p:getPile("strail"):length() > 2 and p:objectName() ~= self.player:objectName() then table.insert(needhelp, p) end
	end
	if #needhelp == 0 then return false end
	if not table.contains(needhelps, self.player) then 
		self.TSTtarget = needhelp[1]
		if (needhelp[1]:isLord() or needhelp[1]:getHp() == 1) and self:isWeak(needhelp[1]) then
			self.TSTtargetSharp = true
		end
		return true
	else
		local shouldgive = false
		local finded = false
		local n = 1
		for key,p in ipairs(needhelp) do
			if table.contains(needhelps, p) and not finded then 
				finded = true
				n = key
			end
			if p:objectName() == self.player:objectName() then 
				shouldgive = key > n + 1
			end
		end
		if shouldgive and (self.player:getHp() > 1 or self.player:hasSkill("buqu|nosbuqu")) then
			self.TSTtarget = needhelp[1]
			if (needhelp[1]:isLord() or needhelp[1]:getHp() == 1) and self:isWeak(needhelp[1]) then
				self.TSTtargetSharp = true
			end
			return true
		end
	end
	return false
end

local stdrive_skill = {}
stdrive_skill.name = "stdrive"
table.insert(sgs.ai_skills, stdrive_skill)
stdrive_skill.getTurnUseCard = function(self)
--	self.room:writeToConsole("drive A")
	if self:shouldUseTrainTST() and self.player:getPile("strail"):length() > 2 and self.TSTtargetSharp then
		self.room:writeToConsole("drive BLA")
		return sgs.Card_Parse("#stdriveCard:.:")
	elseif self:shouldUseTrainGEQ() and self.player:getPile("strail"):length() > 1 then
	--	self.room:writeToConsole("drive EQ")
		return sgs.Card_Parse("#stdriveCard:.:")
	elseif self:shouldUseTrainGHC() and self.player:getPile("strail"):length() ~= 0 then
		if self.player:isKongcheng() then return end
	--	self.room:writeToConsole("drive HC")
		return sgs.Card_Parse("#stdriveCard:.:")
	elseif self:shouldUseTrainTST() and self.player:getPile("strail"):length() > 2 and not self.TSTtargetSharp then
	--	self.room:writeToConsole("drive BL")
		return sgs.Card_Parse("#stdriveCard:.:")
	end
end

sgs.ai_skill_use_func["#stdriveCard"] = function(card, use, self)
	if self:shouldUseTrainTST() and self.player:getPile("strail"):length() > 2 and self.TSTtargetSharp then
		use.card = sgs.Card_Parse("#stdriveCard:.:")
		if use.to then use.to:append(self.TSTtarget) end
		self.TSTtarget = nil
		self.TSTtargetSharp = false
		return
	elseif self:shouldUseTrainGEQ() and self.player:getPile("strail"):length() > 1 then
		use.card = sgs.Card_Parse("#stdriveCard:" .. self.TGEQcard:getId() .. ":")
		if use.to then use.to:append(self.TGEQtarget) end
		self.TGEQtarget = nil
		self.TGEQcard = nil
		return
	elseif self:shouldUseTrainGHC()  and self.player:getPile("strail"):length() ~= 0 then
	--	self.room:writeToConsole("drive preHC")
		local cards = sgs.QList2Table(self.player:getHandcards())
		self:sortByUseValue(cards, true)
		local notFound
		for i = 1, #cards do
			local card, friend = self:getCardNeedPlayer(cards)
			if card and friend then
				cards = self:resetCards(cards, card)
			else
				notFound = true
				break
			end

			if friend:objectName() == self.player:objectName() or (not self.player:getHandcards():contains(card)) or friend:getPile("strail"):length() == 0 then continue end
			local canJijiang = self.player:hasLordSkill("jijiang") and friend:getKingdom() == "shu"
			if card:isAvailable(self.player) and ((card:isKindOf("Slash") and not canJijiang) or card:isKindOf("Duel") or card:isKindOf("Snatch") or card:isKindOf("Dismantlement")) then
				local dummy_use = { isDummy = true, to = sgs.SPlayerList() }
				local cardtype = card:getTypeId()
				self["use" .. sgs.ai_type_name[cardtype + 1] .. "Card"](self, card, dummy_use)
				if dummy_use.card and dummy_use.to:length() > 0 then
					if card:isKindOf("Slash") or card:isKindOf("Duel") then
						local t1 = dummy_use.to:first()
						if dummy_use.to:length() > 1 then continue
						elseif t1:getHp() == 1 or sgs.card_lack[t1:objectName()]["Jink"] == 1
								or t1:isCardLimited(sgs.Sanguosha:cloneCard("jink"), sgs.Card_MethodResponse) then continue
						end
					elseif (card:isKindOf("Snatch") or card:isKindOf("Dismantlement")) and self:getEnemyNumBySeat(self.player, friend) > 0 then
						local hasDelayedTrick
						for _, p in sgs.qlist(dummy_use.to) do
							if self:isFriend(p) and (self:willSkipDrawPhase(p) or self:willSkipPlayPhase(p)) then hasDelayedTrick = true break end
						end
						if hasDelayedTrick then continue end
					end
				end
			elseif card:isAvailable(self.player) and self:getEnemyNumBySeat(self.player, friend) > 0 and (card:isKindOf("Indulgence") or card:isKindOf("SupplyShortage") or card:isKindOf("Hetongbh") or card:isKindOf("Zuhua")) then
				local dummy_use = { isDummy = true }
				self:useTrickCard(card, dummy_use)
				if dummy_use.card then continue end
			end

			if friend:hasSkill("enyuan") and #cards >= 1 then
				use.card = sgs.Card_Parse("#stdriveCard:" .. card:getId() .. "+" .. cards[1]:getId() .. ":")
			else
				use.card = sgs.Card_Parse("#stdriveCard:" .. card:getId() .. ":")
			end
		--	self.room:writeToConsole("drive HCed")
			if use.to then use.to:append(friend) end
			return
		end
	elseif self:shouldUseTrainTST() and self.player:getPile("strail"):length() > 2 and not self.TSTtargetSharp then
		use.card = sgs.Card_Parse("#stdriveCard:.:")
		if use.to then use.to:append(self.TSTtarget) end
		self.TSTtarget = nil
		return
	end
end

sgs.ai_use_value.stdriveCard = 8.2
sgs.ai_use_priority.stdriveCard = 8.7

function sgs.ai_cardneed.stdrive(to, card)
	return to:getCards("h"):length() < 5 and self:getKeepValue(card) + self:getUseValue(card) < 8.7
end

sgs.ai_card_intention.stdriveCard = function(self, card, from, tos)
	local to = tos[1]
	local intention = -70
	if hasManjuanEffect(to) then
		intention = 0
	elseif to:hasSkill("kongcheng") and to:isKongcheng() and self:shouldUseTrainGHC() then
		intention = 30
	end
	sgs.updateIntention(from, to, intention)
end

sgs.dynamic_value.benefit.stdriveCard = true

sgs.ai_skill_invoke.hskefad = function(self, data)
	local typ = data:toString()
	local toUse = self:getTurnUse()
	local hs = nil
	for _,sp in sgs.qlist(self.room:getOtherPlayers(self.player)) do
		if sp:getMark("hskefafound") > 0 then hs = sp break end
	end
	local needdmg = hs and self:needToLoseHp(self.player, hs) and self:damageIsEffective(self.player, sgs.DamageStruct_Normal, hs)
	if self:willSkipPlayPhase(self.player) then return needdmg end
	for _,card in ipairs(toUse) do
		if not self.player:isJilei(card) then -- 如果没有被“鸡肋”
		--	self.room:writeToConsole(card:getClassName())
			local type = card:getTypeId()
			local dummy_use = { isDummy = true, to = sgs.SPlayerList(), current_targets = {} }
			self["use" .. sgs.ai_type_name[type + 1] .. "Card"](self, card, dummy_use) -- 按卡牌的类型使用卡牌
		--	self.room:writeToConsole("dummyused")
			if dummy_use.card then
				if card:isKindOf(typ) then
				--	self.room:writeToConsole("OK")
					if needdmg then return false end
					return true
				end
			end
		end
	end
	return needdmg
end

sgs.ai_skill_cardask["@krenergy"]=function(self, data) 
	return "." -- wait for fill
end

sgs.ai_skill_choice.lpyuqing = function(self, choices, data)
	if #choices == 1 then return "lpyqdraw" end
	local ans = "lpyqdraw"
	local victim = nil
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do 
		if data:toString() == p:objectName() then victim = p break end
	end
	if victim then
		if self:isFriend(victim) then
			if self:needToThrowArmor(victim) or ((not victim:getJudgingArea():isEmpty()) and not victim:containsTrick("YanxiaoCard")) then
				ans = "lpyqdis"
			end
		elseif self:isEnemy(victim) then
			if not self:doNotDiscard(victim) then ans = "lpyqdis" end
		end
		return ans
	end
end

sgs.ai_skill_choice.bnrepeat = function(self, choices, data)
	local choit = {"bnrepeatpile", "bnrepeathand"}
	local n = math.random(1,2)
	return choit[n]
end

sgs.ai_skill_playerchosen.kltiance = function(self, targets)
	return nil
end

sgs.ai_skill_invoke.kltiance = function(self, data)
	local objname = data:toString():split(":")[2]
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if p:objectName() == objname then
			return (self:isFriend(p) and not self:needKongcheng(p, true))
		end
	end
end

surveyShouleBeOpen = false

sgs.ai_skill_invoke.surveyStart = function(self, data)
	if surveyShouleBeOpen then return true end
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if p:hasSkills("tuntian|wuzhishouheng|nsjunheng") then
			if p:objectName() == self.player:objectName() or self:isFriend(p) then
				return true
			else
				return false
			end
		end
	end
	local n = math.random(1,self.room:getAlivePlayers():length())
	return self.player:getRole() ~= "renegade" and n >= math.mod(self.player:getSeat(), self.room:getAlivePlayers():length()) 
end

sgs.ai_skill_invoke.surveyDraw = function(self, data)
	return not self:needKongcheng(self.player, true)
end

sgs.ai_skill_invoke.surveyArgue = function(self, data)
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if p:hasSkills("tuntian|wuzhishouheng|nsjunheng") then
			if (p:objectName() == self.player:objectName() or self:isFriend(p)) and #self.friends_noself - #self.enemies <= 2 then
				return true
			else
				return false
			end
		end
	end
	return #self.friends_noself <= #self.enemies
end

sgs.ai_skill_invoke.surveyWar = function(self, data)
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if p:hasSkills("tuntian|wuzhishouheng|nsjunheng") then
			if (p:objectName() == self.player:objectName() or self:isFriend(p)) and #self.enemies - #self.friends_noself <= 2 then
				return true
			else
				return false
			end
		end
	end
	return #self.friends_noself >= #self.enemies
end

sgs.ai_skill_use["surveyWarforAI"] = function(self, prompt)
	local cards = sgs.QList2Table(self.player:getHandcards()) -- 获得手牌的表
	local notuse = {"Analeptic","Yimi"}
	local damagecard = {"Slash","Acid","Alkali","Duel","ArcheryAttack","SavageAssault","Acidfly","Alkalifly","FireAttack","Sizao","Fireup"}
	local dummy_use = {isDummy = true, to = sgs.SPlayerList(), current_targets = {}}
	local touse = {}
	local weakenemy = {}
	for _,p in sgs.qlist(self.room:getAlivePlayers()) do
		if self:isEnemy(p) and self:isWeak(p) then
			table.insert(weakenemy, p)
		end
	end
	for _,c in ipairs(cards) do 
		local hasweak = false
		for _,ene in ipairs(weakenemy) do 
			local damage = sgs.DamageStruct()
				damage.from = self.player
				damage.to = ene
				damage.card = c
			if self:damageIsEffective(damage) then
				hasweak = true
			end
		end
		if c:isAvailable(self.player) and (not table.contains(notuse,c:getClassName())) and (self.player:getHandcardNum() == 1 or hasweak or (not table.contains(damagecard,c:getClassName()))) then
			table.insert(touse, c)
		end
	end
	if #touse > 0 then
		local cmp = function(a, b)
			return (self:getKeepValue(a) > self:getKeepValue(b)) == self.player:containsTrick("indulgence")
		end
		table.sort(touse, cmp)
		local cd = touse[1]
		self:useCardByClassName(cd, dummy_use)
		if dummy_use.card then
			if dummy_use.to:isEmpty() then
				return dummy_use.card:toString()
			else
				local target_objectname = {}
				for _, p in sgs.qlist(dummy_use.to) do
					table.insert(target_objectname, p:objectName())
				end
				return dummy_use.card:toString() .. "->" .. table.concat(target_objectname, "+")
			end
		end
	end
	return "."
end

sgs.ai_skill_choice.tkAItest = function(self, choices, data)
	for key,value in ipairs(self) do
		self.room:writeToConsole(key)
	end
	return "aaa"
end

---------------------

--[[
function SmartAI:useCardacid(card, use)
	if not use.isDummy and not card:isAvailable(self.player) then return end

	local basicnum = 0
	local cards = self.player:getCards("he")
	cards = sgs.QList2Table(cards)
	for _, acard in ipairs(cards) do
		if acard:getTypeId() == sgs.Card_TypeBasic and not acard:isKindOf("Peach") then basicnum = basicnum + 1 end
	end
	local no_distance = sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_DistanceLimit, self.player, card) > 50
						or card:getSkillName() == "qiaoshui"
	self.slash_targets = 1 + sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_ExtraTarget, self.player, card)
	if use.isDummy and use.extra_target then self.slash_targets = self.slash_targets + use.extra_target end

	local rangefix = 0
	if card:isVirtualCard() then
		if self.player:getWeapon() and card:getSubcards():contains(self.player:getWeapon():getEffectiveId()) then
			if self.player:getWeapon():getClassName() ~= "Weapon" then
				rangefix = sgs.weapon_range[self.player:getWeapon():getClassName()] - self.player:getAttackRange(false)
			end
		end
		if self.player:getOffensiveHorse() and card:getSubcards():contains(self.player:getOffensiveHorse():getEffectiveId()) then
			rangefix = rangefix + 1
		end
	end

	local function canAppendTarget(target)
		if use.to:contains(target) then return false end
		local targets = sgs.PlayerList()
		for _, to in sgs.qlist(use.to) do
			targets:append(to)
		end
		return card:targetFilter(targets, target, self.player)
	end

	if not use.isDummy and self:isWeak() and self:getOverflow() == 0 then return end
	for _, friend in ipairs(self.friends_noself) do
		local slash_prohibit = false
		slash_prohibit = self:slashProhibit(card, friend)
		if self:isPriorFriendOfSlash(friend, card) then
			if not slash_prohibit then
				if (not use.current_targets or not table.contains(use.current_targets, friend:objectName()))
					and (self.player:canSlash(friend, card, not no_distance, rangefix)
						or (use.isDummy and (self.player:distanceTo(friend, rangefix) <= self.predictedRange)))
					and self:slashIsEffective(card, friend) then
					use.card = card
					if use.to and canAppendTarget(friend) then
						use.to:append(friend)
					end
					if not use.to or self.slash_targets <= use.to:length() then return end
				end
			end
		end
	end


	local targets = {}
	local forbidden = {}
	self:sort(self.enemies, "defense")
	for _, enemy in ipairs(self.enemies) do
		if not self.room:isProhibited(self.player, enemy,card) and sgs.isGoodTarget(enemy, self.enemies, self, true) then
			if self:hasQiuyuanEffect(self.player, enemy) then table.insert(forbidden, enemy)
			elseif not self:getDamagedEffects(enemy, self.player, true) then table.insert(targets, enemy)
			else table.insert(forbidden, enemy) end
		end
	end
	if #targets == 0 and #forbidden > 0 then targets = forbidden end
	
	for _, target in ipairs(targets) do
		if (not use.current_targets or not table.contains(use.current_targets, target:objectName()))
				or (use.isDummy and self.predictedRange and self.player:distanceTo(target, rangefix) <= self.predictedRange)
			and self:objectiveLevel(target) > 3
			and self:slashIsEffective(card, target, self.player, shoulduse_wuqian)
			and not (not self:isWeak(target) and #self.enemies > 1 and #self.friends > 1
				and self:getOverflow() > 0 and not self:hasCrossbowEffect()) then

				if target:getHp() > 1 and target:hasSkill("jianxiong") and self.player:hasWeapon("spear") and card:getSkillName() == "spear" then
					local ids, isGood = card:getSubcards(), true
					for _, id in sgs.qlist(ids) do
						local c = sgs.Sanguosha:getCard(id)
						if isCard("Peach", c, target) or isCard("Analeptic", c, target) then isGood = false break end
					end
					if not isGood then continue end
				end
			end

			-- fill the card use struct
			local usecard = card
			if not use.to or use.to:isEmpty() then
				if self.player:hasWeapon("spear") and card:getSkillName() == "spear" then
				elseif not use.isDummy then
					local card = self:findWeaponToUse(target)
					if card then
						use.card = card
						return
					end

				local godsalvation = self:getCard("GodSalvation")
				if not use.isDummy and godsalvation and godsalvation:getId() ~= card:getId() and self:willUseGodSalvation(godsalvation) and
					(not target:isWounded() or not self:hasTrickEffective(godsalvation, target, self.player)) then
					use.card = godsalvation
					return
				end
			end
			use.card = use.card or usecard
			if use.to and not use.to:contains(target) and canAppendTarget(target) then
				use.to:append(target)
			end
			if not use.isDummy then
				local analeptic = self:searchForAnaleptic(use, target, use.card)
				if analeptic and self:shouldUseAnaleptic(target, use.card) and analeptic:getEffectiveId() ~= card:getEffectiveId() then
					use.card = analeptic
					if use.to then use.to = sgs.SPlayerList() end
					return
				end
				if self.player:hasSkill("jilve") and self.player:getMark("@bear") > 0 and not self.player:hasFlag("JilveWansha") and target:getHp() == 1 and not self.room:getCurrent():hasSkill("wansha")
					and (target:isKongcheng() or getCardsNum("alkali", target, self.player) < 1 or sgs.card_lack[target:objectName()]["alkali"] == 1) then
					use.card = sgs.Card_Parse("@JilveCard=.")
					sgs.ai_skill_choice.jilve = "wansha"
					if use.to then use.to = sgs.SPlayerList() end
					return
				end
				if self.player:hasSkill("duyi") and self.room:getDrawPile():length() > 0 and not self.player:hasUsed("DuyiCard") then
					sgs.ai_duyi = { id = self.room:getDrawPile():first(), tg = target }
					use.card = sgs.Card_Parse("@DuyiCard=.")
					if use.to then use.to = sgs.SPlayerList() end
					return
				end
			end
			if not use.to or self.slash_targets <= use.to:length() then return end
		end
	end

	for _, friend in ipairs(self.friends_noself) do
		local slash_prohibit = self.room:isProhibited(self.player, friend,card)
		if (not use.current_targets or not table.contains(use.current_targets, friend:objectName()))
		and (not use.to or not use.to:contains(friend))
		or (self:getDamagedEffects(friend, self.player) and not (friend:isLord() and #self.enemies < 1))
		or (self:needToLoseHp(friend, self.player, true, true) and not (friend:isLord() and #self.enemies < 1)) then

			if not slash_prohibit then
				if player:usedTimes("acid") <= sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, player , card)
				or (player:getWeapon() and player:getWeapon():isKindOf("aciddd"))
				and not (player:isCardLimited(card, sgs.Card_MethodUse) or self.room:isProhibited(self.player, friend,card))
				or (use.isDummy and self.predictedRange and self.player:distanceTo(friend, rangefix) <= self.predictedRange)			then
					use.card = card
					if use.to and canAppendTarget(friend) then
						use.to:append(friend)
					end
					if not use.to or self.slash_targets <= use.to:length() then return end
				end
			end
		end
	end
end
]]--

function SmartAI:damageIsEffective_(damageStruct)

	if type(damageStruct) ~= "table" and type(damageStruct) ~= "userdata" then self.room:writeToConsole(debug.traceback()) return end
	if not damageStruct.to then self.room:writeToConsole(debug.traceback()) return end
	local to = damageStruct.to
	local nature = damageStruct.nature or sgs.DamageStruct_Normal
	local damage = damageStruct.damage or 1
	local from = damageStruct.from
	if from:hasSkill("jueqing") then return true end

	local jinxuandi = self.room:findPlayerBySkillName("wuling")
	if jinxuandi and jinxuandi:getMark("@fire") > 0 then nature = sgs.DamageStruct_Fire end

	if to and to:hasSkill("shenjun") and to:getGender() ~= from:getGender() and nature ~= sgs.DamageStruct_Thunder then
		return false
	end
	if to:getMark("@fenyong") > 0 and to:hasSkill("fenyong")  then
		return false
	end
	if to:getMark("@fog") > 0 and nature ~= sgs.DamageStruct_Thunder then
		return false
	end
	if to:hasFlag("bls") then -- changed
		return false
	end
	if to:hasSkills("ayshuiyong|jgyuhuo") and nature == sgs.DamageStruct_Fire then
		return false
	end
	if to:hasSkill("mingshi") and from:getEquips():length() - (self.equipsToDec or 0) <= to:getEquips():length() then
		damage = damage - 1
		if damage == 0 then return false end
	end
	if to:hasSkill("yuce") and not to:isKongcheng() and to:getHp() > 1 then
		if self:isFriend(to, from) then return false
		else
			if from:objectName() ~= self.player:objectName() then
				if from:getHandcardNum() <= 2 then return false end
			else
				if (getKnownCard(to, self.player, "TrickCard", false, "h") + getKnownCard(to, self.player, "EquipCard", false, "h") < to:getHandcardNum()
					and getCardsNum("TrickCard", from, self.player) + getCardsNum("EquipCard", from, self.player) - from:getEquips():length() < 1)
					or getCardsNum("BasicCard", from, self.player) < 2 then
					return false
				end
			end
		end
	end
	if to:hasLordSkill("shichou") and to:getMark("xhate") == 1 then
		for _, p in sgs.qlist(self.room:getOtherPlayers(to)) do
			if p:getMark("hate_" .. to:objectName()) > 0 and p:getMark("@hate_to") > 0 then return self:damageIsEffective(p, nature, from) end
		end
	end

	for _, callback in ipairs(sgs.ai_damage_effect) do
		if type(callback) == "function" then
			local is_effective = callback(self, to, nature, from)
			if not is_effective then return false end
		end
	end

	return true
end

sgs.ai_card_intention.Slash = function(self, card, from, tos)
	if sgs.ai_liuli_effect then
		sgs.ai_liuli_effect = false
		if sgs.ai_liuli_user then
			sgs.updateIntention(from, sgs.ai_liuli_user, 10)
			sgs.ai_liuli_user = nil
		end
		return
	end
	if sgs.ai_collateral then sgs.ai_collateral = false return end
	if card:hasFlag("nosjiefan-slash") then return end
	if card:getSkillName() == "mizhao" then return end
	if card:getSkillName() == "ndfengdeng" then return end --changed
	for _, to in ipairs(tos) do
		local value = 80
		speakTrigger(card, from, to)
		if to:hasSkills("yiji|qiuyaun") then value = 0 end
		if to:hasSkills("nosleiji|leiji") and (getCardsNum("Jink", to, from) > 0 or to:hasArmorEffect("eight_diagram")) and not self:hasHeavySlashDamage(from, card, to)
			and (hasExplicitRebel(self.room) or sgs.explicit_renegade) and not self:canLiegong(to, from) then value = 0 end
		if not self:hasHeavySlashDamage(from, card, to) and (self:getDamagedEffects(to, from, true) or self:needToLoseHp(to, from, true, true)) then value = 0 end
		if from:hasSkill("pojun") and to:getHp() > (2 + self:hasHeavySlashDamage(from, card, to, true)) then value = 0 end
		if self:needLeiji(to, from) then value = from:getState() == "online" and 0 or -10 end
		if to:hasSkill("fangzhu") and to:isLord() and sgs.turncount < 2 then value = 10 end
		sgs.updateIntention(from, to, value)
	end
end

sgs.ai_card_intention.Duel = function(self, card, from, tos)
	if string.find(card:getSkillName(), "lijian") then return end
	if string.find(card:getSkillName(), "jlsidou") then return end
	sgs.updateIntentions(from, tos, 80)
end

function SmartAI:isPriorFriendOfSlash(friend, card, source)
	source = source or self.player
	local huatuo = self.room:findPlayerBySkillName("jijiu")
	if not self:hasHeavySlashDamage(source, card, friend) and card:getSkillName() ~= "lihuo"
			and ((self:findLeijiTarget(friend, 50, source, -1) or (self:findLeijiTarget(friend, 50, source, 1) and friend:isWounded()))
				or (friend:isLord() and source:hasSkill("guagu") and friend:getLostHp() >= 1 and getCardsNum("Jink", friend, source) == 0)
				or (friend:hasSkill("jieming") and source:hasSkill("nosrende") and (huatuo and self:isFriend(huatuo, source)))
				or (friend:hasSkill("hunzi") and friend:getHp() == 2 and self:getDamagedEffects(friend, source)))
				or self:hasNosQiuyuanEffect(source, friend)
				then
		return true
	end
	if self:damageIsEffective(friend, sgs.DamageStruct_Normal, source) and sgs.Sanguosha:getCurrentCardUsePattern() == "@@ndfengdeng" and source:hasSkill("ndhuli") and (not source:hasSkill("jueqing")) and (not self.room:getCurrent():hasFlag("ndhuliused")) then return true end -- changed
	if not source:hasSkill("jueqing") and card:isKindOf("NatureSlash") and friend:isChained() and self:isGoodChainTarget(friend, source, nil, nil, card) then return true end
	return
end

sgs.ai_skill_cardask["slash-jink"] = function(self, data, pattern, target)
	local isdummy = type(data) == "number"
	local function getJink()
		if target and target:hasSkill("dahe") and self.player:hasFlag("dahe") then
			for _, card in ipairs(self:getCards("Jink")) do
				if card:getSuit() == sgs.Card_Heart then return card:getId() end
			end
			return "."
		end
		return self:getCardId("Jink") or not isdummy and "."
	end

	local slash
	if type(data) == "userdata" then
		local effect = data:toSlashEffect()
		slash = effect.slash
	else
		slash = sgs.Sanguosha:cloneCard("slash")
	end
	local cards = sgs.QList2Table(self.player:getHandcards())
	if (not target or self:isFriend(target)) and slash:hasFlag("nosjiefan-slash") then return "." end
	if sgs.ai_skill_cardask.nullfilter(self, data, pattern, target) then return "." end
	if not target then return getJink() end
	if not self:hasHeavySlashDamage(target, slash, self.player) and self:getDamagedEffects(self.player, target, slash) then return "." end
	if slash:isKindOf("NatureSlash") and self.player:isChained() and self:isGoodChainTarget(self.player, target, nil, nil, slash) then return "." end
	if self:isFriend(target) then
		if self:findLeijiTarget(self.player, 50, target) then return getJink() end
		if target:hasSkill("jieyin") and not self.player:isWounded() and self.player:isMale() and not self.player:hasSkills("leiji|nosleiji") then return "." end
		if not target:hasSkill("jueqing") then
			if (target:hasSkill("nosrende") or (target:hasSkill("rende") and not target:hasUsed("RendeCard"))) and self.player:hasSkill("jieming") then return "." end
			if target:hasSkill("pojun") and not self.player:faceUp() then return "." end
			if target:hasSkill("ndhuli") and not self.room:getCurrent():hasFlag("ndhuliused") then return "." end -- changed
		end
	else
		if self:hasHeavySlashDamage(target, slash) then return getJink() end

		local current = self.room:getCurrent()
		if current and current:hasSkill("juece") and self.player:getHp() > 0 then
			local use = false
			for _, card in ipairs(self:getCards("Jink")) do
				if not self.player:isLastHandCard(card, true) then
					use = true
					break
				end
			end
			if not use then return not isdummy and "." end
		end
		if self.player:getHandcardNum() == 1 and self:needKongcheng() then return getJink() end
		if not self:hasLoseHandcardEffective() and not self.player:isKongcheng() then return getJink() end
		if target:hasSkill("mengjin") and not (target:hasSkill("nosqianxi") and target:distanceTo(self.player) == 1) then
			if self:doNotDiscard(self.player, "he", true) then return getJink() end
			if self.player:getCards("he"):length() == 1 and not self.player:getArmor() then return getJink() end
			if self.player:hasSkills("jijiu|qingnang") and self.player:getCards("he"):length() > 1 then return "." end
			if self:canUseJieyuanDecrease(target) then return "." end
			if (self:getCardsNum("Peach") > 0 or (self:getCardsNum("Analeptic") > 0 and self:isWeak()))
				and not self.player:hasSkills("tuntian+zaoxian") and not self:willSkipPlayPhase() then
				return "."
			end
		end
		if self.player:getHp() > 1 and getKnownCard(target, self.player, "Slash") >= 1 and getKnownCard(target, self.player, "Analeptic") >= 1 and self:getCardsNum("Jink") == 1
			and (target:getPhase() < sgs.Player_Play or self:slashIsAvailable(target) and target:canSlash(self.player)) then
			return "."
		end
		if not (target:hasSkill("nosqianxi") and target:distanceTo(self.player) == 1) then
			if target:hasWeapon("axe") then
				if target:hasSkills(sgs.lose_equip_skill) and target:getEquips():length() > 1 and target:getCards("he"):length() > 2 then return not isdummy and "." end
				if target:getHandcardNum() - target:getHp() > 2 and not self:isWeak() and not self:getOverflow() then return not isdummy and "." end
			elseif target:hasWeapon("blade") then
				if slash:isKindOf("NatureSlash") and self.player:hasArmorEffect("vine")
					or self.player:hasArmorEffect("renwang_shield")
					or self:hasEightDiagramEffect()
					or self:hasHeavySlashDamage(target, slash)
					or (self.player:getHp() == 1 and #self.friends_noself == 0) then
				elseif (self:getCardsNum("Jink") <= getCardsNum("Slash", target, self.player) or self.player:hasSkill("qingnang")) and self.player:getHp() > 1
						or self.player:hasSkill("jijiu") and getKnownCard(self.player, self.player, "red") > 0
						or self:canUseJieyuanDecrease(target)
					then
					return not isdummy and "."
				end
			end
		end
	end
	return getJink()
end

function SmartAI:useCardAmazingGrace(card, use)
	if self.player:hasSkill("noswuyan") then use.card = card return end
	local yusuiflag = (not self.player:hasFlag("lpyusuiused")) and self.player:hasSkill("lpyusui")
	if (self.role == "lord" or self.role == "loyalist") and sgs.turncount <= 2 and self.player:getSeat() <= 3 and self.player:aliveCount() > 5 and not yusuiflag then return end
	local value = yusuiflag and (1 + self.player:aliveCount() / 3) or 1
	local suf, coeff = 0.8, 0.8
	if self:needKongcheng() and self.player:getHandcardNum() == 1 or self.player:hasSkills("nosjizhi|jizhi") then
		suf = 0.6
		coeff = 0.6
	end
--	self.room:writeToConsole("AGS "..value)
	local enenum = 0
	for _, player in sgs.qlist(self.room:getOtherPlayers(self.player)) do
		local index = 0
		if self:hasTrickEffective(card, player, self.player) then
			if self:isFriend(player) then 
				index = 1
			elseif self:isEnemy(player) then
				enenum = enenum + 1
				if card:getSkillName() ~= "lpfengshou" or enenum > self.player:getMark("fengshouc") then
					index = -1
				end
			end
		end
		value = value + index * suf
	--	self.room:writeToConsole("AGV" .. value)
		if value < 0 then return end
		suf = suf * coeff
	end
--	self.room:writeToConsole("pre use AG")
	use.card = card
end

function SmartAI:getDynamicUsePriority(card)
	if not card then return 0 end

	if card:hasFlag("AIGlobal_KillOff") then return 15 end
	if self.player:getMark("JianyingSuit") == card:getSuit() + 1 and self.player:getMark("JianyingNumber") == card:getNumber() then
		return self:getUsePriority(card) + 50
	end
	local oldtype = ""
	if self.player:getMark("qunluntri") ~= 0 then
		oldtype = self.player:property("qunlunrecord"):toString()
	end
	if oldtype == card:getType() then return self:getUsePriority(card) + 50 end
	local dynamic_value

	-- direct control
	if card:isKindOf("AmazingGrace") then
		local zhugeliang = self.room:findPlayerBySkillName("kongcheng")
		if zhugeliang and self:isEnemy(zhugeliang) and zhugeliang:isKongcheng() then
			return math.max(sgs.ai_use_priority.Slash, sgs.ai_use_priority.Duel) + 0.1
		end
	end
	if card:isKindOf("Peach") and self.player:hasSkills("kuanggu|kofkuanggu") then return 1.01 end
	if card:isKindOf("YanxiaoCard") and self.player:containsTrick("YanxiaoCard") then return 0.1 end
	if card:isKindOf("DelayedTrick") and not card:isKindOf("YanxiaoCard") and #card:getSkillName() > 0 then
		return (sgs.ai_use_priority[card:getClassName()] or 0.01) - 0.01
	end
	if self.player:hasSkill("danshou") and not self.player:hasSkill("jueqing")
		and (card:isKindOf("Slash") or card:isKindOf("Duel") or card:isKindOf("AOE")
			or sgs.dynamic_value.damage_card[card:getClassName()]) then
		return 0
	end
	if card:isKindOf("Duel") then
		--[[if self:getCardsNum("FireAttack") > 0 and dummy_use.to and not dummy_use.to:isEmpty() then
			for _, p in sgs.qlist(dummy_use.to) do
				if p:getHp() == 1 then return sgs.ai_use_priority.FireAttack + 0.1 end
			end
		end]]
		if self:hasCrossbowEffect()
			or self.player:hasFlag("XianzhenSuccess")
			or self.player:canSlashWithoutCrossbow()
			or sgs.Sanguosha:correctCardTarget(sgs.TargetModSkill_Residue, self.player, sgs.Sanguosha:cloneCard("slash")) > 0
			or self.player:hasUsed("FenxunCard") then
			return sgs.ai_use_priority.Slash - 0.1
		end
	end

	local value = self:getUsePriority(card) or 0
	if card:getTypeId() == sgs.Card_TypeEquip then
		if self.player:hasSkills(sgs.lose_equip_skill) then value = value + 12 end
		if card:isKindOf("Weapon") and self.player:getPhase() == sgs.Player_Play and #self.enemies > 0 then
			self:sort(self.enemies)
			local enemy = self.enemies[1]
			local v, inAttackRange = self:evaluateWeapon(card, self.player, enemy) / 20
			value = value + string.format("%3.3f", v)
			if inAttackRange then value = value + 0.5 end
		end
	end

	if card:isKindOf("AmazingGrace") then
		dynamic_value = 10
		for _, player in sgs.qlist(self.room:getOtherPlayers(self.player)) do
			dynamic_value = dynamic_value - 1
			if self:isEnemy(player) then dynamic_value = dynamic_value - ((player:getHandcardNum() + player:getHp()) / player:getHp()) * dynamic_value
			else dynamic_value = dynamic_value + ((player:getHandcardNum() + player:getHp()) / player:getHp()) * dynamic_value
			end
		end
		value = value + dynamic_value
		if (not self.player:hasFlag("lpyusuiused")) and self.player:hasSkill("lpyusui") then value = value + 49 end
	elseif card:isKindOf("ArcheryAttack") and self.player:hasSkill("luanji") then
		value = value + 6.0
	elseif card:isKindOf("Duel") and self.player:hasSkill("shuangxiong") then
		value = value + 6.3
	elseif card:isKindOf("Slash") and self.player:hasSkill("cihuai") and self.player:getMark("@cihuai") > 0 then
		value = value + 99
	end

	return value
end