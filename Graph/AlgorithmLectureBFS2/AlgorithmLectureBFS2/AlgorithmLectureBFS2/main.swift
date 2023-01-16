//
//  main.swift
//  AlgorithmLectureBFS2
//
//  Created by Kay on 2023/01/16.
//

/*
 24445
 알고리즘 수업 - 너비 우선 탐색 2
 */

/*
 문제 접근
 인접 정접은 내림차순으로 방문한다.
 BFS + 양방향 + 최단거리 + 내림차순 방문 + 몇번쨰로 방문 했는지 출력
 5 5 1
 1 4
 1 2
 2 3
 2 4
 3 4
 
 
 [1][4,2]
 [2][4,3,1]
 [3][4,2]
 [4][3,2,1]
 
 
 1
 3
 4
 2
 0
 
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
            return dequeueList.popLast()
        }
        return dequeueList.popLast()
    }
}

var dfsQueue = Queue<Int>()

let NMR = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = NMR[0]
let M = NMR[1]
let R = NMR[2]

var adjList = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

for i in 0..<M {
    let uv = readLine()!.split(separator: " ").map { Int(String($0))! }
    let u = uv[0]
    let v = uv[1]
    adjList[u].append(v)
    adjList[v].append(u)
}

var counter = 1
func bfs(_ node: Int) {
    visited[node] = counter
    dfsQueue.enqueue(node)
    while !dfsQueue.isEmpty {
        let currentNumber = dfsQueue.dequeue()!
        adjList[currentNumber].sort(by: { $0 > $1 })
        for i in 0..<adjList[currentNumber].count {
            if visited[adjList[currentNumber][i]] != 0 { continue }
            counter += 1
            visited[adjList[currentNumber][i]] = counter
            dfsQueue.enqueue(adjList[currentNumber][i])
        }
    }
}


bfs(R)

for i in 1..<visited.count {
    print(visited[i])
}
