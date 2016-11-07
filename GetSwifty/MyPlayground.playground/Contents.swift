//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//Basic Switch
let name = "bilbo"
let last = "cho"

switch (name, last) {
case ("bilbo", _):
    print("I'm from the shire")
    
case ("mandy", "cho"):
    print("I'm from Dallas")
    
default:
    print("Stranger")
}

// Now with tuples
let person = (name: "try", last: "hard")

switch person {
case ("bilbo", "baggin"):
    print("Try harder")
    
case ("mandy", let last):
    print("take care of yourself")
    
case ("try", "hard"):
    print("go to bed")
    fallthrough
    
default:
    print("Night!")
}

// Calculated tuples
func fizzbuzz(number number: Int) -> String{
    switch (number % 3 == 0, number % 5 == 0){
    case (true, true):
        return "fizzbuzz"
    
    case (true, false):
        return "fizz"
    
    case (false, true):
        return "buzz"
    
    default:
        return String(number)
    }
}

print(fizzbuzz(number: 15))


let mandy = (name: "mandy", last:"cho")
let paul = (name:"paul", last:"hudson")
let olive = (name: "bubs", last: "wubby")

let peoples = [mandy, paul, olive]










