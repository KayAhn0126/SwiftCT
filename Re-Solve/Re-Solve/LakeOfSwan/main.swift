import Foundation

// 1500 * 1500 사이즈이므로 O(N) 이하로 풀어야한다.
// 플러드 필 알고리즘 사용

let RC = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RC[0]
let C = RC[1]

var adjMatrix = [[Character]](repeating: [Character](), count: R)

for i in 0..<R {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var swanLocation: [(Int,Int)] = []


let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var currentMeltQueue: [(Int,Int)] = [], idx = 0
var nextMeltQueue: [(Int,Int)] = []
var visited = [[Bool]](repeating: [Bool](repeating: false, count: C), count: R)


var swanQueue: [(Int,Int)] = [], swanIdx = 0
var nextSwanQueue: [(Int,Int)] = []
var swanVisited = [[Bool]](repeating: [Bool](repeating: false, count: C), count: R)

for i in 0..<R {
    for j in 0..<C {
        if adjMatrix[i][j] != "X" {
            currentMeltQueue.append((i,j))
            visited[i][j] = true
            if adjMatrix[i][j] == "L" {
                swanLocation.append((i,j))
            }
        }
    }
}

let firstSwanLoc = swanLocation[0]
let secondSwanLoc = swanLocation[1]

swanQueue.append((firstSwanLoc.0, firstSwanLoc.1))
swanVisited[firstSwanLoc.0][firstSwanLoc.1] = true

var found = false
var time = 0




//MARK: 얼음을 만나면 저장하는 BFS
func meltBFS() {
    while idx < currentMeltQueue.count {
        let current = currentMeltQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
            if visited[ny][nx] == true { continue }
            visited[ny][nx] = true
            if adjMatrix[ny][nx] == "X" {
                nextMeltQueue.append((ny,nx))
                continue
            }
            currentMeltQueue.append((ny,nx))
        }
    }
    for i in nextMeltQueue {
        adjMatrix[i.0][i.1] = "."
    }
    currentMeltQueue = nextMeltQueue
    idx = 0
    nextMeltQueue = []
}


//MARK: 백조가 다른 백조를 찾아가는 BFS
func swanBFS() {
    while swanIdx < swanQueue.count {
        let current = swanQueue[swanIdx]; swanIdx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
            if swanVisited[ny][nx] == true { continue }
            swanVisited[ny][nx] = true
            if adjMatrix[ny][nx] == "X" {
                nextSwanQueue.append((ny,nx))
                continue
            }
            if ny == secondSwanLoc.0 && nx == secondSwanLoc.1 { found = true; break }
            swanQueue.append((ny,nx))
        }
    }
    swanQueue = nextSwanQueue
    nextSwanQueue = []
    swanIdx = 0
}


while true {
    swanBFS()
    if found == true {
        print(time)
        break
    }
    meltBFS()
    time += 1
}
