extends Control

func close_self() -> void:
	self.hide()
	%Username.text = ""
	%Password.text = ""

func disable_buttons() -> void:
	$Panel/Buttons/Login.disabled = true
	$Panel/Buttons/Cancel.disabled = true

func enable_buttons() -> void:
	$Panel/Buttons/Login.disabled = false
	$Panel/Buttons/Cancel.disabled = false

func _ready() -> void:
	close_self()

func _process(_delta) -> void:
	if Global.blurFx:
		$Blur.show()
	else:
		$Blur.hide()

func login() -> void:
	var encryptedPass = str(%Password.text).to_utf8_buffer()

	print("\nLogging in as ",%Username.text,"...")
	Account.username = str(%Username.text)
	Account.password = str(Account.crypto.encrypt(Account.cryptKey,encryptedPass))
	Account.loggedIn = true
	print("Success!")
	Account.loginSuccess = true
	close_self()
	print("\nAccount Details\n--------------------\nUsername: ",Account.username,"\nPassword (encrypted): ",Account.password)
	%AccountLabel.text = "Welcome, %s!\nOnline sync is not available." % Account.username
	PlayerStats.save()

func _on_login_pressed() -> void:
	if %Username.text != "" and %Password.text != "":
		login()
	elif %Username.text == "" and %Password.text == "":
		print("/!\\ Please provide an username and password!")
	elif %Username.text == "":
		print("/!\\ Please provide an username!")
	elif %Password.text == "":
		print("/!\\ Please provide a password!")

func _on_cancel_pressed() -> void:
	close_self()
