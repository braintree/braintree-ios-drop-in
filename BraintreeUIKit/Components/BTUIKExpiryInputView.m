#import "BTUIKExpiryInputView.h"
#import "BTUIKExpiryInputCollectionViewCell.h"
#import "BTUIKCollectionReusableView.h"
#import "BTUIKAppearance.h"
#import "BTUIKLocalizedString.h"

#define BT_EXPIRY_FULL_PADDING 10
#define BT_EXPIRY_SECTION_HEADER_HEIGHT 12

@interface BTUIKExpiryInputView ()

@property (nonatomic, strong) NSArray* months;
@property (nonatomic, strong) NSArray* years;
@property (nonatomic, strong) UICollectionView* monthCollectionView;
@property (nonatomic, strong) UICollectionView* yearCollectionView;
@property (nonatomic, strong) UIView* verticalLine;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSInteger currentMonth;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic) BOOL needsOrientationChange;
@end

@implementation BTUIKExpiryInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.needsOrientationChange = NO;
        self.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
        self.months = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
        
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:currentDate];
        
        self.currentYear = [components year];
        self.currentMonth = [components month];
        NSMutableArray* mutableYears = [@[] mutableCopy];
        
        NSInteger yearCounter = self.currentYear;
        while (yearCounter < self.currentYear + 20) {
            [mutableYears addObject:[NSString stringWithFormat:@"%li", (long)yearCounter]];
            yearCounter++;
        }
        
        self.years = [NSArray arrayWithArray:mutableYears];
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        self.monthCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.monthCollectionView registerClass:[BTUIKExpiryInputCollectionViewCell class] forCellWithReuseIdentifier:@"BTMonthCell"];
        [self.monthCollectionView registerClass:[BTUIKCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        self.monthCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.monthCollectionView.delegate = self;
        self.monthCollectionView.dataSource = self;
        self.monthCollectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.monthCollectionView];
        
        layout=[[UICollectionViewFlowLayout alloc] init];
        self.yearCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.yearCollectionView registerClass:[BTUIKExpiryInputCollectionViewCell class] forCellWithReuseIdentifier:@"BTYearCell"];
        [self.yearCollectionView registerClass:[BTUIKCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        self.yearCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.yearCollectionView.delegate = self;
        self.yearCollectionView.dataSource = self;
        self.yearCollectionView.backgroundColor = [UIColor clearColor];
        self.yearCollectionView.showsVerticalScrollIndicator = YES;
        [self addSubview:self.yearCollectionView];
        
        self.verticalLine = [[UIView alloc] init];
        self.verticalLine.translatesAutoresizingMaskIntoConstraints = NO;
        self.verticalLine.backgroundColor = [BTUIKAppearance sharedInstance].lineColor;
        [self addSubview:self.verticalLine];
        
        [self.yearCollectionView reloadData];

        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.pageControl];
        self.pageControl.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.pageControl.numberOfPages = 6;
        self.pageControl.currentPage = 1;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = self.tintColor;
        self.pageControl.hidden = true;
        
        NSDictionary* viewBindings = @{@"view":self, @"monthCollectionView":self.monthCollectionView, @"yearCollectionView": self.yearCollectionView, @"verticalLine":self.verticalLine, @"pageControl": self.pageControl};
        
        NSDictionary* metrics = @{@"BT_EXPIRY_FULL_PADDING":@BT_EXPIRY_FULL_PADDING, @"BT_EXPIRY_FULL_PADDING_HALF": @(BT_EXPIRY_FULL_PADDING/2.0)};
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(BT_EXPIRY_FULL_PADDING_HALF)-[monthCollectionView][verticalLine(0.5)][yearCollectionView]-(BT_EXPIRY_FULL_PADDING_HALF)-|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:viewBindings]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(BT_EXPIRY_FULL_PADDING)-[monthCollectionView]"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:viewBindings]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(BT_EXPIRY_FULL_PADDING)-[yearCollectionView]"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:viewBindings]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[verticalLine]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewBindings]];
        
        id bottomReferenceView = self;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        if (@available(iOS 11.0, *)) {
            bottomReferenceView = self.safeAreaLayoutGuide;
        }
