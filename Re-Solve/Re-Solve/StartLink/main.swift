import Foundation

let FSGUD = readLine()!.split(separator: " ").map { Int(String($0))! }
let F = FSGUD[0]
let S = FSGUD[1]
let G = FSGUD[2]
let U = FSGUD[3]
let D = FSGUD[4]

var visited = [Int](repeating: 0, count: F + 1)

let levels = [U, -D]
var queue = [Int](), idx = 0
func bfs() {
    while idx < queue.count {
        let currentLevel = queue[idx]; idx += 1
        for level in levels {
            if currentLevel + level < 1 || currentLevel + level > F { continue }
            if visited[currentLevel + level] != 0 { continue }
            visited[currentLevel + level] = visited[currentLevel] + 1
            queue.append(currentLevel + level)
        }
    }
}

queue.append(S)
visited[S] = 1
bfs()
if visited[G] == 0 {
    print("use the stairs")
} else {
    print(visited[G] - 1)
}
