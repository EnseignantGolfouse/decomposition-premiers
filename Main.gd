extends Node2D


var input: bool = true


func _ready() -> void:
	$Texte.hide()

func trouve_diviseurs(n: int):
	var crible = []
	var premiers = []
	for i in range(0, n):
		crible.push_back(true)
	for i in range(1, n):
		var nombre: int = i+1
		if crible[i]:
			var multiple = i + nombre
			while multiple < n:
				crible[multiple] = false
				multiple += nombre
			premiers.push_back(nombre)
	var premiers_index = 0
	var premier
	var diviseurs = []
	while premiers_index < premiers.size():
		premier = premiers[premiers_index]
		if n % premier == 0:
			n = n / premier
			diviseurs.push_back(premier)
		else:
			premiers_index += 1
	return diviseurs

func _on_Input_text_entered(new_text) -> void:
	var nombre = int($Input.text)
	var nombre_original = nombre
	var nb_length = $Input.text.length()
	if nombre == 0:
		$Input/RichTextLabel.bbcode_text = "[center]Erreur : il faut entrer un entier ![/center]"
		return
	if nombre < 0:
		$Input/RichTextLabel.bbcode_text = "[center]Erreur : il faut entrer un entier positif ![/center]"
		return
	var diviseurs = trouve_diviseurs(nombre)
	var divisees = [nombre]
	for diviseur in diviseurs:
		nombre /= diviseur
		divisees.push_back(nombre)
	
	var placeholder_text = " ".repeat(nb_length)
	$Texte.textes = [String(divisees[0]) + " │ "]
	for index in range(0, diviseurs.size()):
		var divisee_text = String(divisees[index + 1])
		var diviseur_text = String(diviseurs[index])
		var text = $Texte.textes.back()
		text += (
			diviseur_text
			+ " ".repeat(nb_length - diviseur_text.length())
			+ "\n"
			+ " ".repeat(nb_length - divisee_text.length())
			+ divisee_text
			+ " │ "
		)
		$Texte.textes.push_back(text)
	var text = (
		"[center]"
		+ $Texte.textes.back()
		+ placeholder_text
		+ "\n\n"
		+ String(nombre_original)
		+ "= "
	)
	for index in range(0, diviseurs.size()):
		if index > 0:
			text += " × "
		text += String(diviseurs[index])
	text += "[/center]"
	$Texte.textes.push_back(text)
	
	for index in range(0, $Texte.textes.size() - 1):
		$Texte.textes[index] = (
			"[center]"
			+ $Texte.textes[index]
			+ placeholder_text
			+ "[/center]"
		)
	$Texte.index = 0
	$Texte.bbcode_text = $Texte.textes[0]
	$Input.hide()
	$Texte.show()
	self.input = false

func _input(event: InputEvent):
	if (not self.input and Input.is_key_pressed(KEY_Q) and not event.echo):
		$Input.text = ""
		$Input/RichTextLabel.bbcode_text = "[center]Rentrez un nombre :[/center]"
		$Input.show()
		$Texte.hide()
		self.input = true
