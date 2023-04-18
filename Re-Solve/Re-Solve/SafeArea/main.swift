import Foundation

let N = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ level: Int, _ y: Int, _ x: Int, _ visited: inout [[Bool]]) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if adjMatrix[ny][nx] <= level { continue }
        if visited[ny][nx] == true { continue }
        visited[ny][nx] = true
        dfs(level, ny, nx, &visited)
    }
}

// 100 * (100 * 100) = 100만
var max = Int.min
for level in 1...100 {
    var currentCount = 0
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == true { continue }
            if adjMatrix[i][j] <= level { continue }
            visited[i][j] = true
            currentCount += 1
            dfs(level, i,j, &visited)
        }
    }
    max = currentCount > max ? currentCount : max
}
if max == 0 {
    print(1)
} else {
    print(max)
}
