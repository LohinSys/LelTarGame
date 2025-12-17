extends Control

var username: String = ""
var password: String = ""

var loggedIn: bool = false
var loginSuccess: bool = false

var crypto = Crypto.new()
var cryptKey = crypto.generate_rsa(4096)

func _ready() -> void:
	pass
