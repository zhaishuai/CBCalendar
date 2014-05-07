/*
 The MIT License (MIT)
 
 Copyright (c) 2014 zhaishuai
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import <Cocoa/Cocoa.h>

@interface CBDayView : NSView
@property (nonatomic,strong)NSString *day;
@property int state;
@property (nonatomic,strong)NSColor *rectBackgroundColor;
@property (nonatomic,strong)NSColor *rectBoundColor;
@property (nonatomic,strong)NSColor *dayFontColor;
/**
 *  state YES mean you can draw a circle in the rect then set a color;
 *  state NO mean you can not draw a circle int the rect then you should set color to nil;
 */
- (void)drawCirleInRect:(BOOL)state color:(NSColor *)color;

/**
 *  state YES mean you can draw a point in the rect then set a color;
 *  state NO mean you can not draw a point int the rect then you should set color to nil;
 */
- (void)drawPointInRect:(BOOL)state color:(NSColor *)color;
@end

