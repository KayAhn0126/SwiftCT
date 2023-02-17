//
//  main.swift
//  Laboratory
//
//  Created by Kay on 2023/02/16.
//

/*
 14502
 연구소
 */

// 벽 조합 구하기 = (64 - 2의 갯수 - 1의 갯수) C 3 = 41664이하
// 바이러스 퍼뜨리기 = DFS의 반복횟수
// 0의 갯수 체크하기 = 64

// O(40000 * 64)

/*
 1. 빈칸 위치 저장. + 바이러스 퍼뜨릴 바이러스 위치 저장 + 벽 위치 저장.
 2. Combination으로 빈칸 조합 구하기
 3. Combination을 이용해 조건에 맞게 벽 세우기 + 바이러스 퍼뜨리기 + 0의 갯수 체크하기 + 벽 허물기
 4. 조합 바뀔때마다 0의 갯수 체크 + max 구하기
 */

import Foundation

func combination<T>(_ arr:[T], _ num: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < num { return result }
    func cycle(_ now: [T], _ index: Int) {
        if now.count == num {
            result.append(now)
            return
        }
        for i in index..<arr.count {
            cycle(now + [arr[i]], i + 1)
        }
    }
    cycle([], 0)
    return result
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var emptyLocation: [(Int,Int)] = []
var wallLocation: [(Int,Int)] = []
var virusLocation: [(Int,Int)] = []

var result = 0

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 0 {
            emptyLocation.append((i,j))
        } else if adjMatrix[i][j] == 1 {
            wallLocation.append((i,j))
        } else {
            virusLocation.append((i,j))
        }
    }
}

var combination: [[(Int,Int)]] = combination(emptyLocation, 3)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

func clearVisited() {
    for i in 0..<N {
        for j in 0..<M {
            visited[i][j] = 0
        }
    }
}

func dfs(_ y: Int, _ x: Int) {
    visited[y][x] = 2
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == 2  || adjMatrix[ny][nx] == 1  || adjMatrix[ny][nx] == 2 { continue }
        dfs(ny,nx)
    }
}


func countZeroes() {
    var temp = 0
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 0 && adjMatrix[i][j] == 0 {
                temp += 1
            }
        }
    }
    result = temp > result ? temp : result
}

func spreadVirus() {
    for location in virusLocation {
        dfs(location.0, location.1)
    }
}

for combi in combination {
    adjMatrix[combi[0].0][combi[0].1] = 1
    adjMatrix[combi[1].0][combi[1].1] = 1
    adjMatrix[combi[2].0][combi[2].1] = 1
    spreadVirus()
    countZeroes()
    adjMatrix[combi[0].0][combi[0].1] = 0
    adjMatrix[combi[1].0][combi[1].1] = 0
    adjMatrix[combi[2].0][combi[2].1] = 0
    clearVisited()
}
print(result)

// 2시간++
