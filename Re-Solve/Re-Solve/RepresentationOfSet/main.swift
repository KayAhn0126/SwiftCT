import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var parent = [Int](repeating: 0, count: N + 1)
for i in 1...N {
    parent[i] = i
}


// parent[child] = 10이라면 child의 부모는 10이라는것이다.
// 10 -> 7 -> 3
// parent[10] = 3
func find_parent(_ child: Int) -> Int {
    if parent[child] != child {
        parent[child] = find_parent(parent[child])
    }
    return parent[child]
}

func union_parent(_ a: Int, _ b: Int) {
    let a = find_parent(a)
    let b = find_parent(b)
    
    if a < b {
        parent[b] = a
    } else {
        parent[a] = b
    }
}

for i in 0..<M {
    let operAB = readLine()!.split(separator: " ").map { Int(String($0))! }
    let oper = operAB[0]
    let A = operAB[1]
    let B = operAB[2]
    if oper == 0 {
        union_parent(A,B)
    } else {
        if find_parent(A) == find_parent(B) {
            print("YES")
        } else {
            print("NO")
        }
    }
}
