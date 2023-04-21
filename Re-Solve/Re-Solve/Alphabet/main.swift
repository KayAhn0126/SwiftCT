import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var board = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    board[i].append(contentsOf: readLine()!.map { Int($0.asciiValue!) - 65 })
}
var finalResult = 1
var visited: Int = (1 << 26) // 100 0000 0000 0000 0000 0000 0000
visited |= (1 << board[0][0])

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ y: Int, _ x: Int, _ tempResult: Int) {
    if tempResult > finalResult {
        finalResult = tempResult
    }
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited & (1 << board[ny][nx]) != 0 { continue }
        visited |= (1 << board[ny][nx])
        dfs(ny, nx, tempResult + 1)
        visited &= ~(1 << board[ny][nx])
    }
}
dfs(0,0,finalResult)
print(finalResult)
