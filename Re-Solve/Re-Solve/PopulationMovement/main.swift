import Foundation

let NLR = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NLR[0]
let L = NLR[1]
let R = NLR[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var changeList: [(Int, Int)] = []

var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
var tempResult = 0
func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] == true { continue }
        let between = abs(adjMatrix[y][x] - adjMatrix[ny][nx])
        if L <= between && between <= R {
            changeList.append((ny,nx))
            tempResult += adjMatrix[ny][nx]
            visited[ny][nx] = true
            dfs(ny,nx)
        }
    }
}

func visitedClear() {
    visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
}


var time = 0
while true {
    var noChangeFlag = false
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == true { continue }
            changeList.removeAll()
            tempResult = 0
            visited[i][j] = true
            changeList.append((i,j))
            tempResult += adjMatrix[i][j]
            dfs(i,j)
            if changeList.count == 1 { continue }
            let count = changeList.count
            for i in 0..<count {
                adjMatrix[changeList[i].0][changeList[i].1] = tempResult / count
                noChangeFlag = true
            }
        }
    }
    if noChangeFlag == false {
        break
    }
    visitedClear()
    time += 1
}
print(time)
