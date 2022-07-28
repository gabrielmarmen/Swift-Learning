import UIKit

///--------------------OPPERATORS--------------------------------

//You can Multiply, Divide, Add, Substract and Remainder with *, /, +, - and %

//You can add different types toghetter like arrays, int and strings

var string1 = "Swappin the b"
var string2 = "I'm all the way up"
var string1and2 = string1 + string2

var arrayOfBrands1 = ["Ford", "Toyota"]
var arrayOfBrands2 = ["Mercedes", "Ferrari"]
var arrayOfBrands1and2 = arrayOfBrands1 + arrayOfBrands2


//You can also use += and -= to do operations on a specific variable
//var -= 5 will substract 5 from var and save the result into var
//var += 5 will add 5 on var and save the result into var

var score = 95
score += 5 //This adds 5 to score and saves it into score

score = 95
score -= 5 //This adds 5 to score and saves it into score


//Comparaisons can be made with <, >, <=, <=, == or !=
//if strings are compared using < or > it will check the alphabetical order

var name1 = "Twitter"
var name2 = "Facebook"
var result = name2 < name1


//If statements can be done like this

if(name1 < name2)
{
    print("name1 is before name2")
}
else
{
    print("name2 is before name1")
}

//The ternary operator (?) returns what you want if the condition is true or false

print(name1 < name2 ? "name1 is before name2" : "name2 is before name1")


//Switch case exemple. Better to use switch case instead of multiple if, else if

var game = "EFT"

switch game {
case "EFT":
    print("Good Game")
case "GTA":
    print("Bad Game")
case "COD":
    print("Bad Game")
default:
    print("Bad Game")
}

//Switch can also use Range Operators
// 0..<50 checks if a value is from 0 up to 50 excluding 50
// 0...50 checks if a value is from 0 up to 50 including 50

let scoring = 85

switch scoring {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}


