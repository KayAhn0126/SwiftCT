import sys

userInput = int(sys.stdin.readline())

arr = []
for i in range(userInput):
    arr.append(list(map(int, input())))

visited = [[0 for _ in range(userInput)] for _ in range(userInput)]

resultList = []

dy = [-1,0,1,0]
dx = [0,1,0,-1]


for i in range(userInput):
    print(arr[i])




global highest
highest = 1

def dfs(y,x):
    global highest
    visited[y][x] = 1
    for i in range(4):
        ny = y + dy[i]
        nx = x + dx[i]
        if ny < 0 or nx < 0 or ny >= userInput or nx >= userInput : continue
        if arr[ny][nx] == 0 or visited[ny][nx] != 0:
            continue
        highest += 1
        dfs(ny,nx)

for i in range(userInput):
    for j in range(userInput):
        if arr[i][j] == 0 or visited[i][j] != 0 :
            continue
        highest = 1
        dfs(i,j)
        resultList.append(highest)

print(len(resultList))
resultList.sort()
for i in resultList:
    print(i)






