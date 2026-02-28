extends Area2D

func _on_body_entered(body: Node2D) -> void:
	#print("ENTERED:", body)
	if body.is_in_group("player"):
		body.playerInside = true


func _on_body_exited(body: Node2D) -> void:
	#print("EXIT:", body)
	if body.is_in_group("player"):
		body.playerInside = false
