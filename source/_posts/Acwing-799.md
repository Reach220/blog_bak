---
title: Acwing 799
date: 2021-10-27 20:37:34
tags: 
    - Study
    - 双指针
categories: 
    - 题解
    - Acwing
---
 给定一个长度为 n 的整数序列，请找出最长的不包含重复的数的连续区间，输出它的长度。

#### 输入格式

第一行包含整数 n。

第二行包含 n 个整数（均在 0∼1050∼105 范围内），表示整数序列。

#### 输出格式

共一行，包含一个整数，表示最长的不包含重复的数的连续区间的长度。

#### 数据范围

1≤n≤105

#### 输入样例：

```
5
1 2 2 3 5
```

#### 输出样例：

```
3
```
#### 思路
##### 暴力
首先想到的是纯暴力的做法，遍历数组并判断是否有重复数字，时间复杂度达到了O(n^2),显然有点慢。

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

const int N = 10010;

int n,res;
int a[N];

int check(int l, int r) {
    for (int i = l + 1; i <= r; i++) {
        for (int j = l; j < i; j++) {
            if (a[j] == a[i]) return 0;
        }
    }

    return 1;//满足条件，返回1
}

int main() {
    cin >> n;
    for (int i = 0; i < n; i++) cin >> a[i];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= i; j++) {
            if (check(j, i)) res = max(res, i - j + 1);
        }
    }

    cout << res << endl;
    return 0;
}
```
暴力方法用数组来存数据，我开始用string，只能过样例，因为string只能存一个字符。
##### 双指针
仔细观察暴力方法就会发现，在解题时有很多地方是重复计算的 ( i 指针在 j 指针的后面，i是遍历的整个数组的，j 是遍历 0 到 i 的)，也就是说j没必要每次都从0开始移动，j是递增的，永远不会向左移动。当举例，当你发现[2,5]满足条件，接下来你该直接判断[2,6]是否满足，如果不满足，就判断[3,6].以此类推，会节省很多重复的时间。

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

const int N = 10010;

int n, res;
int a[N];
// string a;不能用string因为一次一个字符

//判断没有重复
int check_one(int l, int r) {
    for (int i = l + 1; i <= r; i++) {
        for (int j = l; j < i; j++) {
            if (a[j] == a[i]) return 0;
        }
    }

    return 1;  //满足条件，返回1
}

int main() {
    cin >> n;
    for (int i = 0; i < n; i++) cin >> a[i];

    // for (int i = 0; i < n; i++) {
    //     for (int j = 0; j <= i; j++) {
    //         if (check_one(j, i)) res = max(res, i - j + 1);
    //     }
    // }
    //暴力方法超时了
    for (int i = 0, j = 0; i < n; i++) {
        while(j <= i){
            if(check_one(j,i)) {
                res = max(res, i - j + 1);
                break;
            }
            else
                j++;
        }
        //j:最长不重复数列的左端点 j只会往后走
    }
    cout << res << endl;
    return 0;
}
```
然后发现还是超时了，是因为check函数太慢了，就需要我们重新寻找判断方法。  
就像桶排一样，我们开一个数组来存区间数字出现的次数。每次把i向后移动一位，并将新的数字对应的数组位置++。因为重复的数字只会是在新加入的a[i]，那么我们就移动j，直到重复的数字消失，然后更新res。

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

int n, res;
int a[N], cnt[N];
// string a;不能用string因为一次一个字符

//判断没有重复
int check_one(int l, int r) {
    for (int i = l + 1; i <= r; i++) {
        for (int j = l; j < i; j++) {
            if (a[j] == a[i]) return 0;
        }
    }

    return 1;  //满足条件，返回1
}

int main() {
    cin >> n;
    for (int i = 0; i < n; i++) cin >> a[i];

    // for (int i = 0; i < n; i++) {
    //     for (int j = 0; j <= i; j++) {
    //         if (check_one(j, i)) res = max(res, i - j + 1);
    //     }
    // }
    //暴力方法超时了
    // for (int i = 0, j = 0; i < n; i++) {
    //     while(j <= i){
    //         if(check_one(j,i)) {
    //             res = max(res, i - j + 1);
    //             break;
    //         }
    //         else
    //             j++;
    //     }

    // j:最长不重复数列的左端点 j只会往后走
    //}
    //用双指针。还是超时，check函数太暴力了

    for (int i = 0, j = 0; i < n; i++) {
        //类似桶排
        cnt[a[i]]++;
        while (j <= i && cnt[a[i]] > 1) {
            cnt[a[j]]--;
            j++;
        }  //将j移动到满足条件的位置
        res = max(res, i - j + 1);
    }
    cout << res << endl;
    return 0;
}
```