import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Character]](repeating: [Character](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

//MARK: 특징 찾기
func getCount(_ y: Int, _ x: Int, _ first: Character) -> Int {
    var tempCount = 0
    for i in y..<y+8 {
        for j in x..<x+8 {
            if i % 2 == 0 {
                if j % 2 == 0 {
                    if adjMatrix[i][j] != first {
                        tempCount += 1
                    }
                } else {
                    if adjMatrix[i][j] == first {
                        tempCount += 1
                    }
                }
            } else {
                if j % 2 != 0 {
                    if adjMatrix[i][j] != first {
                        tempCount += 1
                    }
                } else {
                    if adjMatrix[i][j] == first {
                        tempCount += 1
                    }
                }
            }
        }
    }
    return tempCount
}

let W = Character("W")
let B = Character("B")

var totalMin = Int.max
for i in 0...N-8{
    for j in 0...M-8 {
        let whenFirstIsW = getCount(i,j, W)
        let whenFirstIsB = getCount(i,j, B)
        let tempResult = whenFirstIsW > whenFirstIsB ? whenFirstIsB : whenFirstIsW
        totalMin = tempResult < totalMin ? tempResult : totalMin
    }
}
print(totalMin)
