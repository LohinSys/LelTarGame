extends Control

var username: String = ""
var password

var token: String = ""

var loggedIn: bool = false
var loginSuccess: bool = false

func login(username_input,password_input) -> void:
	print("\nLogging in as ",username_input,"...")
	username = str(username_input)
	password = Marshalls.utf8_to_base64(str(password_input)).reverse()

	Api.post_request("auth/login",str('{"username":"',username_input,'","password":"',password_input,'"}'))
	await Api.http_request.request_completed

	if Api.req_response == 200:
		token = Api.req_body.get("token","")
		print(token)
		loggedIn = true
		print("Success!")
		loginSuccess = true
		print("\nAccount Details\n--------------------\nUsername: ",username,"\nPassword (encrypted): ",password)
		PlayerStats.save()
	else:
		print("/!\\ Login failed! Please try again later. (Error code: %s)" % Api.req_response)
		username = ""
		password = ""

	print("\nAPI Response (%s):\n" % Api.req_response,Api.req_body)

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
	pass # unused for now until I'll ever bother adding a prompt if you wanna keep credentials saved (which is probably never)

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout

	if username != "" and password != "":	# check if the save file has any login info saved
		print("\n(i) User credentials detected in save file! Attempting to log in automatically...")
		login(username,str(Marshalls.base64_to_utf8(password.reverse())))
	else:
		print("(i) You are not logged in.")
