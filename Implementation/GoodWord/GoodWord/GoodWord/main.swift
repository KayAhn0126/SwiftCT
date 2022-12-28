//
//  main.swift
//  GoodWord
//
//  Created by Kay on 2022/12/28.
//

/*
 3986
 좋은 단어
 */
// 1st week fast-campus
import Foundation

struct Stack<T> {
    var elements: [T] = []
    
    var count : Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    func top() -> T? {
        return elements.last
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func clear() {
        elements.removeAll()
    }
}

var number = Int(readLine()!)!
var result = 0

for _ in 0..<number {
    let testString = readLine()!
    var myStack = Stack<String>()
    let length = testString.count
    let testStringArr = [Character](testString)
    for j in 0..<length {
        let nextString = String(testStringArr[j])
        if myStack.count > 0 {
            if myStack.top()! == nextString {
                myStack.pop()
            } else {
                myStack.push(nextString)
            }
        } else {
            myStack.push(nextString)
        }
    }
    if myStack.isEmpty {
        result += 1
    }
}
print(result)

