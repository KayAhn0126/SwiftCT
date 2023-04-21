import Foundation
// 맵 입력 받기
// 빙산의 위치를 가질 리스트(icebergList) 만들고 빙산의 위치 넣어주기
// 각 빙산을 돌면서 빙산이 몇개의 공기와 접촉해서 녹을지 저장하는 배열 melt 선언
//      각 빙산마다 주변 4 방향의 공기의 개수를 melt 배열에 저장한다.
//      위의 작업이 끝나면 board에 적용한다. 이때 0보다 작으면 0으로 바꿔준다.
//      또, icebergList에서 삭제한다.
//      CC를 구한다.
//      CC가 2개 이상이 되는 순간 time 출력 후 break.
//      icebergList의 갯수는 없는데 CC의 갯수는 1개이면 0 출력 후 break.
//      time을 늘린다.
// 순서가 중요하다.

// 시간복잡도는 처음에는 90,000이였다가 점점 줄어들것.
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var board = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    board[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var icebergList: [(Int,Int)] = []
for i in 0..<N {
    for j in 0..<M {
        if board[i][j] != 0 { icebergList.append((i,j)) }
    }
}

//MARK: 녹을 정보를 가지는 2차원 배열
var meltBoard = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

//MARK: 얼마나 녹일지 저장하는 함수
func getAirInfo() {
    for iceberg in icebergList {
        var air = 0
        for i in 0..<4 {
            let ny = iceberg.0 + dy[i]
            let nx = iceberg.1 + dx[i]
            if board[ny][nx] == 0 { air += 1 }
        }
        meltBoard[iceberg.0][iceberg.1] = air
    }
}

//MARK: 접촉한 공기 갯수만큼 board 맵에서 차감하는 함수
func deduction() {
    for i in 1..<N {
        for j in 1..<M {
            if meltBoard[i][j] == 0 { continue }
            let num = board[i][j] - meltBoard[i][j]
            if num > 0 {
                board[i][j] = num
            } else {
                board[i][j] = 0
            }
        }
    }
    icebergList.removeAll(where: { board[$0.0][$0.1] == 0 })
}

//MARK: CC 체크용 dfs 함수
func dfs(_ y: Int, _ x: Int, _ visited: inout [[Bool]]) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == true { continue }
        if board[ny][nx] == 0 { continue }
        visited[ny][nx] = true
        dfs(ny,nx, &visited)
    }
}


var time = 0
while true {
    var cc = 0
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
    getAirInfo()
    deduction()
    time += 1
    for i in 1..<N {
        for j in 1..<M {
            if cc >= 2 { continue }
            if board[i][j] == 0 { continue }
            if visited[i][j] == true { continue }
            visited[i][j] = true
            dfs(i,j,&visited)
            cc += 1
        }
    }
    if cc >= 2 {
        print(time)
        break
    }
    if cc == 0 {
        print(0)
        break
    }
}
