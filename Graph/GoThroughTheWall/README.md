# 2206 벽 부수고 이동하기

## 🍎 어려운 문제이니 지문을 다시 읽어보자
- N×M의 행렬로 표현되는 맵이 있다. 
- 맵에서 0은 이동할 수 있는 곳을 나타내고, 1은 이동할 수 없는 벽이 있는 곳을 나타낸다.
- 당신은 (1, 1)에서 (N, M)의 위치까지 이동하려 하는데, 이때 최단 경로로 이동하려 한다.
- 최단경로는 맵에서 가장 적은 개수의 칸을 지나는 경로를 말하는데, 이때 시작하는 칸과 끝나는 칸도 포함해서 센다.
- 만약에 이동하는 도중에 한 개의 벽을 부수고 이동하는 것이 좀 더 경로가 짧아진다면, 벽을 한 개 까지 부수고 이동하여도 된다.
- 한 칸에서 이동할 수 있는 칸은 상하좌우로 인접한 칸이다.
- 맵이 주어졌을 때, 최단 경로를 구해 내는 프로그램을 작성하시오.

## 🍎 문제 접근
### 📖 처음에 시도했던 방법
    - 맵 전체를 돌면서 1의 위치(y,x) 형태를 모두 저장한다.
    - 해당 1을 0으로 바꾼다.
    - BFS를 돌리고
    - 방금 0으로 바꿨던 위치를 다시 1로 원상복구 시켜준다.
    - 위의 스텝을 반복한다.
- 해당 로직의 가장 큰 문제점. -> 시간초과
- 입력의 범위를 보자.
- N의 최대 1000, M의 최대 1000.
- 맵 사이즈 = 1000 * 1000
- BFS 탐색 = 1000 * 1000
- 위의 로직대로 실행하면 시간 복잡도는 10^12
### 📖 3차원 배열을 이용한 새로운 방법
- 3차원 배열의 마지막 배열은 부쉈는지, 안 부쉈는지 판단하는 용도.
- 처음에는 부시지 않은 상태이니 0으로 두고 그 상태에서 처음 벽을 만나면 1로 변환한 상태로 계속 BFS를 진행한다.

## 🍎 시간 초과 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

var oneLocation: [(Int, Int)] = []
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 1 {
            oneLocation.append((i,j))
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var result = 987654321
for i in oneLocation {
    var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    var bfsQueue: [(Int,Int)] = [], idx = 0
    adjMatrix[i.0][i.1] = 0
    
    visited[0][0] = 1
    bfsQueue.append((0,0))
    
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] > 0 || adjMatrix[ny][nx] == 1 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            bfsQueue.append((ny,nx))
        }
    }
    adjMatrix[i.0][i.1] = 1
    let roundResult = visited[N-1][M-1]
    if roundResult == 0 { // 가는 방법이 없다면
        continue
    } else { // 가는 방법이 있다면
        result = result > roundResult ? roundResult : result
    }
    
}
if result == 987654321 {
    print(-1)
} else {
    print(result)
}
```

## 🍎 통과 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

// 3차원 배열
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 2), count: M), count: N)

func bfs() -> Int {
    var bfsQueue: [(Int,Int,Int)] = [], idx = 0
    visited[0][0][0] = 1
    bfsQueue.append((0,0,0))
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        let currentShatterStatus = currentLocation.2
        if currentY == N - 1 && currentX == M - 1 { // 목표 위치에 도달 했다면..?
            return visited[N-1][M-1][currentShatterStatus]
        }
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx][currentShatterStatus] > 0 { continue } // 문제의 특성상 여기서 벽 체크 하지 않음
            if adjMatrix[ny][nx] == 0 { // 맵에서 다음 가려는 곳이 벽이 아니라면..? -> 일반적인 BFS 상황처럼 흘러감
                visited[ny][nx][currentShatterStatus] = visited[currentY][currentX][currentShatterStatus] + 1
                bfsQueue.append((ny,nx,currentShatterStatus))
            } else { // 맵에서 다음 가려는 곳이 벽이라면..?? -> 이전에 벽을 부쉈는지 체크 후 분기처리
                if currentShatterStatus == 0 { // 아직 벽을 부시지 않음
                    visited[ny][nx][1] = visited[currentY][currentX][currentShatterStatus] + 1
                    bfsQueue.append((ny,nx,1))
                } else { // 여기까지 오면서 벽을 부신적이 있음
                    continue
                }
            }
        }
    }
    return -1
}
print(bfs())
```
