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
