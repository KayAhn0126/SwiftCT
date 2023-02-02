//
//  main.swift
//  GoodWord
//
//  Created by Kay on 2023/02/02.
//

/*
 3986
 좋은 단어
 */
import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

struct Stack<T> {
    var stack: [T] = []
    
    var count: Int {
        return stack.count
    }
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    var top: T? {
        return stack.last
    }
    
    mutating func push(_ element: T) {
        stack.append(element)
    }
    
    mutating func pop() -> T? {
        return stack.popLast()
    }
}

let tryCount = Int(readLine()!)!
if 1 <= tryCount && tryCount <= 100 {
    var result = 0
    for _ in 0..<tryCount {
        var myStack = Stack<Character>()
        let testString = readLine()!
        let testStringArr = [Character](testString)
        for i in 0..<testStringArr.count {
            if myStack.isEmpty {
                myStack.push(testStringArr[i])
            } else {
                if myStack.top! == testStringArr[i] {
                    myStack.pop()
                } else {
                    myStack.push(testStringArr[i])
                }
            }
        }
        if myStack.isEmpty {
            result += 1
        }
    }
    print(result)
}
