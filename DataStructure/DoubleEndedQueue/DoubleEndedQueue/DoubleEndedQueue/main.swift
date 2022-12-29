//
//  main.swift
//  DoubleEndedQueue
//
//  Created by Kay on 2022/12/29.
//

import Foundation

// MARK: - PopFirst와 PopLast에서 반환 받을때 T? (옵셔널)로 반환 받는것보다 차라리 popFirst/Last 하기 전에 isEmpty인지 체크하는것이 반환받고 옵셔널 바인딩보다  더 낫다고 생각한다.
struct Deque<T>{
    var enQueue: [T] = []
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    
    mutating func pushFirst(_ element: T) {
        deQueue.append(element)
    }
    
    mutating func pushLast(_ element: T) {
        enQueue.append(element)
    }
    
    mutating func popFirst() -> T {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue.removeAll()
        }
        return deQueue.popLast()!
    }
    
    mutating func popLast() -> T {
        if enQueue.isEmpty {
            enQueue = deQueue.reversed()
            deQueue.removeAll()
        }
        return enQueue.popLast()!
    }
    
    // MARK: - 두개의 배열을 일반 배열처럼 출력하는 메서드
    func show() {
        var temp: [T] = []
        deQueue.reversed().enumerated().forEach {
            temp.append($0.element)
        }
        enQueue.enumerated().forEach {
            temp.append($0.element)
        }
        print(temp)
    }
}

var myDequeue = Deque<Int>()
myDequeue.pushLast(1)
myDequeue.pushLast(2)
myDequeue.pushLast(3)
myDequeue.pushLast(4)
myDequeue.pushLast(5) // 5가 가장 늦게 들어감.

myDequeue.pushFirst(5) // 5가 가장 먼저 들어감.
myDequeue.pushFirst(4)
myDequeue.pushFirst(3)
myDequeue.pushFirst(2)
myDequeue.pushFirst(1)

myDequeue.show()

