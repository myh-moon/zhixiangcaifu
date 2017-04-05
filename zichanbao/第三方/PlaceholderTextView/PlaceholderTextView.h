//
//  PlaceholderTextView.h
//  PlaceholderTextView
//
//  Created by lisongrc on 15/9/7.
//  Copyright (c) 2015年 rcplatform. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PlaceholderTextView : UITextView

@property (nonatomic, strong) IBInspectable NSString *placeholder;       /**< 提示文字 */
@property (nonatomic, strong) IBInspectable UIColor  *placeholderColor;  /**< 提示文字颜色 */
@property (nonatomic, assign) IBInspectable BOOL      displayPlaceHolder;/**< 是否显示提示文字 */

@end
