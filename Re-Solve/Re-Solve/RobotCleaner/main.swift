import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]
let currentLocationAndDirection = readLine()!.split(separator: " ").map { Int(String($0))! }

var cLocY = currentLocationAndDirection[0]
var cLocX = currentLocationAndDirection[1]
var cDir = currentLocationAndDirection[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var result = 0
var queue = [(Int, Int)](), idx = 0
queue.append((cLocY, cLocX))

while idx < queue.count {
    let currtLocation = queue[idx]; idx += 1
    let curY = currtLocation.0
    let curX = currtLocation.1
    if adjMatrix[curY][curX] == 0 {
        adjMatrix[curY][curX] = 2
        result += 1
    }
    var count = 0
    for i in 0..<4 {
        let nd = (cDir + 3 - i) % 4
        let ny = curY + dy[nd]
        let nx = curX + dx[nd]
        if ny < 0 || nx < 0 || ny >= N || nx >= M || adjMatrix[ny][nx] != 0 { continue }
        count += 1
        cDir = nd
        queue.append((ny,nx))
        break
    }
    if count == 0 {
        let backDir = (cDir + 2) % 4
        let backY = curY + dy[backDir]
        let backX = curX + dx[backDir]
        if backY < 0 || backX < 0 || backY >= N || backX >= M || adjMatrix[backY][backX] == 1 { break }
        queue.append((backY, backX))
    }
}
print(result)
