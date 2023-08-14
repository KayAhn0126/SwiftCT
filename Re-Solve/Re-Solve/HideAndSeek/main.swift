/*
 수빈이의 위치 N
 동생의 위치 K
 N, K 모두 0에서 10만 사이
 1초 후에 X - 1, X + 1, X * 2로 갈 수 있다.
 가장 빠르게 찾는 법 -> BFS
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

// 수빈이의 위치 60000, 동생의 위치가 99999라면 직접 움직이는것보다 순간이동 후 움직이는것이 더 적게 걸린다.
var visited = [Int](repeating: 0, count: 200001)
var bfsQueue = [Int](), idx = 0
visited[N] = 1
bfsQueue.append(N)

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    
    if current == K { break }
    let temp = [current - 1, current + 1, current * 2]
    for i in 0..<3 {
        if temp[i] < 0 || temp[i] > 200000 { continue }
        if visited[temp[i]] != 0 { continue }
        visited[temp[i]] = visited[current] + 1
        bfsQueue.append(temp[i])
    }
}

print(visited[K] - 1)
