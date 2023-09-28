function effectblock()
	local levelhide = nil
	
	if (featureindex["level"] ~= nil) then
		levelhide = hasfeature("level","is","hide",1)
		
		local isred = hasfeature("level","is","red",1)
		local isblue = hasfeature("level","is","blue",1)
		local isgreen = hasfeature("level","is","green",1)
		local islime = hasfeature("level","is","lime",1)
		local isyellow = hasfeature("level","is","yellow",1)
		local ispurple = hasfeature("level","is","purple",1)
		local ispink = hasfeature("level","is","pink",1)
		local isrosy = hasfeature("level","is","rosy",1)
		local isblack = hasfeature("level","is","black",1)
		local isgrey = hasfeature("level","is","grey",1)
		local issilver = hasfeature("level","is","silver",1)
		local iswhite = hasfeature("level","is","white",1)
		local isbrown = hasfeature("level","is","brown",1)
		local isorange = hasfeature("level","is","orange",1)
		local iscyan = hasfeature("level","is","cyan",1)
		local isgold = hasfeature("level","is","gold",1)
		local ismaroon = hasfeature("level","is","maroon",1)
		local isteal = hasfeature("level","is","teal",1)
	
		local colours = {isred, isorange, isyellow, islime, isgreen, iscyan, isblue, ispurple, ispink, isrosy, isblack, isgrey, issilver, iswhite, isbrown, isgold, ismaroon, isteal}
		local ccolours = {{2,2},{2,3},{2,4},{5,3},{5,2},{1,4},{3,2},{3,1},{4,1},{4,2},{0,4},{0,1},{0,2},{0,3},{6,1},{6,2},{2,1},{1,2}}
		
		leveldata.colours = {}
		local c1,c2 = -1,-1
		
		for a=1,#ccolours do
			if (colours[a] ~= nil) then
				local c = ccolours[a]
				
				if (#leveldata.colours == 0) then
					c1 = c[1]
					c2 = c[2]
				end
				
				table.insert(leveldata.colours, {c[1],c[2]})
			end
		end
		
		if (#leveldata.colours == 1) then
			if (c1 > -1) and (c2 > -1) then
				if (c1 == 0) and (c2 == 4) then
					MF_backcolour(c1, c2)
				else
					MF_backcolour_dim(c1, c2)
				end
			end
		elseif (#leveldata.colours == 0) then
			MF_backcolour(0, 4)
		end
	else
		MF_backcolour(0, 4)
	end
	
	local resetcolour = {}
	local updatecolour = {}
	
	for i,unit in ipairs(units) do
		unit.new = false
		
		if (levelhide == nil) then
			unit.visible = true
		else
			unit.visible = false
		end
		
		if (unit.className ~= "level") then		
			local name = unit.strings[UNITNAME]
			
			local isred = hasfeature(name,"is","red",unit.fixed)
			local isblue = hasfeature(name,"is","blue",unit.fixed)
			local islime = hasfeature(name,"is","lime",unit.fixed)
			local isgreen = hasfeature(name,"is","green",unit.fixed)
			local isyellow = hasfeature(name,"is","yellow",unit.fixed)
			local ispurple = hasfeature(name,"is","purple",unit.fixed)
			local ispink = hasfeature(name,"is","pink",unit.fixed)
			local isrosy = hasfeature(name,"is","rosy",unit.fixed)
			local isblack = hasfeature(name,"is","black",unit.fixed)
			local isgrey = hasfeature(name,"is","grey",unit.fixed)
			local issilver = hasfeature(name,"is","silver",unit.fixed)
			local iswhite = hasfeature(name,"is","white",unit.fixed)
			local isbrown = hasfeature(name,"is","brown",unit.fixed)
			local isorange = hasfeature(name,"is","orange",unit.fixed)
			local iscyan = hasfeature(name,"is","cyan",unit.fixed)
			local isgold = hasfeature(name,"is","gold",unit.fixed)
			local ismaroon = hasfeature(name,"is","maroon",unit.fixed)
			local isteal = hasfeature(name,"is","teal",unit.fixed)
			
			unit.colours = {}
			
			local colours = {isred, isorange, isyellow, islime, isgreen, iscyan, isblue, ispurple, ispink, isrosy, isblack, isgrey, issilver, iswhite, isbrown, isgold, ismaroon, isteal}
			local ccolours = {{2,2},{2,3},{2,4},{5,3},{5,2},{1,4},{3,2},{3,1},{4,1},{4,2},{0,4},{0,1},{0,2},{0,3},{6,1},{6,2},{2,1},{1,2}}
			
			local c1,c2,ca = -1,-1,-1
			
			unit.flags[PHANTOM] = false
			local isphantom = hasfeature(name,"is","phantom",unit.fixed)
			if (isphantom ~= nil) then
				unit.flags[PHANTOM] = true
			end
			
			for a=1,#ccolours do
				if (colours[a] ~= nil) then
					local c = ccolours[a]
					
					if (#unit.colours == 0) then
						c1 = c[1]
						c2 = c[2]
						ca = a
					end
					
					table.insert(unit.colours, c)
				end
			end
			
			if (#unit.colours == 1) then
				if (c1 > -1) and (c2 > -1) and (ca > 0) then
					MF_setcolour(unit.fixed,c1,c2)
					unit.colour = {c1,c2}
					unit.values[A] = ca
				end
			elseif (#unit.colours == 0) then
				if (unit.values[A] > 0) and (math.floor(unit.values[A]) == unit.values[A]) then
					if (unit.strings[UNITTYPE] ~= "text") or (unit.active == false) then
						setcolour(unit.fixed)
					else
						setcolour(unit.fixed,"active")
					end
					unit.values[A] = 0
				end
			else
				unit.values[A] = ca
				
				if (unit.strings[UNITTYPE] == "text") then
					local curr = (unit.currcolour % #unit.colours) + 1
					local c = unit.colours[curr]
					
					unit.colour = {c[1],c[2]}
					MF_setcolour(unit.fixed,c[1],c[2])
				end
			end
		end
	end
	
	if (levelhide == nil) then
		local ishide = findallfeature(nil,"is","hide",true)
		
		for i,unitid in ipairs(ishide) do
			local unit = mmf.newObject(unitid)
			
			unit.visible = false
		end
	end
end