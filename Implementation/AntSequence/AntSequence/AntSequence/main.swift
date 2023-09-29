//
//  main.swift
//  AntSequence
//
//  Created by Kay on 2023/09/29.
//

/*
 28292
 개미 수열
 */

/*
 애드 혹 문제
 접근방법:
    일반적인 구현으로 문제를 풀면 input을 50 정도 넣어도 1초안에 계산하지 못한다.
 
    1                          1
    11                         2
    12                         3
    1121                       4
    122111                     5
    112213                     6
    12221131                   7
    1123123111                 8
    12213111213113             9
    11221131132111311231       10
 
    개미 수열에서
    1항과 2항은 1이 가장 큰 숫자.
    3항에서 5항까지는 2가 가장 큰 숫자.
    6항부터는 3이 가장 큰 숫자다.
    
    개미수열에서 4는 나오지 않는다.
*/


import Foundation

var num = Int(readLine()!)!

if num >= 6 {
    print(3)
} else if num >= 3 {
    print(2)
} else {
    print(1)
}

/*  시간초과 코드
 
extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}
var temp = "1"

while num > 1 {
    var localTemp = ""
    var localCount = 1
    var last = temp[0]!
    let currentTempStrCount = temp.count
    for i in 1..<currentTempStrCount {
        let currentChar = temp[i]!
        if currentChar == last {
            localCount += 1
        } else {
            localTemp = localTemp + String(last) + String(localCount)
            last = currentChar
            localCount = 1
        }
    }
    localTemp = localTemp + String(last) + String(localCount)
    temp = localTemp
    num -= 1
}

let result = temp.max()!
print(result)
*/
