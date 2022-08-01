import UIKit

//Classes are a bit like structs but differ in a couple of ways. The thing that is the most different is that they are reference type.
// Here is how to create a class

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

//Classes can also inherit from other classes
//Here we create a classe that as the init function. When we initiate the employee class or any inherited function we need to pass it the hours value
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    func printSummary()
    {
        print("This employee worked \(hours) this week")
    }
}

//Both following classes inherit from Employee. This lets the classes use the hours property whitout declaring it. They both use the same
class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

//Here we create instances of the two inherited classes. We need to give it the value for hours that is inherited from Employee. The work function uses that value to output in the console
let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()


//You can also change inherited methods. This is done with the override keyword. Here is an exempole

class Seller: Employee
{
    func work() {
        print("I'm selling for \(hours) hours.")
    }
    override func printSummary() {
        print("This function is overriden. This employee worked \(hours) hours this week.")
    }
}

let tigui = Seller(hours: 11)
tigui.work()
tigui.printSummary()

//You should also use final for classes. That makes them unmodifiable by a child until you decide to go and remove the final keyword

//The parent initializer must be called in the child initializer if it has one using the keyword super. If the child doesnt have an initializer, its going to inherit its parent initializer. Here is an exemple

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isConvertible: Bool, isElectric: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isConvertible: false, isElectric: true)


//Since classes are a reference type if you try to copy a class by doing User = User2 its just going to copy its reference. Both User are always going to be the same if we modify them. To copy them by value you just have to create a custom function. Here is how:

class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

//Now when we call the function copy its going to return a brand new user instance with the same values as the other one

//You can deinitialize classes which will get rid of its data in memory. They don't use the keyword func, they don't take parameters or return data, the deinit IS NEVER called manually, it is called automatically when the last instance of a class is destroyed. Instances of a class are destroyed when the scope end (ex: end of a loop, condition, parrat)  Struct don't have deinit because they are always unique (Value type vs reference type)

class User2 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

//There are 4 different ways Classes can be created in code

//Constant instance, constant property – a pointer that always points to the same user, who always has the same name.

//Constant instance, variable property – a pointer that always points to the same user, but their name can change.

//Variable instance, constant property – a pointer that can point to different users, but their names never change.

//Variable instance, variable property – a pointer that can point to different users, and those users can also change their names.
