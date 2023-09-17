//
//  main.swift
//  Anagram
//
//  Created by Kay on 2023/09/14.
//

/*
 6443
 애너그램
 */

import Foundation

var num = Int(readLine()!)!
var result = [String]()

while num > 0 {
    let strArr = readLine()!.map { $0 }
    let count = strArr.count
    var countingArr = [Int](repeating: 0, count: 26)
    for char in strArr {
        countingArr[Int(char.asciiValue!) - 97] += 1
    }
    
    func getAnagram(_ currentStr: String) {
        if currentStr.count == count {
            result.append(currentStr)
            return
        }
        for i in 0..<26 {
            if countingArr[i] > 0 {
                countingArr[i] -= 1
                getAnagram(currentStr + "\(UnicodeScalar(i+97)!)")
                countingArr[i] += 1
            }
        }
    }
    getAnagram("")
    num -= 1
}

for i in result {
    print(i)
}
