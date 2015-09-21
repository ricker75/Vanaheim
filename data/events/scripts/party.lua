function Party:onJoin(player)
	return true
end

function Party:onLeave(player)
	return true
end

function Party:onDisband()
	return true
end

function Party:onShareExperience(exp)
	local sharedExperienceMultiplier = 1.20 --20%
	
	local vocationsIds = {}
	
	local vocationId = self:getLeader():getVocation():getId()
	if vocationId ~= VOCATION_NONE then
		vocationsIds[#vocationsIds + 1] = self:getLeader():getVocation():getId()
	end
	
	for _, member in ipairs(self:getMembers()) do
		vocationId = member:getVocation():getId()
		if not isInArray(vocationsIds, vocationId) and vocationId ~= VOCATION_NONE then
			vocationsIds[#vocationsIds + 1] = vocationId
		end
	end
	
	local size = #vocationsIds
	if size > 1 then
		sharedExperienceMultiplier = 1.0 + ((size * (10 + (size - 1) * 5)) / 100)
	end
	
	exp = (exp * sharedExperienceMultiplier) / (self:getMembers() + 1)
	return exp
end
