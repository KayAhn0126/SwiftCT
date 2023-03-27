//
//  main.swift
//  AddingParenthesis
//
//  Created by Kay on 2023/03/27.
//

/*
 16637
 괄호 추가하기
 */

/*
 숫자와 연산자 분리하기
 괄호가 하나도 없어도 되고, 제한도 없다. 다만 겹치지만 않으면 된다.
 일반 계산처럼 왼쪽부터 계산해야한다.
 3 + 8 * 7
    1. (3 + 8) * 7 -> 77
    2. 3 + (8 * 7) -> 59

 */
import Foundation

let number = Int(readLine()!)!

var line = readLine()!.map { String($0) }
var numberArr = [Int]()
var operatorArr = [Character]()

for i in 0..<line.count {
    if i % 2 == 0 {
        numberArr.append(Int(line[i])!)
    } else {
        operatorArr.append(Character(line[i]))
    }
}

func calculate(_ num1: Int, _ oper: Character, _ num2: Int) -> Int {
    if oper == "+" { return num1 + num2 }
    if oper == "-" { return num1 - num2 }
    if oper == "*" { return num1 * num2 }
    return 0
}

var result = Int.min
func go(_ currentIdx: Int, _ number: Int) {
    if currentIdx == numberArr.count - 1 {
        result = number > result ? number : result
        return
    }
    go(currentIdx + 1, calculate(number, operatorArr[currentIdx], numberArr[currentIdx + 1]))
    if currentIdx + 2 <= numberArr.count - 1 {
        let backSideCalculation = calculate(numberArr[currentIdx + 1], operatorArr[currentIdx + 1], numberArr[currentIdx + 2])
        go(currentIdx + 2, calculate(number, operatorArr[currentIdx], backSideCalculation))
    }
}

go(0, numberArr[0])
print(result)
