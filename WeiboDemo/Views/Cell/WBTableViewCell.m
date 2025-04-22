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
#import "Masonry/Masonry.h"

@implementation WBTableViewCell

// 垂直方向上组件间的spacing
static const CGFloat kVerticalspacing = 6.0;

// cell内子视图左右的margin
static const CGFloat kHorizontalMargin = 8.0;

// override：自定义cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(WBCellModel *)model {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        _model = model;
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    _usrInfoView = [[WBUsrInfoView alloc] init];
    _textLbl = [[UILabel alloc] init];
    _mediaView = [[UIView alloc] init];
    _countLbl = [[UILabel alloc] init];
    _line = [[UIView alloc] init];
    _interacButtonsView = [[WBInteractButtonsView alloc] init];
    _seperator = [[UIView alloc] init];
    
    [self initStyle];
//    [self loadModel];
    
    [self.contentView addSubview:_usrInfoView];
    [self.contentView addSubview:_textLbl];
    [self.contentView addSubview:_mediaView];
    [self.contentView addSubview:_countLbl];
    [self.contentView addSubview:_line];
    [self.contentView addSubview:_interacButtonsView];
    [self.contentView addSubview:_seperator];
    
    [self setupLayout];
}

- (void)initStyle {
    // 取消cell选中时默认背景色
    UIView *selectedView = [[UIView alloc] init];
    [selectedView setBackgroundColor:[UIColor clearColor]];
    self.selectedBackgroundView = selectedView;

    // 设置边框 for debug
    void(^setBorder)(UIView *, UIColor *) = ^(UIView *view, UIColor *color){
        view.layer.borderColor = color.CGColor;
        view.layer.borderWidth = 4.0;
    };
//    setBorder(self.usrInfoView, [UIColor redColor]);
//    setBorder(self.textLbl, [UIColor blueColor]);
//    setBorder(self.mediaView, [UIColor greenColor]);
//    setBorder(self.countLbl, [UIColor lightGrayColor]);
//    setBorder(self.interacButtonsView, [UIColor yellowColor]);
    
    // 子控件
    // 发文
    self.textLbl.font = [UIFont systemFontOfSize:14];
    self.textLbl.numberOfLines = 0; // 允许多行显示
    
    // 统计浏览人数
    self.countLbl.font = [UIFont systemFontOfSize:14];
    long cnt = 338;
    [self.countLbl setText:[NSString stringWithFormat:@"%@人🤩😎🤓", [self formattedCount:cnt]]];
    self.countLbl.textAlignment = NSTextAlignmentRight;
    
    // 灰色分割线
    [self.line setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    
    // cell与cell之间灰色区域
    self.seperator.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
}

// TODO: 封装成工具类单例
- (NSString *)formattedCount:(long) num {
    if (num <= 9999) {
        return [NSString stringWithFormat:@"%ld", num];
    } else if (num <= 999 * 10000) {
        return [NSString stringWithFormat:@"%.lf万", num / 10000.0];
    } else {
        return [NSString stringWithFormat:@"9999+万"];
    }
}

- (void)setupLayout {
    // usrInfoView
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
//    
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

// 复用cell时重新加载数据即可
- (void)setModel:(WBCellModel *)model {
    _model = model;
    [self loadModel];

}

// 加载数据，并处理动态布局
- (void)loadModel{
    if (self.model) {
        // 头像
        [self.usrInfoView setAvatarWithImageName:self.model.avatar];
        
        // 昵称
        [self.usrInfoView setNameWithName:self.model.name];
        
        // vip显示
        if (self.model.vip) {
            [self.usrInfoView disPlayVip];
        } else {
            [self.usrInfoView hideVip];
        }
        
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
}

- (void)setMediaViewFrame {
    // TODO: 改成按原比例显示图片
    const CGFloat kcellWidth = [UIScreen mainScreen].bounds.size.width; //cell的宽度
    static CGFloat spacing = 8.0;
    
    // 先清空子控件
    [self.mediaView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 重新计算布局并添加子控件
    NSArray<NSString *> *picsArray = [NSArray arrayWithArray:self.model.pic];
    if (picsArray.count) {
        const NSInteger picsNum = MIN(9, picsArray.count); // 最多显示9张
        UIImage *image = [UIImage imageNamed:picsArray[0]];
        // 以第一张图片的比例为所有图片显示的宽高比
        const CGFloat heightWidhRatio = image.size.height / image.size.width;
        
        // 根据行数、列数排布mediaView内的照片，以及约束mediaView的高度
        void(^arrangePicsandLayout)(int, int) = ^(int columns, int rows) {
            CGFloat imageWidth = (kcellWidth - spacing * (columns - 1) - kHorizontalMargin * 2) / columns;
            CGFloat imageHeight = imageWidth * heightWidhRatio;
            CGFloat mediaViewH = imageHeight * rows + spacing * (rows - 1);
            for (int i = 0; i < picsNum; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:picsArray[i]]];
                
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
            // 单张图
            CGFloat imageWidth = 250.0;
            CGFloat imageHeight = imageWidth * heightWidhRatio;
            CGFloat imageX = 0;
            CGFloat imageY = 0;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:picsArray[0]]];
            imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
            [self.mediaView addSubview:imageView];
            
            // 重用cell的时候，已有的约束应该更新，否则产生多个等号右边不一的方程必定冲突
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
