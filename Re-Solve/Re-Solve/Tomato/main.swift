import Foundation
// 1 익은 토마토
// 0 익지 않은 토마토
// -1 벽
// 토마토는 여러개 있을 수 있다.

let MN = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = MN[1]
let M = MN[0]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


var bfsQueue = [(Int,Int)](), idx = 0
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 1 {
            bfsQueue.append((i,j))
            visited[i][j] = 1
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var result = 1

func bfs() {
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] != 0 { continue }
            if adjMatrix[ny][nx] == -1 { continue }
            let nextVisitNumber = visited[current.0][current.1] + 1
            visited[ny][nx] = nextVisitNumber
            result = nextVisitNumber > result ? nextVisitNumber : result
            bfsQueue.append((ny,nx))
        }
    }
}

func checkMap() -> Bool {
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 0 && adjMatrix[i][j] != -1 { return false }
        }
    }
    return true
}


bfs()

if checkMap() == true {
    print(result - 1)
} else {
    print(-1)
}
