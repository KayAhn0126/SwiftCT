//
//  main.swift
//  MeasureArea
//
//  Created by Kay on 2023/02/16.
//

/*
 2583
 영역 구하기
 */

import Foundation

struct Queue<T> {
    var enqueueList: [T] = []
    var dequeueList: [T] = []
    
    var count: Int {
        return enqueueList.count + dequeueList.count
    }
    
    var isEmpty: Bool {
        return enqueueList.isEmpty && dequeueList.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enqueueList.append(element)
    }
    
    mutating func dequeue() -> T? {
        if dequeueList.isEmpty {
            dequeueList = enqueueList.reversed()
            enqueueList.removeAll()
        }
        return dequeueList.popLast()
    }
}

let MNK = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = MNK[0]
let M = MNK[1]
let K = MNK[2]

var matrix = [[Int]](repeating: [Int](repeating: 1, count: M), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]



for i in 0..<K {
    let location = readLine()!.split(separator: " ").map { Int(String($0))! }
    let x1 = location[0]
    let y1 = location[1]
    let x2 = location[2]
    let y2 = location[3]
    for row in y1..<y2 {
        for col in x1..<x2 {
            matrix[row][col] = 0
        }
    }
}

var count = 0
func dfs(_ y: Int, _ x: Int) {
    count += 1
    visited[y][x] = 1
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] > 0 || matrix[ny][nx] == 0 { continue }
        dfs(ny,nx)
    }
}

var totalCount = 0
var result: [Int] = []
for i in 0..<N {
    for j in 0..<M {
        if visited[i][j] == 1 || matrix[i][j] == 0 { continue }
        count = 0
        totalCount += 1
        dfs(i,j)
        result.append(count)
    }
}

print(totalCount)
result.sorted(by: <).enumerated().forEach {
    print($0.element, terminator: " ")
}

