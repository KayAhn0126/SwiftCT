//
//  main.swift
//  One
//
//  Created by Kay on 2023/01/12.
//

/*
 4375
 1
 */
// 1st week fast campus

import Foundation

while let number = readLine() {
    let N = Int(number)!
    if N == 1 {
        print("1")
    } else {
        var count = 1
        var num = 1
        while num != 0 {
            num = ((num % N) * (10 % N) + (1 % N)) % N
            count += 1
        }
        print(count)
    }
}
