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
