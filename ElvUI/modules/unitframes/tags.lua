local E, L, V, P, G, _ = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local _, ns = ...
local ElvUF = ns.oUF
assert(ElvUF, "ElvUI was unable to locate oUF.")

------------------------------------------------------------------------
--	Tags
------------------------------------------------------------------------

ElvUF.Tags.Events['afk'] = 'PLAYER_FLAGS_CHANGED'
ElvUF.Tags.Methods['afk'] = function(unit)
	local isAFK = UnitIsAFK(unit)
	if isAFK then
		return '|cffFFFFFF[|r|cffFF0000'..DEFAULT_AFK_MESSAGE..'|r|cFFFFFFFF]|r'
	else
		return ''
	end
end

ElvUF.Tags.Events['healthcolor'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['healthcolor'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return Hex(0.84, 0.75, 0.65)
	else
		local r, g, b = ElvUF.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
		return Hex(r, g, b)
	end
end

ElvUF.Tags.Events['health:current'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['health:current'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT', min, max)
	end
end

ElvUF.Tags.Events['health:deficit'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['health:deficit'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return status
	else
		return E:GetFormattedText('DEFICIT', min, max)
	end
end

ElvUF.Tags.Events['health:current-percent'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['health:current-percent'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['health:current-max'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['health:current-max'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT_MAX', min, max)
	end
end

ElvUF.Tags.Events['health:current-max-percent'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['health:current-max-percent'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return status
	else
		return E:GetFormattedText('CURRENT_MAX_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['health:percent'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION'
ElvUF.Tags.Methods['health:percent'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and L['Offline'] or UnitIsGhost(unit) and L['Ghost'] or UnitIsDead(unit) and DEAD

	if (status) then
		return status
	else
		return E:GetFormattedText('PERCENT', min, max)
	end
end

ElvUF.Tags.Events['powercolor'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['powercolor'] = function(unit)
	local pType, pToken, altR, altG, altB = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
	
	local r, g, b = altR, altG, altB
	local color = ElvUF['colors'].power[pToken]
	if color then
		r, g, b = color[1], color[2], color[3]
	end
	
	return Hex(r, g, b)
end

ElvUF.Tags.Events['power:current'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current'] = function(unit)
	local pType = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
		
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT', min, max)
	end
end

ElvUF.Tags.Events['power:current-max'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current-max'] = function(unit)
	local pType = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
		
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_MAX', min, max)
	end
end

ElvUF.Tags.Events['power:current-percent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current-percent'] = function(unit)
	local pType = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
		
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['power:current-max-percent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:current-max-percent'] = function(unit)
	local pType = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
		
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_MAX_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['power:percent'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:percent'] = function(unit)
	local pType = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
		
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('PERCENT', min, max)
	end
end

ElvUF.Tags.Events['power:deficit'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER'
ElvUF.Tags.Methods['power:deficit'] = function(unit)
	local pType = UnitPowerType(unit)
	local min, max = UnitPower(unit, pType), UnitPowerMax(unit, pType)
		
	return E:GetFormattedText('DEFICIT', min, max, r, g, b)
end

ElvUF.Tags.Events['difficultycolor'] = 'UNIT_LEVEL PLAYER_LEVEL_UP'
ElvUF.Tags.Methods['difficultycolor'] = function(unit)
	local r, g, b = 0.69, 0.31, 0.31
	local level = UnitLevel(unit)
	if (level > 1) then
		local DiffColor = UnitLevel(unit) - UnitLevel('player')
		if (DiffColor >= 5) then
			r, g, b = 0.69, 0.31, 0.31
		elseif (DiffColor >= 3) then
			r, g, b = 0.71, 0.43, 0.27
		elseif (DiffColor >= -2) then
			r, g, b = 0.84, 0.75, 0.65
		elseif (-DiffColor <= GetQuestGreenRange()) then
			r, g, b = 0.33, 0.59, 0.33
		else
			r, g, b = 0.55, 0.57, 0.61
		end
	end
	
	return Hex(r, g, b)
end

ElvUF.Tags.Events['namecolor'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['namecolor'] = function(unit)
	local unitReaction = UnitReaction(unit, 'player')
	local _, unitClass = UnitClass(unit)
	if (UnitIsPlayer(unit)) then
		local class = RAID_CLASS_COLORS[unitClass]
		if not class then return "" end
		return Hex(class.r, class.g, class.b)
	elseif (unitReaction) then
		local reaction = ElvUF['colors'].reaction[unitReaction]
		return Hex(reaction[1], reaction[2], reaction[3])
	else
		return '|cFFC2C2C2'
	end
end

ElvUF.Tags.Events['smartlevel'] = 'UNIT_LEVEL PLAYER_LEVEL_UP'
ElvUF.Tags.Methods['smartlevel'] = function(unit)
	local level = UnitLevel(unit)
	if ( UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) ) then
		return UnitBattlePetLevel(unit);
	elseif level == UnitLevel('player') then
		return ''
	elseif(level > 0) then
		return level
	else
		return '??'
	end
end

ElvUF.Tags.Events['name:short'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:short'] = function(unit)
	local name = UnitName(unit)
	if name then
		return E:ShortenString(name, 10)
	else
		return ''
	end
end

ElvUF.Tags.Events['name:medium'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:medium'] = function(unit)
	local name = UnitName(unit)
	if name then	
		return E:ShortenString(name, 15)
	else
		return ''
	end	
end

ElvUF.Tags.Events['name:long'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:long'] = function(unit)
	local name = UnitName(unit)
	if name then	
		return E:ShortenString(name, 20)
	else
		return ''
	end	
end

ElvUF.Tags.Events['threat:percent'] = 'UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['threat:percent'] = function(unit)
	local _, status, percent = UnitDetailedThreatSituation('player', unit)
	if(percent and percent > 0) and IsInGroup() then
		return string.format('%d%%', E:TrimFloatingPoint(percent / 100 * 100))
	else 
		return ''
	end
end

ElvUF.Tags.Events['threat:current'] = 'UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['threat:current'] = function(unit)
	local _, status, percent, _, threatvalue = UnitDetailedThreatSituation('player', unit)
	if(percent and percent > 0) and IsInGroup() then
		return E:ShortValue(threatvalue)
	else 
		return ''
	end
end

ElvUF.Tags.Events['threatcolor'] = 'UNIT_THREAT_LIST_UPDATE GROUP_ROSTER_UPDATE'
ElvUF.Tags.Methods['threatcolor'] = function(unit)
	local _, status = UnitDetailedThreatSituation('player', unit)
	if(status) and IsInGroup() then
		return Hex(GetThreatStatusColor(status))
	else 
		return ''
	end
end

ElvUF.Tags.Methods['pvptimer'] = function(unit)
	local time = GetPVPTimer()
	local min = format("%01.f", floor((time / 1000) / 60))
	local sec = format("%02.f", floor((time / 1000) - min * 60)) 
	
	if(UnitIsPVPFreeForAll(unit)) then
		if time ~= 301000 and time ~= -1 then
			return PVP.." ".."("..min..":"..sec..")"
		else
			return PVP
		end
	elseif UnitIsPVP(unit) then
		if time ~= 301000 and time ~= -1 then
			return PVP.." ".."("..min..":"..sec..")"
		else
			return PVP
		end
	else
		return ""
	end
end

local Harmony = { 
	[0] = {1, 1, 1},
	[1] = {.57, .63, .35, 1},
	[2] = {.47, .63, .35, 1},
	[3] = {.37, .63, .35, 1},
	[4] = {.27, .63, .33, 1},
	[5] = {.17, .63, .33, 1},
}

local function GetClassPower(class)
	local min, max, r, g, b = 0, 0, 0, 0, 0
	local spec = GetSpecialization()
	if class == 'PALADIN' then
		min = UnitPower('player', SPELL_POWER_HOLY_POWER);
		max = UnitPowerMax('player', SPELL_POWER_HOLY_POWER);	
		r, g, b = 228/255, 225/255, 16/255
	elseif class == 'MONK' then
		min = UnitPower("player", SPELL_POWER_LIGHT_FORCE)
		max = UnitPowerMax("player", SPELL_POWER_LIGHT_FORCE)
		r, g, b = unpack(Harmony[min])
	elseif class == 'DRUID' and GetShapeshiftFormID() == MOONKIN_FORM then
		min = UnitPower('player', SPELL_POWER_ECLIPSE)
		max = UnitPowerMax('player', SPELL_POWER_ECLIPSE)
		if GetEclipseDirection() == 'moon' then
			r, g, b = .80, .82,  .60
		else
			r, g, b = .30, .52, .90
		end
	elseif class == 'PRIEST' and spec == SPEC_PRIEST_SHADOW and UnitLevel("player") > SHADOW_ORBS_SHOW_LEVEL then
		min = UnitPower("player", SPELL_POWER_SHADOW_ORBS)
		max = UnitPowerMax("player", SPELL_POWER_SHADOW_ORBS)
		r, g, b = 1, 1, 1
	elseif class == 'WARLOCK' then
		if (spec == SPEC_WARLOCK_DESTRUCTION) then	
			min = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true)
			max = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
			min = math.floor(min / 10)
			max = math.floor(max / 10)
			r, g, b = 230/255, 95/255,  95/255
		elseif ( spec == SPEC_WARLOCK_AFFLICTION ) then
			min = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
			max = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)
			r, g, b = 148/255, 130/255, 201/255
		elseif spec == SPEC_WARLOCK_DEMONOLOGY then
			min = UnitPower("player", SPELL_POWER_DEMONIC_FURY)
			max = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY)
			r, g, b = 148/255, 130/255, 201/255
		end
	end
	
	return min, max, r, g, b
end

ElvUF.Tags.Events['classpowercolor'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpowercolor'] = function()
	local _, _, r, g, b = GetClassPower(E.myclass)
	return Hex(r, g, b)
end

ElvUF.Tags.Events['classpower:current'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT', min, max)
	end	
end

ElvUF.Tags.Events['classpower:deficit'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:deficit'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('DEFICIT', min, max)
	end
end

ElvUF.Tags.Events['classpower:current-percent'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current-percent'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['classpower:current-max'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current-max'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_MAX', min, max)
	end
end

ElvUF.Tags.Events['classpower:current-max-percent'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:current-max-percent'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('CURRENT_MAX_PERCENT', min, max)
	end
end

ElvUF.Tags.Events['classpower:percent'] = 'UNIT_POWER PLAYER_TALENT_UPDATE UPDATE_SHAPESHIFT_FORM'
ElvUF.Tags.Methods['classpower:percent'] = function()
	local min, max = GetClassPower(E.myclass)
	if min == 0 then
		return ' '
	else
		return E:GetFormattedText('PERCENT', min, max)
	end
end