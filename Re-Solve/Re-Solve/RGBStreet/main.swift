import Foundation

let N = Int(readLine()!)!
var adjMatrix = [[Int]]()
var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: N)
for _ in 0..<N {
    adjMatrix.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

dp[0][0] = adjMatrix[0][0]
dp[0][1] = adjMatrix[0][1]
dp[0][2] = adjMatrix[0][2]

for i in 1..<N {
    for j in 0..<3 {
        if j == 0 { // 0번 집일 경우
            dp[i][j] = min(dp[i-1][j+1], dp[i-1][j+2]) + adjMatrix[i][j]
        } else if j == 1 { // 1번 집일 경우
            dp[i][j] = min(dp[i-1][j-1], dp[i-1][j+1]) + adjMatrix[i][j]
        } else { // 2번 집일 경우
            dp[i][j] = min(dp[i-1][j-2], dp[i-1][j-1]) + adjMatrix[i][j]
        }
    }
}
print(dp[N-1].min()!)
