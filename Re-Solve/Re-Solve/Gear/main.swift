import Foundation

//MARK: 하나의 톱니바퀴 돌리기
func rotateSingleGear(_ gear: Int, _ LR: Int) {
    if LR == 1 {
        let last = gears[gear].popLast()!
        gears[gear].insert(last, at: 0)
    } else if LR == -1 {
        let first = gears[gear].first!
        gears[gear].append(first)
        gears[gear].removeFirst()
    } else {
        return
    }
}

//MARK: 현재 톱니바퀴와 좌우 매칭되는 부분 찾고 저장하기
var storage = [Int](repeating: 0, count: 4)
var visited = [Bool](repeating: false, count: 4)
func rotate(_ gear: Int, _ LR: Int) {
    storage[gear] = LR
    visited[gear] = true
    // 왼쪽 체크
    if -1 < gear - 1 && visited[gear - 1] == false {
        if gears[gear-1][2] != gears[gear][6] {
            rotate(gear - 1, (LR * -1))
        }
    }
    // 오른쪽 체크
    if gear + 1 < 4 && visited[gear + 1] == false {
        if gears[gear][2] != gears[gear+1][6] {
            rotate(gear + 1, (LR * -1))
        }
    }
}

//MARK: 방향을 저장하는 storage 배열 초기화 함수
func clearStorageAndVisited() {
    storage = [0,0,0,0]
    visited = [false, false, false, false]
}

//MARK: 최종값 계산 함수
func calculateFinalResult() -> Int {
    var result = 0
    for i in 0..<4 {
        if gears[i][0] == 1 {
            result += Int(pow(Float(2), Float(i)))
        }
    }
    return result
}

//MARK: 입력받기
var gears = [[Int]](repeating: [Int](), count: 4)
for i in 0..<4 {
    gears[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}
let orderCount = Int(readLine()!)!
for _ in 0..<orderCount {
    let whichToLR = readLine()!.split(separator: " ").map { Int(String($0))! }
    let which = whichToLR[0]
    let LR = whichToLR[1]
    rotate(which - 1, LR)
    for j in 0..<storage.count {
        rotateSingleGear(j, storage[j])
    }
    clearStorageAndVisited()
}
print(calculateFinalResult())
