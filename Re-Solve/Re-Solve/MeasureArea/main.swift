import Foundation

let MNK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = MNK[0]
let M = MNK[1]
let K = MNK[2]

var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)

// 주어진대로 색칠하기
// dfs로 범위 구하기 -> arr에 넣기
// CC 갯수 구하기

for i in 0..<K {
    let locations = readLine()!.split(separator: " ").map { Int(String($0))! }
    let fromY = locations[1]
    let fromX = locations[0]
    let toY = locations[3]
    let toX = locations[2]
    for j in fromY..<toY {
        for k in fromX..<toX {
            adjMatrix[j][k] = 1
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ y: Int, _ x: Int, _ areaCounter: inout Int) {
    areaCounter += 1
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == true { continue }
        if adjMatrix[ny][nx] != 0 { continue }
        visited[ny][nx] = true
        dfs(ny, nx, &areaCounter)
    }
}

var resultArr = [Int]()
var totalCounter = 0
for i in 0..<N {
    for j in 0..<M {
        if visited[i][j] == true { continue }
        if adjMatrix[i][j] == 1 { continue }
        totalCounter += 1
        visited[i][j] = true
        var area = 0
        dfs(i, j, &area)
        resultArr.append(area)
    }
}

print(totalCounter)
resultArr.sorted(by: < ).forEach {
    print($0)
}
