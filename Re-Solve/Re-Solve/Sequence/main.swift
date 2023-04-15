import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]


var result = Int.min
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var prefixSum = [Int](repeating: 0, count: N + 1)

arr.insert(0, at: 0)
for i in 1...N {
    prefixSum[i] = arr[i] + prefixSum[i-1]
}

for i in 0...N-K {
    let number = prefixSum[i+K] - prefixSum[i]
    result = number > result ? number : result
}
print(result)
/*
 10 2
 3 -2 -4  -9   0  3 7 13 8 -3
 3  1 -3 -12 -12  9
 
 */
