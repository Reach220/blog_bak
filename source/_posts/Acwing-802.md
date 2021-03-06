---
title: Acwing 802
date: 2021-10-31 11:00:11
tags: 
    - Study
    - 离散化
categories: 
    - 题解
    - Acwing
---
假定有一个无限长的数轴，数轴上每个坐标上的数都是 0。

现在，我们首先进行 n 次操作，每次操作将某一位置 x 上的数加 c。

接下来，进行 m 次询问，每个询问包含两个整数 l 和 r，你需要求出在区间 [l,r] 之间的所有数的和。
#### 输入格式

第一行包含两个整数 n 和 m。

接下来 n 行，每行包含两个整数 x 和 c。

再接下来 m 行，每行包含两个整数 l 和 r。

#### 输出格式

共 mm 行，每行输出一个询问中所求的区间内数字和。
#### 数据范围

−109≤x≤109,  
1≤n,m≤105,  
−109≤l≤r≤109,  
−10000≤c≤10000  
#### 输入样例：

```
3 3
1 2
3 6
7 5
1 3
4 6
7 8
```

#### 输出样例：

```
8
0
5
```
#### 思路
这道题是一个区间离散化的过程，因为区间很长，但是某些元素的排布可能很稀疏，所以将原数列映射到一个连续数列中排列。  
关于这道题的步骤就大概有了：
1. 读输入。将每次读入的`x c` `push_back()`到`add`数列中，将每次读入的位置`x` `push_back()`到`all`中，将每次读入的`l r` `push_back()`到`query`中。
2. 排序、去重。
3. 通过遍历`add`，完成在离散化的数组映射到的a数组中进行加上c的操作（用到`find_one`函数）。
4. 初始化s数组。
5. 通过遍历`query`，完成求区间[l,r]的和。（前缀和）

解释一下步骤。其中，`add`数列存放的是每次输入的数据，即位置与对应的值，`all`存放的只是位置，不论是将要查询的还是已经存放数据的位置。`query`存放的是待每组查询的区间边界。 元素存储在vector<int> all中，排序去重后，再把值映射到长度较小的数组`a`中 ，`a`也就是连续数列，对他求前缀和得到答案。
`find_one`函数采用二分查找，输入一个离散数列的位置（映射前的位置）x返回连续数列的位置+1（映射后的位置+1）[+1是为了方便前缀和计算]  
排序，去重就是为了`find_one`做准备，想要二分就先排序，而排序之前先去重，排序去重后的all与数组a的相对顺序是一致的
`sort(alls.begin(), alls.end()); // 将所有值排序
alls.erase(unique(alls.begin(), alls.end()), alls.end());   // 去掉重复元素、`
当然去重函数也可以自己写。
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

typedef pair<int, int> PII;
const int N = 300010;
int n, m;
int a[N], s[N];

vector<int> all;  //待离散化的区间
vector<PII> add, query;

int find_one(int x) {
    int l = 0, r = all.size() - 1;
    while (l < r) {
        int mid = (l + r) >> 1;
        if (all[mid] >= x)
            r = mid;
        else
            l = mid + 1;
    }

    return l + 1;
}

vector<int>::iterator unique_one(vector<int>& all) {
    int j = 0;
    for (int i = 0; i < all.size(); i++) {
        if (!i || all[i] != all[i - 1]) all[j++] = all[i];
    }

    return all.begin() + j;
}

int main() {
    cin >> n >> m;
    for (int i = 0; i < n; i++) {
        int x, c;
        cin >> x >> c;
        add.push_back({x, c});  //存储数据

        all.push_back(x);  //放入待离散化的区间
    }

    for (int i = 0; i < m; i++) {
        int l, r;
        cin >> l >> r;
        query.push_back({l, r});

        all.push_back(l);
        all.push_back(r);  //放入待离散化的区间
    }

    //离散化，去重
    sort(all.begin(), all.end());
    // all.erase(unique(all.begin(), all.end()), all.end());
    all.erase(unique_one(all), all.end());

    //往映射中插入数据
    for (auto item : add) {
        int x = find_one(item.first);
        a[x] += item.second;
    }

    //前缀和处理
    for (int i = 1; i <= all.size(); i++) s[i] = s[i - 1] + a[i];
    
    for (auto item : query) {
        int l = find_one(item.first);
        int r = find_one(item.second);
        cout << s[r] - s[l - 1] << endl;
    }
    return 0;
}
```