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

//MARK: 시간초과 코드

//import Foundation
//
//let N = Int(readLine()!)!
//var adjMatrix = [[Int]](repeating: [Int](), count: N)
//for i in 0..<N {
//    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
//}
//
//func calculate(_ arr: [Int]) -> Int {
//    let total = Set(1...N)
//    var teamA = 0
//    var teamB = 0
//    let opponent = Array(total.subtracting(Set(arr)))
//    for i in arr { // teamA
//        for j in arr {
//            if i == j { continue }
//            teamA += adjMatrix[i][j]
//        }
//    }
//    for i in opponent { // teamB
//        for j in opponent {
//            if i == j { continue }
//            teamB += adjMatrix[i][j]
//        }
//    }
//    return abs(teamA - teamB)
//}
//
//var result = Int.max
//var visited = [Int](repeating: 0, count: N + 1)
//var filterSet = Set<Set<Int>>()
//func dfs(_ depth: Int, _ currentArr: [Int], _ index: Int) {
//    if depth == N/2 {
//        let tempSet = Set(currentArr)
//        if filterSet.contains(tempSet) { return }
//        filterSet.insert(tempSet)
//        let temp = calculate(currentArr)
//        result = result > temp ? temp : result
//    }
//    for i in index..<N {
//        if visited[i] == 1 { continue }
//        visited[i] = 1
//        dfs(depth + 1, currentArr + [i], i + 1)
//        visited[i] = 0
//    }
//}
//
//dfs(0, [], 0)
//print(result)



import Foundation

let n = Int(readLine()!)!
var arr = [[Int]]()
var visited = [Bool](repeating: false, count: n)
var minResult = Int.max

for _ in 0..<n {
    arr.append(readLine()!.split(separator: " ").map{ Int($0)! })
}

private func dfs(depth: Int, start: Int) {
    if depth == n/2 {
        var teamStart = 0
        var teamLink = 0

        for i in 0..<n {
            for j in 0..<n {
                if visited[i], visited[j] {
                    teamStart += arr[i][j]
                }

                if !visited[i], !visited[j] {
                    teamLink += arr[i][j]
                }
            }
        }
        minResult = min(minResult, abs(teamLink - teamStart))
        return
    }

    for i in start..<n {
        if !visited[i] {
            visited[i] = true
            dfs(depth: depth + 1, start: i)
            visited[i] = false
        }
    }
}

dfs(depth: 0, start: 0)
print(minResult)
