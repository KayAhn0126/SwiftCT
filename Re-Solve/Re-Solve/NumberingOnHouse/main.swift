import Foundation

let N = Int(readLine()!)!

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var localResult = 1
func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] != 0 { continue }
        if adjMatrix[ny][nx] == 0 { continue }
        localResult += 1
        visited[ny][nx] = 1
        dfs(ny,nx)
    }
}

var dfsCount = 0
var resultArr = [Int]()
for i in 0..<N {
    for j in 0..<N {
        if visited[i][j] != 0 { continue }
        if adjMatrix[i][j] == 0 { continue }
        dfsCount += 1
        visited[i][j] = 1
        dfs(i,j)
        resultArr.append(localResult)
        localResult = 1
    }
}
print(dfsCount)
resultArr.sorted().forEach {
    print($0)
}
