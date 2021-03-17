#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BTUIKExpirationDatePickerDelegate;

@interface BTUIKExpirationDatePicker : UIView

@property (nonatomic, weak) id <BTUIKExpirationDatePickerDelegate> delegate;

@end

@protocol BTUIKExpirationDatePickerDelegate <NSObject>

- (void)expirationDatePicker:(BTUIKExpirationDatePicker *)picker didSelectDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
