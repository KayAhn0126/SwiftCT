//
//  main.swift
//  Parenthesis
//
//  Created by Kay on 2023/02/12.
//

/*
 괄호
 9012
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

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

func checkParenthesis(_ element: String) {
    var testString = element
    var myStack = Stack<Character>()
    for i in testString {
        if !myStack.isEmpty {
            if myStack.top! == "(" && i == ")" {
                myStack.pop()
            } else {
                myStack.push(i)
            }
        } else {
            myStack.push(i)
        }
    }
    if myStack.isEmpty {
        print("YES")
    } else {
        print("NO")
    }
}

let userInput = Int(readLine()!)!

for i in 0..<userInput {
    let testString = readLine()!
    checkParenthesis(testString)
}

// 30분
