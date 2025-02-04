class_name BuffsTabUI extends Control

const BUFF_SLOT = preload("res://UI/BuffsTab/buff_slot.tscn")

@export var data: BuffTabData

func _ready() -> void:
	update_buffs_tab()
	PlayerManager.update_buff_ui.connect(update_buffs_tab)

func clear_buffs_tab() -> void:
	for child in get_children():
		child.queue_free()

func update_buffs_tab() -> void:
	clear_buffs_tab()
	for s in data.slots:
		var new_slot = BUFF_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		
	
