//: Playground - noun: a place where people can play

import UIKit

func fibonacci(num: Int) -> Int {
    if num < 2 {
        return num
    }
    else {
        return (fibonacci (num-1) + fibonacci(num-2))
    }
}


let fibSequence = (0...100).lazy.map(fibonacci)
print(fibSequence[2])
print(fibSequence[9])