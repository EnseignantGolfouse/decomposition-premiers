extends RichTextLabel

var textes = []
var index = -1

func _ready():
	self.bbcode_enabled = true

func _input(event: InputEvent):
	if (Input.is_key_pressed(KEY_RIGHT) and not event.echo):
		if self.index < self.textes.size() - 1:
			self.index += 1
			self.bbcode_text = self.textes[self.index]
	elif (Input.is_key_pressed(KEY_LEFT) and not event.echo):
		if self.index > 0:
			self.index -= 1
			self.bbcode_text = self.textes[self.index]
