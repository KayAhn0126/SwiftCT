import Foundation

let size = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var dp = [Int](repeating: 0, count: size)

var result = Int.min
for i in 0..<size {
    var latest = 0
    for j in 0..<i {
        if arr[j] < arr[i] && latest < dp[j] {
            latest = dp[j]
        }
    }
    dp[i] = latest + 1
    result = dp[i] > result ? dp[i] : result
}

print(result)
