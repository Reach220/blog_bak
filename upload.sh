#!/bin/bash

hexo c
hexo g
hexo d

git add .
git commit -m "blog backup"
git push -u origin master
