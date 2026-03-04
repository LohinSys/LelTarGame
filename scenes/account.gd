extends Control

var username: String = ""
var password

var token: String = ""

var loggedIn: bool = false
var loginSuccess: bool = false

#var crypto = Crypto.new()
#var cryptKey = crypto.generate_rsa(4096)
#
#var storedKey

func login(username_input,password_input) -> void:
	#var encryptedPass = str(password_input).to_utf8_buffer()
	#storedKey = cryptKey

	print("\nLogging in as ",username_input,"...")
	username = str(username_input)
	password = Marshalls.utf8_to_base64(str(password_input)).reverse()
	await get_tree().create_timer(randf_range(0.9,1.8)).timeout
	loggedIn = true
	print("Success!")
	loginSuccess = true
	print("\nAccount Details\n--------------------\nUsername: ",username,"\nPassword (encrypted): ",password)
	PlayerStats.save()

func logoff() -> void:
	print("\nAttempting to log off...")
	if loggedIn:
		username = ""
		password = ""
		token = ""
		loggedIn = false
		loginSuccess = false
		PlayerStats.save()
		print("Success!")
	else:
		print("/!\\ You have not signed in!")

func keep_credentials() -> void:
	pass

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout

	if username != "" and password != "":
		print("\n(i) User credentials detected in save file! Attempting to log in automatically...")
		login(username,str(Marshalls.base64_to_utf8(password.reverse())))
	else:
		print("(i) You are not logged in.")
