import Foundation
let NMB = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMB[0]
let M = NMB[1]
let B = NMB[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


/*
제거 ⇒ 2초
삽입 → 1초

땅의 높이가 가장 높은것 + 최소시간
최소시간이 같다면 땅의 높이가 가장 높은것
높이는 256보다 작거나 같은 자연수 또는 0 즉, 256 ~ 0
stride. 256 → 0까지
var result = 0
타겟 넘버 i 두고 맵 전체를 해당 숫자로 만들기 했을때
i가 map의 요소보다 작을때,클때 분기처리
 var temp = 0
 var tempB = B
 tempB가 부족하다 → continue
 tempB가 정상 범위다
    현재 result와 비교하고 더 작으면 업데이트 시켜준다.
*/

/*
 시간 복잡도
 500 * 500 * 256
 */
var resultGroundLevel = 0
var minTime = Int.max
for tryNumber in stride(from: 256, through: 0, by: -1) {
    var tempInventory = B
    var time = 0
    for i in 0..<N {
        for j in 0..<M {
            var blockCount = 0 //MARK: 더하고 뺄 블록의 카운트를 저장하는 변수
            let currentNumber = adjMatrix[i][j]
            if currentNumber < tryNumber { /// 인벤토리에서 빼서 써야하는 경우
                blockCount = (tryNumber - currentNumber)
                tempInventory -= blockCount
                time += blockCount
            } else if currentNumber > tryNumber { /// 맵의 요소가 더 많아 인벤토리에 저장하는 경우
                blockCount = (currentNumber - tryNumber)
                tempInventory += blockCount
                time += (blockCount * 2)
            } else {
                continue
            }
        }
    }
    if tempInventory < 0 { continue }
    if time < minTime {
        minTime = time
        resultGroundLevel = tryNumber
    }
}
print(minTime, resultGroundLevel)
