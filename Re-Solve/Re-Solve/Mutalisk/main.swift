import Foundation

// 순열 9,3,1 구하기

func permutation<T>(_ arr: [T], _ num: Int) -> [[T]] {
    var result: [[T]] = []
    if num > arr.count { return result }
    
    var visited = [Bool](repeating: false, count: arr.count)
    func cycle(_ now: [T]) {
        if now.count == num {
            result.append(now)
            return
        }
        
        for i in 0..<arr.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                cycle(now + [arr[i]])
                visited[i] = false
            }
        }
    }
    cycle([])
    return result
}


let N = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

var damages = permutation([9,3,1],3)

while arr.count != 3 {
    arr.append(0)
}
var first = arr[0]
var second = arr[1]
var third = arr[2]
var queue: [(Int,Int,Int)] = [], idx = 0
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 61), count: 61), count: 61)
queue.append((first,second,third))
visited[first][second][third] = 1



while idx < queue.count {
    let current = queue[idx]; idx += 1
    let cFirst = current.0
    let cSecond = current.1
    let cThird = current.2
    
    if cFirst == 0 && cSecond == 0 && cThird == 0 {
        break
    }
    
    for damage in damages {
        let dFirst = damage[0]
        let dSecond = damage[1]
        let dThird = damage[2]
        
        let nFirst = (cFirst - dFirst) > 0 ? cFirst - dFirst : 0
        let nSecond = (cSecond - dSecond) > 0 ? cSecond - dSecond : 0
        let nThird = (cThird - dThird) > 0 ? cThird - dThird : 0
        if visited[nFirst][nSecond][nThird] != 0 { continue }
        visited[nFirst][nSecond][nThird] = visited[cFirst][cSecond][cThird] + 1
        queue.append((nFirst,nSecond,nThird))
    }
}
print(visited[0][0][0] - 1)
