extends Node2D
const LEVEL_2 = preload("uid://eg06sud37q35")

## 

## 
func _ready() -> void:
	SceneTransitions.fade_in()


## Transition: Scene Two
func _on_area_2d_body_entered(_body: Node2D) -> void:
	SceneTransitions.fade_out()
	
	await SceneTransitions.fade_complete
	
	get_tree().call_deferred("change_scene_to_packed", LEVEL_2)
