import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var board = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    board[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: M), count: N), count: 2)

var queue: [(Int,Int,Int)] = [], idx = 0
visited[0][0][0] = 1
queue.append((0,0,0))

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

// visited[벽 부쉈는지][y][x]
func bfs() -> Int {
    while idx < queue.count {
        let currentStatus = queue[idx]; idx += 1
        let currentBreak = currentStatus.0
        let currentY = currentStatus.1
        let currentX = currentStatus.2
        if currentY == N - 1 && currentX == M - 1 {
            return visited[currentBreak][N - 1][M - 1]
        }
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if currentBreak == 1 && board[ny][nx] == 1 { continue }
            if visited[currentBreak][ny][nx] != 0 { continue }
            if board[ny][nx] == 1 {
                visited[1][ny][nx] = visited[0][currentY][currentX] + 1
                queue.append((1, ny, nx))
                continue
            }
            visited[currentBreak][ny][nx] = visited[currentBreak][currentY][currentX] + 1
            queue.append((currentBreak, ny, nx))
        }
    }
    return -1
}
print(bfs())
