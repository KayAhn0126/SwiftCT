import Foundation

let num = Int(readLine()!)!
var arr = [Int](repeating: 0, count: num + 1)
for i in 1...num {
    arr[i] = Int(readLine()!)!
}
var dp = [Int](repeating: 0, count: num + 1)

if num == 1 {
    print(arr[num])
} else if num == 2 {
    print(arr[1] + arr[2])
} else {
    dp[0] = 0
    dp[1] = arr[1]
    dp[2] = arr[1] + arr[2]
    for i in 3...num {
        dp[i] = max(arr[i] + dp[i-2], arr[i] + arr[i-1] + dp[i-3])
    }
    print(dp[num])
}
