###TYActionSheet 可以深度定制的ActionSheet

![](https://github.com/qqcc1388/TYActionSheet/blob/master/TYActionSheet/TYActionSheet.gif) ![](https://github.com/qqcc1388/TYActionSheet/blob/master/TYActionSheet/actionSheet2.jpg) 

* 创建方法1 - acton提供统一回调方法，action headle = nil

```
-(void)addActon1
{
    TYActionSheet *actionSheet = [[TYActionSheet alloc] initActionSheetWithTitle:@"标题"];
    
    //创建acton
    TYAction *action1 = [[TYAction alloc] initWithActionTitle:@"内容1" Image:nil];
    TYAction *action2 = [[TYAction alloc] initWithActionTitle:@"内容2" Image:@"test"];
    TYAction *action3 = [[TYAction alloc] initWithActionTitle:@"内容3" Image:@"test"];
    //添加action
    [actionSheet addAction:action1 handle:nil];
    [actionSheet addAction:action2 handle:nil];
    [actionSheet addAction:action3 handle:nil];
    //回调
    [actionSheet actionSheetDidClick:^(TYAction *action, NSInteger index) {
        NSLog(@"%@---%zi",action.currentTitle,index);
    }];
    //显示actionSheet
    [actionSheet show];
}
```

---

* 创建方式2  - 每个action提供一个回调方法

```
-(void)addActon2
{
    TYActionSheet *actionSheet = [[TYActionSheet alloc] initActionSheetWithTitle:@"标题"];
    //创建acton
    TYAction *action1 = [[TYAction alloc] initWithActionTitle:@"内容1" Image:nil];
    TYAction *action2 = [[TYAction alloc] initWithActionTitle:@"内容2" Image:@"test"];
    TYAction *action3 = [[TYAction alloc] initWithActionTitle:@"内容3" Image:@"test"];
    
    //添加action 并提供回调
    [actionSheet addAction:action1 handle:^(TYAction *acton,NSString *title) {
        NSLog(@"%@",title);
    }];
    [actionSheet addAction:action2 handle:^(TYAction *acton, NSString *title) {
        
        NSLog(@"%@",title);
    }];
    [actionSheet addAction:action3 handle:^(TYAction *acton, NSString *title) {
        
        NSLog(@"%@",title);
    }];
    //显示actionSheet
    [actionSheet show];
}
```
