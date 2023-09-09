//
//  main.swift
//  StartAndLink
//
//  Created by Kay on 2023/08/25.
//

/*
 14889
 스타트와 링크
 */

/*
 문제 접근
 depth가 N / 2 될때까지 백트래킹으로 순열 구하기 계산하기
 */

import Foundation

let N = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

func calculate(_ arr: [Int]) -> Int {
    let total = Set(0..<N)
    var teamA = 0
    var teamB = 0
    let opponent = Array(total.subtracting(Set(arr)))
    for i in arr { // teamA
        for j in arr {
            if i == j { continue }
            teamA += adjMatrix[i][j]
        }
    }
    for i in opponent { // teamB
        for j in opponent {
            if i == j { continue }
            teamB += adjMatrix[i][j]
        }
    }
    return abs(teamA - teamB)
}

var result = Int.max
var visited = [Int](repeating: 0, count: N)

func dfs(_ depth: Int, _ currentArr: [Int], _ index: Int) {
    if depth == N/2 {
        let temp = calculate(currentArr)
        result = result > temp ? temp : result
        return
    }
    for i in index..<N {
        if visited[i] == 1 { continue }
        visited[i] = 1
        dfs(depth + 1, currentArr + [i], i)
        visited[i] = 0
    }
}

dfs(0, [], 0)
print(result)
