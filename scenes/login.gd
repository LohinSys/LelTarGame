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

func enable_buttons() -> void:
	$Panel/Buttons/Login.disabled = false
	$Panel/Buttons/Cancel.disabled = false

func _ready() -> void:
	close_self()
	if Account.username != "" and Account.password != "":
		await Api.http_request.request_completed
		if Api.req_response == 200: set_account_label()

func _physics_process(_delta) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

func printErrorMsg(message) -> void:
	msg = message
	print(warnicon,msg)
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
		%LoginErrorLbl.text = ""
		await Account.login(%Username.text, %Password.text)
		set_account_label()
		close_self()

func _on_cancel_pressed() -> void:
	close_self()
