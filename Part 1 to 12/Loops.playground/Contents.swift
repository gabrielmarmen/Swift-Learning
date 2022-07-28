import UIKit

///-------------------FOR LOOP--------------------------------

let count = 1...5

for number in count
{
    print("Number is \(number)")
}


let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

//Use an underscore when not using the value in the for loop
print("Players gonna ")

for _ in 1...5 {
    print("play")
}

///------------------- WHILE --------------------------------
///
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Count to 20 done")

number = 1

///------------------- REPEAT --------------------------------
//Repeat loop are like do while loop in c#.
//Verification si done at the end instead of at first
repeat {
    print(number)
    number += 1
} while number <= 20
print("Count to 20 done")


//You can break any loop with the break key word. Ex:
var countDown = 10
while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}

//If you wanna break from a nested loop you need to name the loop you wanna exit. In the next exemple we exit the outerLoop by calling break outerLoop

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

//You can also skip an item in a for loop

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}

//Infinite loops are made with a while loop with condition true

var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}
