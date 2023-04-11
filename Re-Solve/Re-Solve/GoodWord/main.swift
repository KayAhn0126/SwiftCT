import Foundation

struct Stack<T> {
    var element: [T] = []
    var count: Int {
        return element.count
    }
    var isEmpty: Bool {
        return element.isEmpty
    }
    var top: T? {
        return element.last
    }
    mutating func push(_ ele: T) {
        element.append(ele)
    }
    mutating func pop() -> T? {
        element.popLast()
    }
}

let num = Int(readLine()!)!
var result = 0
for i in 0..<num {
    let temp = readLine()!
    var stack = Stack<Character>()
    var lastChar: Character = " "
    for i in temp {
        if stack.isEmpty == true || (stack.isEmpty == false && stack.top! != i) {
            stack.push(i)
        } else if stack.isEmpty == false && stack.top! == i {
            stack.pop()!
        }
    }
    if stack.isEmpty == true {
        result += 1
    }
}
print(result)
