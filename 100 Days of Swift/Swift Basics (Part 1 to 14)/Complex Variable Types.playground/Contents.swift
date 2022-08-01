import UIKit

let John = "John Lennon"
let George = "George Clooney"
let Mother = "Myriam"
let Father = "Luc"

///-----------------------------ARRAYS---------------------------------------

//Creates an Array
let GroupOPeople = [John, George, Mother, Father]

//Enumerates through the array
//Arrays have a order and can be looked through with an index
GroupOPeople[0]
GroupOPeople[1]
GroupOPeople[2]
GroupOPeople[3]


///-----------------------------SETS---------------------------------------

//Sets are created from an array
//Set don't have any specific order
//Each items need to be unique
let SetOPeople = Set(GroupOPeople)
//They are created using an array
let SetOPeople2 = Set(["Paul", "Christen", "Julius"])


///-----------------------------TUPLES---------------------------------------

//Creates a Tuple with 3 values
//firstName:, lastName: and age: acts a names for the values
//Types can't be changed, values can
var TuplePerson = (firstName: "Gabriel", lastName: "Marmen", age: 24)

//Accessing each values of the tuple by their names
TuplePerson.firstName
TuplePerson.lastName
TuplePerson.age

//Accessing each value by their index
TuplePerson.0
TuplePerson.1
TuplePerson.2


///-----------------------------DICTIONNARIES---------------------------------------

//Dictionnairies are like arrays but use a Key that identifies them
//Very fast to find

//Declaring a Dictionnary
var Heights = ["Gabriel Marmen": 1.72, "Donald Trump": 1.52]

//Reading the values of the dictionnary
Heights["Gabriel Marmen"]
Heights["Donald Trump"]
//This sets a default return value in case the "key" isnt found
Heights["Joe Biden", default: 0]


///-----------------------------EMPTY COLLECTIONS----------------------------------

//Empty Array of strings
var emptyArray = [String]()

//Empty Dictionnary with a key of type String and a value of type Int
var emptyDictionnary = [String: Int]()

//Empty Set
var emptySet = Set<String>()


///-----------------------------ENUMS---------------------------------------

//Enums are basically a nice name for a value
//They should be used by exemple for a short list of things
//Ex: Days of the week
//Here is an enum for directions

enum Direction{
    case West
    case North
    case East
    case South
}

Direction.East

//Possible to add associated value to an Enum option
//This puts more information about the specific enum

enum Activity {
    case Running(speed: Double)
    case Walking(destination: String)
    case Idle
    case Eating(foodType: String)
}

var Running = Activity.Running(speed: 15)
var Walking = Activity.Walking(destination: "To the Park")

//Enum raw values can be added automatically

enum Planet: Int {
    case Mars
    case Venus
    case BruhLand
}

var BruhLand = Planet(rawValue: 2)
