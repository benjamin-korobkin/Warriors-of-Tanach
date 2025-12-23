extends Reference

## Cards at the bottom of the script are ordered as such 
## for the sake of the tutorial
## Full organized list of cards can be found in README (eventually, חחח)

const SET = "Core Set"
const CARDS := {


	# ========== PROPHETS ==========
	
	# "Eliyahu HaNavi": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Discard your entire hand and draw 3 new cards"
	# },
	
	# "Shmuel HaNavi": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "The cards played in this round are swapped."
	# },
	
	# "Yehoshua": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Draw an extra card from the deck. You must use it by the end of next round or it will be discarded."
	# },
	
	# "Natan": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "No bonuses/effects occur this round"
	# },
	
	# "Hoshea": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Next round, your opponent reveals their chosen card before you select yours"
	# },
	
	
	# ========== KINGS ==========
	
	"David HaMelech": {
		"Type": "King",
		"Power": 5,
		"Base_Power": 5,
		"Description": "+2 for each General in your field\n-2 for each General in opponent field"
	},
	
	"Asa HaMelech": {
		"Type": "King",
		"Power": 3,
		"Base_Power": 3,
		"Description": "+1 for each General in your field"
	},

	"Chizkiyahu HaMelech": {
		"Type": "King",
		"Power": 4,
		"Base_Power": 4,
		"Description": "+3 for each General in your field\n-3 for each General in opponent field"
	},
	
	
	# ========== SHOFTIM ==========

	"Devorah HaNeviah": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Gideon": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Shimshon": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Ehud ben Geira": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Shamgar ben Anat": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Yiftach ben Gilad": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Osniel ben Kenaz": {
		"Type": "Shofet",
		"Power": 0,
		"Base_Power": 0,
		"Description": "Double the base value of each Shofet you played beforehand"
	},
	
	"Toleh ben Puah": {
		"Type": "Shofet",
		"Power": 1,
		"Base_Power": 1,
		"Description": "Shofet effect: +1 for each other Shofet in your field\nIf opponent plays a Shofet this round, +2"
	},
	
	"Yair HaGiladi": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	
	"Avdon ben Hillel": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},

	# ========== GENERALS ==========
	
	"Yoav": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+4 if opponent played a King this round"
	},
	"Benaiah": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+3 if opponent plays a General this turn"
	},
	"Barak": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+2 if placed after a Shofet. If that Shofet is Devorah, +3"
	},
	"Avner": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	
	"Elazar ben Dodo": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+5 if the only General in your field"
	},
	
	"Avishai": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	
	"Amasa": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	
	"Yonatan": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	
	"Ittai": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+2 if you played a General last turn"
	},
	
	# DEBUGGING CARD
	"Shaul HaMelech": {
		"Type": "King",
		"Power": 4,
		"Base_Power": 4,
		"Description": "+2 for each General in your field\n-1 for each General in opponent field"
	},
}
