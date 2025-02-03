class_name ShopData extends Resource

@export var slots : Array[ItemData]

func add_item( item: ItemData ) -> bool:
	for s in slots:
		if s:
			return false
	for i in slots.size():
		print("creating new shop slot")
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			slots[i] = new
			return true
			
	print("Shop is full")
	return false
