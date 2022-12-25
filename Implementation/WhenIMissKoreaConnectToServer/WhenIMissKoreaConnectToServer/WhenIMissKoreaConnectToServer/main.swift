//
//  main.swift
//  WhenIMissKoreaConnectToServer
//
//  Created by Kay on 2022/12/25.
//

/*
 9996
 한국이 그리울 땐 서버에 접속하지
 */

// 1st week fast-campus
import Foundation

var number = Int(readLine()!)!
var pattern = readLine()!
var starIndex = pattern.firstIndex(of: "*")!
var checkArr: [String] = []

for _ in 0..<number {
    checkArr.append(readLine()!)
}


let startString = String(pattern[pattern.startIndex..<starIndex])
let endString = String(pattern[pattern.index(after: starIndex)...pattern.index(before: pattern.endIndex)])

checkPattern(checkArr, startString: startString, endString: endString)
