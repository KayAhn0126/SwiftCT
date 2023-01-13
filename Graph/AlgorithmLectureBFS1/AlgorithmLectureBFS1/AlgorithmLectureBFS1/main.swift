//
//  main.swift
//  AlgorithmLectureBFS1
//
//  Created by Kay on 2023/01/04.
//

/*
 24444
 알고리즘 수업 - 너비 우선 탐색 1
 */

// 양방향
// 가중치 1
// 인접 정점 오름차순으로 방문 adjMatrix[node].sorted()
// 정점의 방문 순서 R
// i번째 줄에 i의 방문 순서 출력

import Foundation

struct Queue<T> {
    var enQueue: [T] = []
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enQueue.append(element)
    }
    
    mutating func dequeue() -> T {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue.removeAll()
        }
        return deQueue.popLast()!
    }
}


var bfsQueue = Queue<Int>()
let userInput = readLine()!.split(separator: " ").map { Int($0)! }

let N = userInput[0]
let M = userInput[1]
let R = userInput[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

var counter = 1

for _ in 0..<M {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    adjMatrix[u].append(v)
    adjMatrix[v].append(u)
}

func bfs(_ node: Int) {
    visited[node] = counter
    bfsQueue.enqueue(node)
    while !bfsQueue.isEmpty {
        let currentNode = bfsQueue.dequeue()
        adjMatrix[currentNode].sort()
        for i in 0..<adjMatrix[currentNode].count {
            if visited[adjMatrix[currentNode][i]] != 0 { continue }
            counter += 1
            visited[adjMatrix[currentNode][i]] = counter
            bfsQueue.enqueue(adjMatrix[currentNode][i])
        }
    }
}

bfs(R)


for i in 1..<N+1 {
    print(visited[i])
}

