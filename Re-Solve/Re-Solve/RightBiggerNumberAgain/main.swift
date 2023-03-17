//
//  main.swift
//  RightBiggerNumberAgain
//
//  Created by Kay on 2023/03/17.
//

/*
 17298
 오큰수 다시풀기 두번째
 */

/*
 result 배열을 -1로 초기화
 
 stack에는 실제 값을 넣는것이 아닌 인덱스를 넣는다.
 비어있는경우 기존배열의 해당 인덱스 push
 비어있지 않고 기존배열[top에 있는 인덱스]보다 현재 수가 작은경우 해당 인덱스 push
 비어있지 않고 기존배열[top에 있는 인덱스]가 나보다 큰 경우 정답배열[top에 있는 인덱스]에 현재 수를 대입.
 시간 복잡도는 O(100만)이라 괜찮을것.
 일단 해보자!
 */

import Foundation

struct Stack<T> {
    var elements: [T] = []
    
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
        return elements.popLast()
    }
}

var N = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var result = [Int](repeating: -1, count: N)

var stack = Stack<Int>()

for i in 0..<N {
    while !stack.isEmpty && arr[stack.top!] < arr[i] {
        result[stack.pop()!] = arr[i]
    }
    stack.push(i)
}
result.enumerated().forEach {
    print(String($0.element), terminator: " ")
}
