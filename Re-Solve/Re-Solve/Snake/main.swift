// 벽 = 1
// 사과 = 3
// 뱀의 몸 = 방문배열에서 true로 관리

// N * N
// 사과 위치는 받자마자 맵에 적용

// 뱀이 늘어나는 과정 -> 머리를 다음칸에 위치 시킨다.
// 머리가 늘어난 공간에 사과가 있다면 꼬리 유지
// 사과가 없다면 꼬리 삭제

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var time = 0
var snake: [(Int, Int)] = []
var snakeDirection = 1
var timeTurnArr = [Character](repeating: " ", count: 10001)

func turnLeft() {
    snakeDirection = (snakeDirection + 3) % 4
}

func turnRight() {
    snakeDirection = (snakeDirection + 1) % 4
}

//MARK: 입력 받기
let N = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: N + 1), count: N + 1)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: N + 1), count: N + 1)


let appleCount = Int(readLine()!)!
for _ in 0..<appleCount {
    let YX = readLine()!.split(separator: " ").map { Int(String($0))! }
    let Y = YX[0]
    let X = YX[1]
    adjMatrix[Y][X] = 3
}
let orderCount = Int(readLine()!)!
for _ in 0..<orderCount {
    let order = readLine()!.split(separator: " ").map { String($0) }
    let time = Int(order[0])!
    let to = Character(order[1])
    timeTurnArr[time] = to
}

snake.append((1,1))
visited[1][1] = true

while true {
    time += 1
    
    let currentHead = snake.last!
    let ny = currentHead.0 + dy[snakeDirection]
    let nx = currentHead.1 + dx[snakeDirection]
    if ny < 1 || nx < 1 || ny > N || nx > N || visited[ny][nx] == true {
        print(time)
        break
    }
    snake.append((ny,nx))
    visited[ny][nx] = true
    
    if adjMatrix[ny][nx] == 3 {
        adjMatrix[ny][nx] = 0
    } else {
        let first = snake.first!
        visited[first.0][first.1] = false
        snake.removeFirst()
    }
    if timeTurnArr[time] != " " {
        if timeTurnArr[time] == "L" {
            turnLeft()
        } else {
            turnRight()
        }
    }
}
