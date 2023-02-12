//
//  main.swift
//  BalancedWorld
//
//  Created by Kay on 2023/02/12.
//

/*
 4949
 균형잡힌 세상
 */

/*
 () []
 1:1 매칭
 
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

while let testString = readLine() {
    var str = testString
    if str.last! == "." {
        if str.first! == str.last! {
            break
        }
        var myStack = Stack<Character>()
        for i in str {
            if !myStack.isEmpty {
                if (myStack.top! == "(" && i == ")") || (myStack.top! == "[" && i == "]") {
                    myStack.pop()
                } else {
                    if i == "(" || i == "[" || i == ")" || i == "]" {
                        myStack.push(i)
                    }
                }
            } else {
                if i == "(" || i == "[" || i == ")" || i == "]" {
                    myStack.push(i)
                }
            }
        }
        if myStack.isEmpty {
            print("yes")
        } else {
            print("no")
        }
    } else {
        print("no")
    }
}

// 40분
