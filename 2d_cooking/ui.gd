extends Control

@onready var food = $Food
@onready var result = $Result
#writing random comments to test commits delete this later

@onready var top = $Food/top/ingredient
@onready var middle = $Food/middle/ingredient
@onready var bottom = $Food/bottom/ingredient


func _on_delivery_button_pressed():
	if top.text == "" and middle.text == "" and bottom.text == "":
		result.text = "Nothing to deliver!"
	elif top.text == "Top Bun" and middle.text == "Meat" and bottom.text == "Bottom Bun":
		result.text = "Delivery success! Another happy customer"
	else:
		result.text = "You donkey! That's not how you make a burger!"