#endif
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.monthCollectionView attribute:NSLayoutAttributeBottom relatedBy:0 toItem:bottomReferenceView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.yearCollectionView attribute:NSLayoutAttributeBottom relatedBy:0 toItem:bottomReferenceView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.verticalLine attribute:NSLayoutAttributeBottom relatedBy:0 toItem:bottomReferenceView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

        CGSize sizeOfPageControl = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeRight relatedBy:0 toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:sizeOfPageControl.width/2 - sizeOfPageControl.height/2 + 10]];
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.yearCollectionView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:self attribute:NSLayoutAttributeWidth multiplier:0.33 constant:0]];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChange)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

#pragma mark - Accessors

- (void)setSelectedYear:(NSInteger)selectedYear {
    NSString *stringToSearch = [NSString stringWithFormat:@"%li", (long)selectedYear];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",stringToSearch];
    NSString *results = [[self.years filteredArrayUsingPredicate:predicate] firstObject];
    NSInteger yearIndex = [self.years indexOfObject:results];
    if (([self isValidYear:selectedYear forMonth:self.selectedMonth] && yearIndex != NSNotFound) || selectedYear == 0) {
        _selectedYear = selectedYear;
        if (selectedYear > 0) {
            [self.yearCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:
                                                                               yearIndex inSection:0] animated:NO scrollPosition:0];
        } else {
            NSIndexPath *selectedIndexPath = [[self.yearCollectionView indexPathsForSelectedItems] firstObject];
            [self.yearCollectionView deselectItemAtIndexPath:selectedIndexPath animated:NO];
        }
        [self updateVisibleCells];
    }
}

- (void)setSelectedMonth:(NSInteger)selectedMonth {
    if ([self isValidMonth:selectedMonth forYear:self.selectedYear] || selectedMonth == 0) {
        _selectedMonth = selectedMonth;
        if (selectedMonth > 0) {
            [self.monthCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:selectedMonth - 1 inSection:0] animated:NO scrollPosition:0];
        } else {
            NSIndexPath *selectedIndexPath = [[self.monthCollectionView indexPathsForSelectedItems] firstObject];
            [self.monthCollectionView deselectItemAtIndexPath:selectedIndexPath animated:NO];
        }
        [self updateVisibleCells];
    }
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(__unused NSInteger)section {
    if (collectionView == self.monthCollectionView) {
        return [self.months count];
    }
    return [self.years count];
}

