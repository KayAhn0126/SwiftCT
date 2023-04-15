import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var prefixSum = [Int](repeating: 0, count: N + 1)
arr.insert(0, at: 0)

for i in 1...N {
    prefixSum[i] = prefixSum[i-1] + arr[i]
}

func findFromTo(_ from: Int, _ to: Int) -> Int {
    return prefixSum[to] - prefixSum[from-1]
}

for i in 0..<M {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    print(findFromTo(fromTo[0], fromTo[1]))
}
