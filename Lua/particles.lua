function effects(timer)
	doeffect(timer,nil,"win","unlock",1,2,20,{2,4})
	doeffect(timer,nil,"best","unlock",6,30,2,{2,4})
	doeffect(timer,nil,"tele","glow",1,5,20,{1,4})
	doeffect(timer,nil,"hot","hot",1,80,10,{0,1})
	doeffect(timer,nil,"bonus","bonus",1,2,20,{4,1})
	doeffect(timer,nil,"wonder","wonder",1,10,5,{0,3})
	doeffect(timer,nil,"sad","tear",1,2,20,{3,2})
	doeffect(timer,nil,"sleep","sleep",1,2,60,{3,2})
	doeffect(timer,nil,"broken","error",3,10,8,{2,2})
	doeffect(timer,nil,"pet","pet",1,0,50,{3,1},"nojitter")
	
	doeffect(timer,nil,"power","electricity",2,5,8,{2,4})
	doeffect(timer,nil,"power2","electricity",2,5,8,{5,4})
	doeffect(timer,nil,"power3","electricity",2,5,8,{4,4})
	--doeffect(timer,"play",nil,"music",1,2,30,{0,3})
	doeffect(timer,nil,"inf","infinity",1,2,20,{4,1})
	
	local rnd = math.random(2,4)
	doeffect(timer,nil,"end","unlock",1,1,10,{1,rnd},"inwards")
	
	do_mod_hook("effect_always")
end

local old_clearunits = clearunits

function clearunits(restore_)
    sparkedstatus = {}
    return old_clearunits(restore_)
end

local old_smallclear = smallclear

function smallclear(restore_)
    sparkedstatus = {}
    return old_smallclear(restore_)
end

local old_clear = clear

function clear(restore_)
	sparkedstatus = {}
    return old_clear(restore_)
end