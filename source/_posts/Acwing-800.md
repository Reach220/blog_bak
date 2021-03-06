---
title: Acwing 800
date: 2021-10-27 22:09:06
tags: 
    - Study
    - 双指针
categories: 
    - 题解
    - Acwing
---
给定两个升序排序的有序数组 AA 和 BB，以及一个目标值 xx。

数组下标从 00 开始。

请你求出满足 A[i]+B[j]=xA[i]+B[j]=x 的数对 (i,j)(i,j)。

数据保证有唯一解。

#### 输入格式

第一行包含三个整数 n,m,xn,m,x，分别表示 AA 的长度，BB 的长度以及目标值 xx。

第二行包含 nn 个整数，表示数组 AA。

第三行包含 mm 个整数，表示数组 BB。

#### 输出格式

共一行，包含两个整数 ii 和 jj。

#### 数据范围

数组长度不超过 105105。\
同一数组内元素各不相同。\
1≤数组元素≤1091≤数组元素≤109

#### 输入样例：

```
4 5 6
1 2 4 7
3 4 6 8 9
```

#### 输出样例：

```
1 1
```
#### 思路
##### 双指针
首先寻找暴力方法，就是两个循环遍历，判断是否满足条件，当然是超时的。

```js
// foreverking
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <queue>
#include <vector>
using namespace std;

const int N = 100010;
int n, m, x;
int a[N], b[N];
int ans_a, ans_b;

 void check(int x[], int y[]) {
     for (int i = 0; i < n; i++) {
         for (int j = 0; j < m; j++) {
             if (x[i] == y[j]) {
                 ans_a = i;
                 ans_b = j;
             }
         }
     }
 }



int main() {
    cin >> n >> m >> x;
    for (int i = 0; i < n; i++) cin >> a[i];
    for (int i = 0; i < m; i++) cin >> b[i];

    check();

    return 0;
}

```
因为a,b是升序数组，可知a,b构成递增单调性，由于ab数组单调递增且答案唯一那么就可采用双指针算法，这也是典型的双指针算法。寻找满足`a[i] + b[j] >= x`条件的i,j，其中，当i增大时，j就只能减小或者不变，即b的下标只能向右移动。所以，i从0开始，j从m-1开始，寻找满足`a[i] + b[j] >= x`的j的值，找到满足条件的j的最小值，如果等于，就找到了，否则继续循环。

```js
// foreverking
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <queue>
#include <vector>
using namespace std;

const int N = 100010;
int n, m, x;
int a[N], b[N];
int ans_a, ans_b;

// void check(int x[], int y[]) {
//     for (int i = 0; i < n; i++) {
//         for (int j = 0; j < m; j++) {
//             if (x[i] == y[j]) {
//                 ans_a = i;
//                 ans_b = j;
//             }
//         }
//     }
// }

void check() {
    for (int i = 0, j = m - 1; i < n; i++) {
        while (j >= 0 && a[i] + b[j] > x) j--;
        if (a[i] + b[j] == x) {
            cout << i << " " << j;
            break;
        }
    }
}

int main() {
    cin >> n >> m >> x;
    for (int i = 0; i < n; i++) cin >> a[i];
    for (int i = 0; i < m; i++) cin >> b[i];

    check();

    return 0;
}

```
##### 二分
没错可以二分来做，循环a数组，在每次循环中，对b数组进行二分，找`x - a[i]`。
```js
// foreverking
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <queue>
#include <vector>
using namespace std;

const int N = 100010;
int n, m, x;
int a[N], b[N];

int main() {
    cin >> n >> m >> x;
    for (int i = 0; i < n; i++) cin >> a[i];
    for (int i = 0; i < m; i++) cin >> b[i];

    for (int i = 0; i < n; i++) {
        int temp = x - a[i];//条件，需要在b数组中找到等于temp的值
        int l = 0, r = m - 1;//二分边界
        while(l < r) {
            int mid = (l + r + 1) >> 1;
            if (b[mid] <= temp) l = mid;//更新左端点
            else
                r = mid - 1;//更新右端点
        }
        if(b[l] == temp){//找到了
            cout << i << " " << l;
            break;
        }
    }
    return 0;
}
```