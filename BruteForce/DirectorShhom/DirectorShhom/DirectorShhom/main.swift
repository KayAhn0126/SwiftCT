//
//  main.swift
//  DirectorShhom
//
//  Created by Kay on 2023/01/07.
//

/*
 1436
 영화감독 숌
 */
// 2nd week fast campus

import Foundation

let input = Int(readLine()!)!

var count = 0

func hasContainThreeSix(_ number: Int) -> Bool {
    var temp = number
    while temp >= 666 {
        if temp % 1000 == 666 {
            return true
        }
        temp /= 10
    }
    return false
}

if input == 0 {
    print("0")
} else {
    for i in 666...666 * 10000 { // 666부터 6660000
        if hasContainThreeSix(i) {
            count += 1
        }
        if count == input {
            print(i)
            break
        }
    }
}



