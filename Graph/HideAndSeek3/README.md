# 13549 숨바꼭질 3
- BFS
- 가지치기에서 우선순위

## 🍎 문제 접근
- 타 숨바꼭질 문제와 다른점은 이전 문제들(숨바꼭질, 숨바꼭질2, 숨바꼭질 4)같은 경우는 X + 1, X - 1, X * 2 위치로 이동할때 모두 1초가 걸렸지만, 숨바꼭질 3 문제에서는 X + 1, X - 1으로 이동 할 때는 1초, X * 2의 위치로 이동할 때는 0초가 걸린다는 점이 다르다.
- bfsQueue에 넣을때 0초가 걸리는 X * 2 위치를 먼저 넣어주면, 나중에 X + 1이나 X - 1보다 더 먼저 도착하게 되므로 더 최단 시간을 보장받을 수 있다.
- 예를 들면 현재 수빈이의 위치는 5, 동생의 위치는 17이라 했을때,
    - 수빈이를 다음 위치로 이동 시켜주기 위해 만약 X+1이나 X-1을 먼저 계산 하고 bfsQueue에 넣어준다면, X + 1이나 X - 1에서 가지치기한 값들이 bfsQueue에 들어가게 될것이고, 0초가 걸리는 X * 2로의 순간이동보다 먼저 도착해(방문 및 값을 저장해서) 더 짧은 시간이 걸리는 순간이동의 값을 저장하지 못하게 된다.
    - 그러므로 0초가 걸리는 X * 2 위치를 먼저 가지치기 하도록 bfsQueue에 먼저 추가 해주는것이 문제의 포인트이다.

## 🍎 문제 풀이 및 전체 코드
```swift
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
```
