#import "BTUIKExpiryInputView.h"
#import "BTUIKExpiryInputCollectionViewCell.h"
#import "BTUIKCollectionReusableView.h"
#import "BTUIKAppearance.h"
#import "BTUIKLocalizedString.h"

#define BT_EXPIRY_FULL_PADDING 10
#define BT_EXPIRY_SECTION_HEADER_HEIGHT 12

@interface BTUIKExpiryInputView ()

@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *years;
@property (nonatomic, strong) UICollectionView *monthCollectionView;
@property (nonatomic, strong) UICollectionView *yearCollectionView;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic) NSInteger currentYear;
@property (nonatomic) NSInteger currentMonth;

@end

@implementation BTUIKExpiryInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
        self.months = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
        
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:currentDate];
        self.currentYear = components.year;
        self.currentMonth = components.month;

        NSInteger yearCounter = self.currentYear;
        NSMutableArray *mutableYears = [NSMutableArray arrayWithCapacity:20];
        while (yearCounter < self.currentYear + 20) {
            [mutableYears addObject:[NSString stringWithFormat:@"%@", @(yearCounter)]];
            yearCounter++;
        }
        
        self.years = [NSArray arrayWithArray:mutableYears];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.monthCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.monthCollectionView registerClass:[BTUIKExpiryInputCollectionViewCell class] forCellWithReuseIdentifier:@"BTMonthCell"];
        [self.monthCollectionView registerClass:[BTUIKCollectionReusableView class]
                     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                            withReuseIdentifier:@"HeaderView"];
        self.monthCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.monthCollectionView.delegate = self;
        self.monthCollectionView.dataSource = self;
        self.monthCollectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.monthCollectionView];
        
        layout = [[UICollectionViewFlowLayout alloc] init];
        self.yearCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.yearCollectionView registerClass:[BTUIKExpiryInputCollectionViewCell class] forCellWithReuseIdentifier:@"BTYearCell"];
        [self.yearCollectionView registerClass:[BTUIKCollectionReusableView class]
                    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                           withReuseIdentifier:@"HeaderView"];
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
        
        NSDictionary *viewBindings = @{@"view":self, @"monthCollectionView":self.monthCollectionView, @"yearCollectionView": self.yearCollectionView, @"verticalLine":self.verticalLine};
        
        NSDictionary *metrics = @{@"BT_EXPIRY_FULL_PADDING":@BT_EXPIRY_FULL_PADDING, @"BT_EXPIRY_FULL_PADDING_HALF": @(BT_EXPIRY_FULL_PADDING/2.0)};
        
        
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

        if (@available(iOS 11.0, *)) {
            bottomReferenceView = self.safeAreaLayoutGuide;
        }

        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.monthCollectionView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:0
                                                            toItem:bottomReferenceView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.yearCollectionView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:0
                                                            toItem:bottomReferenceView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.verticalLine
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:0
                                                            toItem:bottomReferenceView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.yearCollectionView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:0
                                                            toItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:0.33
                                                          constant:0]];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    
    return self;
}

#pragma mark - Accessors

- (void)setSelectedYear:(NSInteger)selectedYear {
    NSString *stringToSearch = [NSString stringWithFormat:@"%@", @(selectedYear)];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", stringToSearch];
    NSString *results = [self.years filteredArrayUsingPredicate:predicate].firstObject;
    NSInteger yearIndex = [self.years indexOfObject:results];
    if (([self isValidYear:selectedYear forMonth:self.selectedMonth] && yearIndex != NSNotFound) || selectedYear == 0) {
        _selectedYear = selectedYear;
        if (selectedYear > 0) {
            [self.yearCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:yearIndex inSection:0]
                                                  animated:NO
                                            scrollPosition:0];
        } else {
            NSIndexPath *selectedIndexPath = [self.yearCollectionView indexPathsForSelectedItems].firstObject;
            [self.yearCollectionView deselectItemAtIndexPath:selectedIndexPath animated:NO];
        }

        [self.monthCollectionView reloadData];
        [self.yearCollectionView reloadData];
    }
}

