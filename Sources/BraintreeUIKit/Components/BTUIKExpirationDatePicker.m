#import "BTUIKExpirationDatePicker.h"
#import "BTUIKAppearance.h"

#define MONTH 0
#define YEAR 1

@interface BTUIKExpirationDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *monthFormatter;
@property (strong, nonatomic) NSDateFormatter *yearFormatter;
@property (strong, nonatomic) NSDateComponents *currentDateComponents;
@end

// TODO: Test in various languages (esp. right-to-left languages)
// TODO: Test on iPad, rotating between landscape and portrait, etc.

@implementation BTUIKExpirationDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerView = [[UIPickerView alloc] initWithFrame:frame];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
        self.pickerView.backgroundColor = BTUIKAppearance.sharedInstance.formBackgroundColor;
        [self addSubview:self.pickerView];

        [NSLayoutConstraint activateConstraints:@[
            [self.pickerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.pickerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [self.pickerView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.pickerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
        ]];

        self.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        self.monthFormatter = [NSDateFormatter new];
        self.monthFormatter.dateFormat = @"MM - MMMM";
        self.yearFormatter = [NSDateFormatter new];
        self.yearFormatter.dateFormat = @"yyyy";
        self.currentDateComponents = [self.calendar components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate new]];

        [self.pickerView selectRow:self.currentDateComponents.month - 1 inComponent:MONTH animated:NO];
        [self.pickerView selectRow:0 inComponent:YEAR animated:NO];
    }
    return self;
}

- (NSString *)formattedMonthForRow:(NSInteger)row {
    NSDateComponents *components = [NSDateComponents new];
    components.month = row + 1;
    return [self.monthFormatter stringFromDate:[self.calendar dateFromComponents:components]];
}

- (NSString *)formattedYearForRow:(NSInteger)row {
    NSDateComponents *components = [NSDateComponents new];
    components.year = row + self.currentDateComponents.year;
    return [self.yearFormatter stringFromDate:[self.calendar dateFromComponents:components]];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == MONTH) {
        return 12;
    } else {
        return 20;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == MONTH) {
        return [self formattedMonthForRow:row];
    } else {
        return [self formattedYearForRow:row];
    }
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger monthRow = [pickerView selectedRowInComponent:MONTH];
    NSInteger yearRow = [pickerView selectedRowInComponent:YEAR];

    NSDateComponents *selectedDateComponents = [NSDateComponents new];
    selectedDateComponents.year = yearRow + self.currentDateComponents.year;
    selectedDateComponents.month = monthRow + 1;

    NSDate *selectedDate = [self.calendar dateFromComponents:selectedDateComponents];
    [self.delegate expirationDatePicker:self didSelectDate:selectedDate];
}

@end
