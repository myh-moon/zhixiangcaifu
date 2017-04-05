//
//  ExChangeDetailssCell.m
//  zichanbao
//
//  Created by zhixiang on 16/11/9.
//  Copyright © 2016年 zhixiang. All rights reserved.
//

#import "ExChangeDetailssCell.h"

@implementation ExChangeDetailssCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.ssLabel];
        [self.contentView addSubview:self.ssTextView];
        
        self.lefTextViewConstraints = [self.ssTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        [self.ssLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.ssLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kSmallPadding];
        
        [self.ssTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4];
        [self.ssTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kSmallPadding];
        [self.ssTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (UILabel *)ssLabel
{
    if (!_ssLabel) {
        _ssLabel = [UILabel newAutoLayoutView];
        _ssLabel.textColor = [UIColor blackColor];
        _ssLabel.font = font14;
    }
    return _ssLabel;
}

- (PlaceholderTextView *)ssTextView
{
    if (!_ssTextView) {
        _ssTextView = [PlaceholderTextView newAutoLayoutView];
        _ssTextView.placeholderColor = [UIColor lightGrayColor];
        _ssTextView.font = font12;
        _ssTextView.delegate = self;
    }
    return _ssTextView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.didEndEditting) {
        self.didEndEditting(textView.text);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.touchBeginPoint) {
        self.touchBeginPoint(CGPointMake(self.center.x, self.bottom + 10));
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
