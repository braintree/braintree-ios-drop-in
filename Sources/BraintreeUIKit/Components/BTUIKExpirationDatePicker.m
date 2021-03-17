#import "BTUIKExpirationDatePicker.h"
#import "BTUIKAppearance.h"

@interface BTUIKExpirationDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *monthFormatter;
@property (strong, nonatomic) NSDateFormatter *yearFormatter;
@end

@implementation BTUIKExpirationDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerView = [[UIPickerView alloc] initWithFrame:frame];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
        self.pickerView.backgroundColor = BTUIKAppearance.sharedInstance.formBackgroundColor;
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
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
    }
    return self;
}

- (NSString *)formattedMonthForRow:(NSInteger)row {
    NSDate *date = [self.calendar dateBySettingUnit:NSCalendarUnitMonth
                                              value:row + 1
                                             ofDate:[NSDate new]
                                            options:0];

    return [self.monthFormatter stringFromDate:date];
}

- (NSString *)formattedYearForRow:(NSInteger)row {
    NSDate *date = [self.calendar dateByAddingUnit:NSCalendarUnitYear
                                                value:row
                                               toDate:[NSDate new]
                                              options:0];

    return [self.yearFormatter stringFromDate:date];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 12;
    } else {
        return 20;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self formattedMonthForRow:row];
    } else {
        return [self formattedYearForRow:row];
    }
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger month = [pickerView selectedRowInComponent:0] + 1;
    NSInteger year = [pickerView selectedRowInComponent:1];

    NSDate *date = [self.calendar dateBySettingUnit:NSCalendarUnitMonth value:month ofDate:[NSDate new] options:0];
    date = [self.calendar dateByAddingUnit:NSCalendarUnitYear value:year toDate:date options:0];

    [self.delegate expirationDatePicker:self didSelectDate:date];
}

@end
