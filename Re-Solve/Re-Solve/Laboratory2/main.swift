
//MARK: 이번엔 바이러스를 M개
// mC3이고 선택받지 못한 2의 자리들은 0으로 대체된다.

import Foundation

func combination<T>(_ array: [T], _ num: Int) -> [[T]] {
    var result: [[T]] = []
    if array.count < num { return result }
    
    func cycle(_ now: [T], _ index: Int) {
        if now.count == num {
            result.append(now)
            return
        }
        for i in index..<array.count {
            cycle(now + [array[i]], i + 1)
        }
    }
    cycle([],0)
    return result
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var twoList: [(Int, Int)] = []
for i in 0..<N {
    for j in 0..<N {
        if adjMatrix[i][j] == 2 {
            twoList.append((i,j))
            adjMatrix[i][j] = 0
        }
    }
}

var twoCombination = combination(twoList, M)


var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

//MARK: 바이러스가 다 퍼졌는지 체크하는 함수
func checkSpreadAll() -> Bool {
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == 0 && adjMatrix[i][j] == 0 { return false }
        }
    }
    return true
}

var bfsQueue = [(Int,Int)](), idx = 0

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var already = true

//MARK: 바이러스 퍼뜨리기 BFS
func bfs() -> Int {
    var tempResult = 0
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            if visited[ny][nx] != 0 { continue }
            if adjMatrix[ny][nx] != 0 { continue }
            already = false
            let newNum = visited[current.0][current.1] + 1
            visited[ny][nx] = newNum
            tempResult = newNum > tempResult ? newNum : tempResult
            bfsQueue.append((ny,nx))
        }
    }
    return tempResult
}

func visitedClear() {
    visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
}

var result = Int.max
var flag = false
for combi in twoCombination {
    for eachLocation in combi {
        adjMatrix[eachLocation.0][eachLocation.1] = 2
        visited[eachLocation.0][eachLocation.1] = 1
        bfsQueue.append((eachLocation.0, eachLocation.1))
    }
    let tempResult = bfs()
    if already == false && checkSpreadAll() == true {
        result = tempResult < result ? tempResult : result
        flag = true
    } else if already == true && checkSpreadAll() == true {
        result = 0
        flag = true
    }
    
    for eachLocation in combi {
        adjMatrix[eachLocation.0][eachLocation.1] = 0
    }
    visitedClear()
    bfsQueue = []
    idx = 0
}

if flag == false {
    print(-1)
} else {
    if already == true {
        print(0)
    } else {
        print(result - 1)
    }
}

