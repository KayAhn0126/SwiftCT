//
//  main.swift
//  SumOfIntervals5
//
//  Created by Kay on 2023/06/14.
//

/*
 11660
 구간 합 구하기 5
 */

/*
 문제 접근
 1. DP로 배열 다 채우기
    처음에 0,0에서 십자 모양으로 채워주기
    1-1. y가 0일때
        - visited[0][x] = visited[0][x-1] + adjMatrix[0][x]
         x가 0일때
        - visited[y][0] = visited[y-1][0] + adjMatrix[y][0]
    1-2. (2,2) 좌표부터는 아래와 같이 한다. 실제로는
        - visited[1][1]
 */
import Foundation

