//
//  WBTableViewCell.m
//  WeiboDemo
//
//  Created by joson on 2025/4/18.
//

#import "WBTableViewCell.h"
#import "WBCellModel.h"
#import "WBUsrInfoView.h"
#import "WBInteractButtonsView.h"
#import "WBImageView.h"
#import "Masonry/Masonry.h"
#import "WBImageUtils.h"
#import "SDWebImage/SDWebImage.h"

@interface WBTableViewCell()
// 子控件
@property(nonatomic, strong) WBUsrInfoView *usrInfoView;
@property(nonatomic, strong) UILabel *textLbl;
@property(nonatomic, strong) UIView *mediaView;
@property(nonatomic, strong) UILabel *countLbl;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) WBInteractButtonsView *interacButtonsView;
@property(nonatomic, strong) UIView *seperator;


- (void) setupUI;
- (void)initStyle;
- (NSString *)formattedCount:(NSInteger) num;
- (void)setupLayout;
- (void)loadModel;
- (void)setMediaViewFrame;

// for WBImageViewProtocol
- (void)didTapImageView:(WBImageView *)imageView;
@end

@implementation WBTableViewCell

#pragma mark - public methods

// override：自定义cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

// 复用cell时重新加载数据即可
- (void)setModel:(WBCellModel *)model {
    _model = model;
    [self loadModel];

}

#pragma mark - private methods

- (void) setupUI {
    [self initStyle];

    [self.contentView addSubview:self.usrInfoView];
    [self.contentView addSubview:self.textLbl];
    [self.contentView addSubview:self.mediaView];
    [self.contentView addSubview:self.countLbl];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.interacButtonsView];
    [self.contentView addSubview:self.seperator];
    
    [self setupLayout];
}

- (WBUsrInfoView *)usrInfoView {
    if (_usrInfoView == nil) {
        _usrInfoView = [[WBUsrInfoView alloc] init];
        _usrInfoView.avatarView.delegate = self;
    }
    return _usrInfoView;
}

- (UILabel *)textLbl {
    if (_textLbl == nil) {
        _textLbl = [[UILabel alloc] init];
        _textLbl.font = [UIFont systemFontOfSize:14];
        _textLbl.numberOfLines = 0; // 允许多行显示
    }
    return _textLbl;
}

- (UIView *)mediaView {
    if (_mediaView == nil) {
        _mediaView = [[UIView alloc] init];
    }
    return _mediaView;
}

- (UILabel *)countLbl {
    if (_countLbl == nil) {
        _countLbl = [[UILabel alloc] init];
        _countLbl.font = [UIFont systemFontOfSize:14];
        const NSInteger cnt = 338;
        [_countLbl setText:[NSString stringWithFormat:@"%@人🤩😎🤓", [self formattedCount:cnt]]];
        _countLbl.textAlignment = NSTextAlignmentRight;
    }
    return _countLbl;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
    }
    return _line;
}


- (WBInteractButtonsView *)interacButtonsView {
    if (_interacButtonsView == nil) {
        _interacButtonsView = [[WBInteractButtonsView alloc] init];
    }
    return _interacButtonsView;
}

- (UIView *)seperator {
    if (_seperator == nil) {
        _seperator = [[UIView alloc] init];
        _seperator.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }
    return _seperator;
}

- (void)initStyle {
    // 取消cell选中时默认背景色
    // TODO: tbaleView有个属性可以设置
    UIView *selectedView = [[UIView alloc] init];
    [selectedView setBackgroundColor:[UIColor clearColor]];
    self.selectedBackgroundView = selectedView;
}

// TODO: 封装成工具类单例
- (NSString *)formattedCount:(NSInteger) num {
    if (num <= 9999) {
        return [NSString stringWithFormat:@"%ld", num];
    } else if (num <= 999 * 10000) {
        return [NSString stringWithFormat:@"%.lf万", num / 10000.0];
    } else {
        return [NSString stringWithFormat:@"999+万"];
    }
}

- (void)setupLayout {
    // 垂直方向上组件间的spacing
    const CGFloat kVerticalspacing = 6.0;
    // cell内子视图左右的margin
    const CGFloat kHorizontalMargin = 8.0;
    
    // usrInfoView
    // TODO: 最外层改成StackView
    [self.usrInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(kHorizontalMargin);
        make.right.mas_equalTo(-kHorizontalMargin);
        make.height.mas_equalTo(60.0);
    }];
    
    // textLbl
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usrInfoView.mas_bottom).offset(kVerticalspacing);
        make.left.mas_equalTo(kHorizontalMargin);
        make.right.mas_equalTo(-kHorizontalMargin);
    }];
    
    // meadiaView
    [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textLbl.mas_bottom).offset(kVerticalspacing);
        make.left.mas_equalTo(self.contentView).offset(kHorizontalMargin);
        make.right.mas_equalTo(self.contentView).offset(-kHorizontalMargin);
    }];
    
    // countLbl
    [self.countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mediaView.mas_bottom).offset(kVerticalspacing);
        make.left.mas_equalTo(kHorizontalMargin);
        make.right.mas_equalTo(-kHorizontalMargin);
        make.height.mas_equalTo(30);
    }];
    
    // line
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.countLbl.mas_bottom).offset(kVerticalspacing);
            make.left.mas_equalTo(kHorizontalMargin);
            make.right.mas_equalTo(-kHorizontalMargin);
            make.height.mas_equalTo(1);
    }];
    
    // interactButtonsView
    [self.interacButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(kVerticalspacing);
        make.left.mas_equalTo(kHorizontalMargin);
        make.right.mas_equalTo(-kHorizontalMargin);
    }];
    
    // 分割线
    [self.seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.interacButtonsView.mas_bottom).offset(kVerticalspacing);
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom); // 关键
        make.height.mas_equalTo(8.0);
    }];
}


