<?php

$start = microtime(TRUE); 

/* Start of the code to profile */ 

for ($a = 0; $a < 10000000; $a++)
{ $b = $a*$a; } 

/* End of the code to profile */ 

$end = microtime(TRUE); 

echo "The code took ". ($end - $start) . " seconds to complete.\n";
