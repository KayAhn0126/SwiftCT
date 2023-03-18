//
//  main.swift
//  MathHomeworkAgain
//
//  Created by Kay on 2023/03/18.
//

/*
 2870
 수학숙제
 */

import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

var testCase = Int(readLine()!)!

// 003 012 000
func removeZero(_ temp: String) -> String {
    var tempString = temp
    while tempString.hasPrefix("0") == true && tempString.count > 1 {
        tempString.removeFirst()
    }
    return tempString
}

var arr: [String] = []
for i in 0..<testCase {
    var tempString = readLine()!
    var numberString = ""
    for j in 0..<tempString.count {
        if 48 <= Int(tempString[j]!.asciiValue!) &&  Int(tempString[j]!.asciiValue!) <= 57 {
            numberString += String(tempString[j]!)
        } else {
            if !numberString.isEmpty {
                arr.append(removeZero(numberString))
            }
            numberString = ""
        }
    }
    if !numberString.isEmpty {
        arr.append(removeZero(numberString))
    }
}

arr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
}).forEach {
    print($0)
}