// 加载数据，并处理动态布局
- (void)loadModel{
    // 头像
    //TODO: SDWebImage加载的图片会去掉圆角
    [self.usrInfoView.avatarView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    // 昵称
    self.usrInfoView.nameLbl.text = self.model.name;
    
    // vip显示
    self.usrInfoView.vipView.hidden = !self.model.vip;

    
    // 发文
    if (self.model.text) {
        self.textLabel.hidden = NO;
        self.textLbl.text = self.model.text;
    } else {
        self.textLabel.hidden = YES;
    }
    
    // 配图
    [self setMediaViewFrame];
}

- (void)setMediaViewFrame {
    // TODO: 封装成一个view
    const CGFloat spacing = 4;
    const CGFloat kHorizontalMargin = 8;
    // 先清空子控件
    [self.mediaView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 重新计算布局并添加子控件
    NSArray<NSString *> *picsArray = [NSArray arrayWithArray:self.model.pic];
    if (picsArray.count) {
        const NSInteger picsNum = MIN(9, picsArray.count); // 最多显示9张
        const CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
        
        // 根据行数、列数排布mediaView内的照片，以及约束mediaView的高度
        void(^arrangePicsandLayout)(int, int) = ^(int columns, int rows) {
            CGFloat imageWidth = (cellWidth - spacing * (columns - 1) - kHorizontalMargin * 2) / columns;
            CGFloat imageHeight = imageWidth;
            CGFloat mediaViewH = imageHeight * rows + spacing * (rows - 1);
            for (int i = 0; i < picsNum; i++) {
                // TODO: 封装imageView创建
                WBImageView *imageView = [[WBImageView alloc] initWithIndex:i];
                [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.pic[i]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
                imageView.delegate = self;
                // 监听来自imageView的点击事件
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleImageTap:) name:@"imageTapNotification" object:nil];
                
                imageView.frame = CGRectMake((spacing + imageWidth) * (i % columns),
                                             (spacing + imageHeight) * (i / columns),
                                             imageWidth,
                                             imageHeight
                                             );
                [self.mediaView addSubview:imageView];
            }
            
            // 重用cell的时候，已有的约束应该更新，否则产生多个等号右边不一的方程必定冲突
            [self.mediaView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(mediaViewH);
            }];
        };
        
        if (picsNum >= 4) {
            // 九宫格
            int columns = 3; // 每行3个
            int rows = ceil(1.0 * picsNum / columns); // 很奇怪，不能跟普通类型混用
            arrangePicsandLayout(columns, rows);
        } else if (picsNum >= 2){
            // 四宫格
            int columns = 2; // 每行2个
            int rows = ceil(1.0 * picsNum / columns);
            arrangePicsandLayout(columns, rows);
        } else {
            // 单张图按比例
            const CGFloat imageWidth = 250.0;
            const CGFloat imageHeight = imageWidth;
            const CGFloat imageX = 0;
            const CGFloat imageY = 0;
            
            WBImageView *imageView = [[WBImageView alloc] initWithIndex: 0];
            imageView.delegate = self;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.pic[0]] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
            UIImage *image = imageView.image;
            // TODO: 能否将下载的图片按照比例绘制到imageView里
//            const CGFloat heightWidthRatio = image.size.height / image.size.width;
//            const CGFloat imageHeight = imageWidth * heightWidthRatio;
            imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
            [self.mediaView addSubview:imageView];
            
            
            // 重用cell的时候，已有的约束应该更新，否则产生多个等号左边相同，等号右边不一的方程，必定冲突
            [self.mediaView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(imageHeight);
            }];
        }
    } else {
        // 没照片的话直接高度设置为0
        [self.mediaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
 
}

- (void)didTapImageView:(WBImageView *)imageView {
    [WBImageUtils zoomInImageOfImageView:imageView];
}

//- (void)handleImageTap:(NSNotification *)notification {
//    NSLog(@"%@----message from imageView:%@", self, notification.userInfo);
//}

//- (void)dealloc {
//    // 注销在notification中的监听
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end
