import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var queue = [(Int,Int)](), idx = 0
func bfs() {
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] != 0 { continue }
            if adjMatrix[ny][nx] == 0 { continue }
            visited[ny][nx] = visited[current.0][current.1] + 1
            queue.append((ny,nx))
        }
    }
}

visited[0][0] = 1
queue.append((0,0))
bfs()
print(visited[N-1][M-1])

