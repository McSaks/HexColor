BeginTestSection["Test"]

VerificationTest[(* 1 *)
	CompoundExpression[Needs["HexColor`"], HexColor`HexColor["face80"]]
	,
	RGBColor[0.9803921568627451`, 0.807843137254902`, 0.5019607843137255`]	
	,
	TestID->6
]

VerificationTest[(* 2 *)
	HexColor`HexColor["fc8"]
	,
	RGBColor[1.`, 0.8`, 0.5333333333333333`]	
	,
	TestID->3
]

VerificationTest[(* 3 *)
	HexColor`HexColor["#face80"]
	,
	RGBColor[0.9803921568627451`, 0.807843137254902`, 0.5019607843137255`]	
	,
	TestID->#6
]

VerificationTest[(* 4 *)
	HexColor`HexColor["#fc8"]
	,
	RGBColor[1.`, 0.8`, 0.5333333333333333`]	
	,
	TestID->#3
]

VerificationTest[(* 5 *)
	HexColor`HexColor["face8077"]
	,
	RGBColor[0.9803921568627451`, 0.807843137254902`, 0.5019607843137255`, 0.4666666666666667`]	
	,
	TestID->8
]

VerificationTest[(* 6 *)
	HexColor`HexColor["fc87"]
	,
	RGBColor[1.`, 0.8`, 0.5333333333333333`, 0.4666666666666667`]	
	,
	TestID->4
]

VerificationTest[(* 7 *)
	HexColor`HexColor["#face8077"]
	,
	RGBColor[0.9803921568627451`, 0.807843137254902`, 0.5019607843137255`, 0.4666666666666667`]	
	,
	TestID->#8
]

VerificationTest[(* 8 *)
	HexColor`HexColor["#fc87"]
	,
	RGBColor[1.`, 0.8`, 0.5333333333333333`, 0.4666666666666667`]	
	,
	TestID->#4
]

VerificationTest[(* 9 *)
	HexColor`HexColor["notcol"]
	,
	$Failed
	,
	{HexColor::nhex}
	,
	TestID->"not a color"
]

VerificationTest[(* 10 *)
	HexColor`ToHexColor[Red]
	,
	"#ff0000"	
	,
	TestID->"from RGB"
]

VerificationTest[(* 11 *)
	HexColor`ToHexColor[Append[Red, 0.5`]]
	,
	"#ff000080"	
	,
	TestID->"from RGBA"
]

VerificationTest[(* 12 *)
	HexColor`ToHexColor[Hue[0.2`, 0.9`, 0.7`, 0.7`]]
	,
	"#92b212b2"	
	,
	TestID->"from HSBA"
]

VerificationTest[(* 13 *)
	HexColor`ToHexColor[XYZColor[0.2`, 0.9`, 0.7`, 0.7`]]
	,
	"#00ffe6b2"	
	,
	TestID->"from XYZ"
]

EndTestSection[]
