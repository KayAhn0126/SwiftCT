//
//  main.swift
//  ColoredPaper
//
//  Created by Kay on 2023/07/23.
//

/*
    처음엔 일차원 배열 두개를 이용해 하려고 했지만,
    이차원 배열을 통해 arr[row][col]을 색칠하면서 이미 색칠되어있는 부분을 카운트하지 않으면 된다.
*/

import Foundation

let input = Int(readLine()!)!
var arr = [[Int]](repeating: [Int](repeating: 0, count: 101), count: 101)
var total = 0
for _ in 0..<input {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    let w = temp[0]
    let h = temp[1]
    for i in w..<w+10 {
        for j in h..<h+10 {
            if arr[i][j] == 0 {
                total += 1
                arr[i][j] = 1
            }
        }
    }
}

print(total)
