//
//  main.swift
//  Alphabet
//
//  Created by Kay on 2023/03/24.
//

/*
 1987
 알파벳
 */

/*
 다음 가려는 곳이 계수 정렬 값이 1이라면 continue.
 queue에 아무것도 남지 않으면 종료
 매번 max값 갱신
 백트래킹 할 때 계수 정렬 배열도 같이 해주기.
 
 */

import Foundation

let RC = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RC[0]
let C = RC[1]

var adjMatrix = [[Int]](repeating: [Int](), count: R)

for i in 0..<R {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int($0.asciiValue!) - 65 })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var countingArr = [Bool](repeating: false, count: 26)
var visited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)


visited[0][0] = 1
countingArr[adjMatrix[0][0]] = true

var result = 0
func search(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
        if visited[ny][nx] > 0 { continue }
        if countingArr[adjMatrix[ny][nx]] == true { continue }
        visited[ny][nx] = visited[y][x] + 1
        result = visited[ny][nx] > result ? visited[ny][nx] : result
        countingArr[adjMatrix[ny][nx]] = true
        search(ny,nx)
        visited[ny][nx] = 0
        countingArr[adjMatrix[ny][nx]] = false
    }
}
search(0,0)
print(result)
