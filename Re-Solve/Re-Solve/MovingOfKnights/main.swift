import Foundation

var tc = Int(readLine()!)!
let possibleMove = [(-1,-2), (-2,-1), (-2,1), (-1,2), (1,2), (2,1), (2,-1), (1,-2)]

while tc > 0 {
    let L = Int(readLine()!)!
    var visited = [[Int]](repeating: [Int](repeating: 0, count: L), count: L)
    var queue = [(Int,Int)](), idx = 0
    
    let from = readLine()!.split(separator: " ").map { Int(String($0))! }
    visited[from[0]][from[1]] = 1
    queue.append((from[0],from[1]))
    
    let to = readLine()!.split(separator: " ").map { Int(String($0))! }
    let goalY = to[0]
    let goalX = to[1]
    
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        let currentY = current.0
        let currentX = current.1
        if currentY == goalY && currentX == goalX {
            break
        }
        for move in possibleMove {
            let ny = currentY + move.0
            let nx = currentX + move.1
            if ny < 0 || nx < 0 || ny >= L || nx >= L { continue }
            if visited[ny][nx] != 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            queue.append((ny,nx))
        }
    }
    print(visited[goalY][goalX] - 1)
    tc -= 1
}
