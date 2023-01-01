//
//  main.swift
//  MeasureArea
//
//  Created by Kay on 2023/01/01.
//

/*
 2583
 영역 구하기
 */
// 2nd week fast-campus

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let MNK = readLine()!.split(separator: " ").map { Int($0)! }

// MARK: - 주어질때는 MNK 순서로 주어졌지만, 내가 사용할땐 N은 y(세로), M은 (가로)로 사용할것이기 떄문에 N과 M의 위치를 바꿔준다.
// MARK: - 맵을 읽고 나의 기준과 맞추기 연습하자.
    // 나는 (y,x)좌표, 지문은 (x,y)좌표

let N = MNK[0]
let M = MNK[1]
let K = MNK[2]

var adjMatrix = [[Int]](repeating: [Int](repeating: 1, count: M), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var result = 0
var resultArr = [Int]()

var area = 0

for _ in 0..<K {
    let xyPoint = readLine()!.split(separator: " ").map { Int($0)! }
    let x1 = xyPoint[0]
    let y1 = xyPoint[1]
    let x2 = xyPoint[2]
    let y2 = xyPoint[3]
    for i in x1..<x2 {
        for j in y1..<y2 {
            adjMatrix[j][i] = 0
            visited[j][i] = 1
        }
    }
}

func dfs(_ y: Int, _ x: Int) {
    area += 1
    visited[y][x] = 1
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == 1 { continue }
        if adjMatrix[ny][nx] == 0 { continue }
        dfs(ny, nx)
    }
}

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 0 || visited[i][j] == 1 { continue }
        dfs(i,j)
        result += 1
        resultArr.append(area)
        area = 0
    }
}

print(result)
resultArr.sorted(by: <).enumerated().forEach {
    print($0.element, terminator: " ")
}
