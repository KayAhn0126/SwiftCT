import Foundation

let num = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var dp = [Int](repeating: 0, count: num)

var biggest = Int.min
dp[0] = arr[0]
biggest = dp[0] > biggest ? dp[0] : biggest
for i in 1..<num {
    dp[i] = max((dp[i-1] + arr[i]), arr[i])
    biggest = dp[i] > biggest ? dp[i] : biggest
}
print(biggest)
