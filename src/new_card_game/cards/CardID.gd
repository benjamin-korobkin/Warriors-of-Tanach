extends Node
class_name CardID

enum ID {
	# === Kings (100–199) ===
	KING_ASA            = 101
	KING_CHIZKIYAHU     = 102
	KING_DAVID          = 103
	KING_SHAUL          = 104
	KING_YEHOSHAFAT     = 105

	# === Generals (200–299) ===
	GENERAL_AMASA	    = 200
	GENERAL_AVISHAI	    = 201
	GENERAL_AVNER	    = 202
	GENERAL_BARAK       = 203
	GENERAL_BENAIAH     = 204
	GENERAL_ELAZAR      = 205
	GENERAL_ELCHANAN    = 206
	GENERAL_ITTAI       = 207
	GENERAL_YOAV        = 208
	GENERAL_YONATAN	    = 209
	GENERAL_ZALMAN      = 210
	GENERAL_SIBCHAI	 	= 211

	# === Shoftim (300–399) ===
	SHOFET_DEVORAH      = 302
	SHOFET_EHUD         = 303
	SHOFET_GIDEON       = 304
	SHOFET_OSNIEL       = 305
	SHOFET_SHAMGAR	    = 306
	SHOFET_SHIMSHON	    = 307
	SHOFET_TOLEH        = 308
	SHOFET_YAIR	        = 309
	

	# === Prophets (400–499) ===
	PROPHET_ELIYAHU     = 401
	PROPHET_HOSHEA      = 402
	PROPHET_NATAN       = 403
	PROPHET_SHMUEL      = 404
	PROPHET_YEHOSHUA    = 405
}

static func is_king(id:int) -> bool:
	return id >= 100 and id < 200

static func is_general(id:int) -> bool:
	return id >= 200 and id < 300

static func is_shofet(id:int) -> bool:
	return id >= 300 and id < 400

static func is_prophet(id:int) -> bool:
	return id >= 400 and id < 500
