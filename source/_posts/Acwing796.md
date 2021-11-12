---
title: Acwing796
date: 2021-10-22 12:44:18
tags: 
    - Study
categories: 
    - 题解
    - Acwing
---
输入一个 n 行 m 列的整数矩阵，再输入 q 个操作，每个操作包含五个整数 x1,y1,x2,y2,c，其中 (x1,y1) 和 (x2,y2) 表示一个子矩阵的左上角坐标和右下角坐标。

每个操作都要将选中的子矩阵中的每个元素的值加上 cc。

请你将进行完所有操作后的矩阵输出。
#### 输入格式

第一行包含整数 n,m,q。

接下来 n 行，每行包含 m 个整数，表示整数矩阵。

接下来 q 行，每行包含 5 个整数 x1,y1,x2,y2,c，表示一个操作。
#### 输出格式

共 n 行，每行 m 个整数，表示所有操作进行完毕后的最终矩阵。
#### 数据范围

1≤n,m≤1000  
1≤q≤100000  
1≤x1≤x2≤n  
1≤y1≤y2≤m  
−1000≤c≤1000  
−1000≤矩阵内元素的值≤1000  

#### 输入样例：

```
3 4 3
1 2 2 1
3 2 2 1
1 1 1 1
1 1 2 2 1
1 3 2 3 2
3 1 3 4 1
```

#### 输出样例：

```
2 3 4 1
4 3 4 1
2 2 2 2
```
#### 思路
使用二维差分的思路，同时创建两个数组a,b。a是原数组，b是差分数组。
对差分数组b进行操作，那么a数组也对应变化，想要子矩阵区域全部加上c，需要这样的代码`：b[x1][y1] += c;
    b[x2 + 1][y1] -= c;
    b[x1][y2 + 1] -= c;
    b[x2 + 1][y2 + 1] += c;`  
 对差分数组进行插入c操作后，在对其求二维前缀和，就完成题目了。  
 
需要注意的是差分数组的构造，你可以使用`b[i][j] = a[i][j] - a[i - 1][j] - a[i][j - 1] + a[i -1][j - 1];`这样的直接构造方法，也可以利用插入函数，将a,b数组同时视作空的，对a数组每一个小方格加上对应的a[i][j],那么同时用插入c的方法将a[i][j] 插入数组b的一个小方格内。都可以完成差分数组的构造。
```js
//foreverking
#include <vector>
#include <cstdio>
#include <queue>
#include <algorithm>
#include <cstring>
#include <iostream>
#include <cmath>
using namespace std;

const int N = 1010;

int n,m,q;
int a[N][N],b[N][N];

void insert(int x1,int y1,int x2,int y2,int c){
    b[x1][y1] += c;
    b[x1][y2 + 1] -= c;
    b[x2 + 1][y1] -= c;
    b[x2 + 1][y2 + 1] += c;
}

int main(){
    cin >> n >> m >> q;
    for(int i = 1; i <= n; i++)
        for(int j = 1; j <= m; j++)
            cin >> a[i][j];//输入原数组

    for(int i = 1; i <= n; i++)
        for(int j = 1; j <= m; j++)
             insert(i,j,i,j,a[i][j]);//构建差分数组B
            //b[i][j] = a[i][j] - a[i - 1][j] - a[i][j - 1] + a[i -1][j - 1];

    while(q--){
        int x1,x2,y1,y2,c;
        cin >> x1 >> y1 >> x2 >> y2 >> c;
        insert(x1,y1,x2,y2,c); 
    }
    // for(int i = 1; i <= n; i++)
    //     for(int j = 1; j <= m; j++)
    //         b[i][j] += b[i - 1][j] + b[i][j - 1] - b[i - 1][j -1];//求二维前缀和
    for(int i = 1; i <= n; i++){
        for(int j = 1; j <= m; j++){
            //b[i][j] += b[i - 1][j] + b[i][j - 1] - b[i - 1][j -1];//求二维前缀和
            cout << b[i][j] << " ";
        }
        cout << endl;
    }
           

    return 0;
}
```