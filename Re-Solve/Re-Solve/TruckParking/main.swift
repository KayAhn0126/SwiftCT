//
//  main.swift
//  TruckParking
//
//  Created by Kay on 2023/01/28.
//

/*
 2979
 트럭 주차
 */

import Foundation

let ABC = readLine()!.split(separator: " ").map { Int(String($0))! }

let A = ABC[0]
let B = ABC[1]
let C = ABC[2]

var fare = [Int](repeating: 0, count: 101)
for _ in 0..<3 {
    let times = readLine()!.split(separator: " ").map { Int(String($0))! }
    let arrive = times[0]
    let departure = times[1]
    for i in arrive..<departure {
        fare[i] += 1
    }
}

var total = 0

fare.enumerated().forEach {
    if $0.element == 1 {
        total += A
    } else if $0.element == 2 {
        total += B * 2
    } else if $0.element == 3 {
        total += C * 3
    }
}
print(total)
