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
var resultSet = Set<String>()

for i in 0..<count {
    var tempString = ""
    for j in i..<count {
        tempString += userInput[j]
        resultSet.insert(tempString)
    }
}
print(resultSet.count)
