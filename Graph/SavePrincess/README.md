# 17836 공주님을 구해라!
- 특정 상황에서 BFS

## 🍎 지문 해석
- 벽 부수고 이동하기 문제와 비슷하다 다만 벽 부수고 이동하기는 단 하나의 벽만 부술수 있었지만, 이 문제에서는 한번 검을 쥐게 된다면 그 이후에는 계속 벽을 뚫고 갈 수 있다는 점이 다르다.

## 🍎 문제 접근
- 처음에 접근한 방법은 2차원 배열로 푸는 방법이였다.
    - 검을 만나면 flag를 올려 그때부터 벽을 부시는 로직으로 구현했는데, 로직에 문제점이 있어 WA 판정.
    - 검을 만난 지점에서부터 벽을 부셔야하는데 flag 기준으로 벽을 부수기 가능 여부를 판단해 0,5에서 검을 만났다면 다음 사이클에는 2,0에서 바로 벽을 부수는 LE(Logic Error) 발생
- 다시 3차원 배열을 사용해서 검을 가지고 있는 경우, 아닌 경우를 0번째 인덱스에서 관리 해주었다.

## 🍎 문제 풀이 및 전체 코드
### 📖 LE 판정 받은 잘못된 로직의 코드
```swift
import Foundation

let NMT = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMT[0]
let M = NMT[1]
let T = NMT[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}
var swordLocation = (0,0)
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 2 {
            swordLocation = (i,j)
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var bfsQueue = [(Int, Int)](), idx = 0
bfsQueue.append((0,0))
visited[0][0] = 1

var result = 0
var flag = false // 검을 찾았는지!
var foundPrincess = false
while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    let curY = current.0
    let curX = current.1
    if curY == N-1 && curX == M-1 {
        result = visited[N-1][M-1] - 1
        foundPrincess = true
        break
    }
    
    for i in 0..<4 {
        let ny = curY + dy[i]
        let nx = curX + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue } // 범위 초과
        if visited[ny][nx] != 0 { continue } // 이미 방문 했다면
        if !flag && adjMatrix[ny][nx] == 1 { continue } // 검이 없는데 다음 가는곳이 벽이라면 패스
        if !flag { // 검을 아직 못찾았다면,
            if adjMatrix[ny][nx] == 2 {
                flag = true
            }
        }
        visited[ny][nx] = visited[curY][curX] + 1
        bfsQueue.append((ny,nx))
    }
}
if foundPrincess && result != 0 && result <= T {
    print(result)
} else {
    print("Fail")
}
```

### 📖 AC 코드
```swift
import Foundation

let NMT = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMT[0]
let M = NMT[1]
let T = NMT[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: M), count: N), count: 2)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var bfsQueue = [(Int, Int, Int)](), idx = 0
bfsQueue.append((0,0,0))
visited[0][0][0] = 1

var result = 0

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    let curS = current.0 // 검을 가지고 있는지 상태
    let curY = current.1
    let curX = current.2
    if curY == N-1 && curX == M-1 {
        result = visited[curS][N-1][M-1] - 1
        break
    }
    for i in 0..<4 {
        let ny = curY + dy[i]
        let nx = curX + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[curS][ny][nx] != 0 { continue }
        if curS == 0 && adjMatrix[ny][nx] == 1 { continue }
        if curS == 0 { // 검을 아직 못찼았다면
            if adjMatrix[ny][nx] == 2 { // 다음 갈곳이 검이라면
                visited[1][ny][nx] = visited[0][curY][curX] + 1
                bfsQueue.append((1,ny,nx))
                continue
            }
        }
        // 아직 검을 못찾았고 다음 갈곳이 검이 있는곳도 아니거나,
        // 검을 찾은 상태라면, 기본 BFS 진행
        visited[curS][ny][nx] = visited[curS][curY][curX] + 1
        bfsQueue.append((curS,ny,nx))
    }
}
if result != 0 && result <= T {
    print(result)
} else {
    print("Fail")
}
```
