//
//  main.swift
//  OnlineCourseMath
//
//  Created by Kay on 2023/05/24.
//

/*
 19523
 수학은 비대면강의입니다
 */

import Foundation

var input = readLine()!.split(separator: " ").map { Int(String($0))! }
let a = input[0]
let b = input[1]
let c = input[2]
let d = input[3]
let e = input[4]
let f = input[5]

let target = c + f
for i in -999...999 {
    for j in -999...999 {
        let first = (a * i) + (b * j)
        let second = (d * i) + (e * j)
        if first == c && second == f {
            print(i, j)
            break
        }
    }
}
