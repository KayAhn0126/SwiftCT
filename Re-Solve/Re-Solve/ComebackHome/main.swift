import Foundation

let RCK = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RCK[0]
let C = RCK[1]
let K = RCK[2]

var board = [[Character]](repeating: [Character](), count: R)
var visited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)
for i in 0..<R {
    board[i].append(contentsOf: readLine()!)
}

let startLoc: (Int,Int) = (R-1, 0)
let endLoc: (Int,Int) = (0, C-1)
visited[startLoc.0][startLoc.1] = 1

var result = 0
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ y: Int, _ x: Int, _ depth: Int) {
    if y == endLoc.0 && x == endLoc.1 && depth == K {
        result += 1
        return
    }
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
        if visited[ny][nx] != 0 { continue }
        if board[ny][nx] == "T" { continue }
        visited[ny][nx] = visited[y][x] + 1
        dfs(ny, nx, depth+1)
        visited[ny][nx] = 0
    }
}
dfs(startLoc.0, startLoc.1, 1)
print(result)
