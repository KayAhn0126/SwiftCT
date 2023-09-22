//
//  main.swift
//  MakingCheeseburger
//
//  Created by Kay on 2023/09/22.
//

/*
 30017
 치즈버거 만들기
 */

import Foundation

let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var a = arr[0]
var b = arr[1]
var count = 0
if a < b || a == b {
    print(a + (a-1))
} else {
    a -= 1
    count += 1
    while b > 0 {
        b -= 1
        a -= 1
        count += 2
    }
    print(count)
}
