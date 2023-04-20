import Foundation

let NLR = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NLR[0]
let L = NLR[1]
let R = NLR[2]

var board = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    board[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]
var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
var unionList: [(Int,Int)] = []
var unionSum = 0

func dfs(_ y: Int, _ x: Int) {
    visited[y][x] = true
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] != false { continue }
        let between = abs(board[y][x] - board[ny][nx])
        if L <= between && between <= R {
            unionList.append((ny,nx))
            unionSum += board[ny][nx]
            dfs(ny,nx)
        }
    }
}

var time = 0
while true {
    var flag = false
    visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == true { continue }
            unionList.removeAll()
            unionSum = 0
            unionList.append((i,j))
            unionSum += board[i][j]
            dfs(i,j)
            if unionList.count != 1 {
                let num = unionList.count
                for loc in unionList {
                    board[loc.0][loc.1] = unionSum / num
                }
                flag = true
            }
        }
    }
    if flag == false {
        break
    }
    time += 1
}
print(time)
