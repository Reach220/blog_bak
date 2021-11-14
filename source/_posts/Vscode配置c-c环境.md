---
title: Vscode配置c++/c环境
date: 2021-11-14 21:12:01
tags: 
    - Vscode
---
现在很多初学者都用Dev c++，vc++6.0来编写c语言程序，可是这些IDE大都比较老旧，用起来有很多不顺畅的地方，所以寻找一款现代化的、功能强大的编辑器/IDE对于一些人来说还是很有必要的。我推荐使用vscode,轻量级颜值高。或许有人喜欢开箱即用的IDE，但是也不妨碍你试一试vscode。
## Windows环境下配置Vscode
vscode定位代码编辑器，不是IDE，不包含编译功能，因此需要我们自己安装编译器、调试器等编译器套件，并使两者有效的配合起来，以实现快捷操作。把这一整套工具链整合到一起的过程就是搭建环境。  

我们一步一步来，首先需要安装vscode,去官网下就可以了。  

### 第一步
[![v2-68544ffce18f7902d7df0f5ad4556f42_r.jpg](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/15fa4d992ec24055be723fb8a614dad9~tplv-k3u1fbpfcp-watermark.image?)](https://code.visualstudio.com/)

接下来自己装好vscode就可以了（安装路径选好，不知道放哪不如就默认路径）
### 第二步
下载编译套装，我们选择gcc（全称GNU Compiler Collection 意思是GNU编译器套件）。因为是在windows环境下，所以选择在Windows下的特制版**MinGW**(全称Minimalist GNU on Windows）。它实际上是将GCC 移植到了 Windows 平台下，MinGW又分为MinGW-w64 与 MinGW ，区别在于 MinGW 只能编译生成32位可执行程序，而 **[MinGW-w64](https://sourceforge.net/projects/mingw-w64/files/)** 则可以编译生成 64位 或 32位 可执行程序。MinGW 现已被 [MinGW-w64](https://sourceforge.net/projects/mingw-w64/files/) 所取代，且 MinGW 也已停止了更新。

[![v2-2637308c782e35401f75f829d012f9a3_720w.jpg](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9da76349c71142dc8a63bf9b1ec50b0c~tplv-k3u1fbpfcp-watermark.image?)](https://sourceforge.net/projects/mingw-w64/files/)

下载下来后是一个压缩文件，将它解压得到mingw64文件夹（一定要记得解压路径，选一个好地方，以后还用得到），**地址中不要有中文**，这很重要。  

### 第三步
配置环境变量，相信很多小白都不会，但是实际上实很简单的（我当初也觉得很难，多练练就好）。我们为了让程序能访问到编译程序(gcc,g++等)，需要把它们所在的**目录****添加到环境变量Path中**

不懂就就百度一下，下面贴流程图：

![v2-792e514f90cf94fd85b0e5b63b9e3f45_r.jpg](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/457ffa3bf5544e22b1f6269e1048b22e~tplv-k3u1fbpfcp-watermark.image?)

![v2-5b85a90688fc177926a59afc4a4aaeea_r.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/660371c02a8944d18dcf54778e2618b4~tplv-k3u1fbpfcp-watermark.image?)


![v2-97f141744e6959b1460e5b1dd12ee8bd_720w.jpg](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/280579111cb946108ad13b495709248a~tplv-k3u1fbpfcp-watermark.image?)

然后你在cmd内输入gcc检查是否成功，之后重启电脑。

### 第四步
打开vscode，安装一些插件，你觉得好用就用什么，但是先要装上几个必须的插件：

![2021-11-14 20-39-35 的屏幕截图.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dc3b84ebcce24610a5fa6004e9c3bc0d~tplv-k3u1fbpfcp-watermark.image?)

装上后重启vscode。

在vscode你需要一个工作区来存放编译运行你的代码。

![2021-11-14 20-42-01 的屏幕截图.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4d5a36f694534fdeacfc0975634ac242~tplv-k3u1fbpfcp-watermark.image?)

就像这样的一个vscode文件夹，你可以有很多个工作区，取决于你自己的需求。 然后你可以直接写一个`Hello World `然后按F5使用vscode自动生成的配置调试，用*code runner*这个插件运行，不过我觉得不太方便。

我个人倾向你使用下面的配置。

在工作区vscode下创建两个文件夹 **.vscode**与**bin**,然后是在此目录下创建**launch.json**与**tasks.json**文件。
**launch.json**:

```js
//launch
{
    "version": "0.2.0",
    "configurations": [
        {//这个大括号里是我们的‘调试(Debug)’配置
            "name": "Debug", // 配置名称
            "type": "cppdbg", // 配置类型，cppdbg对应cpptools提供的调试功能；可以认为此处只能是cppdbg
            "request": "launch", // 请求配置类型，可以为launch（启动）或attach（附加）
            "program": "${fileDirname}\\bin\\${fileBasenameNoExtension}.exe", // 将要进行调试的程序的路径
            "args": [], // 程序调试时传递给程序的命令行参数，这里设为空即可
            "stopAtEntry": false, // 设为true时程序将暂停在程序入口处，相当于在main上打断点
            "cwd": "${fileDirname}", // 调试程序时的工作目录，此处为源码文件所在目录
            "environment": [], // 环境变量，这里设为空即可
            "externalConsole": false, // 为true时使用单独的cmd窗口，跳出小黑框；设为false则是用vscode的内置终端，建议用内置终端
            "internalConsoleOptions": "neverOpen", // 如果不设为neverOpen，调试时会跳到“调试控制台”选项卡，新手调试用不到
            "MIMode": "gdb", // 指定连接的调试器，gdb是minGW中的调试程序
            "miDebuggerPath": "C:\\cs\\mingw64\\bin\\gdb.exe", // 指定调试器所在路径，如果你的minGW装在别的地方，则要改成你自己的路径，注意间隔是\\
            "preLaunchTask": "build" // 调试开始前执行的任务，我们在调试前要编译构建。与tasks.json的label相对应，名字要一样
    }]
}
```
**tasks.json**:

```js
//tasks
{
    "version": "2.0.0",
    "tasks": [
        {//这个大括号里是‘构建（build）’任务
            "label": "build", //任务名称，可以更改，不过不建议改
            "type": "shell", //任务类型，process是vsc把预定义变量和转义解析后直接全部传给command；shell相当于先打开shell再输入命令，所以args还会经过shell再解析一遍
            "command": "g++", //编译命令，这里是gcc，编译c++的话换成g++
            "args": [    //方括号里是传给gcc命令的一系列参数，用于实现一些功能
                "${file}", //指定要编译的是当前文件
                "-o", //指定输出文件的路径和名称
                "${fileDirname}\\bin\\${fileBasenameNoExtension}.exe", //承接上一步的-o，让可执行文件输出到源码文件所在的文件夹下的bin文件夹内，并且让它的名字和源码文件相同
                "-g", //生成和调试有关的信息
                "-Wall", // 开启额外警告
                "-static-libgcc",  // 静态链接libgcc
                "-fexec-charset=GBK", // 生成的程序使用GBK编码，不加这一条会导致Win下输出中文乱码
                "-std=c++11", // 语言标准，可根据自己的需要进行修改，写c++要换成c++的语言标准，比如c++11
            ],
            "group": {  //group表示‘组’，我们可以有很多的task，然后把他们放在一个‘组’里
                "kind": "build",//表示这一组任务类型是构建
                "isDefault": true//表示这个任务是当前这组任务中的默认任务
            },
            "presentation": { //执行这个任务时的一些其他设定
                "echo": true,//表示在执行任务时在终端要有输出
                "reveal": "always", //执行任务时是否跳转到终端面板，可以为always，silent，never
                "focus": false, //设为true后可以使执行task时焦点聚集在终端，但对编译来说，设为true没有意义，因为运行的时候才涉及到输入
                "panel": "new" //每次执行这个task时都新建一个终端面板，也可以设置为shared，共用一个面板，不过那样会出现‘任务将被终端重用’的提示，比较烦人
            },
            "problemMatcher": "$gcc" //捕捉编译时编译器在终端里显示的报错信息，将其显示在vscode的‘问题’面板里
        },
        {//这个大括号里是‘运行(run)’任务，一些设置与上面的构建任务性质相同
            "label": "run", 
            "type": "shell", 
            "dependsOn": "build", //任务依赖，因为要运行必须先构建，所以执行这个任务前必须先执行build任务，
            "command": "${fileDirname}\\bin\\${fileBasenameNoExtension}.exe", //执行exe文件，只需要指定这个exe文件在哪里就好
            "group": {
                "kind": "test", //这一组是‘测试’组，将run任务放在test组里方便我们用快捷键执行
                "isDefault": true
            },
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": true, //这个就设置为true了，运行任务后将焦点聚集到终端，方便进行输入
                "panel": "new"
            }
        }

    ]
}

```
> **bin**文件夹的作用是存放编译运行的可执行文件

接下来实设置快捷键，按自己的喜好就行

![2021-11-14 20-53-39 的屏幕截图.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6034f9c114a842189b8e85e3ac4ec01f~tplv-k3u1fbpfcp-watermark.image?)
这是我习惯的两个，在写好代码后shift + F10编译，F10运行：
![2021-11-14 20-54-08 的屏幕截图.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2289f2bd743245b7ad6e1d99e15c9fa0~tplv-k3u1fbpfcp-watermark.image?)
从此既可以用vscodex写代码了，大工程还是用Clion或者vs吧。
## Ubantu环境下配置
如果在Windows操作过，就简单许多，同样下好vscode和g++/gcc。

安装gcc/g++只需要一句话：
```
sudo apt-get update
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install gdb
```
然后检查一下：
> gcc -v

![2021-11-14 21-03-14 的屏幕截图.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/607332a9914d490484b977cf89c873c9~tplv-k3u1fbpfcp-watermark.image?)

vscode同样去官网，下载Linux版本的，或者去应用商店下载。当然也可以用命令行安装，很炫酷，但这不是重点。

与在Windows下同样的操作，但是文档配置改变一下，同样放上我的配置：
**launch.json**:

```js
//launch
{
    "version": "0.2.0",
    "configurations": [
        {//这个大括号里是我们的‘调试(Debug)’配置
            "name": "Debug", // 配置名称
            "type": "cppdbg", // 配置类型，cppdbg对应cpptools提供的调试功能；可以认为此处只能是cppdbg
            "request": "launch", // 请求配置类型，可以为launch（启动）或attach（附加）
            "program": "${fileDirname}//bin//${fileBasenameNoExtension}", // 将要进行调试的程序的路径
            "args": [], // 程序调试时传递给程序的命令行参数，这里设为空即可
            "stopAtEntry": false, // 设为true时程序将暂停在程序入口处，相当于在main上打断点
            "cwd": "${fileDirname}", // 调试程序时的工作目录，此处为源码文件所在目录
            "environment": [], // 环境变量，这里设为空即可
            "externalConsole": false, // 为true时使用单独的cmd窗口，跳出小黑框；设为false则是用vscode的内置终端，建议用内置终端
            "internalConsoleOptions": "neverOpen", // 如果不设为neverOpen，调试时会跳到“调试控制台”选项卡，新手调试用不到
            "MIMode": "gdb", // 指定连接的调试器，gdb是minGW中的调试程序
            "miDebuggerPath": "/usr/bin/gdb", // 指定调试器所在路径，如果你的minGW装在别的地方，则要改成你自己的路径，注意间隔是\\
            "preLaunchTask": "build" // 调试开始前执行的任务，我们在调试前要编译构建。与tasks.json的label相对应，名字要一样
    }]
}
```
**tasks,json**:

```js
//tasks
{
    "version": "2.0.0",
    "tasks": [
        {//这个大括号里是‘构建（build）’任务
            "label": "build", //任务名称，可以更改，不过不建议改
            "type": "shell", //任务类型，process是vsc把预定义变量和转义解析后直接全部传给command；shell相当于先打开shell再输入命令，所以args还会经过shell再解析一遍
            "command": "g++", //编译命令，这里是gcc，编译c++的话换成g++
            "args": [    //方括号里是传给gcc命令的一系列参数，用于实现一些功能
                "${file}", //指定要编译的是当前文件
                "-o", //指定输出文件的路径和名称
                "${fileDirname}//bin//${fileBasenameNoExtension}", //承接上一步的-o，让可执行文件输出到源码文件所在的文件夹下的bin文件夹内，并且让它的名字和源码文件相同
                "-g", //生成和调试有关的信息
                "-Wall", // 开启额外警告
                "-static-libgcc",  // 静态链接libgcc
                "-fexec-charset=GBK", // 生成的程序使用GBK编码，不加这一条会导致Win下输出中文乱码
                "-std=c++11", // 语言标准，可根据自己的需要进行修改，写c++要换成c++的语言标准，比如c++11
            ],
            "group": {  //group表示‘组’，我们可以有很多的task，然后把他们放在一个‘组’里
                "kind": "build",//表示这一组任务类型是构建
                "isDefault": true//表示这个任务是当前这组任务中的默认任务
            },
            "presentation": { //执行这个任务时的一些其他设定
                "echo": true,//表示在执行任务时在终端要有输出
                "reveal": "always", //执行任务时是否跳转到终端面板，可以为always，silent，never
                "focus": false, //设为true后可以使执行task时焦点聚集在终端，但对编译来说，设为true没有意义，因为运行的时候才涉及到输入
                "panel": "new" //每次执行这个task时都新建一个终端面板，也可以设置为shared，共用一个面板，不过那样会出现‘任务将被终端重用’的提示，比较烦人
            },
            "problemMatcher": "$gcc" //捕捉编译时编译器在终端里显示的报错信息，将其显示在vscode的‘问题’面板里
        },
        {//这个大括号里是‘运行(run)’任务，一些设置与上面的构建任务性质相同
            "label": "run", 
            "type": "shell", 
            "dependsOn": "build", //任务依赖，因为要运行必须先构建，所以执行这个任务前必须先执行build任务，
            "command": "${fileDirname}//bin//${fileBasenameNoExtension}", //执行exe文件，只需要指定这个exe文件在哪里就好
            "group": {
                "kind": "test", //这一组是‘测试’组，将run任务放在test组里方便我们用快捷键执行
                "isDefault": true
            },
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": true, //这个就设置为true了，运行任务后将焦点聚集到终端，方便进行输入
                "panel": "new"
            }
        }

    ]
}

```
[看看官方文档](https://code.visualstudio.com/docs/cpp/config-linux)
