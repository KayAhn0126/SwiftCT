//
//  main.swift
//  BFS
//
//  Created by Kay on 2022/12/30.
//

import Foundation

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    // MARK: - 디큐하기전 수량 체크 필수. count 보다 isEmpty로 체크하자
    mutating func dequeue() -> T {
        queue = queue.reversed()
        let dequeNumber = queue.popLast()!
        queue = queue.reversed()
        return dequeNumber
    }
}

var dy = [-1,0,1,0]
var dx = [0,1,0,-1]

var matrixSize = readLine()!.split(separator: " ").map { Int($0)! }
let N = matrixSize[0]
let M = matrixSize[1]

let startYX = readLine()!.split(separator: " ").map { Int($0)! }
let sY = startYX[0]
let sX = startYX[1]

let endYX = readLine()!.split(separator: " ").map { Int($0)! }
let eY = endYX[0]
let eX = endYX[1]

var adjmatrix = [[Int]]()
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for _ in 0..<N {
    adjmatrix.append(readLine()!.split(separator: " ").map { Int($0)! })
}

var readyQueue = Queue<(Int,Int)>()
visited[sY][sX] = 1
readyQueue.enqueue((sY, sX))


while !readyQueue.isEmpty {
    
    let current = readyQueue.dequeue()
    
    let y = current.0
    let x = current.1
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        print(ny,nx)
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if adjmatrix[ny][nx] == 0 { continue }
        if visited[ny][nx] != 0 { continue }
        visited[ny][nx] = visited[y][x] + 1
        readyQueue.enqueue((ny,nx))
    }
}

for i in 0..<N {
    for j in 0..<M {
        print(visited[i][j], terminator: "")
    }
    print("")
}

print(visited[eY][eX])
