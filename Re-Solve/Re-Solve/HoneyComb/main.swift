//
//  main.swift
//  HoneyComb
//
//  Created by Kay on 2023/03/18.
//

/*
 2292
 벌집 다시풀기 추가
 */

/*
 1     -> 1
 2 ~ 7 -> 2
 8 ~ 19 -> 3
 20 ~ 37 -> 4
 
 */
import Foundation

let number = Int(readLine()!)!

var count = 1 // layer
var temp = 1 // 숫자
while number > temp {
    temp += count * 6
    count += 1
}
print(count)
