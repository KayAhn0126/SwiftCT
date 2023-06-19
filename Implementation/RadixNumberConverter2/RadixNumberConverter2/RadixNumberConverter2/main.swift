//
//  main.swift
//  RadixNumberConverter2
//
//  Created by Kay on 2023/06/19.
//

/*
 11005
 진법 변환 2
 */
import Foundation

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
var tempNum = userInput[0]
let tempRadix = userInput[1]

var result = ""
while tempNum != 0 {
    let num = tempNum % tempRadix
    if num < 10 { result += String(num) }
    else { result += String(UnicodeScalar(num-10+65)!) }
    tempNum /= tempRadix
}
print(String(result.reversed()))
