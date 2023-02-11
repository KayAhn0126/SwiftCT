//
//  main.swift
//  RightBiggerNumber
//
//  Created by Kay on 2023/02/11.
//

/*
 17298
 오큰수
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

let number = Int(readLine()!)!

var userInput = readLine()!.split(separator: " ").map { Int(String($0))! }

var result = [Int](repeating: -1, count: number)

var myStack = Stack<Int>()

// 1. inputArr을 돈다.
// 2. 현재 stack이 비어있거나 현재 수가 top에 있는 수보다 작으면 넣어준다. (넣어줄때 인덱스를 넣어준다.)
// 3. 비어있지 않고, 현재 수가 top보다 크면 현재수가 계속 클 상황까지 pop을 해준다.
// 3-1. while stack.top() < inputArr[currentIndex] {
//  stack에 있는 요소(인덱스)를 pop해주고 result에서 해당 인덱스의 값을 바꿔준다.
// }

for i in 0..<number {
    if myStack.isEmpty || userInput[myStack.top!] > userInput[i] {
        myStack.push(i)
        continue
    }
    while !myStack.isEmpty && userInput[myStack.top!] < userInput[i] {
        result[myStack.pop()!] = userInput[i]
    }
    myStack.push(i)
}

result.enumerated().forEach {
    print(String($0.element), terminator: " ")
}

// 40분 정도
