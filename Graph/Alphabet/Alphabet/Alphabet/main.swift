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
 //MARK: 처음 생각했던 방식 -> 시간초과
 다음 가려는 곳이 계수 정렬 값이 1이라면 continue.
 queue에 아무것도 남지 않으면 종료
 매번 max값 갱신
 백트래킹 할 때 계수 정렬 배열도 같이 해주기.
 */

/*
 //MARK: 통과한 방식 -> 비트마스킹
 계수 정렬 배열을 비트마스킹으로 바꾸기 + 기존 방문 배열(visited) 없애기
 계수 정렬 배열을 방문 배열로 두어도 괜찮기 때문에 기존 방문 배열을 없앴다.
    - 무작정 쓰지 말자
 알파벳이 단 한번씩만 나와야 하므로 만약 A를 만났던 상태에서 다시 A를 만나면 continue가 된다.
 자세한건 README.md에 정리
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

var visitedNumber: Int = (1 << 26)
visitedNumber |= (1 << adjMatrix[0][0])

var result = 0
func search(_ y: Int, _ x: Int, _ depth: Int) {
    result = depth > result ? depth : result
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
        let idx = 1 << adjMatrix[ny][nx]
        if visitedNumber & (1 << idx) != 0 { continue }
        visitedNumber |= (1 << idx)
        search(ny, nx, depth + 1)
        visitedNumber &= ~(1 << idx)
    }
}
search(0,0,1)
print(result)
