import Foundation

let yx = readLine()!.split(separator: " ").map { Int(String($0))! }
let y = yx[0]
let x = yx[1]

var arr = [[Character]](repeating: [Character](), count: y)

for i in 0..<y {
    arr[i].append(contentsOf: readLine()!.map { Character(String($0)) })
}
var visited = [[Int]](repeating: [Int](repeating: -1, count: x), count: y)

for i in 0..<y {
    var cFlag = false
    var counter = 1
    for j in 0..<x {
        if arr[i][j] == "c" {
            visited[i][j] = 0
            counter = 1
            cFlag = true
        } else if arr[i][j] == "." && cFlag == true {
            visited[i][j] = counter
            counter += 1
        }
    }
}
for i in 0..<y {
    for j in 0..<x {
        print(visited[i][j], terminator: " ")
    }
    print("")
}
