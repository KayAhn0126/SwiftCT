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

let num = Int(readLine()!)!
for _ in 0..<num {
    var myStack = Stack<Character>()
    let tempString = readLine()!
    for char in tempString {
        if myStack.isEmpty || (!myStack.isEmpty && myStack.top! == char) {
            myStack.push(char)
        } else if myStack.top! == "(" && char == ")" {
            myStack.pop()
        }
    }
    if myStack.isEmpty {
        print("YES")
    } else {
        print("NO")
    }
}

