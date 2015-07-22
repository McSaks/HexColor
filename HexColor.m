BeginPackage["HexColor`"]

HexColor::usage = "\!\(\*StyleBox[RowBox[{\"HexColor\", \"[\", \
StyleBox[\"string\",\"TI\"], \"]\"}],\"MR\"]\) \
Returns color via hexadecimal string.
\!\(\*StyleBox[\"ToHexColor\",\"MR\"]\) is inverse of \!\(\*StyleBox[\"HexColor\",\"MR\"]\)";
HexColor::nhex = "Hexadecimal digits required.";
HexColor::ndig = "Number of digits must be 3, 4, 6 or 8 but recieved `1`.";


ToHexColor::usage = "\!\(\*StyleBox[RowBox[{\"ToHexColor\", \"[\", \
StyleBox[\"string\",\"TI\"], \"]\"}],\"MR\"]\) \
Returns hexadecimal string representation of color.
\!\(\*StyleBox[\"HexColor\",\"MR\"]\) is inverse of \!\(\*StyleBox[\"ToHexColor\",\"MR\"]\).";
ToHexColor::notcolor = "Argument must be \!\(\*StyleBox[\"RGBColor\",\"MR\"]\), \
\!\(\*StyleBox[\"CMYKColor\",\"MR\"]\), \!\(\*StyleBox[\"Hue\",\"MR\"]\) or \
\!\(\*StyleBox[\"GrayLevel\",\"MR\"]\) color object but recieved `1`.";

Begin["`Private`"]

SetAttributes[catch, HoldFirst];
catch[expr_] := Catch[expr, HexColor];
throw[expr_] := Throw[expr, HexColor];


HexColor[str_] := catch @ Module[{
    s = str,
    r, g, b,
    a = Undefined
  },
  If[ StringTake[s, 1] === "#",
    s = StringDrop[s, 1] ];
  If[ !StringMatchQ[s, HexadecimalCharacter..],
    Message[HexColor::nhex];
    throw[$Failed];
  ];
  Switch[ StringLength[s]
    ,6,
      r = ToExpression["16^^" <> StringTake[s, {1,2}]];
      g = ToExpression["16^^" <> StringTake[s, {3,4}]];
      b = ToExpression["16^^" <> StringTake[s, {5,6}]];
    ,3,
      r = ToExpression["16^^" <> StringTake[s, {1}] <> StringTake[s, {1}]];
      g = ToExpression["16^^" <> StringTake[s, {2}] <> StringTake[s, {2}]];
      b = ToExpression["16^^" <> StringTake[s, {3}] <> StringTake[s, {3}]];
    ,8,
      r = ToExpression["16^^" <> StringTake[s, {1,2}]];
      g = ToExpression["16^^" <> StringTake[s, {3,4}]];
      b = ToExpression["16^^" <> StringTake[s, {5,6}]];
      a = ToExpression["16^^" <> StringTake[s, {7,8}]];
    ,4,
      r = ToExpression["16^^" <> StringTake[s, {1}] <> StringTake[s, {1}]];
      g = ToExpression["16^^" <> StringTake[s, {2}] <> StringTake[s, {2}]];
      b = ToExpression["16^^" <> StringTake[s, {3}] <> StringTake[s, {3}]];
      a = ToExpression["16^^" <> StringTake[s, {4}] <> StringTake[s, {4}]];
    ,_,
      Message[HexColor::ndig, StringLength[s]];
      throw[$Failed];
  ];
  r /= 255.; g /= 255.; b /= 255.;
  If[ a === Undefined,
    RGBColor[r, g, b]
  (* else *),
    a /= 255.;
    RGBColor[r, g, b, a]
  ]
];


ToHexColor[RGBColor[red_, green_, blue_, alpha_: Null]] := Module[{
    s = "#",
    r, g, b, a
  },
  r = Round[255 red];
  g = Round[255 green];
  b = Round[255 blue];
  s = s <> IntegerString[r, 16, 2];
  s = s <> IntegerString[g, 16, 2];
  s = s <> IntegerString[b, 16, 2];
  If[ alpha =!= Null,
    a = Round[255 alpha];
    s = s <> IntegerString[a, 16, 2];
  ];
  s
];

ToHexColor[c: (_Hue | _GrayLevel | _CMYKColor | _?ColorQ)] :=
  ToHexColor[ColorConvert[c, "RGB"]];

ToHexColor[c_] := (Message[ToHexColor::notcolor, c]; $Failed);

End[]

EndPackage[]
