import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

//MARK: combination 구하기
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

// 0의 위치를 가지는 리스트를 구한다.
// 위의 리스트를 기반으로 벽을 세울수 있게 조합을 구한다.
// 벽을 세우고 바이러스 퍼트리고 안전영역 구하고 벽 허물기
// 위 상황을 반복하면서 안전영역의 최대값 구하기

var zeroList: [(Int,Int)] = []
var virusList: [(Int,Int)] = []
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 0 { zeroList.append((i,j)) }
        if adjMatrix[i][j] == 2 { virusList.append((i,j)) }
    }
}

var wallList = combination(zeroList, 3)
 
func getSafeArea() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 0 && visited[i][j] == 0 { result += 1 }
        }
    }
    return result
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] != 0 { continue }
        if adjMatrix[ny][nx] != 0 { continue }
        visited[ny][nx] = 2
        dfs(ny,nx)
    }
}

func visitedClear() {
    visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
}

var total = 0

for wall in wallList {
    adjMatrix[wall[0].0][wall[0].1] = 1
    adjMatrix[wall[1].0][wall[1].1] = 1
    adjMatrix[wall[2].0][wall[2].1] = 1
    for location in virusList {
        dfs(location.0, location.1)
    }
    let safeCount = getSafeArea()
    total = safeCount > total ? safeCount : total
    visitedClear()
    adjMatrix[wall[0].0][wall[0].1] = 0
    adjMatrix[wall[1].0][wall[1].1] = 0
    adjMatrix[wall[2].0][wall[2].1] = 0
}
print(total)
