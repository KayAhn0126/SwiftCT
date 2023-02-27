//
//  main.swift
//  RedrawingChessBoard
//
//  Created by Kay on 2023/02/27.
//

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var chessBoard = [[Character]](repeating: [Character](), count: N)

for row in 0..<N {
    chessBoard[row].append(contentsOf: readLine()!)
}

// 짝수행의 짝수열은 firstLetter
// 짝수행의 홀수열은 secondLetter
// 홀수행의 짝수열은 secondLetter
// 홀수행의 짝수열은 firstLetter

func checkChangeCount(_ y: Int, _ x: Int, _ first: Character) -> Int {
    var changeCount = 0
    for i in y..<y+8 {
        for j in x..<x+8 {
            if i % 2 == 0 { // 짝수 행
                if j % 2 == 0 { // 짝수 열
                    if chessBoard[i][j] != first {
                        changeCount += 1
                    }
                } else { // 홀수 열
                    if chessBoard[i][j] == first {
                        changeCount += 1
                    }
                }
            } else { // 홀수 행
                if j % 2 == 0 { // 짝수 열
                    if chessBoard[i][j] == first {
                        changeCount += 1
                    }
                } else { // 홀수 열
                    if chessBoard[i][j] != first {
                        changeCount += 1
                    }
                }
            }
        }
    }
    return changeCount
}

var smallest = 987654321
for i in 0...N-8 {
    for j in 0...M-8 {
        let W = Character("W")
        let B = Character("B")
        let tempResultW = checkChangeCount(i, j, W)
        let tempResultB = checkChangeCount(i, j, B)
        let tempResult = tempResultW > tempResultB ? tempResultB : tempResultW
        smallest = smallest > tempResult ? tempResult : smallest
    }
}
print(smallest)
