//
//  UIView+FontSize.m
//  FontSizeModify
//  字体大小自适应
//  Created by dyw on 16/10/22.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import "UIView+FontSize.h"
#import <objc/runtime.h>

#define IgnoreTagKey @"IgnoreTagKey"
#define FontScaleKey @"FontScaleKey"

#define ScrenScale [UIScreen mainScreen].bounds.size.width/375.f

@implementation UIView (FontSize)
/**
 设置需要忽略的控件tag值
 
 @param tagArr tag值数组
 */
+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tagArr forKey:IgnoreTagKey];
    [defaults synchronize];
}

/**
 设置字体大小比例
 
 @param value 需要设置的比例
 */
+ (void)setFontScale:(CGFloat)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(value) forKey:FontScaleKey];
    [defaults synchronize];
}

+ (NSArray *)getIgnoreTags{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *ignoreTagsArr = [defaults objectForKey:IgnoreTagKey];
    return ignoreTagsArr.count?ignoreTagsArr:0;
}

+ (CGFloat)getFontScale{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *valueNum = [defaults objectForKey:FontScaleKey];
    return valueNum?valueNum.floatValue:0;
}

@end

@interface UILabel (FontSize)

@end

@interface UIButton (FontSize)

@end

@interface UITextField (FontSize)

@end

@interface UITextView (FontSize)

@end

@implementation UILabel (FontSize)

+ (void)load{
    if(!UILabelEnable) return;
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}


- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end

@implementation UIButton (FontSize)

+ (void)load {
    if(!UIButtonEnable) return;

    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        CGFloat fontSize = self.titleLabel.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.titleLabel.font = [self.titleLabel.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        CGFloat fontSize = self.titleLabel.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.titleLabel.font = [self.titleLabel.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end

@implementation UITextField (FontSize)

+ (void)load {
    if(!UITextFieldEnable) return;

    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end

@implementation UITextView (FontSize)

+ (void)load {
    if(!UITextViewEnable) return;

    Method ibImp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myIbImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(ibImp, myIbImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end
