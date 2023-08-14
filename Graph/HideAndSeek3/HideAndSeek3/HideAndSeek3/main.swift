//
//  main.swift
//  HideAndSeek3
//
//  Created by Kay on 2023/08/14.
//

/*
 13549
 숨바꼭질 3
 */

/*
 지문 해석:
    X-1, X+1은 1초, 순간이동 X * 2는 0초
    BFS에 조건만 다르게 걸어주자
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var visited = [Int](repeating: 0, count: 200001)
var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)
visited[N] = 1

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    
    let temp = [current * 2, current - 1, current + 1]
    for i in 0..<3 {
        let next = temp[i]
        if next < 0 || next > 200000 { continue }
        if visited[next] != 0 { continue }
        if i == 0 {
            visited[next] = visited[current]
            bfsQueue.append(next)
            continue
        }
        visited[next] = visited[current] + 1
        bfsQueue.append(next)
    }
}

print(visited[K] - 1)

