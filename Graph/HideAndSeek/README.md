# 1697 숨바꼭질

## 🍎 키워드
- BFS
- 범위 체크

## 🍎 문제 이해
- 수빈이가 동생을 찾는 가장 빠른 수를 찾으면 된다.
- 수빈이가 갈 수 있는 위치는 현재 위치에서 최대 * 2이니까 방문 배열의 범위는 100,000 * 2인 200,000으로 잡아야한다.

## 🍎 문제 풀이 및 전체 코드
- 수빈이의 위치를 X라고 했을때,
    - X - 1
    - X + 1
    - X * 2
- 모두 가중치는 1이므로 visited[next] = visited[now] + 1로 방문한다.
- 마지막에 출력은 visited[동생의 위치] - 1
```swift
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
```
