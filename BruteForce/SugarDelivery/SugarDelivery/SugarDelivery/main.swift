//
//  main.swift
//  SugarDelivery
//
//  Created by Kay on 2023/05/24.
//

/*
 2839
 설탕 배달
 */

import Foundation

var n = Int(readLine()!)!
var result = 0

while true {
    if n % 5 == 0 {
        result += (n/5)
        print(result)
        break
    }
    n -= 3
    result += 1
    if n < 0 {
        print(-1)
        break
    }
}

/*
 
 브루트 포스
 import Foundation

 let x = Int(readLine()!)!

 var min = Int.max

 for i in 0...1667 {
     for j in 0..<1667 {
         if (5 * i) + (3 * j) == x {
             let temp = i + j
             min = temp < min ? temp : min
         }
     }
 }
 if min == Int.max {
     print(-1)
 } else {
     print(min)
 }

 */
