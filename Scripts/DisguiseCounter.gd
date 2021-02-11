extends ItemList


export(Resource) var _icon = _icon as Texture

func update_loot(number):
	clear()
	for loot in range(number):
		add_icon_item(_icon, false)
