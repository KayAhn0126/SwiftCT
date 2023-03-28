//
//  main.swift
//  HideAndSeek4
//
//  Created by Kay on 2023/03/28.
//

/*
 13913
 숨바꼭질4 다시 풀기
 */
import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0] // 수빈이의 위치
let K = NK[1] // 동생의 위치


var visited = [Int](repeating: 0, count: 100001)
var prev = [Int](repeating: -1, count: 100001)


var bfsQueue = [Int](), idx = 0
visited[N] = 1
bfsQueue.append(N)

while idx < bfsQueue.count {
    let currentNumber = bfsQueue[idx]; idx += 1
    if currentNumber == K {
        break
    }
    for i in 1...3 {
        var nextNumber = currentNumber
        if i == 1 {
            nextNumber -= 1
        } else if i == 2 {
            nextNumber += 1
        } else {
            nextNumber *= 2
        }
        if nextNumber < 0 || nextNumber > 100000 { continue }
        if visited[nextNumber] > 0 { continue }
        bfsQueue.append(nextNumber)
        visited[nextNumber] = visited[currentNumber] + 1
        prev[nextNumber] = currentNumber
    }
}

var result = [Int]()
if N == K {
    print(0)
    print(N)
} else {
    print(visited[K] - 1)
    var traceBackNumber = prev[K]
    result.append(K)
    while traceBackNumber != -1 {
        result.append(traceBackNumber)
        traceBackNumber = prev[traceBackNumber]
    }
    result.reversed().enumerated().forEach {
        print($0.element, terminator: " ")
    }
    print("")
}
