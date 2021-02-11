extends NinePatchRect


export(NodePath) onready var _loot_counter = get_node(_loot_counter) as ItemList
export(Resource) var _briefcase = _briefcase as Texture


func _ready():
	hide()
	
	
func _collect_loot():
	show()
	_loot_counter.add_icon_item(_briefcase, false)
