//
//  main.swift
//  MathHomework
//
//  Created by Kay on 2023/01/06.
//

/*
 2870
 수학 숙제
 */
// 2nd week fast campus

extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

import Foundation

let N = Int(readLine()!)!
var numberArr: [String] = []

func removeZero(_ temp: String) -> String {
    var newString = temp
    while newString.hasPrefix("0") {
        if newString.count == 1 {
            break
        }
        newString.removeFirst()
    }
    return newString
}

func checkString(_ temp: String) {
    var gatherString = ""
    for i in 0..<temp.count {
        let currentNumber = temp[i]!.asciiValue! - 48
        if 0 <= currentNumber && currentNumber <= 9 {
            gatherString += String(currentNumber)
        } else {
            if !gatherString.isEmpty {
                numberArr.append(removeZero(gatherString))
                gatherString = ""
            }
        }
    }
    if !gatherString.isEmpty {
        numberArr.append(removeZero(gatherString))
    }
}

for i in 0..<N {
    let temp = readLine()!
    checkString(temp)
}
numberArr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
}).forEach {
    print($0)
}
