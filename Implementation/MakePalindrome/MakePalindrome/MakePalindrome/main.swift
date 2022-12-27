//
//  main.swift
//  MakePalindrome
//
//  Created by Kay on 2022/12/27.
//

/*
 1213
 팰린드롬 만들기
 */
// 1st week fast-campus
import Foundation

var userInput = readLine()!
var countingArr = [Int](repeating: 0, count: 26)
var resultStr = ""
var centerChar = ""
var checkCount = 0
userInput.enumerated().forEach {
    countingArr[Int($0.element.asciiValue!) - 65] += 1
}

countingArr.enumerated().reversed().forEach {
    if $0.element % 2 == 1 {
        checkCount += 1
        centerChar = String(UnicodeScalar($0.offset + 65)!)
        countingArr[$0.offset] -= 1
    }
    if $0.element > 0 {
        for _ in stride(from: 0, to: $0.element/2, by: 1) {
            let currentChar = String(UnicodeScalar($0.offset + 65)!)
            resultStr =  currentChar + resultStr
            resultStr += currentChar
        }
    }
}

if checkCount >= 2 {
    print("I'm Sorry Hansoo")
} else {
    let middleIndex = resultStr.count / 2
    if !centerChar.isEmpty {
        resultStr.insert(Character(centerChar), at: resultStr.index(resultStr.startIndex, offsetBy: middleIndex))
    }
    print(resultStr)
}
