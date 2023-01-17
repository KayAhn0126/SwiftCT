//
//  main.swift
//  EffectiveHacking
//
//  Created by Kay on 2023/01/10.
//

/*
 1325
 효율적인 해킹
 */
// 2nd week fast campus

/*
 DFS로 풀었다가 시간초과가 나서 생각해보니 BFS로 풀어야 할것 같음
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
    
    mutating func clear() {
        enqueueList.removeAll()
        dequeueList.removeAll()
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

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjList = [[Int]](repeating: [Int](), count: N + 1)

var biggestList = [Int](repeating: 0, count: N + 1)
var biggestNum = -100000


for i in 0..<M {
    let trustRelation = readLine()!.split(separator: " ").map { Int(String($0))! }
    let by = trustRelation[0]
    let trusted = trustRelation[1]
    adjList[trusted].append(by)
}


func bfs(_ node: Int) -> Int {
    var bfsQueue = Queue<Int>()
    var visited = [Int](repeating: 0, count: N + 1)
    var count = 1
    visited[node] = count
    bfsQueue.enqueue(node)
    while !bfsQueue.isEmpty {
        let number = bfsQueue.dequeue()!
        for i in 0..<adjList[number].count {
            if visited[adjList[number][i]] != 0 { continue }
            count += 1
            visited[adjList[number][i]] = 1
            bfsQueue.enqueue(adjList[number][i])
        }
    }
    return count
}

for i in 1...N {
    let result = bfs(i)
    biggestNum = biggestNum > result ? biggestNum : result
    biggestList[i] = result
}

for i in 1...N {
    if biggestList[i] == biggestNum {
        print(i, terminator: " ")
    }
}
print("")
