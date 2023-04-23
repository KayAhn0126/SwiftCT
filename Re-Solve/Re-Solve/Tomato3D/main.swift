import Foundation

let MND = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = MND[1]
let M = MND[0]
let D = MND[2]

struct ZYX {
    var Z: Int
    var Y: Int
    var X: Int
}

var adjMatrix = [[[Int]]](repeating: [[Int]](repeating: [Int](), count: N), count: D)
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: M), count: N), count: D)

for i in 0..<D {
    for j in 0..<N {
        adjMatrix[i][j].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
    }
}

//MARK: adjMatrix[높이][세로][가로] 순서
let dz = [-1,0,1]
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]


var spendTime = false
var max = 0
var bfsQueue: [ZYX] = [], idx = 0

for i in 0..<D {
    for j in 0..<N {
        for k in 0..<M {
            if adjMatrix[i][j][k] == 1 {
                bfsQueue.append(ZYX(Z: i, Y: j, X: k))
                visited[i][j][k] = 1
            }
        }
    }
}

func bfs() {
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1
        let currentZ = current.Z
        let currentY = current.Y
        let currentX = current.X
        for layer in 0..<3 {
            if dz[layer] == 0 {
                for i in 0..<4 {
                    let ny = currentY + dy[i]
                    let nx = currentX + dx[i]
                    if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
                    if visited[layer][ny][nx] != 0 { continue }
                    if adjMatrix[layer][ny][nx] != 0 { continue }
                    let newNum = visited[currentZ][currentY][currentX] + 1
                    visited[currentZ][ny][nx] = newNum
                    max = newNum > max ? newNum : max
                    bfsQueue.append(ZYX(Z: currentZ, Y: ny, X: nx))
                    spendTime = true
                }
            } else {
                let nz = currentZ + dz[layer]
                if nz < 0 || nz >= D { continue }
                if visited[nz][currentY][currentX] != 0 { continue }
                if adjMatrix[nz][currentY][currentX] != 0 { continue }
                let newNum = visited[currentZ][currentY][currentX] + 1
                visited[nz][currentY][currentX] = newNum
                max = newNum > max ? newNum : max
                bfsQueue.append(ZYX(Z: nz, Y: currentY, X: currentX))
                spendTime = true
            }
        }
    }
}

func checkZeroes() -> Bool {
    for i in 0..<D {
        for j in 0..<N {
            for k in 0..<M {
                if visited[i][j][k] == 0 && adjMatrix[i][j][k] != -1 { return true }
            }
        }
    }
    return false
}

bfs()

if checkZeroes() == true {
    print(-1)
} else {
    if spendTime == true {
        print(max - 1)
    } else {
        print(0)
    }
}

