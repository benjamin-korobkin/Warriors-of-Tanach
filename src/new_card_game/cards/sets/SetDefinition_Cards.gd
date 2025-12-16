extends Reference

## Cards at the bottom of the script are ordered as such 
## for the sake of the tutorial
## Full organized list of cards can be found in README (eventually, חחח)

const SET = "Core Set"
const CARDS := {


	# ========== PROPHETS ==========
	
	"Avraham Avinu": {
		"Type": "Prophet",
		"Power": 5,
		"Description": "+3 for every other Prophet in your field"
	},
	
	"Eliyahu HaNavi": {
		"Type": "Prophet",
		"Power": 4,
		"Description": ""
	},
	
	"Shmuel HaNavi": {
		"Type": "Prophet",
		"Power": 5,
		"Description": ""
	},
	
	"Yehoshua": {
		"Type": "Prophet",
		"Power": 3,
		"Description": "+3 If Moshe Rabbeinu in play"
	},
	
	"Moshe Rabbeinu": {
		"Type": "Prophet",
		"Power": 5,
		"Description": "+5 If Aharon or Chur in your field. +10 If both"
	},
	
	"Aharon": {
		"Type": "Prophet",
		"Power": 1,
		"Description": ""
	},
	
	# ========== PROPHET,SHOFET ==========
	
	"Devorah HaNeviah": {
		"Type": "Prophet,Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	# ========== KINGS ==========
	
	"David HaMelech": {
		"Type": "King",
		"Power": 5,
		"Description": "+3 for each General or Soldier in your field\n-2 for each in opponent field"
	},
	
	
	
	"Asa": {
		"Type": "King",
		"Power": 3,
		"Description": "+2 for each Soldier or General in your field"
	},
	
	
	
	# ========== SHOFTIM ==========
	
	"Gideon": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Shimshon": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "shofet effect: +1 for each other shofet in your field"
	},
	
	"Ehud ben Geira": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Shamgar ben Anat": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Yiftach ben Gilad": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Osniel ben Knaz": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Toleh ben Puah": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Yair HaGiladi": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},
	
	"Avdon ben Hillel": {
		"Type": "Shofet",
		"Power": 2,
		"Description": "Shofet effect: +1 for each other shofet in your field"
	},

	# ========== GENERALS ==========
	
	"Yoav": {
		"Type": "General",
		"Power": 3,
		"Description": "-1 if Benaiah is in opponent field"
	},
	"Benaiah": {
		"Type": "General",
		"Power": 3,
		"Description": ""
	},
	"Barak": {
		"Type": "General",
		"Power": 2,
		"Description": "+3 If Devorah HaNeviah in your field"
	},
	"Avner": {
		"Type": "General",
		"Power": 3,
		"Description": ""
	},
	
	"Elazar ben Dodo": {
		"Type": "General",
		"Power": 3,
		"Description": "" ## TODO: "+5 if only General in your field"
	},
	
	"Avishai": {
		"Type": "General",
		"Power": 3,
		"Description": ""
	},
	
	"Amasa": {
		"Type": "General",
		"Power": 3,
		"Description": ""
	},
	
	"Yonatan": {
		"Type": "General",
		"Power": 3,
		"Description": ""
	},
	
	# ========== SOLDIERS ==========
	
	"Chur": {
		"Type": "Soldier",
		"Power": 1,
		"Description": ""
	},
	
	"Pinchas": {
		"Type": "Soldier",
		"Power": 2,
		"Description": "+3 if Eliyahu HaNavi in play"
	},

	# ========= DEBUGGING CARD ==========
	"Shaul HaMelech": {
		"Type": "King",
		"Power": 4,
		"Description": "+2 for each Soldier or General in your field\n-1 for each in opponent field"
	},
}


