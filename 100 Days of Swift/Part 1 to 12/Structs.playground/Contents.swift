import UIKit


//Struct in swift are declared as follows
struct Sport {
    var name: String
    var season: String
}

//This is how we created an instance of the tennis struct
var tennis = Sport(name: "Tennis", season: "Summer")


//The properties of a struct can also be computed as follows:

struct User
{
    var username: String
    var age: Int
    var password: String
    
    var uniqueIdentifier: String
    {
        return username + String(age)
    }
}
var thisUser = User(username: "Gabton", age: 24, password: "Bruhhh" )
print(thisUser.uniqueIdentifier)

//You can run code when a property is modified with the didSet. In this case this will print to the console everytime the property amount is set.

//It is also possible to do the same thing but with willset. This will run the code just before the property is set.

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

//You can add functions to a struct

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

//Struct are value type as opposed to Classes. This means that functions inside structs cannot modify by default their properties. To be able to do so functions need to be mutating. This can be done as follows

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
