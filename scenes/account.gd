extends Control

var username: String = ""
var password: String = ""

var loggedIn: bool = false
var loginSuccess: bool = false

var crypto = Crypto.new()
var cryptKey = crypto.generate_rsa(4096)

func logoff() -> void:
	if loggedIn:
		Account.username = ""
		Account.password = ""
		Account.loggedIn = false
		Account.loginSuccess = false
		PlayerStats.save()
	else:
		print("/!\\ You have not signed in!")

func keep_credentials() -> void:
	pass

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout

	if username != "" and password != "":
		print("(i) User credentials detected in save file! Attempting to log in automatically...")
		print("\nLogging in as ",Account.username,"...")
		Account.loggedIn = true
		Account.loginSuccess = true
		print("Success!")
		if Account.loginSuccess:
			print("\nAccount Details\n--------------------\nUsername: ",Account.username,"\nPassword (encrypted): ",Account.password)
	else:
		print("(i) You are not logged in.")
