import Foundation

let N = Int(readLine()!)!

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

//MARK: 재귀는 기저사례가 있어야 한다!
func getPressedResult(_ size: Int, _ y: Int, _ x: Int) -> String {
    var result = ""
    var currentLetter = adjMatrix[y][x]
    if size == 1 {
        return String(currentLetter)
    }
    for i in y..<y+size {
        for j in x..<x+size {
            if currentLetter != adjMatrix[i][j] {
                result += "("
                result += getPressedResult(size/2, y, x)
                result += getPressedResult(size/2, y, x + size/2)
                result += getPressedResult(size/2, y + size/2, x)
                result += getPressedResult(size/2, y + size/2, x + size/2)
                result += ")"
                return result
            }
        }
    }
    return String(currentLetter)
}

print(getPressedResult(N,0,0))
