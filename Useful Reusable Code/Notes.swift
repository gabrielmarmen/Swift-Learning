//Tags : Integrating UIKit views in Swift UI, UIViewController, UIKitViewController

===============================================================================================================================================
//Tags: Getting documents URL, documents path, documents URL, local storage, get documents path

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}
===============================================================================================================================================
//Tags: Writting to local documents, Saving to local documents, 
//The next code Writes a string ("Test Message") to a file in the local documents 

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
===============================================================================================================================================
//Tags: FaceID, TouchID, Biometrics
//Authenticating with Biometrics
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
                // authenticated successfully. You can set a State Bool from here to define that it was successful
            } else {
                // there was a problem
            }
        }
    } else {
        // no biometrics
    }
}
===============================================================================================================================================
//Tags: Accessibility, Accessibility Label,  Accessibility Value,  VoiceOver
//Here are Views Modifiers to modify or add accessibility values. This affects VoiceOver

//This adds a Trait to a View. This one is going to be seen as a Button View from now on.
.accessibilityAddTraits(.isButton)

//This removes  a Trait from a View. The View with this modifier will not be treated as an Image from now on
.accessibilityRemoveTraits(.isImage)

//This adds a Label to a SwiftUI View. This message will be read by VoiceOver instead of the content of the view
.accessibilityLabel(labels[selectedPicture])

//This removes accessibility from a View. When clicked Voice Over won't read anything anymore
.accessibilityHidden(true)

//This VStack has it's children ignored. Every children won't be read by VoiceOver anymore. The new Label will be used instead.
VStack {
    Text("Your score is")
    Text("1000")
        .font(.title)
}
.accessibilityElement(children: .ignore)
.accessibilityLabel("Your score is 1000")

//This will set a Views Accessibility Value. 
//Then will read any AjustableAction done on the view(Ex. swipe up will pass .increment as the direction variable). 
//Every time an action is done it will re read the modified value

.accessibilityValue(String(value)) 
.accessibilityAdjustableAction { direction in
    switch direction {
    case .increment:
        value += 1
    case .decrement:
        value -= 1
    default:
        print("Not handled.")
    }
}

===============================================================================================================================================
//Tags: Image Picker, PHPickerViewController, UIKit integration in SwiftUI, Image Saver, Save Image
//See the Swift File named ImagePicker.swift for a wrapped PHPickerViewController
//See the Swift File name ImageSaver.swift for Saving images to library

================================================================================================================================================
//Tags: Local documents directory, repertory, documents URL
//This lets us get the users local directory. 
func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // just send back the first one, which ought to be the only one
    return paths[0]
}
================================================================================================================================================
//Tags: Local Notification, Notifications
//The following code shows how to request notifications permissions using UNUserNotificationCenter. This needs us to import UserNotifications

//Calls the method requestAuthorization of the current UserNotificationCenter. 
//Options are used to select the right privileges. 
//This method takes a closure with a success and error parameters. We can use those to verify if the Authorization was successful or not and act accordingly
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
    if success {
        print("All set!")
    } else if let error = error {
        print(error.localizedDescription)
    }
}

//This code creates a notification request using some content, an Identifier and a trigger

//We first create an instance of UNMutableNotificationContent() that will contain out content
let content = UNMutableNotificationContent()
//Here we set the content's values (Title, Subtitle and Sound
content.title = "Feed the cat"
content.subtitle = "It looks hungry"
content.sound = UNNotificationSound.default

// Now we create our trigger. This exemple uses an instance of UNTimeIntervalNotificationTrigger that takes a time interval (Int) and specifies if it repeats
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

//Here we use an Instance of UNNotificationRequest that will be sent to the notificationCenter
//Its initializer takes 3 parameters as mentionned previously : 
//1. An Identifier : simple UUID
//2. The content : an instance of UNMutableNotificationContent that was defined previously
//3. The trigger : an instance of UNTimeIntervalNotificationTrigger that was also defined previously
let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

// add our notification request
UNUserNotificationCenter.current().add(request)

================================================================================================================================================
//Tags: Saving Data, Loading Data, UserDefaults, ForKey

//This is a custom init that loads data if existing or create a new array if this data doesnt exist in UserDefaults
init() {
    //We first test if our data can be loaded from the userDefaults with the key "SavedData" (Our future save function will save our array under that key)
    if let data = UserDefaults.standard.data(forKey: "SavedData") {
        //We then try to decode from that data to this type : [Prospect].self
        if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
            //If it is successfuly decoded, it puts our array into the "people" property
            people = decoded
            return
        }
    }
    //If all fails, we return an empty array (This is how it will act on a first boot of the app because there is no data
    people = []
}

//This is a custom Save function that we will run everytime something is modified in our array.
func save() {
    //We first try to encode our array
    if let encoded = try? JSONEncoder().encode(people) {
        //If encoding works, we save to our UserDefaults using the Key SavedData
        UserDefaults.standard.set(encoded, forKey: "SavedData")
    }
}









