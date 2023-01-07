//
//  main.swift
//  Parenthesis
//
//  Created by Kay on 2023/01/07.
//

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
        if elements.isEmpty {
            return nil
        }
        return elements.popLast()
    }
}

func checkParenthesis(_ testString: String) {
    var myStack = Stack<Character>()
    testString.enumerated().forEach {
        if !myStack.isEmpty {
            if myStack.top! == "(" && $0.element == ")" {
                myStack.pop()
            } else {
                myStack.push($0.element)
            }
        } else {
            myStack.push($0.element)
        }
    }
    
    if myStack.isEmpty {
        print("YES")
    } else {
        print("NO")
    }
}


let N = Int(readLine()!)!
for _ in 0..<N {
    let parenthesis = readLine()!
    checkParenthesis(parenthesis)
}

