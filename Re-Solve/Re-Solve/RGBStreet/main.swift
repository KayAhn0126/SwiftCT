import Foundation

var num = Int(readLine()!)!

var adjMatrix = [[Int]](repeating: [Int](), count: num)
for i in 0..<num {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: num)

dp[0][0] = adjMatrix[0][0]
dp[0][1] = adjMatrix[0][1]
dp[0][2] = adjMatrix[0][2]

for i in 1..<num {
    dp[i][0] = min(dp[i-1][1], dp[i-1][2]) + adjMatrix[i][0]
    dp[i][1] = min(dp[i-1][0], dp[i-1][2]) + adjMatrix[i][1]
    dp[i][2] = min(dp[i-1][0], dp[i-1][1]) + adjMatrix[i][2]
}
print(dp[num-1].sorted()[0])

