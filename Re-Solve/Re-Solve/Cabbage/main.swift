import Foundation

var tc = Int(readLine()!)!

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

while tc > 0 {
    tc -= 1
    let MNK = readLine()!.split(separator: " ").map { Int(String($0))! }
    let N = MNK[1]
    let M = MNK[0]
    let K = MNK[2]
    var adjMatrix = [[Int]](repeating: [Int](repeating:0, count: M), count: N)
    var visited = [[Int]](repeating: [Int](repeating:0, count: M), count: N)
    for _ in 0..<K {
        let ij = readLine()!.split(separator: " ").map { Int(String($0))! }
        adjMatrix[ij[1]][ij[0]] = 1
    }
    var count = 0
    func dfs(_ y: Int, _ x: Int) {
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] != 0 { continue }
            if adjMatrix[ny][nx] == 0 { continue }
            visited[ny][nx] = 1
            dfs(ny,nx)
        }
    }
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 1 { continue }
            if adjMatrix[i][j] == 0 { continue }
            count += 1
            visited[i][j] = 1
            dfs(i,j)
        }
    }
    print(count)
}
