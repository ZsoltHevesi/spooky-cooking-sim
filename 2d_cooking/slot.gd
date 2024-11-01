extends PanelContainer

@onready var ingredient = $ingredient
@onready var ui = $"../.."

func _get_drag_data(at_position):
	
	set_drag_preview(get_preview())
	
	return ingredient
	
func _can_drop_data(_pos, data):
	return data is Label

func _drop_data(_pos, data):
	var temp = ingredient.text
	ingredient.text = data.text
	data.text = temp

func get_preview():
	var preview_ingredient = Label.new()
 
	preview_ingredient.text = ingredient.text
	preview_ingredient.size = Vector2(30,30)
 
	var preview = Control.new()
	preview.add_child(preview_ingredient)
 
	return preview
