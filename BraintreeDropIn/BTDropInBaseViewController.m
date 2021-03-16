#import "BTDropInBaseViewController.h"
#import "BTAPIClient_Internal_Category.h"

#if __has_include("BraintreeUIKit.h")
#import "BraintreeUIKit.h"
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

@interface BTDropInBaseViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *activityIndicatorWrapperView;
@property (nonatomic, strong) UILabel *titleView;
@end

@implementation BTDropInBaseViewController

- (instancetype)initWithAPIClient:(BTAPIClient *)apiClient request:(BTDropInRequest *)request
{
    if (self = [super init]) {
        self.apiClient = apiClient;
        _dropInRequest = request;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activityIndicatorWrapperView = [[UIView alloc] init];
    self.activityIndicatorWrapperView.backgroundColor = [UIColor clearColor];
    self.activityIndicatorWrapperView.hidden = YES;
    [self.view addSubview:self.activityIndicatorWrapperView];
    self.activityIndicatorWrapperView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[activityWrapper]|" options:0 metrics:nil views:@{@"activityWrapper": self.activityIndicatorWrapperView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[activityWrapper]|" options:0 metrics:nil views:@{@"activityWrapper": self.activityIndicatorWrapperView}]];

    self.activityIndicatorView = [UIActivityIndicatorView new];
    self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicatorView.activityIndicatorViewStyle = [BTUIKAppearance sharedInstance].activityIndicatorViewStyle;
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorWrapperView addSubview:self.activityIndicatorView];
    [self.activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.activityIndicatorWrapperView.centerXAnchor].active = YES;
    [self.activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.activityIndicatorWrapperView.centerYAnchor].active = YES;

    self.titleView = [BTUIKAppearance styledNavigationTitleLabel];
    self.titleView.text = self.title;
    self.navigationItem.titleView = self.titleView;
}

- (void)loadConfiguration {
    [self.apiClient fetchOrReturnRemoteConfiguration:^(BTConfiguration *configuration, __unused NSError *error) {
        self.configuration = configuration;
        [self configurationLoaded:configuration error:error];
    }];
}

- (void)showLoadingScreen:(BOOL)show {
    if (show) {
        [self.view bringSubviewToFront:self.activityIndicatorWrapperView];
    }
    self.activityIndicatorWrapperView.hidden = !show;
}

- (void)configurationLoaded:(__unused BTConfiguration *)configuration error:(__unused NSError *)error {
    //Subclasses should override this method
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    if (self.titleView) {
        self.titleView.text = self.title;
    }
}

#pragma mark - UI Preferences

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

@end
