class_name ItemData extends Resource

@export var name: String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D

@export_category("Item Use Effects")
@export var effects : Array[ItemEffect] # so we can use multiple effects in an item

func use() -> bool:
	if effects.size() == 0:
		return false
		
	for e in effects:
		if e:
			e.use()
	return true
