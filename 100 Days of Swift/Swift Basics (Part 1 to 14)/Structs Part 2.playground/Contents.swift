import UIKit


//It is really important to apply access control to our code. In swift in can be achieved with the following words:
//private : Makes a variable private outside a struct
//fileprivate : Makes a variable private ouside of the current file
//public : Makes the variable public to everyone
//private(set) : Makes a variable public only for read

//Here is some code to demonstrate that

struct BankAccount {
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

//In the previous code, we make the variable funds read only so that the only way to modify it would be through the functions inside the struct.

//Static properties can be really useful when you want to have some info without having to have an instance of a struct (ex: Version, Json Paths, Default values). They are also accessible all across your application Bellow are exemples

//Application data always accessible by calling AppData.version, AppData.saveFilename, etc)
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

//You can access a default instance of a employee by calling Employee.exemple
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}