- (void)setSelectedMonth:(NSInteger)selectedMonth {
    if ([self isValidMonth:selectedMonth forYear:self.selectedYear] || selectedMonth == 0) {
        _selectedMonth = selectedMonth;
        if (selectedMonth > 0) {
            [self.monthCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:selectedMonth - 1 inSection:0]
                                                   animated:NO
                                             scrollPosition:0];
        } else {
            NSIndexPath *selectedIndexPath = [self.monthCollectionView indexPathsForSelectedItems].firstObject;
            [self.monthCollectionView deselectItemAtIndexPath:selectedIndexPath animated:NO];
        }

        [self.monthCollectionView reloadData];
        [self.yearCollectionView reloadData];
    }
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(__unused NSInteger)section {
    if (collectionView == self.monthCollectionView) {
        return self.months.count;
    } else {
        return self.years.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView: (__unused UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTUIKExpiryInputCollectionViewCell *cell;
    BOOL isDisabled = NO;
    if (collectionView == self.monthCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTMonthCell" forIndexPath:indexPath];
        cell.label.text = self.months[indexPath.row];
        cell.selected = [cell getInteger] == self.selectedMonth;
        isDisabled = self.selectedYear && self.selectedYear == self.currentYear && [cell getInteger] < self.currentMonth;
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTYearCell" forIndexPath:indexPath];
        cell.label.text = self.years[indexPath.row];
        cell.selected = [cell getInteger] == self.selectedYear;
        isDisabled = self.selectedMonth && self.selectedMonth < self.currentMonth && [cell getInteger] == self.currentYear;
    }
    
    if (isDisabled) {
        cell.userInteractionEnabled = NO;
        cell.label.textColor = [BTUIKAppearance sharedInstance].disabledColor;
    } else {
        cell.userInteractionEnabled = YES;
        cell.label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(__unused NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    BTUIKCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"HeaderView"
                                                                                  forIndexPath:indexPath];
    view.label.text = collectionView == self.yearCollectionView ? BTUIKLocalizedString(YEAR_LABEL) : BTUIKLocalizedString(MONTH_LABEL);
    return view;
}

- (CGSize)collectionView:(__unused UICollectionView *)collectionView
                  layout:(__unused UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(__unused NSInteger)section {
    return CGSizeMake(100, BT_EXPIRY_SECTION_HEADER_HEIGHT);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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

    [self.delegate expiryInputViewDidChange:self];
    
    [self.monthCollectionView reloadData];
    [self.yearCollectionView reloadData];
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

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(__unused UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(__unused NSIndexPath *)indexPath {
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation);
    int monthRows = isLandscape ? 3.0 : 4.0;
    
    CGFloat cellHeight = (CGRectGetHeight(self.monthCollectionView.frame) - BT_EXPIRY_SECTION_HEADER_HEIGHT - ((BT_EXPIRY_FULL_PADDING * monthRows) + BT_EXPIRY_FULL_PADDING)) / monthRows;
    
    if (self.monthCollectionView == collectionView) {
        int monthCols = isLandscape ? 4.0 : 3.0;
        CGFloat monthCellWidth = (CGRectGetWidth(self.monthCollectionView.frame) - ((BT_EXPIRY_FULL_PADDING * monthCols) + BT_EXPIRY_FULL_PADDING * 2.0)) / monthCols;
        return CGSizeMake(monthCellWidth, cellHeight);
    } else {
        int yearCols = isLandscape ? 2.0 : 1.0;
        CGFloat yearCellWidth = (CGRectGetWidth(self.yearCollectionView.frame) - ((BT_EXPIRY_FULL_PADDING * yearCols) + BT_EXPIRY_FULL_PADDING * 2.0)) / yearCols;
        return CGSizeMake(yearCellWidth, cellHeight);
    }
}

- (UIEdgeInsets)collectionView:(__unused UICollectionView *)collectionView
                        layout:(__unused UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(__unused NSInteger)section {
    return UIEdgeInsetsMake(BT_EXPIRY_FULL_PADDING, BT_EXPIRY_FULL_PADDING, BT_EXPIRY_FULL_PADDING, BT_EXPIRY_FULL_PADDING);
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.window != nil) {
        [self.monthCollectionView.collectionViewLayout invalidateLayout];
        [self.yearCollectionView.collectionViewLayout invalidateLayout];
        [self.yearCollectionView flashScrollIndicators];
    }
}

@end
