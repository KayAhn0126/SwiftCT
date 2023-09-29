//
//  main.swift
//  AntSequence
//
//  Created by Kay on 2023/09/29.
//

/*
 28292
 개미 수열
 */

/*
 접근방법:
    
 */
import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

var num = Int(readLine()!)!

var temp = "1"

while num > 1 {
    var localTemp = ""
    var localCount = 1
    var last = temp[0]!
    let currentTempStrCount = temp.count
    for i in 1..<currentTempStrCount {
        let currentChar = temp[i]!
        if currentChar == last {
            localCount += 1
        } else {
            localTemp = localTemp + String(last) + String(localCount)
            last = currentChar
            localCount = 1
        }
    }
    localTemp = localTemp + String(last) + String(localCount)
    temp = localTemp
    num -= 1
}
print(temp)
let result = temp.max()!
print(result)
