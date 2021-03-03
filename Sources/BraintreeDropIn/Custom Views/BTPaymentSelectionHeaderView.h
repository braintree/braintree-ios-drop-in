#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BTPaymentSelectionHeaderViewDelegate;

@interface BTPaymentSelectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, copy) NSString *buttonText;
@property (nonatomic, nullable, weak) id<BTPaymentSelectionHeaderViewDelegate> delegate;

@end

@protocol BTPaymentSelectionHeaderViewDelegate <NSObject>

- (void)didTapButtonOnHeaderView:(BTPaymentSelectionHeaderView *)headerView;

@end

NS_ASSUME_NONNULL_END
