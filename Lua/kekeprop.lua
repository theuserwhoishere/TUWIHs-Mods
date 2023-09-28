function conversion(dolevels_)
	local alreadydone = {}
	local dolevels = dolevels_ or false
	
	for i,v in pairs(features) do
		local words = v[1]
		
		local operator = words[2]
		
		if (operator == "is") or (operator == "write") or (operator == "become") then
			local output = {}
			local name = words[1]
			local thing = words[3]
			
			if (getmat(thing) ~= nil) or (thing == "not " .. name) or (thing == "all") or (unitreference[thing] ~= nil) or ((thing == "text") and (unitreference["text_text"] ~= nil)) or (thing == "revert") or (thing == "kekeprop") or ((operator == "write") and getmat_text("text_" .. name)) then
				if (featureindex[name] ~= nil) and (alreadydone[name] == nil) then
					alreadydone[name] = 1
					
					for a,b in ipairs(featureindex[name]) do
						local rule = b[1]
						local conds = b[2]
						local target,verb,object = rule[1],rule[2],rule[3]
						
						if (verb == "is") or (verb == "become") then
							if (target == name) and (object ~= "word") and ((object ~= name) or (verb == "become")) then
								if (object ~= "text") and (object ~= "revert") and (object ~= "kekeprop") then
									if (object == "not " .. name) then
										table.insert(output, {"error", conds, "is"})
									else
										for d,mat in pairs(objectlist) do
											if (string.sub(d, 1, 5) ~= "group") and (d == object) then
												table.insert(output, {object, conds, "is"})
											end
										end
									end
								elseif (name ~= object) or (verb == "become") then
									if (object ~= "revert") then
										table.insert(output, {object, conds, "is"})
									else
										table.insert(output, 1, {object, conds, "is"})
									end
								end
							end
						elseif (verb == "write") then
							if (string.sub(object, 1, 4) ~= "not ") and (target == name) then
								table.insert(output, {object, conds, "write"})
							end
						end
					end
				end
				
				if (#output > 0) then
					local conversions = {}
					
					for k,v3 in pairs(output) do
						local object = v3[1]
						local conds = v3[2]
						local op = v3[3]
						
						if (op == "is") then
							if (findnoun(object,nlist.brief) == false) and (object ~= "word") and (object ~= "text") and (object ~= "kekeprop") then
								table.insert(conversions, v3)
							elseif (object == "all") then
								--[[
								addaction(0,{"createall",{name,conds},dolevels})
								createall({name,conds})
								]]--
								table.insert(conversions, {"createall",conds})
							elseif (object == "text") then
								table.insert(conversions, {"text_" .. name,conds})
							elseif (object == "kekeprop") then
								table.insert(conversions, {"keke",conds})
							end
						elseif (op == "write") then
							table.insert(conversions, v3)
						end
					end
					
					if (#conversions > 0) then
						convert(name,conversions,dolevels)
					end
				end
			end
		end
	end
end