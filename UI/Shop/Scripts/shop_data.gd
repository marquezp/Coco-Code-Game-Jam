class_name ShopData extends Resource

@export var slots : Array[ItemData]

func add_item( item: ItemData ) -> bool:
	# This implementation doesnt allow dupes in the shop
	for s in slots:
		if s:
			if s.name == item.name:
				print("Item already in shop!")
				return false
	for i in slots.size():
		if slots[i] == null:
			var new = ItemData.new()
			new = item
			slots[i] = new
			return true
			
	print("Shop is full")
	return false
