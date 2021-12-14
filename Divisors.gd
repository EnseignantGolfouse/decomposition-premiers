extends Control


func _ready():
	$Result/Text.index = 0
	$Result/Text.textes = get_node("/root/Variables").textes
	$Result/Text.bbcode_text = $Result/Text.textes[0]
	print($InstructionDialog/Instructions.rect_size)
	print($InstructionDialog/Instructions.rect_min_size)
#	$InstructionDialog.rect_size = $InstructionDialog/Instructions.rect_size

func _input(event: InputEvent):
	if (Input.is_key_pressed(KEY_Q) and not event.echo):
		if get_tree().change_scene("res://Main.tscn") != OK:
			printerr("can't open scene at 'res://Main.tscn'")


func _on_InstructionButton_pressed():
	$InstructionDialog.popup_centered()
