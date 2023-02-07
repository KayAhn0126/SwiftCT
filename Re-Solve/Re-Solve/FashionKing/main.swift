//
//  main.swift
//  FashionKing
//
//  Created by Kay on 2023/02/07.
//

/*
 9375
 패션왕 신해빈
 */
import Foundation

let total = Int(readLine()!)!

for _ in 0..<total {
    var dictionary: [String: Int] = [:]
    let count = Int(readLine()!)!
    for _ in 0..<count {
        let userInput = readLine()!.split(separator: " ")
        if dictionary["\(userInput[1])"] == nil {
            dictionary["\(userInput[1])"] = 2
        } else {
            dictionary["\(userInput[1])"]! += 1
        }
    }
    var result = 1
    dictionary.enumerated().forEach {
        result *= $0.element.value
    }
    print(result - 1)
}

// 8분 10초
