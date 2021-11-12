---
title: Acwing788
date: 2021-09-30 20:35:29
tags: 
    - Study
    - 排序
categories: 
    - 题解
    - Acwing
---
给定一个长度为 n 的整数数列，请你计算数列中的逆序对的数量。

逆序对的定义如下：对于数列的第 i 个和第 j 个元素，如果满足 i<j且 a[i]>a[j]，则其为一个逆序对；否则不是。

#### 输入格式

第一行包含整数 nn，表示数列的长度。

第二行包含 nn 个整数，表示整个数列。

#### 输出格式

输出一个整数，表示逆序对的个数。

#### 数据范围

1≤n≤1000001≤n≤100000，\
数列中的元素的取值范围 [1,10^9]

#### 输入样例：

```
6
2 3 4 5 6 1
```

#### 输出样例：

```
5
```
#### 思路：
根据题目我们给出逆序对的定义：  
对于数列的第 i 个和第 j 个元素，如果满足 i < j 且 a[i] > a[j]，则其为一个逆序对。
有一个重要的地方在于，一个元素可以不只是在一个逆序对中存在。如果 k > j > i 且 a[i] > a[j] > a[k]，那么这里有两个含 a[i] 的逆序对，分别是 (a[i], a[j]) 和 (a[i], a[k]), 即a[i]是可以使用多次的。

知道定义后来思考如何解决问题,我们以分治思想来解决问题，将区间一分为二，所有的逆序对以中间为划分分为三类
- 两个元素都在左边的（左半边逆序对的数量：merge-sort(l,mid)）
- 两个元素都在右边的（右半边逆序对的数量：merge_sort(mid + 1,r)）
- 两个元素一左一右的（）

我们要做的就是分别递归左边和右边寻找逆序对，最后计算一个在左边一个在右边的情况（归并）。把所有的加在一起就是答案。在第三步计算元素分别在左右两边的逆序对的时候，先对左右分别进行排序，这样并不会改变答案（**一个很重要的性质，左右半边的元素在各自任意调换顺序，是不影响第三步计数的**），但是可以让第三步计算变得很简单。
> 7 8 9 | 4 5 6 

显然在7 > 4后，在左边7后面所有的数都大于4，就不继续计算，只用加上后面的元素个数就行了，很自然的，用到了归并排序的思想。


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
//对于数列的第 i 个和第 j 个元素，如果满足 i<j 且 a[i]>a[j]，则其为一个逆序对；否则不是。

const int N = 100010;
int n;
long long cnt;
int q[N],tep[N];


void merge_sortfind(int q[],int l,int r){
    if(l >= r) return;
    int mid = (l + r) >> 1;

    merge_sortfind(q,l,mid),merge_sortfind(q,mid + 1,r);
    int k = 0,i = l,j = mid + 1;
    while(i <= mid && j <= r){
        if(q[i] <= q[j]) tep[k++] = q[i++];//不满足，往后加
        else{
            tep[k++] = q[j++];
            cnt += (mid - i + 1);//直接加，因为排序后左边有一个大于右边的某数，那么此数后面所有都大于右边的某数
        }
    }

    while(i <= mid) tep[k++] = q[i++];
    while(j <= r) tep[k++] = q[j++];

    for(i = l,j = 0;i <= r;i++,j++) q[i] = tep[j];
}

int main(){
    scanf("%d",&n);
    for(int i = 0; i < n; i++) scanf("%d",&q[i]);

    merge_sortfind(q,0,n - 1);
    cout << cnt;
    return 0;
}
```