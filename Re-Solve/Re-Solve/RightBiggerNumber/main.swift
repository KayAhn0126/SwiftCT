import Foundation

let number = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

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

var myStack = Stack<Int>()

var result = [Int](repeating: -1, count: number)

// arr를 돌면서 (empty라면 stack에 push) 또는! (현재 값이 top보다 작으면 push)
// 현재 값이 stack의 top보다 크면 해당 인덱스를 현재 값으로 채운다. until 현재 값이 같거나 큰 동안만 계속 pop한다.


for i in 0..<number {
    if myStack.isEmpty || arr[myStack.top!] > arr[i] {
        myStack.push(i)
        continue
    }
    while !myStack.isEmpty && arr[myStack.top!] < arr[i] {
        result[myStack.pop()!] = arr[i]
    }
    myStack.push(i)
}

result.enumerated().forEach {
    print(String($0.element), terminator: " ")
}
print("")
