//
//  main.swift
//  SortInside
//
//  Created by Kay on 2023/04/11.
//

/*
 1427
 소트인사이드
 */

import Foundation

let num = readLine()!

var arr = [Int](repeating: 0, count: 10)

for i in num {
    arr[Int(String(i))!] += 1
}
var result = ""
for i in stride(from: 9, to: -1, by: -1) {
    for _ in 0..<arr[i] {
        result += String(i)
    }
}
print(result)
