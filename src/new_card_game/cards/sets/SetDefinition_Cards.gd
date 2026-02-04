extends Reference

## Cards at the bottom of the script are ordered as such 
## for the sake of the tutorial
## Full organized list of cards can be found in README (eventually, חחח)

const SET = "Core Set"
const CARDS := {


	# ========== PROPHETS ==========
	
	# "Eliyahu HaNavi": {
	# 	"CardID": CardID.ID.PROPHET_ELIYAHU,
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Discard your entire hand and draw 3 new cards"
	# },
	
	# "Shmuel HaNavi": {
	# 	"CardID": CardID.ID.PROPHET_SHMUEL,
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Any Shofet played this round onward may not exceed 3 Power"
	# },
	
	# "Yehoshua": {
	# 	"CardID": CardID.ID.PROPHET_YEHOSHUA,
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "The cards played in this round are swapped"
	# },
	
	# "Natan": {
	# 	"CardID": CardID.ID.PROPHET_NATAN,
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "No effects occur this round"
	# },
	
	# "Hoshea": {
	# 	"CardID": CardID.ID.PROPHET_HOSHEA,
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Next round, your opponent reveals their card before you select yours"
	# },
	
	
	# ========== KINGS ==========
	
	
	
	
	# ========== SHOFTIM ==========

	"Devorah HaNeviah": {
		"CardID": CardID.ID.SHOFET_DEVORAH,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
	},
	
	"Gideon": {
		"CardID": CardID.ID.SHOFET_GIDEON,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
	},
	
	"Shimshon": {
		"CardID": CardID.ID.SHOFET_SHIMSHON,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
	},
	
	"Ehud ben Geira": {
		"CardID": CardID.ID.SHOFET_EHUD,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
	},
	"Yair HaGiladi": {
		"CardID": CardID.ID.SHOFET_YAIR,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
	},
	
	
	
	
	
	
	
	
	
	

	# ========== GENERALS ==========
	
	
	
	
	
	
	
	
	
	
	
	# DEBUGGING
	
	"Yoav": {
		"CardID": CardID.ID.GENERAL_YOAV,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+3 if opponent played a King this round"
	},
	"Benaiah": {
		"CardID": CardID.ID.GENERAL_BENAIAH,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+3 if opponent plays a general this turn"
	},
	
	
	"Asa": {
		"CardID": CardID.ID.KING_ASA,
		"Type": "King",
		"Power": 2,
		"BasePower": 2,
		"Description": "If at least one card on either side is a General, +3"
	},
	
	"Shaul": {
		"CardID": CardID.ID.KING_SHAUL,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "If previous card is General, +1\nIf next card is a Shofet, +2"
	},

	"Shamgar ben Anat": {
		"CardID": CardID.ID.SHOFET_SHAMGAR,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
	},
	"Barak": {
		"CardID": CardID.ID.GENERAL_BARAK,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+2 if placed after a Shofet. If that Shofet is Devorah, +3"
	},
	
	"Ittai": {
		"CardID": CardID.ID.GENERAL_ITTAI,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": ""
	},
	"Amasa": {
		"CardID": CardID.ID.GENERAL_AMASA,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "If opponent has 3 or more Shoftim this turn, -1 to ALL Shoftim on board"
	},
	"Avishai": {
		"CardID": CardID.ID.GENERAL_AVISHAI,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+2 if you played a general last turn"
	},
	"Yonatan": {
		"CardID": CardID.ID.GENERAL_YONATAN,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+3 if opponent plays a Shofet this turn"
	},
	"Elazar ben Dodo": {
		"CardID": CardID.ID.GENERAL_ELAZAR,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+3 if this is the only general in your field, except Elchanan."
	},
	
	"Zalman": {
		"CardID": CardID.ID.GENERAL_ZALMAN,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": ""
	},
	"Elchanan ben Dodo": {
		"CardID": CardID.ID.GENERAL_ELCHANAN,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": ""
	},
	"Yehoshafat": {
		"CardID": CardID.ID.KING_YEHOSHAFAT,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "If previous card is a Shofet +1. If next card is a General, +2"
	},
	"Osniel ben Knaz": {
		"CardID": CardID.ID.SHOFET_OSNIEL,
		"Type": "Shofet",
		"Power": 0,
		"BasePower": 0,
		"Description": "+1 for each other shofet in your field. +2 to each shofet you played before"
	},
	"Avner": {
		"CardID": CardID.ID.GENERAL_AVNER,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+2 while you have more Generals than your opponent"
	},
	"Toleh ben Puah": {
		"CardID": CardID.ID.SHOFET_TOLEH,
		"Type": "Shofet",
		"Power": 1,
		"BasePower": 1,
		"Description": "+1 for each other shofet in your field. +2 If opponent plays a shofet this round"
	},
	"David": {
		"CardID": CardID.ID.KING_DAVID,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "If previous card is General, +1\nIf next card is a General, +2"
	},
	"Chizkiyahu": {
		"CardID": CardID.ID.KING_CHIZKIYAHU,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "If previous card is a Shofet, +1. If next card is a Shofet, +2"
	}
}
