//
//  main.swift
//  Multiply
//
//  Created by Kay on 2023/02/02.
//

/*
 1629
 곱셈
 */

// 자연수 A를 B번 곱한 수를 알고 싶다. 단 구하려는 수가 매우 커질 수 있으므로 이를 C로 나눈 나머지를 구하는 프로그램을 작성하시오.

import Foundation

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = userInput[0]
let B = userInput[1]
let C = userInput[2]

// 정수론 나머지
// A % B = (A % B) % B
// (A + B) % C = ((A % C) + (B % C)) % C
// 재귀함수는 기저사례 꼭 생각하자..

var result = 1
func calculate(_ a: Int, _ b: Int) -> Int {
    if b == 1 {
        return a % C
    }
    result = calculate(a, b/2)
    result = (result * result) % C
    
    if b % 2 != 0 {
        result = (result * a) % C
    }
    return result
}

print(calculate(A,B))
