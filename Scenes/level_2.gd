extends Node2D


## 
func _ready() -> void:
	SceneTransitions.fade_in()




## Transition: Scene 3
func _on_area_2d_body_entered(_body: Node2D) -> void:
	SceneTransitions.fade_out()
	
	await SceneTransitions.fade_complete
	
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_3.tscn")
