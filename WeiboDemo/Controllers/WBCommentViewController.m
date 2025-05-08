//
//  WBCommentViewController.m
//  WeiboDemo
//
//  Created by joson on 2025/5/5.
//

#import "WBCommentViewController.h"

@interface WBCommentViewController ()

@end

@implementation WBCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评论";
    
    // 返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"<"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(backAction)];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
