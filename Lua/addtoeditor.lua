local version = "b1.6.1"
timedmessage(string.format("$1,3TUWIH's Mods$0,3 version: v%s", version))

table.insert(editor_objlist_order, "text_usually")
editor_objlist["text_usually"] = 
{
	name = "text_usually",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","text_prefix","abstract"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {5, 1},
	colour_active = {5, 2},
}
table.insert(editor_objlist_order, "text_sometimes")
editor_objlist["text_sometimes"] = 
{
	name = "text_sometimes",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","text_prefix","abstract"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {2, 2},
	colour_active = {2, 3},
}
table.insert(editor_objlist_order, "text_maybe")
editor_objlist["text_maybe"] = 
{
	name = "text_maybe",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","text_prefix","abstract"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {6, 1},
	colour_active = {2, 4},
}
table.insert(editor_objlist_order, "text_rarely")
editor_objlist["text_rarely"] = 
{
	name = "text_rarely",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","text_prefix","abstract"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {4, 1},
	colour_active = {4, 2},
}
table.insert(editor_objlist_order, "text_scarce")
editor_objlist["text_scarce"] = 
{
	name = "text_scarce",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","text_prefix","abstract"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {3, 0},
	colour_active = {3, 1},
}
table.insert(editor_objlist_order, "text_gold")
editor_objlist["text_gold"] = 
{
	name = "text_gold",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_quality", "colour"},
	tiling = -1,
	type = 2,
	layer = 20,
	colour = {6, 1},
    colour_active = {6, 2},
}
table.insert(editor_objlist_order, "text_maroon")
editor_objlist["text_maroon"] = 
{
	name = "text_maroon",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_quality", "colour"},
	tiling = -1,
	type = 2,
	layer = 20,
	colour = {2, 0},
    colour_active = {2, 1},
}
table.insert(editor_objlist_order, "text_nexttodown")
editor_objlist["text_nexttodown"] = 
{
	name = "text_nexttodown",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {6, 1},
    colour_active = {2, 4},
}
word_names["nexttodown"] = "next to (down)"
table.insert(editor_objlist_order, "text_nexttoleft")
editor_objlist["text_nexttoleft"] = 
{
	name = "text_nexttoleft",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition", "abstract"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {6, 1},
    colour_active = {2, 4},
}
word_names["nexttoleft"] = "next to (left)"
table.insert(editor_objlist_order, "text_nexttoright")
editor_objlist["text_nexttoright"] = 
{
	name = "text_nexttoright",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {6, 1},
    colour_active = {2, 4},
}
word_names["nexttoright"] = "next to (right)"
table.insert(editor_objlist_order, "text_nexttoup")
editor_objlist["text_nexttoup"] = 
{
	name = "text_nexttoup",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {6, 1},
    colour_active = {2, 4},
}
word_names["nexttoup"] = "next to (up)"
table.insert(editor_objlist_order, "text_neardl")
editor_objlist["text_neardl"] = 
{
	name = "text_neardl",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {4, 1},
    colour_active = {4, 2},
}
word_names["neardl"] = "near (down-left)"
table.insert(editor_objlist_order, "text_neardr")
editor_objlist["text_neardr"] = 
{
	name = "text_neardr",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {4, 1},
    colour_active = {4, 2},
}
word_names["neardr"] = "near (down-right)"
table.insert(editor_objlist_order, "text_nearul")
editor_objlist["text_nearul"] = 
{
	name = "text_nearul",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {4, 1},
    colour_active = {4, 2},
}
word_names["nearul"] = "near (up-left)"
table.insert(editor_objlist_order, "text_nearur")
editor_objlist["text_nearur"] = 
{
	name = "text_nearur",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_condition"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {4, 1},
    colour_active = {4, 2},
}
word_names["nearur"] = "near (up-right)"
table.insert(editor_objlist_order, "text_teal")
editor_objlist["text_teal"] = 
{
	name = "text_teal",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_quality", "colour"},
	tiling = -1,
	type = 2,
	layer = 20,
	colour = {4, 3},
    colour_active = {1, 2},
}
table.insert(editor_objlist_order, "text_inf")
editor_objlist["text_inf"] = 
{
	name = "text_inf",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_quality", "abstract"},
	tiling = -1,
	type = 2,
	layer = 20,
	colour = {4, 0},
    colour_active = {4, 1},
}
table.insert(editor_objlist_order, "text_undone")
editor_objlist["text_undone"] = 
{
	name = "text_undone",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","text_prefix","abstract"},
	tiling = -1,
	type = 3,
	layer = 20,
	colour = {3, 0},
	colour_active = {3, 1},
}
table.insert(editor_objlist_order, "text_kekeprop")
editor_objlist["text_kekeprop"] = 
{
	name = "text_kekeprop",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text", "text_quality"},
	tiling = -1,
	type = 2,
	layer = 20,
	colour = {2, 1},
    colour_active = {2, 2},
	pairedwith = "keke",
}
word_names["kekeprop"] = "keke"
table.insert(editor_objlist_order, "text_qn")
editor_objlist["text_qn"] = 
{
	name = "text_qn",
	sprite_in_root = false,
	unittype = "text",
	tags = {"text","text_condition","abstract"},
	tiling = -1,
	type = 7,
	layer = 20,
	colour = {0, 1},
    colour_active = {0, 3},
}
formatobjlist()
