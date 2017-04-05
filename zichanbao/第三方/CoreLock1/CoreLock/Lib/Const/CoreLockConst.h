//
//  CoreLockConst.h
//  CoreLock
//
//  Created by 成林 on 15/4/24.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifndef _CoreLockConst_H_
#define _CoreLockConst_H_


#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


/*
 *  背景色
 */ 
//#define CoreLockViewBgColor rgba(226,226,226,1)
#define CoreLockViewBgColor rgba(241,242,243,1)

/*
 *  外环线条颜色：默认
 */
//#define CoreLockCircleLineNormalColor rgba(36,30,28,0.8)
#define CoreLockCircleLineNormalColor rgba(93,45,77,0.8)

/*
 *  外环线条颜色：选中
 */
//#define CoreLockCircleLineSelectedColor rgba(214,79,0,1)
#define CoreLockCircleLineSelectedColor rgba(93,45,77,1)


/*
 *  实心圆
 */
//#define CoreLockCircleLineSelectedCircleColor rgba(214,79,0,1)
#define CoreLockCircleLineSelectedCircleColor rgba(93,45,77,1)
#define CoreLockCircleLineSelectedCircleColor1 rgba(214,79,0,1)


/*
 *  实心圆
 */
//#define CoreLockLockLineColor rgba(214,79,0,1)
#define CoreLockLockLineColor rgba(93,45,77,1)



/*
 *  警示文字颜色
 */
#define CoreLockWarnColor rgba(36,30,28,0.8)
//#define CoreLockWarnColor rgba(93,45,77,0.8)


/** 选中圆大小比例 */
extern const CGFloat CoreLockArcWHR;



/** 选中圆大小的线宽 */
extern const CGFloat CoreLockArcLineW;


/** 密码存储Key */
extern NSString *const CoreLockPWDKey;


/** 最低设置密码数目 */
extern const NSUInteger CoreLockMinItemCount;



/*
 *  设置密码
 */

/** 设置密码提示文字：第一次 */
extern NSString *const CoreLockPWDTitleFirst;


/** 设置密码提示文字：确认 */
extern NSString *const CoreLockPWDTitleConfirm;


/** 设置密码提示文字：再次密码不一致 */
extern NSString *const CoreLockPWDDiffTitle;


/** 设置密码提示文字：设置成功 */
extern NSString *const CoreLockPWSuccessTitle;



/*
 *  登录验证密码
 */

/** 登录验证密码：普通提示文字 */
extern NSString *const CoreLockVerifyNormalTitle;

/** 登录验证密码：密码错误 */
extern NSString *const CoreLockVerifyErrorPwdTitle;

/** 登录验证密码：验证成功 */
extern NSString *const CoreLockVerifySuccesslTitle;


/*
 *  修改密码
 */
/** 修改密码：普通提示文字 */
extern NSString *const CoreLockModifyNormalTitle;

#endif