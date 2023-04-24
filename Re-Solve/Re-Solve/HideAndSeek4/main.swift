import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

// trace 문제

var visited = [Int](repeating: 0, count: 100001)
var trace = [Int](repeating: 0, count: 100001)


var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)
visited[N] = 1

var result = 0
let walk = [-1,1,2]
while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    if current == K {
        result = visited[current] - 1
        break
    }
    for i in 0..<3 {
        var next = 0
        if i == 0 || i == 1 {
            next = current + walk[i]
        } else {
            next = current * walk[i]
        }
        if next < 0 || next >= 100001 { continue }
        if visited[next] != 0 { continue }
        if trace[next] != 0 { continue }
        visited[next] = visited[current] + 1
        trace[next] = current
        bfsQueue.append(next)
    }
}

var resultArr = [Int]()
var num = K
resultArr.append(K)
while num != N {
    let temp = trace[num]
    resultArr.append(temp)
    num = temp
}
print(result)
resultArr.reversed().enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
