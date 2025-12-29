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
	# 	"Description": "Draw an extra card from the deck. Use it by the end of next round or it will be discarded."
	# },
	
	# "Natan": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "No effects occur this round"
	# },
	
	# "Hoshea": {
	# 	"Type": "Prophet",
	# 	"Power": 0,
	# 	"Description": "Next round, your opponent reveals their card before you select yours"
	# },
	
	
	# ========== KINGS ==========
	
	
	
	
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
	
	
	
	
	
	
	
	
	
	

	# ========== GENERALS ==========
	
	
	
	
	
	
	
	
	
	
	
	# DEBUGGING
	
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
	
	"Chizkiyahu HaMelech": {
		"Type": "King",
		"Power": 3,
		"Base_Power": 3,
		"Description": "+3 for each General in your field\n-3 for each General in opponent field"
	},
	
	"Avner": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	"Asa HaMelech": {
		"Type": "King",
		"Power": 3,
		"Base_Power": 3,
		"Description": "+1 for each General in your field"
	},
	
	"Shaul HaMelech": {
		"Type": "King",
		"Power": 3,
		"Base_Power": 3,
		"Description": "+2 for each General in your field\n-1 for each General in opponent field"
	},
	"Elazar ben Dodo": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+5 if the only General in your field"
	},

	"David HaMelech": {
		"Type": "King",
		"Power": 5,
		"Base_Power": 5,
		"Description": "+2 for each General in your field\n-2 for each General in opponent field"
	},
	
	"Shamgar ben Anat": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	"Barak": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+2 if placed after a Shofet. If that Shofet is Devorah, +3"
	},
	
	"Ittai": {
		"Type": "General",
		"Power": 2,
		"Base_Power": 2,
		"Description": "+2 if you played a General last turn"
	},
	"Osniel ben Kenaz": {
		"Type": "Shofet",
		"Power": 0,
		"Base_Power": 0,
		"Description": "+2 to each Shofet you played beforehand"
	},
	"Amasa": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	"Yiftach ben Gilad": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	"Yair HaGiladi": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	"Avishai": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	"Avdon ben Hillel": {
		"Type": "Shofet",
		"Power": 2,
		"Base_Power": 2,
		"Description": "Shofet effect: +1 for each other Shofet in your field"
	},
	"Yonatan": {
		"Type": "General",
		"Power": 3,
		"Base_Power": 3,
		"Description": ""
	},
	"Toleh ben Puah": {
		"Type": "Shofet",
		"Power": 1,
		"Base_Power": 1,
		"Description": "Shofet effect: +1 for each other Shofet in your field\nIf opponent plays a Shofet this round, +2"
	},
}
