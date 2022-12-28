//
//  main.swift
//  Multiply
//
//  Created by Kay on 2022/12/28.
//

/*
#1629
 곱셈
 */

// 1st week fast-campus
import Foundation

func numberTheory(_ a: Int, _ b: Int) -> Int {
    if b == 1 {
        return a % C
    }
    result = numberTheory(a, b / 2)
    result = (result * result) % C
    
    if b % 2 == 1 {
        result = (result * a) % C
    }
    return result
}

let userInput = readLine()!.split(separator: " ").map { Int($0)! }
let A = userInput[0]
let B = userInput[1]
let C = userInput[2]
var result = 1

print(numberTheory(A, B))

