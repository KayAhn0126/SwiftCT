//
//  main.swift
//  ROT13
//
//  Created by Kay on 2023/02/01.
//

/*
 11655
 ROT13
 */

import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let userInput = readLine()!

var result = ""

for i in 0..<userInput.count {
    if 65 <= Int(userInput[i]!.asciiValue!) && Int(userInput[i]!.asciiValue!) <= 90 {
        if Int(userInput[i]!.asciiValue!) + 13 > 90 {
            result += String(UnicodeScalar(Int(userInput[i]!.asciiValue!) - 13)!)
        } else {
            result += String(UnicodeScalar(Int(userInput[i]!.asciiValue!) + 13)!)
        }
    } else if 97 <= Int(userInput[i]!.asciiValue!) && Int(userInput[i]!.asciiValue!) <= 122 {
        if Int(userInput[i]!.asciiValue!) + 13 > 122 {
            result += String(UnicodeScalar(Int(userInput[i]!.asciiValue!) - 13)!)
        } else {
            result += String(UnicodeScalar(Int(userInput[i]!.asciiValue!) + 13)!)
        }
    } else {
        result += String(userInput[i]!)
    }
}
print(result)



