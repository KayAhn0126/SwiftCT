//
//  main.swift
//  PascalsTriangle
//
//  Created by Kay on 2023/02/20.
//

/*
 16395
 파스칼의 삼각형
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var arr = [[Int]](repeating: [Int](repeating: 0, count: 31), count: 31)

arr[1][1] = 1
arr[2][1] = 1
arr[2][2] = 1

if N < 3 {
    print(arr[N][K])
} else {
    for i in 3...N {
        arr[i][1] = 1
        arr[i][i] = 1
        for j in 2..<i {
            arr[i][j] = arr[i-1][j-1] + arr[i-1][j]
        }
    }
    print(arr[N][K])
}
