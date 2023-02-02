//
//  main.swift
//  WhenIMissKoreaConnectToServer
//
//  Created by Kay on 2023/02/02.
//

/*
 9996
 한국이 그리울 땐 서버에 접속하지
 */

import Foundation

func checkPattern(_ testString: String) {
    if testString.hasPrefix(prefixString) && testString.hasSuffix(suffixString) && testString.count >= standard {
        print("DA")
    } else {
        print("NE")
    }
}

let userInput = Int(readLine()!)!
let patternString = readLine()!

let starIndex = patternString.firstIndex(of: "*")!
let prefixString = String(patternString[patternString.startIndex..<starIndex])
let suffixString = String(patternString[patternString.index(after: starIndex)..<patternString.endIndex])
let standard = prefixString.count + suffixString.count

for _ in 0..<userInput {
    let testString = readLine()!
    checkPattern(testString)
}

