import Foundation

let N = Int(readLine()!)!

var normalMatrix = [[Character]](repeating: [Character](), count: N)
var cbMatrix = [[Character]](repeating: [Character](), count: N)

var normalVistied = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
var cbVistied = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)

for i in 0..<N {
    let arr = readLine()!.map { Character(String($0)) }
    normalMatrix[i].append(contentsOf: arr)
    cbMatrix[i].append(contentsOf: arr)
}
for i in 0..<N {
    for j in 0..<N {
        if cbMatrix[i][j] == "R" || cbMatrix[i][j] == "G" {
            cbMatrix[i][j] = "R"
        }
    }
}

let RGB: [Character] = ["R", "G", "B"]


let dy = [-1,0,1,0]
let dx = [0,1,0,-1]


func normalDFS(_ y: Int, _ x: Int, _ char: Character) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if normalVistied[ny][nx] == true { continue }
        if normalMatrix[ny][nx] != char { continue }
        normalVistied[ny][nx] = true
        normalDFS(ny,nx,char)
    }
}

func cbDFS(_ y: Int, _ x: Int, _ char: Character) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if cbVistied[ny][nx] == true { continue }
        if cbMatrix[ny][nx] != char { continue }
        cbVistied[ny][nx] = true
        cbDFS(ny,nx,char)
    }
}

var normalTotal = 0
for i in 0..<N {
    for j in 0..<N {
        if normalVistied[i][j] == true { continue }
        normalVistied[i][j] = true
        normalDFS(i,j, normalMatrix[i][j])
        normalTotal += 1
    }
}

var cbTotal = 0
for i in 0..<N {
    for j in 0..<N {
        if cbVistied[i][j] == true { continue }
        cbVistied[i][j] = true
        cbDFS(i,j, cbMatrix[i][j])
        cbTotal += 1
    }
}
print("\(normalTotal) \(cbTotal)")
