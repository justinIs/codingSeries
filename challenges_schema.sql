/*
-- Query: SELECT * FROM codingchamps.challenges
LIMIT 0, 5000

-- Date: 2015-10-06 20:46
*/
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (5,'Caribbean',1,'Rövarspråket','<p>Young Swedes were taught a SUPER-SECRET language that only kids know, so they can hide secrets from our confused parents. This language is known as \"Rövarspråket\" (which means \"Robber\'s language\", more or less), and is surprisingly easy to become fluent in, at least when you\'re a kid.</p>\r\n<p>Rövarspråket is not very complicated: you take an ordinary word and replace the consonants with the consonant doubled and with an \"o\" in between. So the consonant \"b\" is replaced by \"bob\", \"r\" is replaced with \"ror\", \"s\" is replaced with \"sos\", and so on. Vowels are left intact. It\'s made for Swedish, but it works just as well in English.</p>\r\n<p>Your task today is to write a program that can encode a string of text into Rövarspråket.</p>','<p>You will recieve one line of input, which is a text string that should be encoded into Rövarspråket.</p>\r\n<pre>Welcome to Textnow</pre>','<p>The output will be the encoded string.</p>\r\n<pre>Wowelolcocomome toto Totexoxtotnonowow</pre>','The show \'Teletubbies\' scared me as a kid.','Tothohe soshohowow \'Toteloletotubobbobiesos\' soscocaroredod mome asos a kokidod.',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (6,'Caribbean',3,'Balancing Words','<p>For this challenge you are going to balance words on one of the letters in them. Use the position and letter itself to calculate the weight around the balance point. A word can be balanced if the weight on either side of the balance point is equal. Not all words can be balanced, but those that can are interesting for this challenge.</p>\r\n<p>The formula to calculate the weight of the word is to look at the letter position in the English alphabet (so A=1, B=2, C=3 ... Z=26) as the letter weight, then multiply that by the distance from the balance point, so the first letter away is multiplied by 1, the second away by 2, etc.</p>\r\n<p>As an example:</p>\r\n<pre>STEAD balances at T: 1 * S(19) = 1 * E(5) + 2 * A(1) + 3 * D(4))</pre>','<p>You\'ll be given a series of English words. Example:</p>\r\n<pre>MESSAGING</pre>\r\n<pre>CONSUBSTANTIATION</pre>','<pre>CONSUBST A NTIATION - 456</pre>\r\n<pre>MESSAGING DOES NOT BALANCE</pre>','UNINTELLIGIBILITY','UNINTELL I GIBILITY - 521',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (7,'Caribbean',9,'Phone Network','<p>Your company has built its own telephone network. This allows all your remote locations to talk to each other. It is your job to implement the program to establish calls between locations.\r\nCalls are dedicated bandwidth on your network. It uses up resources on the network connection between locations. Because of this building a call between two locations on the network can be tricky. As a call is built it continues to use resources and new calls might have to route differently to find a way to reach the source and destination. If there are no ways to build a call then the call will fail.</p>','<p>There will be two sets of input. First set deals with what your phone network looks like. The second set will be the series of calls you must handle.</p>\r\n<p>You must be able to read in network connections. They will be letter names for locations and a number. The number represents how many calls can go across the network link between these two locations. So for example if you have location A and location B and you can have 2 calls between these you will read in a link as:</p>\r\n<pre>A B 2</pre>\r\n<p>Example list of links for a telephone network:</p>\r\n<pre>A B 2\r\nA C 2\r\nB C 2\r\nB D 2\r\nC E 1\r\nD E 2\r\nD G 1\r\nE F 2\r\nF G 2</pre>\r\n<p>You then have a list of calls to be placed on the network. Each call builds in the order you enter it and it is unknown if the resources will be there or not. You must read in all the calls. The calls simply have pairs listing the source and destination of the call. So for example if you wanted Location C to call Location G you would read in the call as:</p>\r\n<pre>C G</pre>\r\n<p>Example of calls to be placed on your example network:</p>\r\n<pre>A G\r\nA G\r\nC E\r\nG D\r\nD E\r\nA B\r\nA D</pre>','<p>Your program will build the call if it can and list back the route the call took. If the call cannot be placed due to too many calls taking up resources it will indicate the \"Call Failed\".</p>\r\n<p>Example output given above the inputs:</p>\r\n<pre>Call A G -- placed A B D G\r\nCall A G -- placed A C E F G\r\nCall C E -- placed C B D E\r\nCall G D -- placed G F E D\r\nCall D E -- failed\r\nCall A B -- placed A B\r\nCall A D -- failed</pre>\r\n<p>Understanding the Bandwidth:</p>\r\n<p>So a link A B has a unit of \"2\" - if a call goes across this connection then the amount of calls the link can handle is reduced down to 1. If 1 more call crosses the link then the resource is 0 and the link is full. Any calls trying to be placed cannot cross this link as the bandwidth does not exist to support the call.\r\nLinks between locations can support calls in any direction. So a link A B exists the call can go A to B or B to A. In some cases you might have a call that is going over this link as A B and another call going B A.</p>','A B 1\r\nB C 2\r\nC D 2\r\nD E 2\r\nE F 2\r\nF G 2\r\nG A 2\r\nE H 1\r\nH D 1\r\nA C\r\nA D\r\nA D\r\nF D\r\nB D\r\nB D\r\nB E\r\nC F','Call A C -- placed A B C\r\nCall A D -- placed A G F E D\r\nCall A D -- placed A G F E D\r\nCall F D -- failed\r\nCall B D -- placed B C D\r\nCall B D -- failed\r\nCall B E -- failed\r\nCall C F -- failed',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (8,'Caribbean',1,'Reverse Polish Calculator','<p>Reverse Polish notation (RPN) is a mathematical notation in which every operator follows all of its operands, in contrast to Polish notation, which puts the operator in the prefix position. It is also known as postfix notation and is parenthesis-free as long as operator arities are fixed.<p>\r\n<p>Your task is to calculate the result of a simple addition/subtraction equation in RPN</p>\r\n<p>An example equation and result in RPN is:</p>\r\n<pre>6\r\n10\r\n+</pre>\r\n<pre>16</pre>','<p>You will be given the equation with each value on a new line:</p>\r\n<pre>2\r\n5\r\n+</pre>','<p>Your output will simply be the result of the equation</p>\r\n<pre>7</pre>','<pre>6\r\n5\r\n-\r\n7\r\n+</pre>','8',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (9,'Caribbean',3,'String Transposition','<p>It can be helpful sometimes to rotate a string 90-degrees, like a big vertical \"SALES\" poster or your business name on vertical neon lights, like <a href=”https://i.imgur.com/766x8uM.jpg”>this image from Las Vegas</a>. Your goal is to write a program that does this, but for multiples lines of text. This is very similar to a Matrix Transposition, since the order we want returned is not a true 90-degree rotation of text.</p>','<p>You will first be given an integer N which is the number of strings that follows. N will range inclusively from 1 to 16. Each line of text will have at most 256 characters, including the new-line (so at most 255 printable-characters, with the last being the new-line or carriage-return).</p>\r\n<pre>1\r\nHello, World!</pre>\r\n<pre>5\r\nKernel\r\nMicrocontroller\r\nRegister\r\nMemory\r\nOperator</pre>','<p>Simply print the given lines top-to-bottom. The first given line should be the left-most vertical line.</p>\r\n<pre>H\r\ne\r\nl\r\nl\r\no\r\n,\r\n\r\nW\r\no\r\nr\r\nl\r\nd\r\n!</pre>\r\n<pre>KMRMO\r\neieep\r\nrcgme\r\nnrior\r\neosra\r\nlctyt\r\n oe o\r\n nr r\r\n t\r\n r\r\n o\r\n l\r\n l\r\n e\r\n r</pre>','7\nRed\nOrange\nYellow\nGreen\nBlue\nIndigo\nViolet','ROYGBIV\nererlni\ndaleudo\n nleeil\n gon ge\n ew  ot',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (10,'Mr. Murga.',9,'Information Exchange','We have a problem at Enflick. One of our content champions has gone camping and they forgot to send us the updated content for our about page. They only have their computer and enough juice in their phone to send between two and four text messages -- and there’s no Internet up there! ** nightmare **\r\n<br />\r\n<br />\r\nHow would you send the content?\r\n<br />\r\n<br />\r\n<strong>Original Content:</strong><br />\r\nFounded back in year by two University of Waterloo engineering students, our core products are now in the hands of more than 50 million users.\r\nTextNow, our free app, provides users with their own genuine number, which they can use to make free calls and texts across location.\r\n<br />\r\n<br />\r\n<b>Because you may come up with weird encodings, be sure to submit your answer in binary!</b>','The quick brown fox jumps over the lazy dog','In ASCII this string is, well, the same =). In binary, it is the following:\r\n<pre>\r\n01010100 01101000 01100101 00100000 01110001 01110101 01101001 01100011 01101011 00100000 01100010 01110010 01101111 01110111 01101110 00100000 01100110 01101111 01111000 00100000 01101010 01110101 01101101 01110000 01110011 00100000 01101111 01110110 01100101 01110010 00100000 01110100 01101000 01100101 00100000 01101100 01100001 01111010 01111001 00100000 01100100 01101111 01100111\r\n</pre>\r\n\r\nIn Base64:\r\n<pre>VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==</pre>\r\n\r\nCan this string be represented as a smaller string?','<p class=”code”>We provide a better alternative to traditional wireless plans and services.\r\n\r\nFounded back in 2009 by two University of Waterloo engineering students, our core products are now in the hands of more than 50 million users.\r\n\r\nTextNow, our free app, provides users with their own genuine ten-digit number, which they can use to make free calls and texts across Canada and the US.\r\n\r\nTextNow Wireless is the world’s first all-IP, cloud-based mobile phone carrier. All of our plans are ultra-affordable, contract-free, feature unlimited talk and text, and let customers use their number across different platforms.</p>','100110010001100111101011010110011010010111000001101000110111111100010101010000101111010001110110100001011010010001010001010011010001101010010111010101011100011100001010100010010101001000111011101001000010101100011101000011001101100111101110110000100011011010000100111001100110000101110011010010111110000011010010101001011100111011111101000101011100100111000001110011011111111000111110100111101100010010011000110011011111100111111000011010011101111111100111111101010100100010111001111100010000101001101000101101100010101010011111110010111110111010011001100010100001011111010101010111000001000011000001001000000001011001001000011000110011010100111011100000010010100110001110110010101110101111011111001011011000110011110101101011110001110111110101001101101000101100011001000101100100110001001001101010111100000110111100100001001110001101100101111101110001111010110110001101010111100100001001100011010101111110011000111100101110111101001001010100110011100110000101101101001010100101110011101001011100111011111101100000110111010001100100101100100001110110010101110101111011110110110000001101000011110011110001110110011110101101011001101001011100000011011001110011000010110110110100100001010101111001101010111100000001010111100101100100010011000110000000100011100010010000011010100000100011111111100001000110000010101011001000111000111111111110001011001110110100100111100001011111011110011010101111000001001111111011111010000100110011100110000110101001011100011111000100111100001101111011011000000110111110100011101111010110110100001001110011010100000011011101001101101000111110101101010110011011000110011110000100100011100100011010000100111001101010111100000110011111001001100001001010100101110011101001011100111011111101100000110111010001100100101100100110100110010010101100011101000011001101100010011011010101111000001101001000101101111101111000011010001111110101100110001011011011110100101011011010101101000111011110101111110111110110011010110011101101111101110101010111011100011111111111111000011000011100110001111010111111110010111010001100111101111000101010000011011111010001011101100100001011100101011001111101011101111011100101111101110010101110101111001111011101100001000110110100010110001100111011101101010111000011111110001111011111010101101111100100011111111110100000111011011111001010100101010111000111110101001111111111011011000000001110110111101000100010100111010110001100111001001110100100011110010101000011100110101010001110110011110110100001001110011010100000011011101000111011010000100111001101110100010101101111100111001101010010100111100010110110110011100110000110101011110000000101011110010001110001111111111100010111101000111110101101010110011011011100001011110111110100010110000100101011001111011101100010101111010101101100111101101001010',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (11,'Jake',1,'How To Prounounce Hex','<p>\n<pre>\nIf you watch the show silicon valley then you may already be fluent in hex, and for those who don\'t you will be fluent by the end of this challenge. Albeit slightly ridiculous silicon valley has come up with a way to pronounce hex. For this challenge you will be writing a program to translate plain hex to it\'s proper pronounciation. Below is a table showing the translation of each alphabetical hex value. Numeric values are represented by their existing english pronounciations\n\n0xA0	“Atta”\n0xB0	“Bibbity”\n0xC0	“City”\n0xD0	“Dickety”\n0xE0	“Ebbity”\n0xF0	“Fleventy”\n0xA000	\"Atta-bitey\"\n0xB000	\"Bibbity-bitey\"\n0xC000	\"City-bitey\"\n0xD000	\"Dickety-bitey\"\n0xE000	\"Ebbity-bitey\"\n0xF000	\"Fleventy-bitey\"\n\nExamples:\n---------------------\nInput: \n\"0xB3\"\n\nOutput:\n“bibbity-three”\n---------------------\nInput:\n\"0xE4\"\n\nOutput:\n“ebbity-four”\n</pre>\n</p>','<p><pre>0xA0C9</pre></p>','<p><pre>atta-bitey city-nine</pre></p>','0xD05C','dickety-bitey five-city',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (12,'Jake',1,'JSON Treasure Map','<p>\nJSON is a common standard used to represent data.\nToday that data represents a map. \nSomewhere inside each of the given input maps is a string value \"textnow\". \nFor this challenge you will write a program that is able to find the path \nthat leads to the string value \"textnow\". Your program will take in a json \nfile and will output the path to textnow. The format of the output will be \na comma separated list of the keys used (in order) to access the value textnow.\n</p>','<p>\n<pre>\n{\n    \"awesomeCompanies\": [\n        \"enflick\": {\n            \"founded\": 2009,\n            \"products\": [\n                \"touchMobile\",\n                \"textnow\"\n            ]\n        },\n        \"netflix\": {\n            \"founded\": 1997,\n            \"products\": [\n                \"netflix\"\n            ]\n        }\n\n    ]\n}\n</pre>\n</p>','<p>awesomeCompanies,enflick,products</p>','{\n	\"example\": {\n		\"answer\": \"textnow\"\n	}\n}','example,answer',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (13,'Jake',3,'Packing It All Up','<p> <pre> If you\'ve ever moved then you know the pain of packing. Instead of doing my own packing i\'m going to have you do it for me. I have a bunch of strings lying around and I need to pack them up in boxes. For this challenge you will need to write a program that can pack strings into boxes. Given a string, you will need to pack it into a box representing a valid rectangle. Note that spaces are not part of the rectangle as they can be added again once I unpack the box.  For this challenge the output should be a text file containing the rectangular representation of the input string.  In order to ensure accuracy on your results the boxes should be packed by putting the string  into the box starting in the top left, working accross each row first before moving to the second. The result you submit MUST use \"\\n\" to denote the start of a new row. NOTE: The output dimensions will be the square root of the number of characters in the input string. ie the input. ie the example below is 49 characters so the output will be 7 x 7.  See the example below. </pre> </p>','<p><pre>EVERYWHERE IS WITHIN WALKING DISTANCE IF YOU HAVE THE TIME</pre></p>','<p>\n<pre>\nVisual:\nEVERYWH\nEREISWI\nTHINWAL\nKINGDIS\nTANCEIF\nYOUHAVE\nTHETIME\n\nFor Submission:\nEVERYWH\\nEREISWI\\nTHINWAL\\nKINGDIS\\nTANCEIF\\nYOUHAVE\\nTHETIME\n</pre>\n</p>','ENFLICK IS THE BEST','ENFL\\nICKI\\nSTHE\\nBEST',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (14,'Jake',9,'The House That ASCII Built','<p>\n<pre>\nSometimes I think it would be really nice to have a sweet mansion,\nthen I realize I can\'t afford a sweet mansion. Instead, let\'s build\nour own sweet mansions, in ASCII!\n\nFor this challenge we will provide you with the blueprints to your\nnew ASCII mansion and you will need to translate it into the real deal\n\nHow to translate the blueprint:\n<ul>\n<li>The bottom line of asterisks (i.e. the \"bottom floor\"), will be one continous line of asterisks.</li>\n<li>All asterisks on lines except for the bottom line are guaranteed to have an asterisk directly below it. That is, there are no \"free hanging\" asterisks. So no balconies.</li>\n<li>The outline: the basic outline of the house. The outline is just the shape you get by replacing the asterisks by 3x5 boxes made of +\'s, -\'s and |\'s. (Edit: to make it more clear what I mean with \"outline\", read this comment)</li>\n</ul>\nEssentially, each asterisk is replaced by this structure:\n<br/>\n+---+\n|   |\n+---+\n\n<ul>\n<li>The roofs: Each asterisk that has no asterisk above it should have a roof over it. The roof is made of /, \\ and A characters. If there are two or more boxes next to each other which don\'t have any boxes above them, they should share a wider roof.\n</li>\n</ul>\n</pre>\n</p>','<pre>\n   *\n  ***\n******\n</pre>','<pre>\n              A\n             / \\\n    A     A +---+ A\n   / \\   / \\|   |/ \\\n  /   \\ +---+   +---+ A\n /     \\|           |/ \\\n+-------+           +---+\n|                       | \n+-----------------------+ \n</pre>',' *\n***\n***\n***\n***\n***\n***','      A\n     / \\\n  A +---+ A\n / \\|   |/ \\\n+---+   +---+\n|           |\n|           |\n|           |\n|           |\n|           |\n|           |\n|           |\n|           |\n|           |\n|           |\n|           |\n+-----------+',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (15,'Mr. Murga.',3,'<3 anagrams?','Find the set of anagrams that contains the most words.','#1\r\n<pre>\r\nsteal\r\ntale\r\ntales\r\nleast\r\nreaps\r\n</pre>\r\n\r\n#2\r\n<pre>\r\nalberta\r\nalberta\'s\r\nalbertan\r\nalbertans\r\nalberti\r\nalbertist\r\nalbertists\r\nalbertlea\r\nalbertlea\'s\r\nalberto\r\nalberto\'s\r\nalberton\r\nratable\r\n</pre>','#1\r\n<pre>\r\n(3 anagrams): steal, tales, least\r\n    because they can be formed with the common letters \'aelst\'\r\n(1 anagram): tale\r\n(1 anagram): reaps\r\n\r\nSo the answer would be:\r\nsteal, tales, least\r\n</pre>\r\n\r\n#2\r\n<pre>\r\nalberta, ratable\r\n</pre>','http://findwifi.website/list.txt','alerts, alters, artels, estral, laster, rastle, ratels, salter, slater, staler, stelar, talers, tarsel',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (16,'Jake',9,'Loopy Robots','<p>\n<pre>\nOur robot has been deployed on an infinite plane at position (0, 0) facing north. He\'s programmed to indefinitely execute a command string. Right now he only knows three commands\nS - Step in the direction he\'s currently facing\nR - Turn right (90 degrees)\nL - Turn left (90 degrees)\nIt\'s our job to determine if a command string will send our robot into an endless loop. (It may take many iterations of executing the command!) In other words, will executing some command string enough times bring us back to our original coordinate, in our original orientation.\nWell, technically he\'s stuck in a loop regardless.. but we want to know if he\'s going in a circle!\n\nYou will accept a command string of arbitrary length. A valid command string will only contain the characters \"S\", \"R\", \"L\" however it is not required that a command string utilizes all commands. Some examples of valid command strings are\nSLLLRLSLSLSRLSLLLLS\nRRL\nSLLLRLSLSLSRLSLLLLS\n\nBased on robot\'s behavior in accordance with a given command string we will output one of two possible solutions\n<ol>\n<li>\nThat a loop was detected and how many cycles of the command string it took to return to the beginning of the loop, specifically the string will be of the form: \"Loop detected in 4 cycles\", replacing X with the appropriate value\n</li>\n<li>\nThat no loop was detected and our precious robot has trudged off into the sunset, specifically the string will be:\n\"No Cycle Detected\"\n</li>\n</ol>\n</pre>\n</p>','SR','Loop detected in 4 cycles','LRLLR','No Cycle Detected',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (17,'Mr. Murga.',3,'Roman numerals!','Convert a number to roman numerals\r\n','#1\r\n<pre>\r\n5\r\n</pre>\r\n\r\n#2\r\n<pre>\r\n40\r\n</pre>\r\n\r\n','#1\r\n<pre>\r\nV\r\n</pre>\r\n\r\n#2\r\n<pre>\r\nXL\r\n</pre>','3251','MMMCCLI',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (18,'Mr. Murga.',1,'Insta-frame me!','Write a function that takes a list of strings an prints them, one per line and centered, in a rectangular frame.\r\n','<pre>\r\nHello\r\nWorld\r\nin\r\na\r\nframe\r\n</pre>','<pre>\r\n*********\r\n* Hello *\r\n* World *\r\n*  in   *\r\n*   a   *\r\n* frame *\r\n*********\r\n</pre>','<pre>\r\nSay\r\nHello\r\nTo\r\nMy\r\nLittle\r\nFriend!\r\n</pre>','***********\n*   Say   *\n*  Hello  *\n*   To    *\n*   My    *\n* Little  *\n* Friend! *\n***********',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (19,'Mr. Murga.',1,'What does poop and aibohphobia have in common?','Given a string, check whether it\'s a valid palindrome. You can skip characters such as \"\'\" and spaces (i.e. \"I\'m\" should be interpreted as \"Im\").','#1\r\n<pre>\r\nBob\r\n</pre>\r\n<br />\r\n#2\r\n<pre>\r\nCheck\r\n</pre>\r\n','#1\r\n<pre>\r\ntrue\r\n</pre>\r\n<br />\r\n#2\r\n<pre>\r\nfalse\r\n</pre>','<pre>\r\nTaco cat\r\n</pre>','true',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (20,'Mr. Murga.',1,'Curls, rounds, and squares','Given a string, check whether the parenthesis are valid.<br />\r\n<br />\r\nSet: [,],{,},(,).<br />\r\n<br />','#1\r\n<pre>\r\n{{]}}\r\n</pre>\r\n<br />\r\n#2\r\n<pre>\r\n{[({}[])]}\r\n</pre>\r\n','#1\r\n<pre>\r\nfalse\r\n</pre>\r\n<br />\r\n#2\r\n<pre>\r\ntrue\r\n</pre>','<pre>\r\n[{[({}[])]}{{[]}}]\r\n</pre>','true',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (21,'Mr. Murga.',1,'srettel gnisrever -- say what?!','Reversing letters in a sentence','<pre>\r\nThis is easy\r\n</pre>','<pre>\r\nysae si sihT\r\n</pre>\r\n','<p class=”code”>\r\nreverse letters in a string\r\n</p>','gnirts a ni srettel esrever',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (22,'Mr. Murga.',9,'A guessing game? Not exactly.','One of our programmers wrote this program that when provided a set of integers, it would map them to corresponding letters in the alphabet. Say [1,5,4] => [a, b, c].<br />\r\n<br />\r\nThen the program would iterate from 1 to X (i.e. say 20 or 30), and it would print out:<br />\r\n&nbsp;&nbsp;- a if the number is divisible by 1<br />\r\n&nbsp;&nbsp;- b if the number is divisible by 5<br />\r\n&nbsp;&nbsp;- etc.<br />\r\n<br />\r\nNumbers are never printed.<br />\r\n<br />\r\nExample:<br />\r\n<pre>\r\n2 5 4\r\n</pre>\r\n<br />\r\n<br />\r\nOutput: <br />\r\n<pre>\r\na\r\nac\r\nb\r\na\r\nac\r\nab\r\nac\r\na\r\nb\r\nac\r\na\r\nabc\r\na\r\n</pre>\r\n<br />\r\nAt 1, nothing is printed. At 2, a will be printed. At 8, a and c will be printed. At 7, nothing is printed. At 30, it\'ll output ab, etc.\r\n<br />\r\n<br />\r\nYou think this program is too easy, so here\'s the challenge: reverse it! Provided the final output, guess what the possible initial set is.<br />\r\n<br />\r\n<strong>Note: this program is non-deterministic, but select the first set that answers the question and that\'s the answer :). Also, the max boundary for the integer is 20.</strong>','#1\r\n<pre>\r\na\r\nb\r\na\r\na\r\nb\r\na\r\n</pre>\r\n\r\n#2\r\n<pre>\r\nb\r\nbe\r\nab\r\nbe\r\nb\r\nabe\r\nb\r\n</pre>','#1\r\nWell, since there\'s only \'a\' and \'b\', we can assume that there were only two integers in the input.\r\n<pre>\r\n3 5\r\n</pre>\r\n\r\n#2\r\nWell, since the letters go from \'a\' to \'e\' -- even if \'c\' and \'d\' don\'t appear, we can assume that there are five integers in the input\r\n<pre>\r\n3 1 8 8 2\r\n</pre>\r\n','a\r\nb\r\nc\r\nd\r\na\r\nabe\r\n','6 9 10 11 18',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (23,'Caribbean',1,'Vampire Numbers','<p>A vampire number v is a number v=xy with an even number n of digits formed by multiplying a n/2 2-digit numbers (where the digits are taken from the original number in any order) x and y together. Pairs of trailing zeros are not allowed. If v is a vampire number, then x and y are called its \"fangs.\"</p>','<p>Two digits on one line indicating n, the number of digits in the number to factor and find if it is a vampire number, and m, the number of fangs. Example:</p>\r\n<pre>4 2</pre>','<p>A list of all vampire numbers of n digits, you should emit the number and its factors (or \"fangs\"). Example:</p>\r\n<pre>1260=21*60\r\n1395=15*93\r\n1435=41*35\r\n1530=51*30\r\n1827=87*21\r\n2187=27*81\r\n6880=86*80</pre>','6 3','114390=41*31*90\r\n121695=21*61*95\r\n127428=21*74*82\r\n127680=21*76*80\r\n127980=20*79*81\r\n137640=31*74*60\r\n163680=66*31*80\r\n178920=71*90*28\r\n197925=91*75*29\r\n198450=81*49*50\r\n247680=40*72*86\r\n294768=46*72*89\r\n376680=73*60*86\r\n397575=93*75*57\r\n457968=56*94*87\r\n479964=74*94*69\r\n498960=99*84*60',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (24,'Caribbean',1,'Friendly Date Ranges','<p>The goal of this challenge is to implement a way of converting two dates into a more friendly date range that could be presented to a user. It must not show any redundant information in the date range. For example, if the year and month are the same in the start and end dates, then only the day range should be displayed. Secondly, if the starting year is the current year, and the ending year can be inferred by the reader, the year should be omitted also (see below for examples).</p>','<p>The input will be two dates in the YYYY-MM-DD format, such as:</p>\r\n<pre>2015-07-01 2015-07-04\r\n2015-12-01 2016-02-03\r\n2015-12-01 2017-02-03\r\n2016-03-01 2016-05-05\r\n2017-01-01 2017-01-01\r\n2022-09-05 2023-09-04</pre>','<p>The program must turn this into a human readable date in the Month Day, Year format (omitting the year where possible). These outputs correspond to the above inputs:</p>\r\n<pre>July 1st - 4th\r\nDecember 1st - February 3rd\r\nDecember 1st, 2015 - February 3rd, 2017\r\nMarch 1st - May 5th, 2016\r\nJanuary 1st, 2017\r\nSeptember 5th, 2022 - September 4th, 2023</pre>','2015-04-01 2020-09-10\r\n2015-12-11 2016-12-11\r\n2019-01-01 2019-01-01','April 1st, 2015 - September 10th, 2020\r\nDecember 11th, 2015 - December 11th, 2016\r\nJanuary 1st, 2019',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (25,'Caribbean',3,'Friendly Date Ranges Pt 2','<p>This question continues from the previous question: \'Friendly Date Ranges\'</p>\r\n<p>Of course, not all users will want to read a Month Day, Year format. To fix this, allow your program to receive hints on how to format the dates, by accepting a date format as a third parameter</p>','<pre>2015-07-01 2015-07-04 DMY\r\n2016-03-01 2016-05-05 YDM\r\n2022-09-05 2023-09-04 YMD</pre>','<pre>1st - 4th July\r\n2016, 1st March - 5th May\r\n2022, September 5th - 2023, September 4th</pre>','2015-04-01 2020-09-10 MDY\r\n2015-12-11 2016-12-11 YMD\r\n2019-01-01 2019-01-01 YMD','',0);
INSERT INTO `challenges` (`id`,`author`,`points`,`title`,`description`,`input`,`output`,`secret_input`,`secret_output`,`hidden`) VALUES (26,'Mr. Murga.',3,'A Wavy Word Snake','Do you remember playing this game? http://playsnake.org/.. yep, it\'s pretty addicting! *your welcome =) *<br />\r\n<br />\r\nLet\'s build a program that outputs the shape of a snake from the input provided.<br />\r\n<br />\r\nRules: \r\n&nbsp;- When drawing a snake, follow the shape of a wave (print to the right, downwards, to the right, and up -- then repeat!)<br />\r\n&nbsp;- Start the snake with the first word in the set','<pre>\r\ncomputer\r\ndesk\r\nkilo\r\noscar\r\nround\r\n</pre>','<pre>\r\ncomputer\r\n       o  oscar\r\n       u  l\r\n       n  i\r\n       desk\r\n</pre>','<pre>\r\ndouble\r\nedit\r\ntap\r\npasswords\r\nsir\r\n</pre>','       sir\n       d\n       r\n       o\n       w\ndouble s\n     d s\n     i a\n     tap',0);