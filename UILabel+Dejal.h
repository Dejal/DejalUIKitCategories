//
//  UILabel+Dejal.h
//  Dejal Open Source Categories
//
//  Created by David Sinclair on 2008-11-15.
//  Copyright (c) 2008-2015 Dejal Systems, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//
//  - Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

@import UIKit;


@interface UILabel (Dejal)

+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font;
+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height;
+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (UILabel *)dejal_labelWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (UILabel *)dejal_labelForPrompt:(NSString *)text withWidth:(CGFloat)width;

+ (UILabel *)dejal_labelForTableCellWithFont:(UIFont *)font textColor:(UIColor *)textColor highlightedTextColor:(UIColor *)highlightedTextColor;
+ (UILabel *)dejal_labelForTableAddRow;
+ (UILabel *)dejal_labelForTablePrimaryText;
+ (UILabel *)dejal_labelForTableSecondaryText;

- (void)dejal_adjustForHighlight:(BOOL)highlighted;

+ (CGSize)dejal_sizeForText:(NSString *)text font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode frameSize:(CGSize)frameSize;
+ (CGSize)dejal_sizeForAttributedText:(NSAttributedString *)text frameSize:(CGSize)frameSize;

- (CGSize)dejal_sizeForTextWithinFrameSize:(CGSize)frameSize;
- (CGSize)dejal_sizeForAttributedTextWithinFrameSize:(CGSize)frameSize;

@end

