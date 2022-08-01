import UIKit


//protocols lets us declare variables, constants and method that need to be defined in a future struct, class, enum, etc that is going to be based on it.

//Opaque return type lets us set a protocol as the return type and swift will accept any returns that are based on this protocol. For exemple we could use some Equatable as a return type
//Here Swift will understand that the value returned is based on "Some Equatable". So it will accept any value returned that is based on an equatable.

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}


//Extensions lets us add functions to any existing type. For exemple we can add a function to the type String that trims white spaces. Thats how we would write it

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

//Now, on any strings, we can call the trimmed function like this

let myString: String = "  Sheesh  "
var mutableString: String = "  Sheeesh  "

let trimmedString = myString.trimmed()

//Since extensions add functions directly to an existing type, you can affect internal values of the class or struct. For exemple you can add a mutating function to String that will apply to self.

extension String {
    mutating func trim() {
        self = self.trimmed()
    }
}

print (mutableString)
mutableString.trim()
print(mutableString)


//Extensions can also be variables. The only rule is that they are computed variables. here is an exemple

extension String
{
    var lines: Int {
        self.components(separatedBy: .newlines).count
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines)

//We can also add extensions to protocols. Here we add the computed property called "isNotEmpty" to the Swift default protocol called Collection. This will then apply to all collections(Arrays, Dictionnaries, Sets)

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty{
    print("Guest count: \(guests.count)")
}
