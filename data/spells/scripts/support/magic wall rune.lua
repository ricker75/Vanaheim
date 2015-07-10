local id = 8753
local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, id)

function removeMw(pos, mw, wall)
	local tile = Tile(pos)
	mw = tile:getItemById(mw)
	wall = tile:getItemById(wall)
	if mw then mw:remove() end
	if wall then wall:remove() end
end

function onCastSpell(creature, var, isHotkey)
	local c = combat:execute(creature, var)
	if c then
		local pos = variantToPosition(var)
		local wall = Game.createItem(1027, 1, pos)
		addEvent(removeMw, 20000, pos, id, wall:getId())
	end
	return c
end