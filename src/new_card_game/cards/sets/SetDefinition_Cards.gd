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
	# 	"Description": "The cards played in this round are swapped."
	# },
	
	# "Yehoshua": {
	# 	"CardID": CardID.ID.PROPHET_YEHOSHUA,
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Draw an extra card from the deck. Use it by the end of next round or it will be discarded."
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
	
	
	
	
	
	
	
	
	
	

	# ========== GENERALS ==========
	
	
	
	
	
	
	
	
	
	
	
	# DEBUGGING
	
	"Yoav": {
		"CardID": CardID.ID.GENERAL_YOAV,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+4 if opponent played a King this round"
	},
	"Benaiah": {
		"CardID": CardID.ID.GENERAL_BENAIAH,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "+3 if opponent plays a general this turn"
	},
	
	
	
	"Avner": {
		"CardID": CardID.ID.GENERAL_AVNER,
		"Type": "General",
		"Power": 2,
		"BasePower": 2,
		"Description": "Future Shoftim cannot exceed 4 Power after this round"
	},
	"Asa HaMelech": {
		"CardID": CardID.ID.KING_ASA,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "+1 for each General in your field"
	},
	
	"Shaul HaMelech": {
		"CardID": CardID.ID.KING_SHAUL,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "+2 for each General in your field.\n-1 for each General in opponent field"
	},

	"David HaMelech": {
		"CardID": CardID.ID.KING_DAVID,
		"Type": "King",
		"Power": 5,
		"BasePower": 5,
		"Description": "+2 for each General in your field.\n-2 for each General in opponent field"
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
		"Power": 2,
		"BasePower": 2,
		"Description": "+2 if you played a general last turn"
	},
	"Amasa": {
		"CardID": CardID.ID.GENERAL_AMASA,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": "If opponent has 3 or more Shoftim, ALL Shoftim receive -1 Power"
	},
	"Yiftach ben Gilad": {
		"CardID": CardID.ID.SHOFET_YIFTACH,
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
	"Avishai": {
		"CardID": CardID.ID.GENERAL_AVISHAI,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": "+1 if Yoav was played beforehand in your field"
	},
	"Avdon ben Hillel": {
		"CardID": CardID.ID.SHOFET_AVDON,
		"Type": "Shofet",
		"Power": 2,
		"BasePower": 2,
		"Description": "+1 for each other Shofet in your field"
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
		"Description": "+4 if this is the only general in your field, except Elchanan."
	},
	"Chizkiyahu": {
		"CardID": CardID.ID.KING_CHIZKIYAHU,
		"Type": "King",
		"Power": 3,
		"BasePower": 3,
		"Description": "+3 for each General in your field.\n-3 for each General in opponent field"
	},
	"Osniel ben Kenaz": {
		"CardID": CardID.ID.SHOFET_OSNIEL,
		"Type": "Shofet",
		"Power": 0,
		"BasePower": 0,
		"Description": "+1 for each other Shofet in your field.\n+2 to Shoftim you played beforehand"
	},
	"Toleh ben Puah": {
		"CardID": CardID.ID.SHOFET_TOLEH,
		"Type": "Shofet",
		"Power": 1,
		"BasePower": 1,
		"Description": "+1 per other Shofet in your field.\n+2 if opponent plays a Shofet this round"
	},
	"Eliav": {
		"CardID": CardID.ID.GENERAL_ELIAV,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": ""
	},
	"Zalman": {
		"CardID": CardID.ID.GENERAL_ZALMAN,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": ""
	},
	"Shammah ben Agay": {
		"CardID": CardID.ID.GENERAL_SHAMMAH,
		"Type": "General",
		"Power": 1,
		"BasePower": 1,
		"Description": "+1 if Adino was played beforehand in your field"
	},
	"Adino HaEtzni": {
		"CardID": CardID.ID.GENERAL_ADINO,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": "+1 if Shammah was played beforehand in your field"
	},
	"Asael": {
		"CardID": CardID.ID.GENERAL_ASAEL,
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
	"Uriah HaChitti": {
		"CardID": CardID.ID.GENERAL_URIAH,
		"Type": "General",
		"Power": 3,
		"BasePower": 3,
		"Description": ""
	},
	"Yehoshafat": {
		"CardID": CardID.ID.KING_YEHOSHAFAT,
		"Type": "King",
		"Power": 2,
		"BasePower": 2,
		"Description": "+3 for each General in your field.\n-2 for each General in opponent field"
	}
}
