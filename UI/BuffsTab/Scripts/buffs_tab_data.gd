class_name BuffTabData extends Resource

@export var slots : Array[SlotData]

func add_item( item: ItemData , count: int = 1 ) -> bool:
	for s in slots:
		if s:
			# If the buff is already applied
			if s.item_data == item:
				s.quantity += count
				return true
	for i in slots.size():
		print("creating new slot")
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[i] = new
			return true
			
	print("Inventory was full")
	return false
