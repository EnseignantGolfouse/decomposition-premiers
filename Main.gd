extends Control


func trouve_diviseurs(n: int):
	var crible = []
	var premiers = []
	for _i in range(0, n):
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

func _on_Input_text_entered(new_text: String) -> void:
	var textes = []
	var nombre = int(new_text)
	var nombre_original = nombre
	var nb_length = $InputNumber/Input.text.length()
	if nombre == 0:
		$InputNumber/Prompt.bbcode_text = "[center]Erreur : il faut entrer un entier ![/center]"
		return
	if nombre < 0:
		$InputNumber/Prompt.bbcode_text = "[center]Erreur : il faut entrer un entier positif ![/center]"
		return
	var diviseurs = trouve_diviseurs(nombre)
	var divisees = [nombre]
	for diviseur in diviseurs:
		nombre /= diviseur
		divisees.push_back(nombre)
	
	var placeholder_text = " ".repeat(nb_length)
	textes = [String(divisees[0]) + " │ "]
	for index in range(0, diviseurs.size()):
		var divisee_text = String(divisees[index + 1])
		var diviseur_text = String(diviseurs[index])
		var text = textes.back()
		text += (
			diviseur_text
			+ " ".repeat(nb_length - diviseur_text.length())
			+ "\n"
			+ " ".repeat(nb_length - divisee_text.length())
			+ divisee_text
			+ " │ "
		)
		textes.push_back(text)
	var text = (
		"[center]"
		+ textes.back()
		+ placeholder_text
		+ "\n\n"
		+ String(nombre_original)
		+ " = "
	)
	for index in range(0, diviseurs.size()):
		if index > 0:
			text += " × "
		text += String(diviseurs[index])
	text += "[/center]"
	textes.push_back(text)
	
	for index in range(0, textes.size() - 1):
		textes[index] = (
			"[center]"
			+ textes[index]
			+ placeholder_text
			+ "[/center]"
		)
	get_node("/root/Variables").textes = textes
	if get_tree().change_scene("res://Divisors.tscn") != OK:
		printerr("can't open scene at 'res://Divisors.tscn'")
