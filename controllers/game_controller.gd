extends Node

var quiz = load("res://scripts/theme/math.tres") as QuizTheme
@export var color_right: Color
@export var color_wrong: Color

@onready var question_text: Label = $Content/QuestionInfo/QuestionText
@onready var question_image: TextureRect = $Content/QuestionInfo/ImageHolder/QuestionImage
@onready var question_timer: Label = $Content/QuestionInfo/QuestionTimer
@onready var timer: Timer = $Content/Timer

var buttons: Array[Button]
var index: int
var correct: int 


func _ready() -> void:
	timer.start()
	correct = 0
	for button in $Content/QuestionHolder.get_children():
		buttons.append(button)
	
	
	load_quiz()
	
	
func load_quiz() -> void:
	if index >= quiz.theme.size():
		_game_over()
		return
	question_text.text = quiz.theme[index].question_info

	var options = quiz.theme[index].options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
	
	match quiz.theme[index].type:
		Enum.QuestionType.TEXT:
			$Content/QuestionInfo/ImageHolder.hide()
		Enum.QuestionType.IMAGE:
			$Content/QuestionInfo/ImageHolder.show()
			question_image.texture = quiz.theme[index].question_image

func _buttons_answer(button) -> void:
	if quiz.theme[index].correct == button.text:
		button.modulate = color_right
		correct += 1
	else: 
		button.modulate = color_wrong
	_next_question()
	
func _next_question() -> void:
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
		
	await get_tree().create_timer(1).timeout
	
	for bt in buttons:
		bt.modulate = Color.WHITE
	
	index += 1
	
	load_quiz()

func _game_over() -> void:
	$Content/GameOver.show()
	$Content/GameOver/Score.text = str(correct, "/", quiz.theme.size())

func _on_timer_timeout() -> void:
	# Quando o tempo acabar, avançar para a próxima pergunta
	_game_over()

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://inicio.tscn")
