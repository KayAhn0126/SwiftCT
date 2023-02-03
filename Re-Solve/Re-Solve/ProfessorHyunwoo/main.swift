//
//  main.swift
//  ProfessorHyunwoo
//
//  Created by Kay on 2023/02/03.
//

import Foundation

/*
 3474
 교수가 된 현우
 */

let input = Int(readLine()!)!

func calculate(_ element: Int) -> Int {
    var localElement = element
    var result = 0
    while localElement >= 5 {
        result += localElement / 5
        localElement /= 5
    }
    return result
}

for i in 0..<input {
    let testNum = Int(readLine()!)!
    print(calculate(testNum))
}
