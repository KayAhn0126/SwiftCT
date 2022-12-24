//
//  main.swift
//  CountingAlphabet
//
//  Created by Kay on 2022/12/24.
//

/*
#10808
 알파벳 개수
 */

// 1st week fast-campus
import Foundation

var alphabet = readLine()!

// 맵
var countArray = [Int](repeating: 0, count: 26)
for char in alphabet {
    countArray[Int(char.asciiValue!) - 97] += 1
}
countArray.enumerated().forEach {
    print($0.element, terminator: " ")
}

print("\n")

// 딕셔너리
var charArr = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n","o","p","q","r","s","t","u","v","w","x", "y", "z",]
var countDictionary: [String : Int] = [:]
for char in charArr {
    countDictionary[char] = 0
}

for char in alphabet {
    countDictionary[String(char)]! += 1
}

for char in charArr {
    print(countDictionary[String(char)]!, terminator: " ")
}
