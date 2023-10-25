//
//  main.swift
//  Ship
//
//  Created by Kay on 2023/10/25.
//

/*
 1092
 배
 */

import Foundation

let N = Int(readLine()!)!

let craine = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted(by: >)
let boxes = Int(readLine()!)!

var boxesArr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted(by: >)

if craine[0] < boxesArr[0] {
    print(-1)
} else {
    var result = 0
    while !boxesArr.isEmpty {
        for i in 0..<craine.count {
            let currentLimitWeight = craine[i]
            for j in 0..<boxesArr.count {
                if currentLimitWeight >= boxesArr[j] {
                    boxesArr.remove(at: j)
                    break
                }
            }
        }
        result += 1
    }
    print(result)
}
