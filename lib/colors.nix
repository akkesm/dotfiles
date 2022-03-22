{ lib }:

let
  inherit (builtins) filter isList length match split substring;
  inherit (lib) flatten foldl imap1 toInt toUpper;
in
rec {
  pow = base: exp:
    if exp == 0
    then 1
    else base * (pow base (exp - 1));

  hexToDec = h:
    let
      toDecDigits = d:
        if (match "[0-9]" d) != null
        then toInt d
        else {
          "A" = 10;
          "B" = 11;
          "C" = 12;
          "D" = 13;
          "E" = 14;
          "F" = 15;
        }.${toUpper d};
      hexDigits = flatten (filter isList (split "([[:xdigit:]])" h));
      decDigits = imap1 (i: d: (toDecDigits d) * (pow 16 ((length hexDigits) - i))) hexDigits;
    in foldl (a: b: a + b) 0 decDigits;

  colorHexToRgbString = hexString:
    let
      hexPair = start: substring start 2 hexString;
      decInteger = start: hexToDec (hexPair start);
      hexPairToDecString = start: substring 0 5 (toString (decInteger start / 255.0));
      red = hexPairToDecString 1;
      green = hexPairToDecString 3;
      blue = hexPairToDecString 5 ;
    in { inherit red green blue; };
}
