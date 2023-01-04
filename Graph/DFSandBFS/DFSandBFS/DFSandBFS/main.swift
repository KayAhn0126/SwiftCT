//
//  main.swift
//  DFSandBFS
//
//  Created by Kay on 2023/01/04.
//

/*
 1260
 DFS와 BFS
 */

/*
 정점의 개수 1 <= N <= 1000
 간선의 개수 1 <= M <= 10000
 탐색 시작 정점 V
 양방향 간선
 */

// 인접 리스트
import Foundation

struct Queue<T> {
    private var queue: [T] = []
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    mutating func dequeue() -> T {
        queue = queue.reversed()
        let number = queue.removeLast()
        queue = queue.reversed()
        return number
    }
}

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = userInput[0]
let M = userInput[1]
let V = userInput[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Bool]()

var dfsString = ""
var bfsString = ""

func reset() {
    visited = [Bool](repeating: false, count: N + 1)
}

for _ in 0..<M {
    let edge = readLine()!.split(separator: " ").map { Int(String($0))! }
    let u = edge[0]
    let v = edge[1]
    adjMatrix[u].append(v)
    adjMatrix[v].append(u)
}


func dfs(_ node: Int){
    visited[node] = true
    dfsString += String(node) + " "
    for i in 0..<adjMatrix[node].count {
        if visited[adjMatrix[node][i]] == true { continue }
        dfs(adjMatrix[node][i])
    }
}

func bfs(_ node: Int) {
    visited[node] = true
    myQueue.enqueue(node)
    while !myQueue.isEmpty {
        let number = myQueue.dequeue()
        bfsString += String(number) + " "
        for i in 0..<adjMatrix[number].count {
            if visited[adjMatrix[number][i]] == true { continue }
            visited[adjMatrix[number][i]] = true
            myQueue.enqueue(adjMatrix[number][i])
        }
    }
}

func sortAll() {
    for i in 0..<N + 1 {
        adjMatrix[i].sort()
    }
}
sortAll()
reset()
dfs(V)
var myQueue = Queue<Int>()
reset()
bfs(V)
print(dfsString)
print(bfsString)
