$string = "blah blah F12 blah blah F32 blah blah blah" ;
​
# matsche Fxx =>
$matches = ([regex]'F\d\d').Matches($string);
​
# or
​
$matches = ([regex]'F[\d]*').Matches($string);
​
$matches[0].Value; # get matching value for second occurance, F12
$matches[1].Value; # get matching value for second occurance, F32