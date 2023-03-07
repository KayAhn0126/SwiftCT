//
//  main.swift
//  RGColorBlind
//
//  Created by Kay on 2023/03/07.
//

/*
 10026
 적록색약
 */

// 적록색약이 아닌 사람이 봤을 때의 구역의 개수와 적록색약인 사람이 봤을 때의 구역의 수를 공백으로 구분해 출력한다.
/*
 적록색약 맵을 따로 만든다 R과 G를 "X"로 바꾼 맵을 하나 만들어서 따로 DFS
 dfs를 함수로 만들어서 시작 위치와 현재 찾으려는 색상
 */
import Foundation

let N = Int(readLine()!)!

// 문제에서 주어지는 맵을 받을것이고
var RGNonBlindMap = [[Character]](repeating: [Character](), count: N)
// 기본으로 주어지는 맵에서 R과 G의 위치를 모두 찾은 후 "X"로 바꿔줄 것이다.
var RGBlindMap = [[Character]](repeating: [Character](), count: N)

var RGNonBlindVisited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

var RGBlindVisited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

for i in 0..<N {
    let userInputLine = readLine()!
    RGNonBlindMap[i].append(contentsOf: userInputLine)
    RGBlindMap[i].append(contentsOf: userInputLine)
}

var RGList: [(Int, Int)] = []
for i in 0..<N {
    for j in 0..<N {
        if RGNonBlindMap[i][j] == "R" || RGNonBlindMap[i][j] == "G" {
            RGList.append((i,j))
        }
    }
}

RGList.enumerated().forEach {
    RGBlindMap[$0.element.0][$0.element.1] = "X"
}


let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ y: Int, _ x: Int, _ findChar: Character, _ blindOption: Bool) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if blindOption == false {
            if RGNonBlindVisited[ny][nx] != 0 { continue }
            if RGNonBlindMap[ny][nx] == findChar {
                RGNonBlindVisited[ny][nx] = 1
                dfs(ny, nx, findChar, false)
            }
        } else {
            if RGBlindVisited[ny][nx] != 0 { continue }
            if RGBlindMap[ny][nx] == findChar {
                RGBlindVisited[ny][nx] = 1
                dfs(ny, nx, findChar, true)
            }
        }
    }
}

var nonBlindResult = 0
var blindResult = 0

// non-blind = 1, blind = 2
func go(_ findChar: Character, _ blindOption: Bool) {
    for i in 0..<N {
        for j in 0..<N {
            if blindOption == false { // non-bline
                if RGNonBlindVisited[i][j] == 1 { continue }
                if RGNonBlindMap[i][j] == findChar {
                    RGNonBlindVisited[i][j] = 1
                    dfs(i, j, RGNonBlindMap[i][j], false)
                    nonBlindResult += 1
                }
            }
            else {           // blind
                if RGBlindVisited[i][j] == 1 { continue }
                if RGBlindMap[i][j] == findChar {
                    RGBlindVisited[i][j] = 1
                    dfs(i, j, RGBlindMap[i][j], true)
                    blindResult += 1
                }
            }
        }
    }
}

go("R",false)
go("G",false)
go("B",false)

go("X",true)
go("B",true)

print("\(nonBlindResult) \(blindResult)")

