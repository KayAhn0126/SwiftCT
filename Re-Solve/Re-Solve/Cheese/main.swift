import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

//MARK: 녹일 치즈 찾기
var list: [(Int,Int)] = []
func findMeltingPoints(_ y: Int, _ x: Int, _ visited: inout [[Bool]]) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == true { continue }
        if adjMatrix[ny][nx] == 1 {
            list.append((ny,nx))
            continue
        }
        visited[ny][nx] = true
        findMeltingPoints(ny,nx,&visited)
    }
}

//MARK: 실제 치즈 녹이기
func meltingCheese() {
    for i in list {
        adjMatrix[i.0][i.1] = 0
    }
    list.removeAll()
}

//MARK: 치즈 조각 갯수 세기
func getCount() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 1 {
                result += 1
            }
        }
    }
    return result
}

var time = 0
var last = 0
while true {
    let number = getCount()
    if number == 0 {
        print(time)
        print(last)
        break
    }
    last = number
    time += 1
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
    visited[0][0] = true
    findMeltingPoints(0, 0, &visited)
    meltingCheese()
}
