condlist["nexttodown"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == -1) and (g == 0)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["nexttoleft"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == 0) and (g == 1)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["nexttoright"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == 0) and (g == -1)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["nexttoup"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == 1) and (g == 0)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["neardl"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == -1) and (g == 1)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["neardr"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == -1) and (g == -1)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["nearul"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == 1) and (g == 1)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["nearur"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if ((h == 1) and (g == -1)) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["qn"] = function(params,checkedconds,checkedconds_,cdata)
			local allfound = 0
			local alreadyfound = {}
			
			local unitid,x,y,surrounds = cdata.unitid,cdata.x,cdata.y,cdata.surrounds
			
			if (#params > 0) then
				for a,b in ipairs(params) do
					local pname = b
					local pnot = false
					if (string.sub(b, 1, 4) == "not ") then
						pnot = true
						pname = string.sub(b, 5)
					end
					
					local bcode = b .. "_" .. tostring(a)
					
					if (string.sub(pname, 1, 5) == "group") then
						return false,checkedconds
					end
					
					if (unitid ~= 1) then
						if (b ~= "level") or ((b == "level") and (alreadyfound[1] ~= nil)) then
							for g=-1,1 do
								for h=-1,1 do
									if (((h == -1) and (g == -1)) or ((h == 0) and (g == 0))) then
										if (pname ~= "empty") then
											local tileid = (x + g) + (y + h) * roomsizex
											if (unitmap[tileid] ~= nil) then
												for c,d in ipairs(unitmap[tileid]) do
													if (d ~= unitid) and (alreadyfound[d] == nil) then
														local unit = mmf.newObject(d)
														local name_ = getname(unit)
														
														if (pnot == false) then
															if (name_ == pname) and (alreadyfound[bcode] == nil) then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														else
															if (name_ ~= pname) and (alreadyfound[bcode] == nil) and (name_ ~= "text") then
																alreadyfound[bcode] = 1
																alreadyfound[d] = 1
																allfound = allfound + 1
															end
														end
													end
												end
											end
										else
											local nearempty = false
									
											local tileid = (x + g) + (y + h) * roomsizex
											local l = map[0]
											local tile = l:get_x(x + g,y + h)
											
											local tcode = tostring(tileid) .. "e"
											
											if ((unitmap[tileid] == nil) or (#unitmap[tileid] == 0)) and (tile == 255) and (alreadyfound[tcode] == nil) then 
												nearempty = true
											end
											
											if (g == 0) and (h == 0) then
												if (unitid == 2) then
													if (pnot == false) then
														nearempty = false
													end
												elseif (unitid ~= 1) and pnot then
													if (unitmap[tileid] == nil) or (#unitmap[tileid] <= 1) then
														nearempty = true
													end
												end
											end
											
											if (pnot == false) then
												if nearempty and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											else
												if (nearempty == false) and (alreadyfound[bcode] == nil) then
													alreadyfound[bcode] = 1
													alreadyfound[tcode] = 1
													allfound = allfound + 1
												end
											end
										end
									end
								end
							end
						elseif (b == "level") and (alreadyfound[bcode] == nil) and (alreadyfound[1] == nil) then
							alreadyfound[bcode] = 1
							alreadyfound[1] = 1
							allfound = allfound + 1
						end
					else
						local ulist = false
					
						if (b ~= "empty") and (b ~= "level") then
							if (pnot == false) then
								if (unitlists[pname] ~= nil) and (#unitlists[pname] > 0) then
									for c,d in ipairs(unitlists[pname]) do
										if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
											alreadyfound[bcode] = 1
											alreadyfound[d] = 1
											ulist = true
											break
										end
									end
								end
							else
								for c,d in pairs(unitlists) do
									local tested = false
									
									if (c ~= pname) and (#d > 0) then
										for e,f in ipairs(d) do
											if (alreadyfound[f] == nil) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												alreadyfound[f] = 1
												ulist = true
												tested = true
												break
											end
										end
									end
									
									if tested then
										break
									end
								end
							end
						elseif (b == "empty") then
							local empties = findempty()
							
							if (#empties > 0) then
								for c,d in ipairs(empties) do
									if (alreadyfound[d] == nil) and (alreadyfound[bcode] == nil) then
										alreadyfound[bcode] = 1
										alreadyfound[d] = 1
										ulist = true
										break
									end
								end
							end
						end
						
						if (b ~= "text") and (ulist == false) then
							for e,f in pairs(surrounds) do
								if (e ~= "dir") and (e ~= "o") then
									for c,d in ipairs(f) do
										if (pnot == false) then
											if (ulist == false) and (d == pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										else
											if (ulist == false) and (d ~= pname) and (alreadyfound[bcode] == nil) then
												alreadyfound[bcode] = 1
												ulist = true
											end
										end
									end
								end
							end
						end
						
						if ulist or (b == "text") then
							alreadyfound[bcode] = 1
							allfound = allfound + 1
						end
					end
				end
			else
				print("no parameters given!")
				return false,checkedconds
			end

			return (allfound == #params),checkedconds
		end
condlist["sometimes"] = function(params,checkedconds,checkedconds_,cdata)
			local unitid,x,y,conds,i = cdata.unitid,cdata.x,cdata.y,tostring(cdata.conds),cdata.i
			
			if (condstatus[tostring(conds)] == nil) then
				condstatus[tostring(conds)] = {}
			end
			
			local rnd = fixedrandom(1,2)
			
			local d = condstatus[tostring(conds)]
			local id = "sometimes" .. "_" .. tostring(i)
			
			if (unitid ~= 2) then
				id = id .. "_" .. tostring(unitid)
			else
				id = id .. "_" .. tostring(unitid) .. tostring(x) .. tostring(y)
			end
			
			if (d[id] ~= nil) then
				rnd = d[id]
			else
				d[id] = rnd
			end
			
			return (rnd == 1),checkedconds
		end
condlist["maybe"] = function(params,checkedconds,checkedconds_,cdata)
			local unitid,x,y,conds,i = cdata.unitid,cdata.x,cdata.y,tostring(cdata.conds),cdata.i
			
			if (condstatus[tostring(conds)] == nil) then
				condstatus[tostring(conds)] = {}
			end
			
			local rnd = fixedrandom(1,3)
			
			local d = condstatus[tostring(conds)]
			local id = "maybe" .. "_" .. tostring(i)
			
			if (unitid ~= 2) then
				id = id .. "_" .. tostring(unitid)
			else
				id = id .. "_" .. tostring(unitid) .. tostring(x) .. tostring(y)
			end
			
			if (d[id] ~= nil) then
				rnd = d[id]
			else
				d[id] = rnd
			end
			
			return (rnd == 1),checkedconds
		end
condlist["rarely"] = function(params,checkedconds,checkedconds_,cdata)
			local unitid,x,y,conds,i = cdata.unitid,cdata.x,cdata.y,tostring(cdata.conds),cdata.i
			
			if (condstatus[tostring(conds)] == nil) then
				condstatus[tostring(conds)] = {}
			end
			
			local rnd = fixedrandom(1,5)
			
			local d = condstatus[tostring(conds)]
			local id = "rarely" .. "_" .. tostring(i)
			
			if (unitid ~= 2) then
				id = id .. "_" .. tostring(unitid)
			else
				id = id .. "_" .. tostring(unitid) .. tostring(x) .. tostring(y)
			end
			
			if (d[id] ~= nil) then
				rnd = d[id]
			else
				d[id] = rnd
			end
			
			return (rnd == 1),checkedconds
		end
condlist["undone"] = function(params,checkedconds)
        return undone,checkedconds
    end
table.insert(mod_hook_functions.undoed_after, function()
	undone = true
end)
table.insert(mod_hook_functions.turn_end, function()
	undone = false
end)
table.insert(mod_hook_functions.level_start, function()
	undone = false
end)
table.insert(mod_hook_functions.level_restart, function()
	undone = false
end)