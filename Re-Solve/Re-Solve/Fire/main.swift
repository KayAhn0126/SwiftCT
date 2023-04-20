import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

let INF = 987654321

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { $0 })
}

var jihoonLocation: (Int, Int)

var jihoonQueue = [(Int,Int)](), jihoonIdx = 0
var fireQueue = [(Int, Int)](), fireIdx = 0

var jihoonVisited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
var fireVisited = [[Int]](repeating: [Int](repeating: INF, count: M), count: N)


for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == "J" {
            jihoonQueue.append((i,j))
            jihoonVisited[i][j] = 1
        } else if adjMatrix[i][j] == "F" {
            fireQueue.append((i,j))
            fireVisited[i][j] = 1
        }
    }
}


let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func checkEdge(_ y: Int, _ x: Int) -> Bool {
    if y == 0 || x == 0 || y == N - 1 || x == M - 1 { return true }
    return false
}

var resultFlag = false
var result = 0

// 초기에 0으로 세팅하면 불이 하나도 없는데 지훈이는 지나가지 못한다!
// 큰수로 세팅 해두고 불이 실제로 퍼진 지역을 체크하면서
func jihoonBFS() {
    while jihoonIdx < jihoonQueue.count {
        let current = jihoonQueue[jihoonIdx]; jihoonIdx += 1
        let currentY = current.0
        let currentX = current.1
        if checkEdge(currentY, currentX) == true {
            resultFlag = true
            result = jihoonVisited[currentY][currentX]
            break
        }
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if jihoonVisited[ny][nx] != 0 { continue }
            if adjMatrix[ny][nx] == "#" { continue }
            if fireVisited[ny][nx] <= jihoonVisited[currentY][currentX] + 1 {
                continue
            }
            jihoonVisited[ny][nx] = jihoonVisited[currentY][currentX] + 1
            jihoonQueue.append((ny,nx))
        }
    }
}


func fireBFS() {
    while fireIdx < fireQueue.count {
        let current = fireQueue[fireIdx]; fireIdx += 1
        let currentY = current.0
        let currentX = current.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if fireVisited[ny][nx] != INF { continue }
            if adjMatrix[ny][nx] == "#" { continue }
            fireVisited[ny][nx] = fireVisited[currentY][currentX] + 1
            fireQueue.append((ny,nx))
        }
    }
}

fireBFS()
jihoonBFS()

if resultFlag == true {
    print(result)
} else {
    print("IMPOSSIBLE")
}

