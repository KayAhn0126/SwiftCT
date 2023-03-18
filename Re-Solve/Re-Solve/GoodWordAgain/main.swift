//
//  main.swift
//  GoodWordAgain
//
//  Created by Kay on 2023/03/18.
//

/*
 3986
 좋은단어 다시풀기 2
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

var result = 0
var number = Int(readLine()!)!
for i in 0..<number {
    var stack = Stack<Character>()
    let userInput = Array(readLine()!)
    
    for j in 0..<userInput.count {
        if stack.isEmpty {
            stack.push(userInput[j])
        } else if !stack.isEmpty && stack.top! == userInput[j] {
            stack.pop()!
            continue
        } else {
            stack.push(userInput[j])
        }
    }
    if stack.isEmpty {
        result += 1
    }
}
print(result)


