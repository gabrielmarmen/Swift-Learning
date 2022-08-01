import UIKit
import Foundation

///---------------------------FUNCTIONS--------------------------

//This creates a function that prints the constant message
func printHelp() {
    let message = """
    Welcome to MyApp!

    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails
    """

    print(message)
}


//This is a function accepting a parameter of type Int called number. This fonction calculates the square of the number

func squareWithoutReturn(number: Int) {
    print(number * number)
}

//Here is the same function but now, it returns the value of the result. The "-> Int" specifies that the function returns a value of type Int

func squareWithReturn(number: Int) -> Int {
    return number * number
}

var result = squareWithReturn(number: 5)

//Functions can use two different names for parameters.
//One name for inside the function and one name for when you call it. This makes readability and logic in certain scenarios. to is the name for outside and name for inside.

func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Donald Trump")

//You can ommit the external parameter name using _ instead of adding a name

func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")

//Default parameters can be added to functions so that they behave in a certain way unless we assign a different value to that parameter. Here the value nicely is by default assigned with true. if we change it to false it will take a different path 

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

//Function can be variadic. This means we can pass infinite quantity of the same type. Int... is converted in a array inside the function so it can be looped through

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1,2,3,4,5)


//Functions can throw errors when you add the throws keyword
//We use a Enum to have every error types

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

//Here we use the keyword do try and catch to handle possible errors. We use the do keyword for part of code that could be problematic. We use try because the function could throw an error. if the code throws an error the code under catch will execute

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

//inout can be used to specify that a parameter should be used as a reference. This way when the value of the parameter is changed it will be reflected in the original caller value. You need to use & before the variable when you call that function


func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
