# 7569 토마토
- 7576 토마토 문제 업그레이드 버전
- BFS를 이용한 최단거리 z축도 확인해야 한다.

## 🍎 문제 접근
- 7576 토마토 문제 + z축이다.
- 3차원 배열 사용하기 -> 현레벨 4방향 + 중심점에서 위 아래.
```swift
[layer][y][x]
 
 dz = [-1,0,1]
 dy = [-1,0,1,0]
 dx = [0,1,0,-1]
```

## 🍎 문제 풀이
```swift
import Foundation

let dz = [-1,0,1]
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

struct ZYX {
    var Z: Int
    var Y: Int
    var X: Int
}

var bfsQueue: [ZYX] = [], idx = 0

var XYZ = readLine()!.split(separator: " ").map { Int(String($0))! }
var Y = XYZ[1]
var X = XYZ[0]
var Z = XYZ[2]

var adjMatrix = [[[Int]]](repeating: [[Int]](repeating: [Int](), count: Y), count: Z)
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: X), count: Y), count: Z)

for i in 0..<Z {
    for j in 0..<Y {
        adjMatrix[i][j].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
    }
}

var oneList: [ZYX] = []

for i in 0..<Z {
    for j in 0..<Y {
        for k in 0..<X {
            if adjMatrix[i][j][k] == 1 {
                oneList.append(ZYX(Z: i, Y: j, X: k))
            }
        }
    }
}

func checkIfZeroExist() -> Bool {
    for i in 0..<Z {
        for j in 0..<Y {
            for k in 0..<X {
                if visited[i][j][k] == 0 && adjMatrix[i][j][k] != -1 {
                    return true
                }
            }
        }
    }
    return false
}

var result = 0
var flag = false
func bfs() {
    while idx < bfsQueue.count {
        let location = bfsQueue[idx]; idx += 1
        let currentZ = location.Z
        let currentY = location.Y
        let currentX = location.X
        for z in 0..<3 {
            if dz[z] == 0 {
                for i in 0..<4 {
                    let ny = currentY + dy[i]
                    let nx = currentX + dx[i]
                    if ny < 0 || nx < 0 || ny >= Y || nx >= X { continue }
                    if visited[currentZ][ny][nx] > 0 { continue }
                    if adjMatrix[currentZ][ny][nx] != 0 { continue }
                    let nextNumber = visited[currentZ][currentY][currentX] + 1
                    visited[currentZ][ny][nx] = nextNumber
                    result = nextNumber > result ? nextNumber : result
                    bfsQueue.append(ZYX(Z: currentZ, Y: ny, X: nx))
                    flag = true
                }
            } else {
                let nz = currentZ + dz[z]
                if nz < 0 || nz >= Z { continue }
                if visited[nz][currentY][currentX] > 0 { continue }
                if adjMatrix[nz][currentY][currentX] != 0 { continue }
                let nextNumber = visited[currentZ][currentY][currentX] + 1
                visited[nz][currentY][currentX] = nextNumber
                result = nextNumber > result ? nextNumber : result
                bfsQueue.append(ZYX(Z: nz, Y: currentY, X: currentX))
                flag = true
            }
        }
    }
}

for i in 0..<oneList.count {
    let oneLocation = oneList[i]
    let oneZ = oneLocation.Z
    let oneY = oneLocation.Y
    let oneX = oneLocation.X
    visited[oneZ][oneY][oneX] = 1
    let location = ZYX(Z: oneZ, Y: oneY, X: oneX)
    bfsQueue.append(location)
}
bfs()
if checkIfZeroExist() {
    print(-1)
} else {
    if flag == false {
        print(result)
    } else {
        print(result - 1)
    }
}
```
