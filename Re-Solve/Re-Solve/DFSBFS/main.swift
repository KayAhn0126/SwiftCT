//
//  main.swift
//  DFSBFS
//
//  Created by Kay on 2023/02/16.
//

/*
 1260
 DFS와 BFS
 */

/*
 인접리스트 -> why? Sparse Graph
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


let NMV = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = NMV[0]
let M = NMV[1]
let V = NMV[2]

var adjList = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

for _ in 0..<M {
    let YX = readLine()!.split(separator: " ").map { Int(String($0))! }
    let Y = YX[0]
    let X = YX[1]
    // 양방향 간선
    adjList[Y].append(X)
    adjList[X].append(Y)
}

func dfs(_ number: Int) {
    visited[number] = 1
    print(number, terminator: " ")
    for i in adjList[number] {
        if visited[i] == 1 {
            continue
        }
        dfs(i)
    }
}

func bfs(_ number: Int) {
    var queue = Queue<Int>()
    visited[number] = 1
    print(number, terminator: " ")
    queue.enqueue(number)
    while !queue.isEmpty {
        let currentNum = queue.dequeue()!
        for i in adjList[currentNum] {
            if visited[i] == 1 { continue }
            print(i, terminator: " ")
            visited[i] = 1
            queue.enqueue(i)
        }
    }
}

func clearVisited() {
    for i in 0..<N+1 {
        visited[i] = 0
    }
}

for i in 0..<adjList.count {
    adjList[i].sort()
}

dfs(V)
clearVisited()
print("")
bfs(V)

// 24분
