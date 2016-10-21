//
//  SVProgressGifHUD.m
//  Auction
//
//  Created by 卢迎志 on 14-12-10.
//
//

#import "SVProgressGifHUD.h"
#import "UIImage+DLExtension.h"

#define Size            150
#define FadeDuration    0.3
#define GifSpeed        0.3

#pragma mark - GiFHUD Private

@interface SVProgressGifHUD ()

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL shown;
@property (nonatomic, strong) UIWindow* overlayWindow;

@end

@implementation SVProgressGifHUD

DEF_SINGLETON(SVProgressGifHUD);

@synthesize overlayWindow;

- (instancetype)init {
    
    if ((self = [super initWithFrame:CGRectMake(0, 0, Size, Size)])) {
        
        [self setAlpha:0];
        [self setCenter:self.overlayWindow.center];
        [self setClipsToBounds:NO];
        
        [self.layer setBackgroundColor:[[UIColor colorWithWhite:0 alpha:0.5] CGColor]];
        [self.layer setCornerRadius:10];
        [self.layer setMasksToBounds:YES];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 20, 20)];
        [self addSubview:self.imageView];
        
        [self.overlayWindow addSubview:self];
    }
    return self;
}

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        //        overlayWindow = APPDELEGATE.window;
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
    }
    return overlayWindow;
}

#pragma mark HUD

+ (void)showWithOverlay {
    [self dismiss:^{
        [[SVProgressGifHUD sharedInstance].overlayWindow addSubview:[[self sharedInstance] overlay]];
        [self show];
    }];
}

+ (void)show {
    [self dismiss:^{
        [[SVProgressGifHUD sharedInstance].overlayWindow bringSubviewToFront:[self sharedInstance]];
        [[self sharedInstance] setShown:YES];
        [[self sharedInstance] fadeIn];
    }];
}


+ (void)dismiss {
    if (![[self sharedInstance] shown])
        return;
    
    [[[self sharedInstance] overlay] removeFromSuperview];
    [[self sharedInstance] fadeOut];
}

+ (void)dismiss:(void(^)(void))complated {
    if (![[self sharedInstance] shown])
        return complated ();
    
    [[self sharedInstance] fadeOutComplate:^{
        [[[self sharedInstance] overlay] removeFromSuperview];
        complated ();
    }];
}

#pragma mark Effects

- (void)fadeIn {
    [self.imageView startAnimating];
    [UIView animateWithDuration:FadeDuration animations:^{
        [self setAlpha:1];
    }];
}

- (void)fadeOut {
    [UIView animateWithDuration:FadeDuration animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setShown:NO];
        [self.imageView stopAnimating];
    }];
}

- (void)fadeOutComplate:(void(^)(void))complated {
    [UIView animateWithDuration:FadeDuration animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setShown:NO];
        [self.imageView stopAnimating];
        complated ();
    }];
}

- (UIView *)overlay {
    
    if (!self.overlayView) {
        self.overlayView = [[UIView alloc] initWithFrame:self.overlayWindow.frame];
        [self.overlayView setBackgroundColor:[UIColor blackColor]];
        [self.overlayView setAlpha:0];
        
        [UIView animateWithDuration:FadeDuration animations:^{
            [self.overlayView setAlpha:0.3];
        }];
    }
    return self.overlayView;
}

#pragma mark Gif

+ (void)setGifWithImages:(NSArray *)images {
    [[[self sharedInstance] imageView] setAnimationImages:images];
    [[[self sharedInstance] imageView] setAnimationDuration:GifSpeed];
}

+ (void)setGifWithImageName:(NSString *)imageName {
    [[[self sharedInstance] imageView] stopAnimating];
    [[[self sharedInstance] imageView] setImage:[UIImage animatedImageWithAnimatedGIFName:imageName]];
}

+ (void)setGifWithURL:(NSURL *)gifUrl {
    [[[self sharedInstance] imageView] stopAnimating];
    [[[self sharedInstance] imageView] setImage:[UIImage animatedImageWithAnimatedGIFURL:gifUrl]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
