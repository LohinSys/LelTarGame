extends Control

var msg = ""
var warnicon = "/!\\ "

func close_self() -> void:
	self.hide()
	%Username.text = ""
	%Password.text = ""
	%LoginErrorLbl.text = ""

func disable_buttons() -> void:
	$Panel/Buttons/Login.disabled = true
	$Panel/Buttons/Cancel.disabled = true
	$Panel/Input/Username.editable = false
	$Panel/Input/Password.editable = false

func enable_buttons() -> void:
	$Panel/Buttons/Login.disabled = false
	$Panel/Buttons/Cancel.disabled = false
	$Panel/Input/Username.editable = true
	$Panel/Input/Password.editable = true

func _ready() -> void:
	close_self()
	if Account.username != "" and Account.password != "" and !Account.loggedIn:
		await Api.http_request.request_completed
		if Api.req_response == 200: set_account_label()
		%LoginTitleButton.disabled = false
	elif Account.loggedIn: set_account_label()

func _physics_process(_delta) -> void:
	if Global.blurFx: $Blur.show()
	else: $Blur.hide()

func printErrorMsg(message) -> void:
	msg = message
	print_rich("[color=red]",warnicon,msg,"[/color]")
	%LoginErrorLbl.text = msg

func set_account_label() -> void:
	%AccountLabel.text = "Welcome, %s!\nOnline sync is not available." % Account.username
	%LoginTitleButton.hide()
	%LogoutTitleButton.show()

func _on_login_pressed() -> void:
	if %Username.text == "" and %Password.text == "":
		printErrorMsg("Please provide an username and password!")
	elif %Username.text == "":
		printErrorMsg("Please provide an username!")
	elif %Password.text == "":
		printErrorMsg("Please provide a password!")
	elif len(%Username.text) < 3:
		printErrorMsg("Username must be at least 3 characters long!")
	elif len(%Username.text) > 32:
		printErrorMsg("Username cannot be longer than 32 characters!")
	elif len(%Password.text) < 8:
		printErrorMsg("Password must be at least 8 characters long!")
	else:
		disable_buttons()
		%LoginErrorLbl.text = ""
		$Panel/Buttons/Login.text = "Logging in..."
		await Account.login(%Username.text, %Password.text)
		if Api.req_response == 200:
			set_account_label()
			close_self()
		else:
			printErrorMsg(str(Api.req_body.get("message",str("Login failed! Please try again later. (Error code: %s)" % Api.req_response))))
		$Panel/Buttons/Login.text = "Login"
		enable_buttons()

func _on_cancel_pressed() -> void: close_self()
