//
//  main.swift
//  Tetromino
//
//  Created by Kay on 2023/03/16.
//

/*
 14500
 테트로미노
 */

/*
 처음에 생각했던 방법
 메서드 19개 만들어서 브루트포스 -> 시간도 코드도 비효율적!
 */

/*
 맵의 맥스를 아래 + 3, 우측 + 3을 해준다.
 
 5개의 모양을 회전 및 대칭해서 19개 모양을 만든다.
 이때 모양은 4 by 4 로 만들어준다. -> 나중에 맵에서 4 * 4로만 체크할것
 
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
    adjMatrix[i].append(contentsOf: [-1000, -1000, -1000])
}
for _ in 0..<3 {
    adjMatrix.append([Int](repeating: -1000, count: M + 3))
}

var tetrominoCollection: [[[Int]]] = [
    [
        [1,1,1,1],
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,0,0,0],
        [1,0,0,0],
        [1,0,0,0],
        [1,0,0,0]
    ],
    [
        [1,1,0,0],
        [1,1,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,0,0,0],
        [1,0,0,0],
        [1,1,0,0],
        [0,0,0,0]
    ],
    [
        [1,1,1,0],
        [1,0,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,1,0,0],
        [0,1,0,0],
        [0,1,0,0],
        [0,0,0,0]
    ],
    [
        [0,0,1,0],
        [1,1,1,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [0,1,0,0],
        [0,1,0,0],
        [1,1,0,0],
        [0,0,0,0]
    ],
    [
        [1,0,0,0],
        [1,1,1,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,1,0,0],
        [1,0,0,0],
        [1,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,1,1,0],
        [0,0,1,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,0,0,0],
        [1,1,0,0],
        [0,1,0,0],
        [0,0,0,0]
    ],
    [
        [0,1,1,0],
        [1,1,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [0,1,0,0],
        [1,1,0,0],
        [1,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,1,0,0],
        [0,1,1,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,1,1,0],
        [0,1,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [0,1,0,0],
        [1,1,0,0],
        [0,1,0,0],
        [0,0,0,0]
    ],
    [
        [0,1,0,0],
        [1,1,1,0],
        [0,0,0,0],
        [0,0,0,0]
    ],
    [
        [1,0,0,0],
        [1,1,0,0],
        [1,0,0,0],
        [0,0,0,0]
    ],
]

func checkAndGetCurrentResult(_ y: Int, _ x: Int, _ k: Int) -> Int {
    var result = 0
    for i in 0..<4 {
        for j in 0..<4 {
            result += tetrominoCollection[k][i][j] * adjMatrix[y+i][x+j]
        }
    }
    return result
}

var result = -100000
var tempResult = 0
for i in 0..<N {
    for j in 0..<M {
        for k in 0..<tetrominoCollection.count {
            tempResult = checkAndGetCurrentResult(i, j, k) // (i,j)는 현재 위치
            result = tempResult > result ? tempResult : result
        }
    }
}
print(result)
