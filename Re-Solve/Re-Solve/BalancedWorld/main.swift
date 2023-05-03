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

while let given = readLine() {
    let myString = given
    if myString.count == 1 && myString == "." {
        break
    }
    var myStack = Stack<Character>()
    for char in myString {
        if char != "(" && char != ")" && char != "[" && char != "]" { continue }
        if myStack.isEmpty {
            myStack.push(char)
        } else if !myStack.isEmpty && myStack.top! == "(" && char == ")" {
            myStack.pop()
        } else if !myStack.isEmpty && myStack.top! == "[" && char == "]" {
            myStack.pop()
        } else {
            myStack.push(char)
        }
    }
    
    if myStack.isEmpty {
        print("yes")
    } else {
        print("no")
    }
}
