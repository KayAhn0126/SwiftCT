//
//  main.swift
//  Cabbage
//
//  Created by Kay on 2023/02/12.
//

/*
 1012
 유기농 배추
 */

/*
 connected component 갯수 구하기
 맵 크기 -> 최대 50 * 50
 배추의 위치가 인접 리스트로 주어진다. -> 아니다!
 인접리스트로 주어지는것 같지만 좌표를 주고 있으므로 행렬로 풀어야 한다.
 또, 테스트 케이스를 보면 (x,y)형태로 주어지는것을 알 수 있다.
 인접 행렬 + (y,x) 형태로 풀자!
 
 시간복잡도는 전체를 검사한다고 했을때, 50 * 50 * dfs만큼.
 
 토탈 테스트 수.
 M N K로 주어진다.
 */


import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let totalTry = Int(readLine()!)!
for _ in 0..<totalTry {
    let MNK = readLine()!.split(separator: " ").map { Int(String($0))! }
    let N = MNK[1]
    let M = MNK[0]
    let K = MNK[2]
    var matrix = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    func dfs(_ y: Int, _ x: Int) {
        visited[y][x] = 1
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if matrix[ny][nx] == 0 || visited[ny][nx] == 1 { continue }
            dfs(ny,nx)
        }
    }
    for _ in 0..<K {
        let XY = readLine()!.split(separator: " ").map { Int(String($0))! }
        let Y = XY[1]
        let X = XY[0]
        matrix[Y][X] = 1
    }
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            if matrix[i][j] == 0 || visited[i][j] == 1 { continue }
            dfs(i,j)
            result += 1
        }
    }
    print(result)
}
// 1시간
