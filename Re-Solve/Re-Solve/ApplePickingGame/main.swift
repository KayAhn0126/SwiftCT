//
//  main.swift
//  ApplePickingGame
//
//  Created by Kay on 2023/02/07.
//

/*
 2828
 사과 담기 게임
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let J = Int(readLine()!)!

let N = NM[0]
let M = NM[1]

var total = 0
var left = 1
var right = left + M - 1

for _ in 0..<J {
    right = left + M - 1
    let drop = Int(readLine()!)!
    if drop < left {
        total += left - drop
        left = drop
    } else if right < drop {
        total += drop - right
        left = drop - M + 1
    }
}

print(total)
// 30 ~ 40분
