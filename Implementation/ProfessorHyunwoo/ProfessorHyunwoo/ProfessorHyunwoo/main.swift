//
//  main.swift
//  ProfessorHyunwoo
//
//  Created by Kay on 2023/01/06.
//

/*
 3474
 교수가 된 현우
 */
// 2nd week fast campus

import Foundation

let N = Int(readLine()!)!

for _ in 0..<N {
    let number = Int(readLine()!)!
    findNumOfZeroFromFactorial(number)
}

func findNumOfZeroFromFactorial(_ number: Int) {
    var numerator = number
    var count = 0
    while numerator >= 5 {
        count += numerator / 5
        numerator = numerator / 5
    }
    print(count)
}
