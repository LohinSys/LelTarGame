extends Control

var username: String = ""
var password

var userId: int = 0
var token: String = ""

var loggedIn: bool = false

func login(username_input,password_input) -> void:
	print_rich("\nLogging in as [b]%s[/b]..." % username_input)
	username = str(username_input)
	password = Marshalls.utf8_to_base64(str(password_input)).reverse()

	Api.post_request("auth/login",str('{"username":"',username_input,'","password":"',password_input,'"}'))
	await Api.http_request.request_completed

	if Api.req_response == 200:
		token = Api.req_body.get("token","")
		loggedIn = true
		print_rich("[color=green]Successfully logged in![/color]")
		print_rich("\n[b]Account Details[/b]\n[s]--------------------[/s]")
		print_rich("Username: %s" % username)
		print_rich("Password: %s [i](obfuscated)[/i]" % password)
		PlayerStats.save()
	else:
		print_rich("[color=red]/!\\ Login failed! Please try again later. (Error code: %s)[/color]" % Api.req_response)
		if Api.req_response == 401:
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
		PlayerStats.save()
		print("Successfully logged off!")
	else:
		print("/!\\ You have not signed in!")

func keep_credentials() -> void:
	pass # unused for now until I'll ever bother adding a prompt if you wanna keep credentials saved (which is probably never)

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout

	if username != "" and password != "" and !loggedIn:	# check if the save file has any login info saved
		print_rich("\n[color=#00ffff](i) User credentials detected in save file! Attempting to log in automatically...[/color]")
		login(username,str(Marshalls.base64_to_utf8(password.reverse())))
	else:
		print("(i) You are not logged in.")
