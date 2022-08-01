import UIKit


//In swift null values need to be predictable. This has been implemented with the use of Optionals. Optionals are values that COULD be nil.

var username: String? = nil

if let username = username {
    print("We got a user: \(username)")
} else {
    print("The optional was empty.")
}

//if let run the code between the braces if there is a value in the optional. There is also a way to run code if there is no value in the optional (nil). This is done using guard let. Here is an exemple

var sheesh: String? = "nil"

func test(_ sheesh: String?)
{
    guard let sheesh = sheesh else{
        print("sheesh did not have a value")
        return
    }
    print("sheesh did have a value \(sheesh)")

}

test(sheesh)


//We can also uwrap optionals with the use of the ? operator. Here this code will put a String? containing nil into new. This is because there is no values with the key "Serenity" into the used dictionnary.

let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"]

//If we add our ? operator, we can put a default return value if our code returns nil. This tells the compiler that if the return of this is any optional return "N/A"

let new2 = captains["Serenity"] ?? "N/A"

//We can also verify if an optional returned by some code does not contain nil by adding ? after it. Here we check if randomElement() returns nil or something by adding ? after it (randomElement()?) If it is not nil then it will run the next code (.uppercased() in this case)

let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")


//If we want to handle errors without exactly knowing what happened we can use a try?. This will return nil if failed or the value we want

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

//This runs the getUser function. If it runs without throwing it returns the
let user = (try? getUser(id: 23)) ?? "Anon"
print("User: \(user)")

