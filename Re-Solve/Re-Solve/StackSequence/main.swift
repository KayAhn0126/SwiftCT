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
var arr = [Int]()
for i in 0..<num {
    arr.append(Int(readLine()!)!)
}

var myStack = Stack<Int>()
var currentNumber = 1
var result: [Character] = []
// stack의 탑이 element와 같아질때까지 currentNumber넣기
for element in arr {
    while currentNumber <= element {
        myStack.push(currentNumber)
        currentNumber += 1
        result.append("+")
    }
    if !myStack.isEmpty && myStack.top! == element {
        myStack.pop()
        result.append("-")
    }
}
if myStack.isEmpty {
    result.enumerated().forEach {
        print($0.element)
    }
} else {
    print("NO")
}
