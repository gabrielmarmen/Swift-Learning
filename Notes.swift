//Tags : Integrating UIKit views in Swift UI, UIViewController, UIKitViewController


//Tags: Getting documents URL, documents path, documents URL, local storage, get documents path

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}

//Tags: Writting to local documents, Saving to local documents, 

let str = "Test Message"
//Adding the name of the file at the end of the local documents path
let url = ().appendingPathComponent("message.txt")

do {
    try str.write(to: url, atomically: true, encoding: .utf8)
    //Gets the content of the newly written file into a String and prints it out to know if everything went fine
    let input = try String(contentsOf: url)
    print(input)
} catch {
    print(error.localizedDescription)
}

//Tags: FaceID, TouchID

func authenticate() {
    let context = LAContext()
    var error: NSError?

    // check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        // it's possible, so go ahead and use it
        let reason = "We need to unlock your data."

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            // authentication has now completed
            if success {
                // authenticated successfully
            } else {
                // there was a problem
            }
        }
    } else {
        // no biometrics
    }
}