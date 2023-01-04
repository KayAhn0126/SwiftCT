//
//  main.swift
//  ApplePickingGame
//
//  Created by Kay on 2023/01/04.
//

/*
 2828
 사과 담기 게임
 */
// 2nd week fast-campus

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]   // 총 칸수
let M = NM[1]   // 박스의 크기

let J = Int(readLine()!)!   // 사과가 하늘에서 떨어지는 횟수

var left: Int = 1 {
    didSet {
        right = left + M - 1
    }
}
var right = left + (M - 1)
var count = 0

for _ in 0..<J {
    let dropTo = Int(readLine()!)!
    if left <= dropTo && dropTo <= right { continue }
    if dropTo < left {
        count += left - dropTo
        left = dropTo
    } else { // right < dropTo 일때
        count += dropTo - right
        left = left + (dropTo - right)
    }
}

print(count)
