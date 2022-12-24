//
//  main.swift
//  Stack
//
//  Created by Kay on 2022/12/24.
//

import Foundation

struct Stack<T> {
    var elements: [T] = []
  
    var count : Int {
        return elements.count
    }
    var isEmpty : Bool {
        return elements.isEmpty
    }
    
    mutating func pop() -> T? { // O(1)
        return elements.popLast()
    }
    mutating func push(_ element: T) { // O(1)
        elements.append(element)
    }
    func top() -> T? {  // O(1)
        return elements.last
    }
}

var x = Stack<Int>()
print(x.elements)
x.push(3)
print(x.elements)
x.push(7)
print(x.elements)
print(x.top())
