//
//  ViewController.m
//  AnimationTest
//
//  Created by Eva on 16/12/1.
//  Copyright © 2016年 Eva. All rights reserved.
//

//  此demo是关于分组展开的折叠效果

#import "ViewController.h"
#import "UIImageAnimation.h"
#define Width  [UIScreen mainScreen].bounds.size.width
#define Height  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSMutableArray *showArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self  setTable];
    //cx
    
    
    
    //ljj
}

- (void)setTable {
    //ljj
    _array = [NSArray array];
    _array =  @[@1,@2,@3,@4,@5];
    _showArray =[[NSMutableArray alloc] initWithArray:@[@0,@0,@0,@0,@0]];
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Width,Height ) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
    footer.backgroundColor = [UIColor whiteColor];
    _table.tableFooterView  = footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_showArray[indexPath.section] boolValue] == YES) {
        return 44;
    }if ([_showArray[indexPath.section] boolValue] == NO ) {
        if (indexPath.row < 2) {
            return 44;
        }else {
            return 0;
        }
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([_showArray[section] boolValue] == YES) {
        return _array.count;
//    }else {
//        return 2;
//    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
    view.backgroundColor = [UIColor cyanColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
//    [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.backgroundColor = [UIColor orangeColor];
    [button setImage:[UIImage imageNamed:@"down"] forState:0];
    [button addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 100 + section;
    [view addSubview:button];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组，第%ld个",indexPath.section,indexPath.row];
    
    return cell;
}
- (void)clickImage:(UIButton *)btn {
    BOOL show = [_showArray[btn.tag - 100] boolValue];
        // (重要)⭐️⭐️⭐️ 动画旋转是仅以最小角度旋转至指定位置就停了,没有顺时针或者逆时针的设置
    CABasicAnimation *animation = [UIImageAnimation rotation:0.3 degree:!show?(179.0 *M_PI/180.0):1.0*M_PI/180  direction: 1 repeatCount:1];
    [btn.layer addAnimation:animation forKey:nil];
    
    
    NSNumber *repalceNum = [NSNumber numberWithBool:!show];
    [_showArray replaceObjectAtIndex:btn.tag - 100 withObject:repalceNum];

//    //一个section刷新
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:btn.tag - 100];
//    [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:btn.tag - 100];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:3 inSection:btn.tag - 100];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:4 inSection:btn.tag - 100];
//indexPath2,indexPath3,
    [_table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2,indexPath3,nil]  withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
