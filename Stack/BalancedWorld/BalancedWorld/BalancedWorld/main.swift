//
//  main.swift
//  BalancedWorld
//
//  Created by Kay on 2023/01/07.
//

/*
 4949
 균형잡힌 세상
 */
// 2nd week fast campus

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
        return elements.popLast()
    }
}

func isThisBalanced(_ testString: String) {
    guard testString.hasSuffix(".") else {
        print("no")
        return
    }
    var myStack = Stack<Character>()
    testString.enumerated().forEach {
        if !myStack.isEmpty {
            if (myStack.top! == "(" && $0.element == ")") || (myStack.top! == "[" && $0.element == "]")  {
                myStack.pop()!
            } else {
                if $0.element == "(" || $0.element == ")" || $0.element == "[" || $0.element == "]" {
                    myStack.push($0.element)
                }
            }
        } else {
            if $0.element == "(" || $0.element == ")" || $0.element == "[" || $0.element == "]" {
                myStack.push($0.element)
            }
        }
    }
    if myStack.isEmpty {
        print("yes")
    } else {
        print("no")
    }
}


while let userInput = readLine() {
    if userInput == "." && userInput.count == 1 {
        break
    }
    isThisBalanced(userInput)
}

