//
//  main.swift
//  Coin0
//
//  Created by Kay on 2023/05/08.
//

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
var K = NK[1]

var arr = [Int]()

for _ in 0..<N {
    arr.append(Int(readLine()!)!)
}
arr.reverse()

var result = 0
for money in arr {
    while K >= money {
        K -= money
        result += 1
    }
}
print(result)
