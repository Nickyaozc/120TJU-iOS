# 120TJU-iOS
The iOS client for the 120th anniversary of Tianjin University

# 简介

120 周年校庆 app 项目。以下几点务必注意：

* 使用 Xcode 6.x 进行开发，推荐 Xcode 6.4 或更新版本。**禁止**使用 Xcode 7 Beta 进行开发
* 使用 Objective-C 与 Swift 开发，**禁止**使用 Swift 2 语法
* 版本控制使用 git
* 依赖管理使用 CocoaPods，使用 TJU120.xcworkspace 进行开发，Pods 目录加入 .gitignore 中。初次使用需要 `pod install`
* 所有界面必须通过 Autolayout 能够自适应 iPhone 与 iPad
* 函数变量名使用**英文**，并通过驼峰命名法描述

# 具体规范

## 工程组织

按照 Model，View，Controller 的模式组织工程。

* Model
	* 数据模型
	* 数据处理模块
	* UIActivity
	* 单例模式实现（data.h）
	* 封装的其他东西
* View
	* 视图
	* UITableViewCell
* Controller
	* UIViewController
	* Storyboard
	* XIB

## 网络交互

使用 [AFNetworking](https://github.com/AFNetworking/AFNetworking) 进行网络交互。直接对回调参数中的 `id responseObject` 进行操作而无需使用 JSONKit 解析。

**不要**直接解析 responseObject 加载，先将 NSDictionary 转为自己的 model。例如，如果获取 User 信息，收到 NSDictionary 结构为：

```JSON
{
    "uid": 1234,
    "user_name": "xiaoming"
}
```

则将其转换为 User model

```objc
@interface User : NSObject

@property (nonatomic) NSInteger uid;
@property (strong, nonatomic) NSString *userName;

@end
```

这样在调用时可以直接通过 `user.uid` 的方式，避免因为数据问题产生 crash。

你可以自己写 NSDictionary -> Model 的转换，也可以使用 [MJExtension](https://github.com/CoderMJLee/MJExtension) 进行转换。

## Objective-C 与 Swift 混编

具体的查阅相关文档。主要有两点：

* Swift 调用 Objective-C，头文件为 TJU120-Bridging-Header.h
* Objective-C 调用 Swift，需要 `#import "TJU120-Swift.h"`，尽管你并不能看到这个文件

同时注意 Swift 和 Objective-C 类型转换，比如 id 和 AnyObject。

## Git

开发某一阶段完成后，commit 自己的代码，并向本主仓库提交 pull request。我在进行 code review 之后会把代码合并到仓库中。

## pragma mark

用好 pragma mark。一般来说，一个文件内的代码应遵循以下顺序：

```objc
#pragma mark - Life Cycle
- (void)viewDidLoad { }
- (void)viewWillAppear:(BOOL)animated { }
- (void)didReceiveMemoryWarning { }

#pragma mark - Custom Accessors
- (void)setProperty:(id)value { }
- (id)customProperty { }

#pragma mark - IBActions
- (IBAction)testFunction:(id)sender { }

#pragma mark - Public Methods
- (void)publicMethod { }

#pragma mark - Private Methods
- (void)privateMethod { }

#pragma mark - Delegates or Data Sources
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { }
```

## 其它的小规范

* 写好注释
* 花括号于代码同一行开始，另起一行结束
* 类方法和实例方法符号后有一个空格。例：`- (void)testFunction;`
* 较长的 NSDictionary 将每一个键值对另起一行