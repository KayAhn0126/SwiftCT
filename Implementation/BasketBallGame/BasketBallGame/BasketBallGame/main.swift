//
//  main.swift
//  BasketBallGame
//
//  Created by Kay on 2022/12/25.
//

/*
#1159
 농구 경기
 */

// 1st week fast-campus
import Foundation

var playersCount = Int(readLine()!)!
var playerArray = [Int](repeating: 0, count: 26)
var resultString = ""

for _ in 0 ..< playersCount {
    playerArray[Int((readLine()!.first!.asciiValue)!) - 97] += 1
}

for index in 0 ..< 26 where playerArray[index] >= 5 {
    resultString += String(UnicodeScalar(index + 97)!)
}

if resultString.isEmpty {
    print("PREDAJA")
} else {
    print(resultString)
}
