extends Node

var stat = ConfigFile.new()
var statKey: String = "Skiptamal00_Shamalamad1ngd0ng"

# Easy
var easyTimesPlayed: int = 0
var easyBestRun: int = 1
var easyHiScore: int = 100_000
var easyDeaths: int = 0
var easyBombsUsed: int = 0
var easyGrazed: int = 0
# Normal
var normTimesPlayed: int = 0
var normBestRun: int = 1
var normHiScore: int = 100_000
var normDeaths: int = 0
var normBombsUsed: int = 0
var normGrazed: int = 0
# Hard
var hardTimesPlayed: int = 0
var hardBestRun: int = 1
var hardHiScore: int = 100_000
var hardDeaths: int = 0
var hardBombsUsed: int = 0
var hardGrazed: int = 0
# Lunatic
var lunaTimesPlayed: int = 0
var lunaBestRun: int = 1
var lunaHiScore: int = 100_000
var lunaDeaths: int = 0
var lunaBombsUsed: int = 0
var lunaGrazed: int = 0

func _ready() -> void:
	var scoreLoad = stat.load_encrypted_pass("user://scores.sav",statKey)
	if scoreLoad == OK:
		# Account Credentials
		Account.username = stat.get_value("Account", "username", "")
		Account.password = stat.get_value("Account", "password", "")

		# Easy
		easyTimesPlayed = stat.get_value("Easy", "timesPlayed", 0)
		easyBestRun = stat.get_value("Easy", "bestRun", 1)
		easyHiScore = stat.get_value("Easy", "hiScore", 100_000)
		easyDeaths = stat.get_value("Easy", "deaths", 0)
		easyBombsUsed = stat.get_value("Easy", "bombsUsed", 0)
		easyGrazed = stat.get_value("Easy", "grazed", 0)
		# Normal
		normTimesPlayed = stat.get_value("Normal", "timesPlayed", 0)
		normBestRun = stat.get_value("Normal", "bestRun", 1)
		normHiScore = stat.get_value("Normal", "hiScore", 100_000)
		normDeaths = stat.get_value("Normal", "deaths", 0)
		normBombsUsed = stat.get_value("Normal", "bombsUsed", 0)
		normGrazed = stat.get_value("Normal", "grazed", 0)
		# Hard
		hardTimesPlayed = stat.get_value("Hard", "timesPlayed", 0)
		hardBestRun = stat.get_value("Hard", "bestRun", 1)
		hardHiScore = stat.get_value("Hard", "hiScore", 100_000)
		hardDeaths = stat.get_value("Hard", "deaths", 0)
		hardBombsUsed = stat.get_value("Hard", "bombsUsed", 0)
		hardGrazed = stat.get_value("Hard", "grazed", 0)
		# Lunatic
		lunaTimesPlayed = stat.get_value("Lunatic", "timesPlayed", 0)
		lunaBestRun = stat.get_value("Lunatic", "bestRun", 1)
		lunaHiScore = stat.get_value("Lunatic", "hiScore", 100_000)
		lunaDeaths = stat.get_value("Lunatic", "deaths", 0)
		lunaBombsUsed = stat.get_value("Lunatic", "bombsUsed", 0)
		lunaGrazed = stat.get_value("Lunatic", "grazed", 0)
	else:
		return

func save() -> void:
	# Account Credentials (stored in the same save file to better curb cheating I hope)
	stat.set_value("Account", "username", Account.username)
	stat.set_value("Account", "password", Account.password)

	# Easy
	stat.set_value("Easy", "timesPlayed", easyTimesPlayed)
	stat.set_value("Easy", "bestRun", easyBestRun)
	stat.set_value("Easy", "hiScore", easyHiScore)
	stat.set_value("Easy", "deaths", easyDeaths)
	stat.set_value("Easy", "bombsUsed", easyBombsUsed)
	stat.set_value("Easy", "grazed", easyGrazed)
	# Normal
	stat.set_value("Normal", "timesPlayed", normTimesPlayed)
	stat.set_value("Normal", "bestRun", normBestRun)
	stat.set_value("Normal", "hiScore", normHiScore)
	stat.set_value("Normal", "deaths", normDeaths)
	stat.set_value("Normal", "bombsUsed", normBombsUsed)
	stat.set_value("Normal", "grazed", normGrazed)
	# Hard
	stat.set_value("Hard", "timesPlayed", hardTimesPlayed)
	stat.set_value("Hard", "bestRun", hardBestRun)
	stat.set_value("Hard", "hiScore", hardHiScore)
	stat.set_value("Hard", "deaths", hardDeaths)
	stat.set_value("Hard", "bombsUsed", hardBombsUsed)
	stat.set_value("Hard", "grazed", hardGrazed)
	# Lunatic
	stat.set_value("Lunatic", "timesPlayed", lunaTimesPlayed)
	stat.set_value("Lunatic", "bestRun", lunaBestRun)
	stat.set_value("Lunatic", "hiScore", lunaHiScore)
	stat.set_value("Lunatic", "deaths", lunaDeaths)
	stat.set_value("Lunatic", "bombsUsed", lunaBombsUsed)
	stat.set_value("Lunatic", "grazed", lunaGrazed)
	# Save the file
	stat.save_encrypted_pass("user://scores.sav",statKey)
	#stat.save("user://scores_decrypted.sav") # ONLY UNCOMMENT THIS LINE FOR DEBUGGING PURPOSES!!