- (NSInteger)numberOfSectionsInCollectionView: (__unused UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.monthCollectionView) {
        BTUIKExpiryInputCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTMonthCell" forIndexPath:indexPath];
        
        cell.userInteractionEnabled = true;
        
        NSString* date = self.months[indexPath.row];
        cell.label.text = date;
        cell.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
        
        cell.label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
        
        if (self.selectedYear && self.selectedYear == self.currentYear) {
            if ([cell getInteger] < self.currentMonth) {
                cell.userInteractionEnabled = false;
                cell.label.textColor = [BTUIKAppearance sharedInstance].disabledColor;
            }
        }
        return cell;
    }
    BTUIKExpiryInputCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTYearCell" forIndexPath:indexPath];
    NSString* date = self.years[indexPath.row];
    cell.userInteractionEnabled = true;
    cell.label.text = date;
    cell.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
    
    cell.label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
    
    if (self.selectedMonth && self.selectedMonth < self.currentMonth && [cell getInteger] == self.currentYear) {
        cell.userInteractionEnabled = false;
        cell.label.textColor = [BTUIKAppearance sharedInstance].disabledColor;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:
(__unused UICollectionView *)collectionView viewForSupplementaryElementOfKind:(__unused NSString *)kind atIndexPath:(__unused NSIndexPath *)indexPath
{
    BTUIKCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    view.label.text = collectionView == self.yearCollectionView ? BTUIKLocalizedString(YEAR_LABEL) : BTUIKLocalizedString(MONTH_LABEL);
    return view;
}

- (CGSize)collectionView:(__unused UICollectionView *)collectionView layout:(__unused UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(__unused NSInteger)section {
    return CGSizeMake(100, BT_EXPIRY_SECTION_HEADER_HEIGHT);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(__unused UICollectionView *)collectionView didSelectItemAtIndexPath:(__unused NSIndexPath *)indexPath
{
    BTUIKExpiryInputCollectionViewCell *cell = (BTUIKExpiryInputCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (collectionView == self.yearCollectionView) {
        _selectedYear = [cell getInteger];
        // If a year is selected first, select a month that is valid for that year
        if (self.selectedMonth == 0) {
            _selectedMonth = 12;
        }
    } else {
        _selectedMonth = [cell getInteger];
    }
    cell.label.textColor = [UIColor blackColor];

    if (self.delegate != nil) {
        [self.delegate expiryInputViewDidChange:self];
    }
    
    [self updateVisibleCells];
}

- (void)collectionView:(__unused UICollectionView *)collectionView didDeselectItemAtIndexPath:(__unused NSIndexPath *)indexPath {
    BTUIKExpiryInputCollectionViewCell *cell = (BTUIKExpiryInputCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.label.textColor = [UIColor blackColor];
}

- (BOOL)isValidYear:(NSInteger)year forMonth:(NSInteger)month {
    if (month == 0) {
        return YES;
    } else if (month < self.currentMonth && year <= self.currentYear) {
        return NO;
    } else if (month > 12 || year < self.currentYear) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidMonth:(NSInteger)month forYear:(NSInteger)year {
    if (year == 0) {
        return YES;
    } else if (month < self.currentMonth && year <= self.currentYear) {
        return NO;
    } else if (month > 12) {
        return NO;
    }
    return YES;
}

- (void) updateVisibleCells {
    for (BTUIKExpiryInputCollectionViewCell* cell in [self.yearCollectionView visibleCells]) {
        cell.userInteractionEnabled = true;
        cell.label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
        if (self.selectedMonth && self.selectedMonth < self.currentMonth && [cell getInteger] == self.currentYear) {
            cell.userInteractionEnabled = false;
            cell.label.textColor = [BTUIKAppearance sharedInstance].disabledColor;
        }
    }
    for (BTUIKExpiryInputCollectionViewCell* cell in [self.monthCollectionView visibleCells]) {
        cell.userInteractionEnabled = true;
        cell.label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
        if (self.selectedYear && self.selectedYear == self.currentYear) {
            if ([cell getInteger] < self.currentMonth) {
                cell.userInteractionEnabled = false;
                cell.label.textColor = [BTUIKAppearance sharedInstance].disabledColor;
            }
        }
    }
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(__unused UICollectionView *)collectionView layout:(__unused UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(__unused NSIndexPath *)indexPath {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    BOOL isLandscape = NO;
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        isLandscape = YES;
        
    }
    int monthCols = isLandscape ? 4.0 : 3.0;
    int monthRows = isLandscape ? 3.0 : 4.0;
    
    CGSize monthCellSize = CGSizeMake((self.monthCollectionView.frame.size.width - ((BT_EXPIRY_FULL_PADDING * monthCols) + BT_EXPIRY_FULL_PADDING + (BT_EXPIRY_FULL_PADDING))) / monthCols , (self.monthCollectionView.frame.size.height - BT_EXPIRY_SECTION_HEADER_HEIGHT - ((BT_EXPIRY_FULL_PADDING * monthRows) + BT_EXPIRY_FULL_PADDING)) / monthRows);
    if (self.monthCollectionView == collectionView) {
        return monthCellSize;
    }
    
    int yearCols = isLandscape ? 2.0 : 1.0;
    
    return CGSizeMake((self.yearCollectionView.frame.size.width - ((BT_EXPIRY_FULL_PADDING * yearCols) + BT_EXPIRY_FULL_PADDING + (BT_EXPIRY_FULL_PADDING))) / yearCols , monthCellSize.height);
}

- (UIEdgeInsets)collectionView:(__unused UICollectionView *)collectionView layout:(__unused UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(__unused NSInteger)section {
    return UIEdgeInsetsMake(BT_EXPIRY_FULL_PADDING, BT_EXPIRY_FULL_PADDING, BT_EXPIRY_FULL_PADDING, BT_EXPIRY_FULL_PADDING);
}

#pragma mark - Orientation

- (void)orientationChange {
    if (self.window != nil) {
        [self.monthCollectionView.collectionViewLayout invalidateLayout];
        [self.yearCollectionView.collectionViewLayout invalidateLayout];
        [self.monthCollectionView performBatchUpdates:nil completion:nil];
        [self.yearCollectionView performBatchUpdates:nil completion:nil];
        [self.yearCollectionView flashScrollIndicators];
        [self setNeedsDisplay];
    } else {
        self.needsOrientationChange = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.needsOrientationChange) {
        self.needsOrientationChange = NO;
        [self orientationChange];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
