import UIKit

///-------------------CLOSURES---------------------------

//A closure is  basically a function inside a variable or constant. In its most basic form it is declared like bellow

let driving = {
    print("I'm driving in my car")
}
//It then can be called like this :

driving()

//Closures can also have parameters. On the other hand they are not declared like in functions. They need to be added at the beggining of the braces like follows

let driving2 = { (place: String) in
    print("I'm going to \(place) in my car")
}
//They are then called the same way as normal functions

driving2("London")


//Closures can also return values with the return indicator -> String.

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//Here this is gonna call the closure with the parameter "London". After that its going to print the message constant
let message = drivingWithReturn("London")
print(message)

//You can also pass closures as function parameters. The only difference between a normal type parameter and a closure parameter is the way it is written in the function declaration.

//Closures are noted like this action: () -> Void
//action: is the name of the closure
//() parentheses just mentions its a closure with no parameters
//-> Void says it doesnt return anything

func travel(_ action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

//Here we use the driving closure as the "action" closure declared in the function previously

travel(driving)

//Trailing closure syntax let you add the code of the closure directly as code. ex:

travel {
    print("I'm driving in my car")
}

//We can also add parameters and return types to closures just like follows. The closure feeded to that function called action must have a string parameter. It returns nothing

func travel2(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

//it then can be called like this :

travel2 { (place:String) in
    print("I'm going to \(place) in my car")
}

//We can also declutter it by removing the parentheses and the type. Since in the function the type is mentionned there is no need to put it again:

travel2 { place in
    print("I'm going to \(place) in my car")
}


//Here is how to use a closure as a parameter when it returns a value and uses a parameter

func travel3(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel3 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//We can also declutter our function call like we did previously. The return type and the parameter are specified in the function declaration so Swift can figure out by it self

travel3 { place in
    return "I'm going to \(place) in my car"
}

//Swift lets us declutter even more if we want to. We can remove the variable and use incremetal variables. We add $ sign before numbers(0 to the number of parameters "travel3" requires. In this situation travel 3 requires only 1 string as the parameter for the closure. Swift is going to assign this parameter to the $0 value. If there was a second parameter it would be $1. We don't even need the return because the closure only has 1 line so Swift assumes that is what we will return.

travel3 {
    "I'm going to \($0) in my car"
}

//Here is an exemple with 2 parameters in the closure. Once again since there is only one parameter (Which is the closure) in the travel4 function we can really shorten our Swift code

func travel4(action: (String,Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London",50)
    print(description)
    print("I arrived!")
}

travel4{
    "Sheesh your \($0) with \($1) quids"
}

//A function can also return a closure. It uses two "->" symbols. First one indicates what the travel5 function returns (a closure that takes a string) and the second one indicates what the closure returns

func travel5() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

//Here result gets the closure. We can then execute result with the string parameter

let result = travel5()
result("London")

//Closures can capture variables and keep them inside them even if the variables don't exist anymore

func travel6() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
