/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGRect.h"
#import <React/RCTLog.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTConversions.h>
#import <React/RCTFabricComponentsPlugins.h>
#import <react/renderer/components/view/conversions.h>
#import <rnsvg/RNSVGComponentDescriptors.h>
#import "RNSVGFabricConversions.h"
#endif // RCT_NEW_ARCH_ENABLED

@implementation RNSVGRect

#ifdef RCT_NEW_ARCH_ENABLED
using namespace facebook::react;

// Needed because of this: https://github.com/facebook/react-native/pull/37274
+ (void)load
{
  [super load];
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNSVGRectProps>();
    _props = defaultProps;
  }
  return self;
}

#pragma mark - RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNSVGRectComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &newProps = static_cast<const RNSVGRectProps &>(*props);

  id x = RNSVGConvertFollyDynamicToId(newProps.x);
  if (x != nil) {
    self.x = [RCTConvert RNSVGLength:x];
  }
  id y = RNSVGConvertFollyDynamicToId(newProps.y);
  if (y != nil) {
    self.y = [RCTConvert RNSVGLength:y];
  }
  id rectheight = RNSVGConvertFollyDynamicToId(newProps.height);
  if (rectheight != nil) {
    self.rectheight = [RCTConvert RNSVGLength:rectheight];
  }
  id rectwidth = RNSVGConvertFollyDynamicToId(newProps.width);
  if (rectwidth != nil) {
    self.rectwidth = [RCTConvert RNSVGLength:rectwidth];
  }
  id rx = RNSVGConvertFollyDynamicToId(newProps.rx);
  if (rx != nil) {
    self.rx = [RCTConvert RNSVGLength:rx];
  }
  id ry = RNSVGConvertFollyDynamicToId(newProps.ry);
  if (ry != nil) {
    self.ry = [RCTConvert RNSVGLength:ry];
  }

  setCommonRenderableProps(newProps, self);
  _props = std::static_pointer_cast<RNSVGRectProps const>(props);
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];

  _x = nil;
  _y = nil;
  _rectwidth = nil;
  _rectheight = nil;
  _rx = nil;
  _ry = nil;
}

#endif // RCT_NEW_ARCH_ENABLED

- (void)setX:(RNSVGLength *)x
{
  if ([x isEqualTo:_x]) {
    return;
  }
  [self invalidate];
  _x = x;
}

- (void)setY:(RNSVGLength *)y
{
  if ([y isEqualTo:_y]) {
    return;
  }
  [self invalidate];
  _y = y;
}

- (void)setRectwidth:(RNSVGLength *)rectwidth
{
  if ([rectwidth isEqualTo:_rectwidth]) {
    return;
  }
  [self invalidate];
  _rectwidth = rectwidth;
}

- (void)setRectheight:(RNSVGLength *)rectheight
{
  if ([rectheight isEqualTo:_rectheight]) {
    return;
  }
  [self invalidate];
  _rectheight = rectheight;
}

- (void)setRx:(RNSVGLength *)rx
{
  if ([rx isEqualTo:_rx]) {
    return;
  }
  [self invalidate];
  _rx = rx;
}

- (void)setRy:(RNSVGLength *)ry
{
  if ([ry isEqualTo:_ry]) {
    return;
  }
  [self invalidate];
  _ry = ry;
}

- (CGPathRef)getPath:(CGContextRef)context
{
  CGMutablePathRef path = CGPathCreateMutable();
  CGFloat x = [self relativeOnWidth:self.x];
  CGFloat y = [self relativeOnHeight:self.y];
  CGFloat width = [self relativeOnWidth:self.rectwidth];
  CGFloat height = [self relativeOnHeight:self.rectheight];

  if (self.rx != nil || self.ry != nil) {
    CGFloat rx = 0;
    CGFloat ry = 0;
    if (self.rx == nil) {
      ry = [self relativeOnHeight:self.ry];
      rx = ry;
    } else if (self.ry == nil) {
      rx = [self relativeOnWidth:self.rx];
      ry = rx;
    } else {
      rx = [self relativeOnWidth:self.rx];
      ry = [self relativeOnHeight:self.ry];
    }

    if (rx > width / 2) {
      rx = width / 2;
    }

    if (ry > height / 2) {
      ry = height / 2;
    }

    CGPathAddRoundedRect(path, nil, CGRectMake(x, y, width, height), rx, ry);
  } else {
    CGPathAddRect(path, nil, CGRectMake(x, y, width, height));
  }

  return (CGPathRef)CFAutorelease(path);
}

@end

#ifdef RCT_NEW_ARCH_ENABLED
Class<RCTComponentViewProtocol> RNSVGRectCls(void)
{
  return RNSVGRect.class;
}
#endif // RCT_NEW_ARCH_ENABLED
