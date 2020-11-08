# CGXCategoryView-OC

 [![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
 [![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
 [![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/CGXCategoryView-OC)
 [![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 
 
 下载链接：https://github.com/974794055/CGXCategoryView-OC.git
 最新版本号： 1.4.1
 
功能：    
- 今日头条、拼多多、QQ音乐、京东、爱奇艺、腾讯视频、优酷、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图
 
优点：
- 1、使用协议封装指示器逻辑，可以为所欲为的自定义指示器效果；
- 2、提供更加全面丰富、高度自定义的效果；-
- 3、使用子类化管理cell样式，逻辑更清晰，扩展更简单；
- 4、高度封装列表容器，使用便捷，完美支持列表的生命周期调用；

效果：
- 1、自定义指示器view;
- 2、纯文字菜单;
- 3、图、文菜单;
- 4、自定义富文本;
- 5、商品排序;
- 6、活动大小标题;
- 7、角标;
- 8、大小缩放;
- 9、背景边框;
- 10、分割线;

## 效果预览
### 指示器效果预览
说明 | Gif |
----|------|
LineView效果  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXCategoryViewGif/Title1.gif" width="287" height="600"> |
BackgroundView  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXCategoryViewGif/Title2.gif" width="287" height="600"> |
大小缩放  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXCategoryViewGif/Title3.gif" width="287" height="600"> |
背景边框  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXCategoryViewGif/Title4.gif" width="287" height="600"> |
分割线  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXCategoryViewGif/Title5.gif" width="287" height="600"> |

## 要求

- iOS 8.0+
- Xcode 9+
- Objective-C

## 安装
### 手动
Clone代码，把Sources文件夹拖入项目，#import "CGXCategoryView.h"，就可以使用了；
### CocoaPods
```ruby
target '<Your Target Name>' do
    pod 'CGXCategoryView-OC'
end
```
先执行`pod repo update`，再执行`pod install`

## 结构图

## 使用

### CGXCategoryTitleView使用示例

1.初始化CGXCategoryTitleView
```Objective-C
self.categoryView = [[CGXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, 50)];
self.categoryView.delegate = self;
[self.view addSubview:self.categoryView];
```
2.配置CGXCategoryTitleView的属性
```Objective-C
self.categoryView.titles = @[@"全部",@"推荐", @"直播", @"热门商品", @"精品课", @"生活", @"苹果"...]
self.categoryView.titleColor = [UIColor whiteColor];
self.categoryView.titleSelectedColor = [UIColor redColor];
self.categoryView.titleColorGradientEnabled = YES;
self.categoryView.titleLabelZoomEnabled = YES;
```

3.添加指示器
```Objective-C
CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
lineView.indicatorColor = [UIColor redColor];
lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
self.categoryView.indicators = @[lineView];
```

4.可选实现`CGXCategoryViewDelegate`代理

```Objective-C
/**
 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**
 点击选中的情况才会调用该方法

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

/**
 滚动选中的情况才会调用该方法

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;


/**
  只有点击的选中才会调用！！！
  因为用户点击，contentScrollView即将过渡到目标index的位置。内部默认实现`[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];`。如果实现该代理方法，以自定义实现为准。比如将animated设置为NO，点击切换时无需滚动效果。类似于今日头条APP。

 @param categoryView categoryView description
 @param index index description
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index;


/**
 控制能否点击Item

 @param categoryView categoryView对象
 @param index 准备点击的index
 @return 能否点击
 */
- (BOOL)categoryView:(CGXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index;

/**
 正在滚动中的回调

 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;
```
### 列表容器使用示例

#### `CGXCategoryListContainerView`封装类使用示例

`CGXCategoryListContainerView`是对列表视图高度封装的类，具有以下优点：
- 相对于直接使用`UIScrollView`自定义，封装度高、代码集中、使用简单；
- 列表懒加载：当显示某个列表的时候，才进行列表初始化。而不是一次性加载全部列表，性能更优；
- 支持列表的willAppear、didAppear、willDisappear、didDisappear生命周期方法调用；

1.初始化`CGXCategoryListContainerView`并关联到`categoryView`
```Objective-C
self.listContainerView = [[CGXCategoryListContainerView alloc] initWithType:CGXCategoryListContainerType_ScrollView delegate:self];
[self.view addSubview:self.listContainerView];
//关联到categoryView
self.categoryView.listContainer = self.listContainerView;
```

2.实现`CGXCategoryListContainerViewDataSource`代理方法
```Objective-C
/**
 返回list的数量
 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView;

/**
 根据index返回一个对应列表实例，需要是遵从`CGXCategoryListContentViewDelegate`协议的对象。
 你可以代理方法调用的时候初始化对应列表，达到懒加载的效果。这也是默认推荐的初始化列表方法。你也可以提前创建好列表，等该代理方法回调的时候再返回也可以，达到预加载的效果。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`CGXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`CGXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。
 
 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从CGXCategoryListContentViewDelegate协议的list实例
 */
- (id<CGXCategoryListContainerViewDelegate>)listContainerView:(CGXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;
```

3.列表实现`CGXCategoryListContainerViewDelegate`代理方法

不管列表是UIView还是UIViewController都可以，提高使用灵活性，更便于现有的业务接入。
```Objective-C
/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己
 
 @return 返回列表视图
 */
- (UIView *)listView;

@optional
/**
 可选实现，列表将要显示的时候调用
 */
- (void)listWillAppearAtIndex:(NSInteger)index;

/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppearAtIndex:(NSInteger)index;

/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappearAtIndex:(NSInteger)index;

/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappearAtIndex:(NSInteger)index;
```


## 补充

如果刚开始使用`CGXCategoryView`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：974794055@qq.com </br>
QQ群： 

<img src="" width="300" height="411">

喜欢就star❤️一下吧

## License

CGXCategoryView is released under the MIT license.

  
  
  
  
  
  
  
  
  
  
  
  
