//
//  main.swift
//  ComebackHome
//
//  Created by Kay on 2023/01/11.
//

/*
 1189
 컴백홈
 */
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let RCK = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RCK[0]
let C = RCK[1]
let K = RCK[2]

/*
 재귀를 이용한 백트래킹
 5x5에서 각 위치에서 전체 탐색 -> 시간복잡도는 5 * 5 * 25 = 625
 */

var map = [[Character]](repeating: [Character](), count: R)
var visited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)


for i in 0..<R {
    map[i].append(contentsOf: readLine()!.map { Character(String($0)) })
}


func search(_ y: Int, _ x: Int) -> Int {
    if y == 0 && x == C-1 {
        if K == visited[y][x] {
            return 1
        }
        return 0
    }
    var result = 0
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C || visited[ny][nx] > 0 || map[ny][nx] == "T" { continue }
        visited[ny][nx] = visited[y][x] + 1
        result += search(ny,nx)
        visited[ny][nx] = 0
    }
    return result
}
visited[R-1][0] = 1
print(search(R-1, 0))
