import Foundation

// -1 -> 비활성화
// 0 -> 바이러스가 퍼질 수 있는 곳
// 1 -> 벽
// 2 -> 바이러스

// 먼저 2의 위치를 구하고 모든 2의 위치를 -1로 바꿔준다.( 비활성화 상태)
// 총 갯수에서 m개 조합을 구한다.
// 바이러스가 퍼질때 비활성화 바이러스가 활성화가 되는데 이때 카운트는 하지 않고 큐에만 넣어준다.


let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // N * N 배열
let M = NM[1] // M 개의 바이러스 선택!

// bfs를 한번도 실행 안했는데 이미 바이러스가 다 퍼져있고 + 맵에 0이 없는 경우

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var twoList: [(Int,Int)] = []

for i in 0..<N {
    for j in 0..<N {
        if adjMatrix[i][j] == 2 {
            twoList.append((i,j))
            adjMatrix[i][j] = -1
        }
    }
}

func combination<T>(_ array: [T], _ n: Int) -> [[T]] {
    var result: [[T]] = []
    if array.count < n { return result }
    
    func cycle(_ now: [T], _ index: Int) {
        if now.count == n {
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

var combi = combination(twoList, M)


var bfsQueue: [(Int,Int)] = [], idx = 0
var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

//MARK: 0이 있는지 확인하는 함수, 0이 있으면 true, 없으면 false 반환
func checkZeroes() -> Bool {
    for i in 0..<N {
        for j in 0..<N {
            if adjMatrix[i][j] == 0 && visited[i][j] == 0 { return false }
        }
    }
    return true
}


let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var already = true
//MARK: 바이러스 퍼뜨리는 BFS함수 다 퍼질 때 까지의 시간을 구한다.
func bfs() -> Int {
    var tempResult = 0
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = current.0 + dy[i]
            let nx = current.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            if visited[ny][nx] != 0 { continue }
            if adjMatrix[ny][nx] == 1 { continue }
            let nextNum = visited[current.0][current.1] + 1
            visited[ny][nx] = nextNum
            if adjMatrix[ny][nx] == 0 {
                tempResult = nextNum > tempResult ? nextNum : tempResult
                already = false
            }
            bfsQueue.append((ny,nx))
        }
    }
    return tempResult
}

var result = Int.max
var flag = false
for locations in combi {
    for location in locations {
        adjMatrix[location.0][location.1] = 2
        bfsQueue.append((location.0, location.1))
        visited[location.0][location.1] = 1
    }
    let current = bfs()
    if already == false && checkZeroes() == true { // 0이 없다면
        result = current < result ? current : result
        flag = true
    } else if already == true && checkZeroes() == true {
        flag = true
        break
    }
    for location in locations {
        adjMatrix[location.0][location.1] = -1
    }
    
    bfsQueue = []
    idx = 0
    visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
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
