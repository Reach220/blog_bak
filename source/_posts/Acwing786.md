---
title: Acwing786
date: 2021-09-22 21:41:26
tags: 
    - Study
    - 排序
categories: 
    - 题解
    - Acwing
---
给定一个长度为 nn 的整数数列，以及一个整数 kk，请用快速选择算法求出数列从小到大排序后的第 kk 个数。

#### 输入格式

第一行包含两个整数 nn 和 kk。

第二行包含 nn 个整数（所有整数均在 1∼1091∼109 范围内），表示整数数列。

#### 输出格式

输出一个整数，表示数列的第 kk 小数。

#### 数据范围

1≤n≤1000001≤n≤100000,\
1≤k≤n1≤k≤n

#### 输入样例：

```
5 3
2 4 1 5 3
```

#### 输出样例：

```
3
```
#### 代码

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


const int N  = 1e6 + 10;
int n,k;
int a[N];

void quick_sort(int a[],int l,int r){
    if(l >= r) return;

    int x = a[l],i = l - 1,j = r + 1;
    while(i < j){
        do i++; while(a[i] < x);
        do j--; while(a[j] > x);
        if(i < j){
            int num = a[i];
            a[i] = a[j];
            a[j] = num;
        }
    }

    quick_sort(a,l,j);
    quick_sort(a,j + 1,r);
}

int main(){
    scanf("%d %d",&n,&k);
    for(int i = 0; i < n; i++){
        scanf("%d",&a[i]);
    }
    quick_sort(a,0,n - 1);
     printf("%d",a[k - 1]);
    //  for(int i = 0; i < n; i++){
    //     //代码
    //     printf("%d ",a[i]);
    //     }
    return 0;
}
```
[快排]([排序 - 掘金 (juejin.cn)](https://juejin.cn/post/7010747248179068965))模板题