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

let userInput = Int(readLine()!)!

// 1666
// 26663
func checkThreeSix(_ number: Int) -> Bool {
    var testNumber = number
    var counter = 0
    while testNumber > 0 {
        if testNumber % 10 == 6 {
            counter += 1
            if counter == 3 {
                return true
            }
        } else {
            counter = 0
        }
        testNumber /= 10
    }
    return false
}

var counter = 0
for i in 666..<666*10000 {
    if checkThreeSix(i) == true {
        counter += 1
    }
    if counter == userInput {
        print(i)
        break
    }
}
