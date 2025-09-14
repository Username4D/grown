extends ColorRect

func _ready() -> void:
	$Label.text = self.name

func _refresh() -> void:
	if self.position.x > 544 - 2 * 96 and self.position.x < 544 + 2 * 96:
		self.modulate.a = 1 - abs(self.position.x - 544) / (2 * 96)
	else:
		self.modulate.a = 0
	
	if self.position.x == 544:
		UiHandler.inv_selection = self.name
