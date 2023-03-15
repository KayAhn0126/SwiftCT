# 15686 치킨 배달
- 브루트포스
- 조합

## 🍎 문제 접근
- 시간복잡도
    - N의 최대 범위 50
    - N * N = 2500
    - 조합은 13Cm 
    - 조합은 가운데로 갈수록 커지기 때문에 
        - 맥스인 13C6, 13C7 = 1,716
    - 집의 최대 값은 2N = 100이다
    - 즉 171,600
    - 브루트 포스로 풀 수 있다!
- 치킨집 조합을 구하고 각각의 집에서 가장 가까운 치킨집과의 거리를 구하면 된다.
- 조합 코드는 조금 어렵지만 나머지 코드는 그냥 읽으면 되는 수준

## 🍎 문제 풀이 코드
```swift
import Foundation

func combinationWithRecursive<T>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    func cycle(_ index: Int, _ now: [T]) {
        if now.count == n {
            result.append(now)
            return
        }

        for i in index..<array.count {
            cycle(i + 1, now + [array[i]])
        }
    }

    cycle(0,[])

    return result
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var homeList = [(Int,Int)]()
var chickenList = [(Int,Int)]()

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


// MARK: - 맵 안에서 집과 치킨집의 위치를 파악하기
func checkHomeAndChickenLocation() {
    for i in 0..<N {
        for j in 0..<N {
            if adjMatrix[i][j] == 1 {
                homeList.append((i,j))
            } else if adjMatrix[i][j] == 2 {
                chickenList.append((i,j))
            }
        }
    }
}


func solution() {
    var finalResult = 987654321
    for i in 0..<randomChickenLocationByNumberOfM.count {
        var localTotal = 0
        for j in 0..<homeList.count {
            let homeLocation  = homeList[j]
            let homeY = homeLocation.0
            let homeX = homeLocation.1
            var distanceFromEachChickenMinimum = 987654321
            for k in 0..<randomChickenLocationByNumberOfM[i].count {
                let randomChickenLocation = randomChickenLocationByNumberOfM[i][k]
                let randomChickenY = randomChickenLocation.0
                let randomChickenX = randomChickenLocation.1
                
                let distance = abs(randomChickenY - homeY) + abs(randomChickenX - homeX)
                distanceFromEachChickenMinimum = distance < distanceFromEachChickenMinimum ? distance : distanceFromEachChickenMinimum
            }
            localTotal += distanceFromEachChickenMinimum
        }
        finalResult = localTotal < finalResult ? localTotal : finalResult
    }
    print(finalResult)
}

// MARK: - 집의 위치와 치킨집 위치 리스트화
checkHomeAndChickenLocation()
// MARK: - M 만큼 조합으로 뽑기
var randomChickenLocationByNumberOfM = combinationWithRecursive(chickenList, M)
// MARK: - 집 집 마다, 조합으로 뽑은 치킨집 중 가장 가까운 치킨집까지 거리를 구하고 계속 최소값으로 업데이트 후 값 구하기
solution()
```
