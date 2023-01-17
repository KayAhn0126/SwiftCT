//
//  main.swift
//  BreakEvenPoint
//
//  Created by Kay on 2023/01/17.
//

/*
 1712
 손익 분기점
 */

import Foundation

let ABC = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = ABC[0]
let B = ABC[1]
let C = ABC[2]

if B >= C {
    print("-1")
} else {
    print(A/(C-B) + 1)
}
