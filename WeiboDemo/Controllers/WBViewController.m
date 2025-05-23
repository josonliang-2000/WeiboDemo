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
    [self.view addSubview:self.tableView];
    self.tableView.separatorInset = UIEdgeInsetsZero; // 取消默认缩进20px
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 设置RunLoop观察者
//    [self setupRunLoopObserver];
}

- (void)setupRunLoopObserver {
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(
        kCFAllocatorDefault,
        kCFRunLoopAllActivities, // 观察所有活动
        YES, // 是否重复观察
        0, // 优先级
        ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            switch (activity) {
                case kCFRunLoopEntry:
                    NSLog(@"👉 RunLoop 进入");
                    break;
                case kCFRunLoopBeforeTimers:
                    NSLog(@"⏱️ RunLoop 即将处理 Timer");
                    break;
                case kCFRunLoopBeforeSources:
                    NSLog(@"🔌 RunLoop 即将处理 Source");
                    break;
                case kCFRunLoopBeforeWaiting:
                    NSLog(@"😴 RunLoop 即将进入休眠");
                    break;
                case kCFRunLoopAfterWaiting:
                    NSLog(@"☀️ RunLoop 被唤醒");
                    break;
                case kCFRunLoopExit:
                    NSLog(@"👋 RunLoop 退出");
                    break;
                default:
                    break;
            }
        });
    
    // 将观察者添加到主线程的 RunLoop
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
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
