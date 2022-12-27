//
//  main.swift
//  FashionKing
//
//  Created by Kay on 2022/12/27.
//

/*
 9375
 패션왕 신해빈
 */
// 1st week fast-campus

import Foundation

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let kinds = Int(readLine()!)!
    var map: [String : Int] = [:]
    var result = 1
    for _ in 0..<kinds {
        let products = readLine()!.split(separator: " ").map { String($0) }
        let category = products[1]
        if let _ = map[category] {
            map[category]! += 1
        } else {
            map[category] = 1
        }
    }
    map.enumerated().forEach {
        result *= $0.element.value + 1
    }
    print(result-1)
}
