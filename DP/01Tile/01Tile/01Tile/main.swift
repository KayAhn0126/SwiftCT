//
//  main.swift
//  01Tile
//
//  Created by Kay on 2023/03/02.
//

/*
 1904
 01타일
 */

/*
 
 N |            가짓수                | 총갯수
 --|--------------------------------|------
 1 | 1                              |  1
 2 | 00, 11                         |  2
 3 | 001, 100, 111                  |  3
 4 | 0011, 0000, 1001, 1100, 1111   |  5
 
 
 총갯수의 패턴을 보면 피보나치 수라는 것을 알 수 있다.
 */

import Foundation

let N = Int(readLine()!)!

var DP = [Int](repeating: 0, count: 1000001)

DP[1] = 1
DP[2] = 2
DP[3] = 3
DP[4] = 5
for i in 5...1000000 {
    DP[i] = (DP[i-1] + DP[i-2]) % 15746
}

print(DP[N])
    
