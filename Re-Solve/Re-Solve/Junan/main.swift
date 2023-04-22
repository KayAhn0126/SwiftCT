import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

let locations = readLine()!.split(separator: " ").map { Int(String($0))! }
let junanLocY = locations[0] - 1
let junanLocX = locations[1] - 1

let thiefLocY = locations[2] - 1
let thiefLocX = locations[3] - 1

var adjMatrix = [[Character]](repeating: [Character](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var queue: [(Int,Int)] = [], idx = 0
var newQueue: [(Int,Int)] = []

var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var crashList: [(Int, Int)] = []
var jump = 0
var flag = false

queue.append((junanLocY, junanLocX))
visited[junanLocY][junanLocX] = true
func bfs() {
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] == true { continue }
            visited[ny][nx] = true
            if adjMatrix[ny][nx] == "#" {
                flag = true
                break
            }
            if adjMatrix[ny][nx] == "1" {
                crashList.append((ny,nx))
                newQueue.append((ny,nx))
                continue
            }
            queue.append((ny,nx))
        }
    }
    for wall in crashList {
        adjMatrix[wall.0][wall.1] = "0"
    }
    jump += 1
    queue = newQueue
    newQueue = []
    crashList = []
    idx = 0
}

while flag == false {
    bfs()
}
print(jump)
