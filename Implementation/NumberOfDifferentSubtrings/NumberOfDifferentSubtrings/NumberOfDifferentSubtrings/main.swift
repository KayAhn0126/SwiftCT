//
//  main.swift
//  NumberOfDifferentSubtrings
//
//  Created by Kay on 2023/06/03.
//

/*
 11478
 서로 다른 부분 문자열의 개수
 */

import Foundation

let userInput = readLine()!.map { String($0) }

let count = userInput.count
var resultArr = [String]()

for i in 1...count {
    for j in 0...count-i {
        var tempStr = ""
        for k in j..<j+i {
            tempStr += userInput[k]
        }
        resultArr.append(tempStr)
    }
}
print(Set(resultArr).count)
