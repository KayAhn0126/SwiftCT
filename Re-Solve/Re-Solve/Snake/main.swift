import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var snake: [(Int, Int)] = [(1,1)] // 배열로 뱀 몸통 구현 큐처럼 활용
// 몸통길이 최대 100 * 10000초 = 100만, removFirst해도 괜찮다!
// 머리는 snake 배열의 맨 마지막
var head = 1 // 오른쪽

var time = 0

let N = Int(readLine()!)!
let K = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: N+1), count: N+1)

for _ in 0..<K {
    let tempAppleLoc = readLine()!.split(separator: " ").map { Int(String($0))! }
    adjMatrix[tempAppleLoc[0]][tempAppleLoc[1]] = 2
}

let turnCount = Int(readLine()!)!
var turnLocation: [Int: String] = [:]
for _ in 0..<turnCount {
    let tempTurnLoc = readLine()!.split(separator: " ").map { String($0) }
    let num = Int(tempTurnLoc[0])!
    turnLocation[num] = tempTurnLoc[1]
}

func turnHead(_ dir: String) {
    if dir == "L" {
        head = (head + 3) % 4
    } else {
        head = (head + 1) % 4
    }
}

while true {
    time += 1
    let currentHeadLoc = snake.last!
    let ny = currentHeadLoc.0 + dy[head]
    let nx = currentHeadLoc.1 + dx[head]
    if ny < 1 || ny > N || nx < 1 || nx > N { break }
    if snake.contains(where: { $0 == (ny,nx) }) {
        break
    }
    snake.append((ny,nx))
    if adjMatrix[ny][nx] == 2 {
        adjMatrix[ny][nx] = 0
    } else {
        snake.removeFirst()
    }

    if turnLocation[time] != nil { // 머리 방향을 바꿔야 하면 바꿔주기
        turnHead(turnLocation[time]!)
    }
}
print(time)
