//
//  main.swift
//  RainWater
//
//  Created by Kay on 2023/08/10.
//

/*
 14719
 빗물
 */

/*
 문제 접근:
    2차원 배열.
    row에 모든 col 값 넣기
    각 row를 돌면서 값사이가 2 이상이면 그 차이만큼 더하기
 500 * 500 = 25000번 연산
 브루트 포스 가능
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

let given = readLine()!.split(separator: " ").map { Int(String($0))! }
for i in 0..<M {
    for j in stride(from: N-1, through: N - given[i], by: -1) {
        adjMatrix[j][i] = 1
    }
}

var result = 0
// 두 값의 차이가 2이상인 경우 찾기
for i in 0..<N {
    var prev = -1
    for j in 0..<M {
        if prev != -1 && adjMatrix[i][j] == 1 {
            if j - prev >= 2 {
                result += j - prev - 1
            }
            prev = j
        } else if prev == -1 && adjMatrix[i][j] == 1 {
            prev = j
        }
    }
}
print(result)
