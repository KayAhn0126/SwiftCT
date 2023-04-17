import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]
var adjMatrix = [[Character]](repeating: [Character](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { $0 })
}

// BFS에서 가장 값이 높은거 찾으면 된다
var queue = [(Int,Int)](), idx = 0

func queueClear() {
    queue = []
    idx = 0
}

func visitedClear() {
    visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
}

func bfs() -> Int {
    var result = -1
    while idx < queue.count {
        let currentLoc = queue[idx]; idx += 1
        for i in 0..<4 {
            let ny = currentLoc.0 + dy[i]
            let nx = currentLoc.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] > 0 { continue }
            if adjMatrix[ny][nx] == "W" { continue }
            let tempNumber = visited[currentLoc.0][currentLoc.1] + 1
            visited[ny][nx] = tempNumber
            result = tempNumber > result ? tempNumber : result
            queue.append((ny,nx))
        }
    }
    return result
}

var result = 0
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == "W" { continue }
        queue.append((i,j))
        visited[i][j] = 1
        let tempResult = bfs() - 1
        result = tempResult > result ? tempResult : result
        queueClear()
        visitedClear()
    }
}
print(result)

