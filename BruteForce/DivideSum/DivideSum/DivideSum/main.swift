//
//  main.swift
//  DivideSum
//
//  Created by Kay on 2023/02/27.
//

import Foundation

let userInput = Int(readLine()!)!

func getSumOfPieces(_ num: Int) -> Int {
    var testNum = num
    var result = num
    while testNum >= 10 {
        result += testNum % 10
        testNum /= 10
    }
    result += testNum
    return result
}

var flag = false
var result = 0
for i in 1...userInput {
    if flag == false {
        if userInput == getSumOfPieces(i) {
            flag = true
            result = i
            break
        }
    }
}
print(result)

