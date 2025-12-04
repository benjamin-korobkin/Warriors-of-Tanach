extends Reference

## Cards at the bottom of the script are ordered as such 
## for the sake of the tutorial
## Full organized list of cards can be found in README (eventually, חחח)

const SET = "Core Set"
const CARDS := {

# For sake of tutorial, leave this card here.
	"Avraham Avinu": {
		"Type": "Tanach",
		"Effect": "Gain extra action"
	},
	### SAGE CARDS BEGIN ###

## TANNAIM

	"Nittai HaArbaily": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Distance yourself from evildoers. Don't befriend the wicked"
	},
	"Yehuda ben Tabbai": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "When judging, view all as guilty. View them as innocent after"
	},
	"Shimon ben Gamliel": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "The world stands on 3 things: Justice, Truth, and Peace"
	},
	
## AMORAIM

	"Reish Lakish": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "Great is teshuva, for it transforms intended sins into merits"
	},
	"Rav (Abba Aricha)": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "Better to cast oneself into a furnace than embarrass someone"
	},
	"Shmuel (bar Abba)": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "It is forbidden to deceive anyone, whether Jew or Pagan"
	},
	"Rabbi Ami": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "One who prepares a mitzva, then can't do it, is still credited"
	},
	"Bar Kappara": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "Teach your child a clean and easy profession"
	},
	"Rabbi Yehoshua ben Levi": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "One who rejoices while suffering brings salvation to the world"
	},
	
## GAONIM

	"Rav Hai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "A community bound by a single calendar stands united before God"
	},
	"Rav Sherira": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "The Torah is broad and deep. None can claim mastery over it"
	},
	"Rav Natronai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "Do not rely on miracles; Torah guides through wisdom and action"
	},
	"Rav Amram bar Sheshna": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "Prayer shapes the day, as Torah shapes the soul."
	},
	"Rav Yehudai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "Study the written and oral Torah together; they are inseparable."
	},
	"Rav Saadia": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "The wicked may live on for the sake of righteous offspring"
	},
#	"Rav Shimon Kayyara": {
#		"Type": "Sage",
#		"Power": 3,
#		"Era": "Gaon",
#		"Teaching": "One who learns, but doesn't teach, diminishes the Torah"
#	},
	
## RISHONIM
	
	"Ramban (Nachmonides)": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The soul of a person is a reflection of the Divine"
	},
	"Rabbeinu Tam": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "To question is the essence of understanding"
	},
	"Isaac Alfasi (Rif)": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The study of Torah is a path to wisdom and peace"
	},

## ACHARONIM

	"Rabbi Yaakov Emden": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "We may return to the land of Israel at any time"
	},
	"Rabbi Yaakov Kamenetsky": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "One does not raise children with falsehood"
	},
	"Vilna Gaon": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "Overcoming negative traits is harder than mastering Talmud"
	},
	
	### TUTORIAL CARDS - Also included in main game ###
	
	"Chafetz Chaim": { # P2 draw and put in timeline
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "One moment of lashon hara can destroy years of work"
	},
	"Hillel": {  # P1 - put previous card in timeline and draw
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Be disciples of Aharon, loving and pursuing peace"
	},
	"Rashi": { # P2 draw and put in BM
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The Torah begins with creation to show G-d's world authority"
	},
	"Yehoshua ben Prachya": { # P1 - put other card from below in BM and draw
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Appoint a teacher, acquire a friend, and judge all favorably"
	},
	
	"Chazon Ish": { # P2 - draw and put in BM
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "Emunah (faith) is not weakness. It's courage to face reality"
	},
	"Rabbi Yehuda HaLevi": { ## see below
		"Type": "Sage", 
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "Israel among the nations is like a heart among the organs"
	},
	"Rav Nachman of Breslov": { ## see below
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "If you believe you can destroy, believe you can also create"
	},
	"Yosef HaTzadik": { # P1 - draw, use, get above 2 cards, put 1 in BM.
		"Type": "Tanach",
		"Effect": "Draw 2 cards"
	},
	"Rambam (Maimonides)": { # P2 - draw and put in BM
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The ultimate purpose of knowledge is to know G-d"
	},
	"Shammai": { # P1 - draw and put in BM
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Say little and do much, and greet all with a smile"
	},
	
# TANACH CARDS
# TANACH CARDS
	
	
	"Yitzchak Avinu": {
		"Type": "Tanach",
		"Effect": "Increase max Merits by 5"
	},
	"Yaakov Avinu": {
		"Type": "Tanach",
		"Effect": "Gain 1 Merit for each Sage in the BM"
	},
	"Aharon": {
		"Type": "Tanach",
		"Effect": "Your opponent loses 1 Action for 2 turns"
	},
	"Yehoshua": {
		"Type": "Tanach",
		"Effect": "View opponent's cards in the Beit Midrash"
	},
	"Shlomo HaMelech": {
		"Type": "Tanach",
		"Effect": "Take up to 2 merits from your opponent"
	},
	"Eliyahu HaNavi": {
		"Type": "Tanach",
		"Effect": "Can fill the final timeline slot with this card"
	},
	"Elisha HaNavi": {
		"Type": "Tanach",
		"Effect": "Draw the top card from the discard pile"
	},
	"Moshe Rabbeinu": { # P1 receives, and uses next turn
		"Type": "Tanach",
		"Effect": "Put a Sage in the Timeline for no merits or action"
	},
	## TODO: Implement David and other cards in the future
#	"David HaMelech": {
#		"Type": "Tanach",
#		"Effect": "Your Sages can't be replaced for 2 turns"
#	},
#	"Shimshon": {
#		"Type": "Tanach",
#		"Effect": "Remove a random card from opponent's BM"
#	},
}


