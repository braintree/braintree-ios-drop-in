#import "BTUIKAppearance.h"
#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKTextField.h"
#import "BTUIKViewUtil.h"

@interface BTUIKTextField () <UITextFieldDelegate>
@property (nonatomic, copy) NSString *previousText;
@end

@implementation BTUIKTextField

- (instancetype)init {
    if (self = [super init]) {
        self.hideCaret = NO;
        self.adjustsFontForContentSizeCategory = YES;
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    NSMutableAttributedString *mutablePlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [mutablePlaceholder beginEditing];
    [mutablePlaceholder addAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].placeholderTextColor,
                                        NSFontAttributeName:[BTUIKAppearance sharedInstance].bodyFont}
                                range:NSMakeRange(0, [mutablePlaceholder length])];
    [mutablePlaceholder endEditing];
    
    self.attributedPlaceholder = mutablePlaceholder;
}

- (BOOL)keyboardInputShouldDelete:(__unused UITextField *)textField {
    if ([self.editDelegate respondsToSelector:@selector(textFieldWillDeleteBackward:)]) {
        [self.editDelegate textFieldWillDeleteBackward:self];
    }

    BOOL shouldDelete = YES;

    if ([UITextField instancesRespondToSelector:_cmd]) {
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];

        if (keyboardInputShouldDelete) {
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }

    return shouldDelete;
}

- (void)deleteBackward
{
    BOOL shouldDismiss = [self.text length] == 0;
    NSString *originalText = self.text;

    [super deleteBackward];

    if (shouldDismiss) {
        if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
        }
    }

    if ([self.editDelegate respondsToSelector:@selector(textFieldDidDeleteBackward:originalText:)]) {
        [self.editDelegate textFieldDidDeleteBackward:self originalText:originalText];
    }
}

- (void)insertText:(NSString *)text {
    if ([self.editDelegate respondsToSelector:@selector(textField:willInsertText:)]) {
        [self.editDelegate textField:self willInsertText:text];
    }

    [super insertText:text];

    if ([self.editDelegate respondsToSelector:@selector(textField:didInsertText:)]) {
        [self.editDelegate textField:self didInsertText:text];
    }
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    if (self.hideCaret) {
        return CGRectZero;
    }
    
    return [super caretRectForPosition:position];
}

@end
