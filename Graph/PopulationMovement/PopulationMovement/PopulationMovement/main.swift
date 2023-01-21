//
//  main.swift
//  PopulationMovement
//
//  Created by Kay on 2023/01/18.
//

/*
 16234
 인구이동
 */
// 3rd week fast campus

// C++로 되어 있는 코드를 Swift로 이해하면서 바꾸기

/*
 지문 및 요구사항
 1. N * N
 2. r행 c열에 있는 나라에는 A[r][c]명
 3. 인구 이동은 하루 동안 다음과 같이 진행되고, 더 이상 아래 방법에 의해 인구 이동이 없을 때까지 지속된다.
 3-1. 국경선을 공유하는 두 나라의 인구 차이가 L명 이상, R명 이하라면, 두 나라가 공유하는 국경선을 오늘 하루 동안 연다.
 3-2. 위의 조건에 의해 열어야하는 국경선이 모두 열렸다면, 인구 이동을 시작한다.
 3-3. 국경선이 열려있어 인접한 칸만을 이용해 이동할 수 있으면, 그 나라를 오늘 하루 동안은 연합이라고 한다.
 3-4. 연합을 이루고 있는 각 칸의 인구수는 (연합의 인구수) / (연합을 이루고 있는 칸의 개수)가 된다. 편의상 소수점은 버린다.
 3-5. 연합을 해체하고, 모든 국경선을 닫는다.
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = userInput[0]
let L = userInput[1]
let R = userInput[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var totalList: [(Int,Int)] = []
var sum = 0
var result = 0

func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] == 1 { continue }
        if L <= (abs(adjMatrix[ny][nx] - adjMatrix[y][x])) && (abs(adjMatrix[ny][nx] - adjMatrix[y][x])) <= R {
            visited[ny][nx] = 1
            totalList.append((ny,nx))
            sum += adjMatrix[ny][nx]
            dfs(ny,nx)
        }
    }
}

while true {
    var flag: Bool = false
    visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == 0 {
                totalList.removeAll()
                visited[i][j] = 1
                totalList.append((i,j))
                sum = adjMatrix[i][j]
                dfs(i,j)
                if totalList.count == 1 { continue }
                for i in 0..<totalList.count {
                    adjMatrix[totalList[i].0][totalList[i].1] = sum / totalList.count
                    flag = true
                }
            }
        }
    }
    if flag == false {
        break
    }
    result += 1
}

print(result)
