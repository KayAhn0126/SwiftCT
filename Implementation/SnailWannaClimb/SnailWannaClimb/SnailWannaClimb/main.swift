//
//  main.swift
//  SnailWannaClimb
//
//  Created by Kay on 2023/04/16.
//

/*
 2869
 달팽이는 올라가고 싶다
 */

import Foundation

let ABV = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = ABV[0]
let B = ABV[1]
let V = ABV[2]

var current = 0
var count = 0

if A >= V {
    print(1)
} else {
    if (V-A) % (A-B) == 0 {
        print(((V-A) / (A-B)) + 1)
    } else {
        print(((V-A) / (A-B)) + 2)
    }
}
