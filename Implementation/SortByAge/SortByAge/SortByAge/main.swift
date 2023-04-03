//
//  main.swift
//  SortByAge
//
//  Created by Kay on 2023/04/03.
//

/*
 10814
 나이순 정렬
 */

import Foundation

let number = Int(readLine()!)!
// 들어온 순서: (나이: 이름)
var dictionary: [Int: (Int, String)] = [:]
for i in 0..<number {
    let userInput = readLine()!.split(separator: " ").map { String($0) }
    let age = Int(userInput[0])!
    let name = userInput[1]
    dictionary[i] = (age, name)
}

dictionary.sorted(by: {
    if $0.value.0 == $1.value.0 {
        return $0.key < $1.key
    }
    return $0.value.0 < $1.value.0
}).forEach {
    print("\($0.value.0) \($0.value.1)")
}
