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
//Tags: Image Picker, PHPickerViewController, UIKit integration in SwiftUI
//The following code will detail the integration of a UIKit ViewController in our SwiftUI environement

//We are here creating a new Swift file with the following code

import PhotosUI
import SwiftUI

//Here we are using a conformance to UIViewControllerRepresentable. This also conforms to View
//This conformance lets us use this struct in our SwiftUI code as a normal SwiftUI View
struct ImagePicker: UIViewControllerRepresentable {
//This struct binds to a UIImage that will be present in our 
    @Binding var image: UIImage?
	
	//This is the first requirement of our conformance to UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}














