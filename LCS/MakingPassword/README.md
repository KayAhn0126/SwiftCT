# 17218 비밀번호 만들기
- LCS (Longest Common Subsequence)

## 🍎 지문 해석
- 두 문자열이 주어질때 가장 긴 부분 문자열을 구해라

## 🍎 문제 접근
- 처음엔 2중 for문으로 풀어야하나 고민하고 어느정도 구현하다 도저히 풀리지 않아 검색 해보았고, LCS라는 알고리즘을 사용하면 가장 긴 부분 문자열을 구할 수 있었다.
- 지문에서는 가장 긴 부분 문자열 (Longest Common Substring)이라고 말하고 있지만 문제에서 요구하는 답은 (Longest Common Subsequence)다.

## 🍎 문제 풀이 및 전체 코드
- LCS 알고리즘
```swift
import Foundation

//MARK: 두 문자열을 입력 받는다
var aStr = readLine()!.map { String($0) }
var bStr = readLine()!.map { String($0) }

//MARK: 2차원 배열에서 0번째 인덱스를 무효화 하기 위해서 사용하지 않을 문자 하나를 0번째 인덱스에 넣어준다.
aStr.insert("-", at: 0)
bStr.insert("-", at: 0)

//MARK: 계속 사용될 각 문자열의 총 갯수를 미리 카운트한다.
let aStrCount = aStr.count // 11 + 1
let bStrCount = bStr.count // 12 + 1

//MARK: LCS를 구하기 위한 2차원 배열을 선언한다.
var LCS = [[Int]](repeating: [Int](repeating: 0, count: bStrCount), count: aStrCount)

//MARK: LCSubsequence를 찾기위한 전처리 작업(2차원 배열을 채우기)
for i in 0..<aStrCount {
    for j in 0..<bStrCount {
        if i == 0 || j == 0 {  // 마진 설정
            LCS[i][j] = 0
        } else if aStr[i] == bStr[j] { // 만약 같다면 N-1, M-1 위치의 값 + 1
            LCS[i][j] = LCS[i - 1][j - 1] + 1
        } else { // 다르다면 현재 위치의 왼쪽 칸, 윗칸 중 큰 값을 넣어준다 (Longest Common Subsequence 특징)
            LCS[i][j] = max(LCS[i - 1][j], LCS[i][j - 1])
        }
    }
}

//MARK: 채워진 2차원 배열에서 어떤 문자열이 LCS인지 찾기
var i = aStrCount - 1
var j = bStrCount - 1
var result = ""
while LCS[i][j] != 0 {
    if LCS[i][j] == LCS[i-1][j] {
        i = i - 1
    } else if LCS[i][j] == LCS[i][j-1] {
        j = j - 1
    } else {
        result += aStr[i]
        i -= 1
        j -= 1
    }
}

//MARK: 뒤에서부터 찾는 알고리즘이므로 역순으로 정렬하면 답!
result = String(result.reversed())
print(result)
```
