//
//  ZSTableViewController.m
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import "WBTableViewController.h"
#import "WBCellModel.h"
#import "WBTableViewCell.h"

@interface WBTableViewController ()


@property(nonatomic, strong) NSMutableArray *wbModels;

@end

@implementation WBTableViewController

// cell类型标识
static NSDictionary<NSNumber *, NSString *> *cellPicNumToTypeDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 确保使用自动布局
    self.tableView.estimatedRowHeight = 200;
    // 隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    cellPicNumToTypeDict = @{
        @0:@"WBTableCell_NoPic",
        @1:@"WBTableCell_1Pics",
        @2:@"WBTableCell_2Pics",
        @3:@"WBTableCell_3Pics",
        @4:@"WBTableCell_4Pics",
        @5:@"WBTableCell_5Pics",
        @6:@"WBTableCell_6Pics",
        @7:@"WBTableCell_7Pics",
        @8:@"WBTableCell_8Pics",
        @9:@"WBTableCell_8Pics",
    };
}

#pragma mark - 懒加载models
- (NSArray *)wbModels {
    if (_wbModels == nil) {
        _wbModels = [NSMutableArray array];
        // 1.加载plist数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        // 2.将数据封装成model
        for (NSDictionary *dict in arrayDict) {
            WBCellModel *model = [WBCellModel modelWithDict:dict];
            [_wbModels addObject:model];
        }
    }
    return _wbModels;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wbModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 获取模型数据
    WBCellModel *model = _wbModels[indexPath.row];
    
    // 2. 创建cell
    NSNumber *picsNum = [[NSNumber alloc] initWithLong:model.pic.count];
    NSString *cellId = cellPicNumToTypeDict[picsNum];
    WBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = model;
    return cell;
}

// TODO: 了解一下自动调整高度的底层
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


@end
