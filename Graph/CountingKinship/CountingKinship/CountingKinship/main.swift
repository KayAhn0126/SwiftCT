//
//  main.swift
//  CountingKinship
//
//  Created by Kay on 2023/02/27.
//

/*
 2644
 촌수 계산
 */

import Foundation

let totalPeople = Int(readLine()!)!
let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
let from = fromTo[0]
let to = fromTo[1]

let connectionCount = Int(readLine()!)!

var adjList = [[Int]](repeating: [Int](), count: totalPeople + 1)
var visited = [Int](repeating: 0, count: totalPeople + 1)

for i in 0..<connectionCount {
    let connection = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = connection[0]
    let to = connection[1]
    // 양방향 연결
    adjList[from].append(to)
    adjList[to].append(from)
}

var bfsQueue = [Int](), idx = 0
bfsQueue.append(from)
visited[from] = 1

var result = -1
while idx < bfsQueue.count {
    let currentNumber = bfsQueue[idx]; idx += 1
    if currentNumber == to {
        result = visited[currentNumber] - 1
        break
    }
    for number in adjList[currentNumber] {
        if visited[number] > 0 { continue }
        visited[number] = visited[currentNumber] + 1
        bfsQueue.append(number)
    }
}
print(result)
