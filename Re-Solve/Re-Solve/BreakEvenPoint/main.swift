//
//  main.swift
//  BreakEvenPoint
//
//  Created by Kay on 2023/02/03.
//

/*
 1712
 손익분기점
 */

// 고정비용 A
// 노트북 1대 만들때 마다 필요한 금액 (재료비 + 인건비 가변 비용) B
// 노트북 가격 C
import Foundation

let ABC = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = ABC[0]
let B = ABC[1]
let C = ABC[2]

if B >= C {
    print(-1)
} else {
    print((A / (C - B)) + 1)
}
