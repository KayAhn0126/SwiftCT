//
//  main.swift
//  Bingo
//
//  Created by Kay on 2023/10/03.
//

/*
 2578
 빙고
 */

/*
 문제 접근:
    1.입력 받기
        1-1 2차원 배열에 빙고판 입력 받기
        1-2 사회자가 부르는 번호 1차원 배열에 입력 받기
 */

import Foundation

var adjMatrix = [[Int]](repeating: [Int](), count: 5)
for i in 0..<5 {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}
var announce = [Int]()
for _ in 0..<5 {
    announce.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var dictionary = [Int:(Int,Int)]()
for i in 0..<5 {
    for j in 0..<5 {
        dictionary[adjMatrix[i][j]] = (i,j)
    }
}

var result = 0
for num in announce {
    result += 1
    let loc = dictionary[num]!
    adjMatrix[loc.0][loc.1] = 0
    if check() >= 3 {
        print(result)
        break
    }
}
        
func check() -> Int {
    var localResult = 0
    
    // row, col check
    for i in 0..<5 {
        var rowLocal = 0
        var colLocal = 0
        for j in 0..<5 {
            if adjMatrix[i][j] == 0 { rowLocal += 1 }
            if adjMatrix[j][i] == 0 { colLocal += 1 }
        }
        if rowLocal == 5 { localResult += 1 }
        if colLocal == 5 { localResult += 1 }
    }
    
    // diagoanl check
    if adjMatrix[0][0] == 0 &&
       adjMatrix[1][1] == 0 &&
       adjMatrix[2][2] == 0 &&
       adjMatrix[3][3] == 0 &&
       adjMatrix[4][4] == 0 { localResult += 1 }
    if adjMatrix[0][4] == 0 &&
       adjMatrix[1][3] == 0 &&
       adjMatrix[2][2] == 0 &&
       adjMatrix[3][1] == 0 &&
       adjMatrix[4][0] == 0 { localResult += 1 }
    return localResult
}
