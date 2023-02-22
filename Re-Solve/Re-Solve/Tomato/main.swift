//
//  main.swift
//  Tomato
//
//  Created by Kay on 2023/02/22.
//

/*
 7576
 토마토
 */

// BFS + 최단거리(마지막 숫자)
// 토마토의 위치 알아야한다.
// BFS 끝나고 맵 전체 체크했을때 0 있으면 -1 아니면 result 출력
// 큐를 배열로 만들기

import Foundation

var bfsQueue = [(Int,Int)](), idx = 0
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let MN = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = MN[1]
let M = MN[0]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
var resultDays = 0

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var tomatoList: [(Int, Int)] = []

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 1 {
            tomatoList.append((i,j))
        }
    }
}
var flag = false
//MARK: 토마토 익게하는 BFS
func ripensTomato() {
    while idx < bfsQueue.count {
        let tomatoLocation = bfsQueue[idx]; idx += 1
        let Y = tomatoLocation.0
        let X = tomatoLocation.1
        for i in 0..<4 {
            let ny = Y + dy[i]
            let nx = X + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] > 0 || adjMatrix[ny][nx] == -1 { continue }
            flag = true
            visited[ny][nx] = visited[Y][X] + 1
            resultDays = visited[ny][nx]
            bfsQueue.append((ny,nx))
        }
    }
}

//MARK: 벽이 아닌 0이 있다면 true, 아니면 false 반환
func checkZero() -> Bool {
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 0 && adjMatrix[i][j] != -1 {
                return true
            }
        }
    }
    return false
}

tomatoList.enumerated().forEach {
    let tomatoY = $0.element.0
    let tomatoX = $0.element.1
    bfsQueue.append((tomatoY, tomatoX))
    visited[tomatoY][tomatoX] = 1
}
ripensTomato()

if checkZero() == true {
    print(-1)
} else {
    if flag == false {
        print(0)
    } else {
        print(resultDays - 1)
    }
}


