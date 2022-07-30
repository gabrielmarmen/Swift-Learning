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
