import Foundation

struct Queue<T> {
    var enQueue: [T]
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    var peek: T? {
        if deQueue.isEmpty {
            return enQueue.first
        }
        return deQueue.last
    }
    mutating func enqueue(_ element: T) {
        enQueue.append(element)
    }
    mutating func dequeue() -> T? {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue = []
        }
        return deQueue.popLast()
    }
}


var tc = Int(readLine()!)!
while tc > 0 {
    let countFind = readLine()!.split(separator: " ").map { Int(String($0))! }
    let count = countFind[0] // 문서의 개수
    let find = countFind[1] // 몇번쨰로 인쇄되었는지 궁금한 문서가 현재 어디에 있는지 나타내는 정수
    let givenArr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var queue = Queue<Int>(enQueue: givenArr)
    var index = find
    var maxQueue = Queue<Int>(enQueue: givenArr.sorted(by: >))
    var result = 1
    while true {
        if queue.peek! == maxQueue.peek! && index == 0 {
            print(result)
            break
        }
        if queue.peek! == maxQueue.peek! {
            queue.dequeue()
            maxQueue.dequeue()
            result += 1
            index -= 1
        } else {
            let firstNumber = queue.dequeue()!
            queue.enqueue(firstNumber)
            if index == 0 {
                index = queue.count - 1
            } else {
                index -= 1
            }
        }
    }
    tc -= 1
}
