import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


// 전체 치킨집의 위치를 구한다.
// 치킨집의 콤비네이션 구한다.

// 유효한 치킨집의 위치가 바뀔때마다
// 집마다 현재 조합으로 있는 치킨집들과의 거리를 재보고 가장 작은것을 tmpResult에 더한다.
// 한판이 끝나면 result와 비교한다. 가장 적은것으로 업데이트 한다.

// 시간 복잡도 -> 13C 6 = 300정도 * 50 * 50  = 2500 * 300

//MARK: 조합 함수 -> [[T]]
func combination<T>(_ arr: [T], _ n: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < n { return result }
    
    func cycle(_ now: [T], _ idx: Int) {
        if now.count == n {
            result.append(now)
            return
        }
        for i in idx..<arr.count {
            cycle(now + [arr[i]], i + 1)
        }
    }
    cycle([], 0)
    return result
}

//MARK: 전체 치킨집의 위치 및 집 위치 구하기
var chickenList: [(Int, Int)] = []
var homeList: [(Int,Int)] = []
for i in 0..<N {
    for j in 0..<N {
        if adjMatrix[i][j] == 2 {
            chickenList.append((i,j))
        } else if adjMatrix[i][j] == 1 {
            homeList.append((i,j))
        }
    }
}

//MARK: 메인 로직
var combi = combination(chickenList, M)
var result = Int.max
for locations in combi {
    var roundResult = 0
    for home in homeList {
        var tempMin = Int.max
        for location in locations {
            var distance = abs(location.0 - home.0) + abs(location.1 - home.1)
            tempMin = distance < tempMin ? distance : tempMin
        }
        roundResult += tempMin
    }
    result = roundResult < result ? roundResult : result
}
print(result)
