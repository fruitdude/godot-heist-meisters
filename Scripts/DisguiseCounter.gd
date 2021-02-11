extends ItemList


export(Resource) var _icon = _icon as Texture

func update_disguises(number):
	clear()
	for disguises in range(number):
		add_icon_item(_icon, false)
