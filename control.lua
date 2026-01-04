script.on_event(defines.events.on_resource_depleted, function(event)
	if storage.generator == nil then
		storage.generator = game.create_random_generator()
  	end

	local first_player = game.get_player(1)
	local entity  = event.entity
	local surface = entity.surface
	local x = entity.position.x
	local y = entity.position.y
	local resourcetype = "stone"
	local resourceamount = 100

	
	local resourcecounter = 0
	for _, resource in pairs(surface.find_entities_filtered{
		type="resource", 
		limit=10, 
		area={{x-1,y-1},{x+1,y+1}}
	}) do
		if ((resource.position.x == x) and (resource.position.y == y)) then 
			resourcetype = resource.name
		--	game.print ("*"..resource.name .. ": " ..resource.amount.." pos:"..resource.position.x..":"..resource.position.y)
		else
			resourcecounter = resourcecounter + 1
		end


	end

	resourceamount = 6.5*math.exp(0.75*resourcecounter)

    local adjustment = storage.generator(75, 125) / 100
	resourceamount = resourceamount * adjustment
	surface.create_entity({name=resourcetype, amount=resourceamount, position={x,y}})


-- Suche nach der Mine (mining-drill) an der angegebenen Position
	local mines = surface.find_entities_filtered{
		type = "mining-drill",
		area={{x-6,y-6},{x+6,y+6}}
	}

	if #mines > 0 then
		for i, v in pairs(mines) do
			v.update_connections()
		end
	end

end)



