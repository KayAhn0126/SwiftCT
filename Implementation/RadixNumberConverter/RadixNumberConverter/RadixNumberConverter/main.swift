//
//  main.swift
//  RadixNumberConverter
//
//  Created by Kay on 2023/06/19.
//

/*
 2745
 진법 변환
 */

import Foundation

let userInput = readLine()!.split(separator: " ").map { String($0) }
let tempString = userInput[0]
let tempRadix = Int(userInput[1])!

let strArr = Array(String(tempString.reversed()))
var total = 0
for i in 0..<strArr.count {
    var currentNumber = Int(strArr[i].asciiValue!)
    if 48 <= currentNumber && currentNumber <= 57 {
        currentNumber -= 48
        let tempNum = Int(pow(Double(tempRadix), Double(i)))
        total += tempNum * currentNumber
    } else {
        currentNumber -= 55
        let tempNum = Int(pow(Double(tempRadix), Double(i)))
        total += tempNum * currentNumber
    }
}
print(total)
