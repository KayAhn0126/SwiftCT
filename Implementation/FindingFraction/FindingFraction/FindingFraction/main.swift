//
//  main.swift
//  FindingFraction
//
//  Created by Kay on 2023/01/11.
//

/*
 1193
 분수 찾기
 */

import Foundation

var layer = 1 // 몇번째 레이어에 있는지
var count = 1 // 인덱스 구하기 용도

let target = Int(readLine()!)!

while target > count {
    layer += 1
    count += layer
}
let index = target - (count - layer)

if layer % 2 == 0 {
    var up = 1
    var down = layer
    for _ in 1..<index {
        up += 1
        down -= 1
    }
    print("\(up)/\(down)")
} else {
    var up = layer
    var down = 1
    for _ in 1..<index {
        up -= 1
        down += 1
    }
    print("\(up)/\(down)")
}
