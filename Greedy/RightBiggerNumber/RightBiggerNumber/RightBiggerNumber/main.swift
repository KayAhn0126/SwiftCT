//
//  main.swift
//  RightBiggerNumber
//
//  Created by Kay on 2023/01/10.
//

/*
 17298
 오큰수
 */
// 2nd week fast campus

/*
 스택 구현하기
 N이 최대 1,000,000
 이중 for 문으로 풀면 시간초과 100억
 
 그리디로 풀어야함
 스택의 top 보다 작으면 계속 push, 크다면 결과 배열의 인덱스에 값 추가
 인덱스와 값 둘 다 사용하는 로직.
 */

import Foundation

struct Stack<T> {
    private var elements: [T] = []
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var top: T? {
        return elements.last
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        elements.popLast()
    }
}



let N = Int(readLine()!)!
var numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
var result = [Int](repeating: -1, count: N)
var myStack = Stack<Int>()

for i in 0..<numbers.count {
    while !myStack.isEmpty && numbers[myStack.top!] < numbers[i] {
        result[myStack.top!] = numbers[i]
        myStack.pop()!
    }
    myStack.push(i)
}
result.enumerated().forEach {
    print(String($0.element), terminator: " ")
}
