//
//  main.swift
//  InequalitySign
//
//  Created by Kay on 2023/03/31.
//

/*
 2529
 부등호
 */

/*
 브루트포스 + 백트래킹
 
 부등호 로직이 맞는지 확인하는 함수 필요
 백트래킹 로직 필요
 최대 최소 비교 로직 필요
 
 진짜 좋은 문제.
 */

import Foundation

var K = Int(readLine()!)!

// readLine()!.map { $0 }은 return type이 String.element 타입이다.
var signArr: [Character] = readLine()!.split(separator: " ").map { Character(String($0)) }
var visited = [Bool](repeating: false, count: 10)

func isValid(_ num1: Int, _ oper: Character, _ num2: Int) -> Bool {
    if num1 < num2 && oper == "<" { return true }
    if num1 > num2 && oper == ">" { return true }
    return false
}

var resultArr = [String]()

func go(_ idx: Int, _ num: String) {
    if idx == K + 1 {
        resultArr.append(num)
        return
    }
    for i in 0...9 {
        if visited[i] == true { continue }
        if idx == 0 || isValid(Int(String(num.last!))!, signArr[idx-1], i) == true {
            visited[i] = true
            go(idx + 1, num + String(i))
            visited[i] = false
        }
    }
}

go(0, "")
resultArr = resultArr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0 < $1
})

print(resultArr[resultArr.count-1])
print(resultArr[0])
