//
//  ZSTableViewController.m
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import "WBViewController.h"
#import "WBCellModel.h"
#import "WBTableViewCell.h"
#import "Masonry/Masonry.h"

@interface WBViewController ()

@property (nonatomic, strong) NSMutableArray *wbModels;
@property (nonatomic, strong) UITableView *tableView;
//@property(nonatomic, strong) NSDictionary<NSNumber *, NSString *> *cellPicNumToTypeDict;

@end

@implementation WBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[WBTableViewCell class] forCellReuseIdentifier:@"cell_id"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // TODO: 测一下帧率
//    self.cellPicNumToTypeDict = [[NSDictionary alloc] init];
//    self.cellPicNumToTypeDict = @{
//        @0:@"WBTableCell_NoPic",
//        @1:@"WBTableCell_1Pics",
//        @2:@"WBTableCell_2Pics",
//        @3:@"WBTableCell_3Pics",
//        @4:@"WBTableCell_4Pics",
//        @5:@"WBTableCell_5Pics",
//        @6:@"WBTableCell_6Pics",
//        @7:@"WBTableCell_7Pics",
//        @8:@"WBTableCell_8Pics",
//        @9:@"WBTableCell_9Pics",
//    };
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
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
    // 获取模型数据
    WBCellModel *model = _wbModels[indexPath.row];
    
    WBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
