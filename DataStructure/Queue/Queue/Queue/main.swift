//
//  main.swift
//  Queue
//
//  Created by Kay on 2022/12/29.
//

import Foundation

struct Queue<T> {
    private var queue: [T?] = []
    private var head: Int = 0
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard head <= queue.count, let element = queue[head] else { return nil }
        queue[head] = nil
        head += 1
        
        if head > 50 {
            queue.removeFirst(head)
            head = 0
        }
        return element
    }
}

var myQueue = Queue<Int>()
myQueue.enqueue(3)
myQueue.enqueue(4)
myQueue.enqueue(5)
let dequeueNum = myQueue.dequeue()
print(dequeueNum)
print(myQueue.count)

