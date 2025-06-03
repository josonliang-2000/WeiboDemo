//
//  WBPlayerView.m
//  WeiboDemo
//
//  Created by joson on 2025/5/23.
//

#import "WBPlayerView.h"
#import "AVFoundation/AVFoundation.h"
#import "AFNetworking/AFNetworking.h"

@interface WBPlayerView()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
 
@end

@implementation WBPlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andUrl:(NSURL *)url{
    if ([super initWithFrame:frame]) {
        [self setupPlayer];
        [self setupUI];
        self.videoUrl = url;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playItemDidReachEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

#pragma mark - override

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        switch(status) {
            case AVPlayerItemStatusReadyToPlay: {
                NSLog(@"▶️开始播放");
                NSLog(@"%@", [self.videoUrl absoluteString]);
                
                
                // 打印视频时长和缓冲进度
                AVPlayerItem *playerItem = (AVPlayerItem *)object;
                CMTime duration = playerItem.duration;
                if (CMTIME_IS_NUMERIC(duration)) {
                    NSLog(@"视频总时长: %.2f秒", CMTimeGetSeconds(duration));
                }
                
                // 该函数在触发KVO的线程中被调用，需要保证在主线程中嗲用play
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.player play];
                });
                break;
            }
            case AVPlayerItemStatusUnknown: {
                NSLog(@"❓未知url");
                break;
            }
            case AVPlayerItemStatusFailed: {
                NSLog(@"❗️url解析失败");
                break;
            }
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
         NSArray *loadedRanges = playerItem.loadedTimeRanges;
         
         if (loadedRanges.count > 0) {
             CMTimeRange timeRange = [loadedRanges.firstObject CMTimeRangeValue];
             NSTimeInterval start = CMTimeGetSeconds(timeRange.start);   // 缓冲起始时间
             NSTimeInterval duration = CMTimeGetSeconds(timeRange.duration); // 缓冲时长
             NSTimeInterval totalBuffered = start + duration;            // 总缓冲进度
             
             NSLog(@"📊 缓冲范围: %.2f秒 ~ %.2f秒 | 已缓冲: %.2f秒", start, start + duration, totalBuffered);
         } else {
             NSLog(@"⚠️ 无缓冲数据");
         }
    }
}

#pragma mark - private

- (void)setupPlayer {
    _player = [[AVPlayer alloc] init];
}

- (void)setupUI {
    self.backgroundColor = [UIColor blackColor];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = self.bounds;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerLayer.borderColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_playerLayer];
}

- (void)playItemDidReachEnd {
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

# pragma mark - set
- (void)setVideoUrl:(NSURL *)videoUrl {
    if (_videoUrl != videoUrl) {
        // 移除旧的监听
        if (self.player.currentItem) {
            [self.player.currentItem removeObserver:self forKeyPath:@"status"];
        }
        
        _videoUrl = videoUrl;
        
        // 创建新的播放item
        AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:_videoUrl];
        [self.player replaceCurrentItemWithPlayerItem:playItem];
        
        [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        
    }
}



@end
