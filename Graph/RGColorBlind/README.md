# 10026 적록색약
- 상황별 Connected Component 구하는 문제

## 🍎 문제 접근
- 맵이 하나 주어지는데 이 맵은 "R", "G", "B"로 이루어져 있다.
- 적록색약인 사람이 봤을때 구역의 갯수와 적록색약이 아닌 사람이 봤을때 구역의 갯수를 출력하면 풀리는 문제이다.
- 적록색약이 아닌 사람이 보는 맵은 R,G,B로 이루어져있고 이것을 RGNonBlindMap로 사용할 것이다.
- 적록색약인 사람이 보는 맵을 RGBlindMap로 사용할 것이다.
    - 하지만 적록색약인 사람이 봤을때는 "R"과 "G"가 하나로 보이는데 이것을 "X"라고 만들것이다.
- visited 배열도 따로 만들어주었다.

## 🍎 문제 풀이
- dfs 함수에서 blindOption를 매개변수로 받는데 이것은 적록색약인지 아닌지 구분한다.
- 나머지는 BFS + 최단거리로 답을 구해주면 된다.

## 🍎 전체 코드
```swift
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
```
