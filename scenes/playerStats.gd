extends Node

var stat = ConfigFile.new()
var statKey: String = "Skiptamal00_Shamalamad1ngd0ng"

# Easy
var easyTimesPlayed = 0
var easyBestRun = 1
var easyHiScore = 50000
var easyDeaths = 0
var easyBombsUsed = 0
# Normal
var normTimesPlayed = 0
var normBestRun = 1
var normHiScore = 50000
var normDeaths = 0
var normBombsUsed = 0
# Hard
var hardTimesPlayed = 0
var hardBestRun = 1
var hardHiScore = 50000
var hardDeaths = 0
var hardBombsUsed = 0
# Lunatic
var lunaTimesPlayed = 0
var lunaBestRun = 1
var lunaHiScore = 50000
var lunaDeaths = 0
var lunaBombsUsed = 0

func _ready() -> void:
	var scoreLoad = stat.load_encrypted_pass("user://scores.sav",statKey)
	if scoreLoad == OK:
		# Account Credentials
		Account.username = stat.get_value("Account", "username")
		Account.password = stat.get_value("Account", "password")

		# Easy
		easyTimesPlayed = stat.get_value("Easy", "timesPlayed")
		easyBestRun = stat.get_value("Easy", "bestRun")
		easyHiScore = stat.get_value("Easy", "hiScore")
		easyDeaths = stat.get_value("Easy", "deaths")
		easyBombsUsed = stat.get_value("Easy", "bombsUsed")
		# Normal
		normTimesPlayed = stat.get_value("Normal", "timesPlayed")
		normBestRun = stat.get_value("Normal", "bestRun")
		normHiScore = stat.get_value("Normal", "hiScore")
		normDeaths = stat.get_value("Normal", "deaths")
		normBombsUsed = stat.get_value("Normal", "bombsUsed")
		# Hard
		hardTimesPlayed = stat.get_value("Hard", "timesPlayed")
		hardBestRun = stat.get_value("Hard", "bestRun")
		hardHiScore = stat.get_value("Hard", "hiScore")
		hardDeaths = stat.get_value("Hard", "deaths")
		hardBombsUsed = stat.get_value("Hard", "bombsUsed")
		# Lunatic
		lunaTimesPlayed = stat.get_value("Lunatic", "timesPlayed")
		lunaBestRun = stat.get_value("Lunatic", "bestRun")
		lunaHiScore = stat.get_value("Lunatic", "hiScore")
		lunaDeaths = stat.get_value("Lunatic", "deaths")
		lunaBombsUsed = stat.get_value("Lunatic", "bombsUsed")
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
	# Normal
	stat.set_value("Normal", "timesPlayed", normTimesPlayed)
	stat.set_value("Normal", "bestRun", normBestRun)
	stat.set_value("Normal", "hiScore", normHiScore)
	stat.set_value("Normal", "deaths", normDeaths)
	stat.set_value("Normal", "bombsUsed", normBombsUsed)
	# Hard
	stat.set_value("Hard", "timesPlayed", hardTimesPlayed)
	stat.set_value("Hard", "bestRun", hardBestRun)
	stat.set_value("Hard", "hiScore", hardHiScore)
	stat.set_value("Hard", "deaths", hardDeaths)
	stat.set_value("Hard", "bombsUsed", hardBombsUsed)
	# Lunatic
	stat.set_value("Lunatic", "timesPlayed", lunaTimesPlayed)
	stat.set_value("Lunatic", "bestRun", lunaBestRun)
	stat.set_value("Lunatic", "hiScore", lunaHiScore)
	stat.set_value("Lunatic", "deaths", lunaDeaths)
	stat.set_value("Lunatic", "bombsUsed", lunaBombsUsed)
	# Save the file
	stat.save_encrypted_pass("user://scores.sav",statKey)
	# stat.save("user://scores_decrypted.sav") # ONLY UNCOMMENT THIS LINE FOR DEBUGGING PURPOSES!!
