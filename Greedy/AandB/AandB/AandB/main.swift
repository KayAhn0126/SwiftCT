//
//  main.swift
//  AandB
//
//  Created by Kay on 2023/04/24.
//

/*
 12904
 A와 B
 */

// 덧붙이는 방식으로 한다면 가짓수가 너무 많아진다.
// 최악의 경우 -> S = 1 T = 1000 -> 경우의 수 2^n

// 무조건 T의 길이가 S보다 크다.
// 그러므로 T에서 S로 만드는것이 정해.

import Foundation

var S = readLine()!
var T = readLine()!

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

while true {
    if S.count == T.count {
        if S == T {
            print(1)
        } else {
            print(0)
        }
        break
    }
    if T[T.count-1]! == "A" {
        T.removeLast()
    } else {
        T.removeLast()
        T = String(T.reversed())
    }
}
