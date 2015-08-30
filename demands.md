需求 & API 构想
======================


# 资讯

## 需求

* 校庆新闻
* 校庆专栏

## 列表

### 请求参数

* type: 0 新闻，1 专栏
* page: int

### 返回

数组，结构如下：

* index: 资讯的 id，使用 index 字段而不用 id（与 Objective-C 的类型 id 冲突）
* title: 标题

## 内容

### 请求参数

* index

### 返回

* title: 标题
* content: 内容
* date: 添加日期

# 活动

## 需求

* 学校活动信息
* 各学院活动信息
* 新老校区地图（等待提供，本地）

## 列表

### 请求参数

* source: string，用序号或英文缩写表示各学院，不过注意两个特殊的：所有学院活动和校方发布活动
* page

### 返回

数组，结构如下：

* index
* title
* time: 活动时间
* place: 活动地点
* source: 活动来源

## 内容

### 请求参数

* index

### 返回

* title
* content
* time
* place
* source
* date: 该篇的添加时间

# 论坛

* 发布照片文字、简单注册 直接 Web

# 捐赠

* 一些信息，也是静态 Web