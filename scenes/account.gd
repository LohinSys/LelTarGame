extends Control

var username: String = ""
var password

var userId: int = 0
var token: String = ""
var role: String = ""

var loggedIn: bool = false

func login(username_input,password_input) -> void:
	if !loggedIn:
		print_rich("\nLogging in as [b]%s[/b]..." % username_input)
		username = str(username_input)
		password = Marshalls.utf8_to_base64(str(password_input)).reverse()

		Api.post_request("auth/login",str('{
			"username": "%s",
			"password": "%s"
		}'.remove_chars("	") % [username_input,password_input]))
		await Api.http_request.request_completed

		if Api.req_response == 200:
			token = Api.req_body.get("token","")
			userId = int(Api.req_body.get("id",0))
			role = Api.req_body.get("role","User")
			loggedIn = true
			print_rich("[color=green]Successfully logged in![/color]")
			## The commented lines below should only be uncommented for debugging purposes
			#print_rich("\n[b]Account Details[/b]\n[s]--------------------[/s]")
			#print_rich("[b]Username:[/b] %s" % username)
			#print_rich("[b]Password:[/b] %s [i](obfuscated)[/i]" % password)
			#print_rich("    [b]Role:[/b] %s" % role)
			Api.req_headers.append("Authorization: Bearer %s" % token)
			PlayerStats.save()
		else:
			print_rich("[color=red]/!\\ Login failed! Please try again later. (Error code: %s)[/color]" % Api.req_response)
			if Api.req_response == 401:
				username = ""
				password = ""

		#print("\nAPI Response (%s):\n" % Api.req_response,Api.req_body)	# only uncomment this for debugging purposes

	else:
		print("You have already logged in!")

func logoff() -> void:
	print("\nAttempting to log off...")
	if loggedIn:
		Api.req_headers.erase("Authorization: Bearer %s" % token)
		username = ""
		password = ""
		token = ""
		role = ""
		loggedIn = false
		PlayerStats.save()
		print_rich("[color=green]Successfully logged off![/color]")
	else:
		print("/!\\ You have not signed in!")

func keep_credentials() -> void:
	pass # unused for now until I'll ever bother adding a prompt if you wanna keep credentials saved (which is probably never)

func initial_login() -> void:
	if username != "" and password != "" and !loggedIn:	# check if the save file has any login info saved
		print_rich("\n[color=#00ffff](i) User credentials detected in save file! Attempting to log in automatically...[/color]")
		login(username,str(Marshalls.base64_to_utf8(password.reverse())))
	else:
		print("(i) You are not logged in.")
