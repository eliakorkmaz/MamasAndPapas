//
// Created by SERDAR YILLAR on 7/10/13.
// Copyright (c) 2013 Spacesheep. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

@import MMProgressHUD;
#import "HudManager.h"
#import "NSObject+BKBlockExecution.h"

@implementation HudManager {
  id loading_call_id;
  id _delay_error_id;
  id _delay_success_id;
  UIColor* _color;
}

+ (HudManager*)instance {
  static HudManager* _instance = nil;
    
  @synchronized(self) {
    if (_instance == nil) {
      _instance = [[self alloc] init];
    }
  }
    
  return _instance;
}

- (id)init {
  self = [super init];
  if (self) {
    [MMProgressHUD sharedHUD].presentationStyle = MMProgressHUDPresentationStyleShrink;
    [MMProgressHUD sharedHUD].overlayMode = MMProgressHUDWindowOverlayModeGradient;
    [MMProgressHUD sharedHUD].progressStyle = MMProgressHUDProgressStyleIndeterminate;
    _color = [UIColor whiteColor];
    [MMProgressHUD sharedHUD].glowColor = _color.CGColor;
    [MMProgressHUD sharedHUD].confirmationMessage = @"İptal ?";
  }
    
  return self;
}

- (void)showWithTitle:(NSString*)string status:(NSString*)status afterDelay:(CGFloat)delay {
  [self cancelPendingCall];
    
  loading_call_id = [self bk_performBlock:^(id sender) {
      
    [MMProgressHUD showWithTitle:string
                          status:status
                     cancelBlock:^{
                       NSLog(@"");
                         
                       [[NSNotificationCenter defaultCenter] postNotificationName:@"notif_cancel_operation" object:nil];
                         
                     }];
  }
                               afterDelay:delay];
}

- (void)dismissWithSuccess:(NSString*)status title:(NSString*)title afterDelay:(CGFloat)delay {
  if (_delay_success_id) {
    [NSObject bk_cancelBlock:_delay_success_id];
  }
    
  [self cancelPendingCall];
    
  if (delay > 0) {
    _delay_success_id = [self bk_performBlock:^(id sender) {
        
      [MMProgressHUD dismissWithSuccess:status title:title afterDelay:.5];
    }
                                   afterDelay:delay];
  } else {
    [MMProgressHUD dismissWithSuccess:status title:title afterDelay:.5];
  }
}

- (void)cancelPendingCall {
  [[MMProgressHUD sharedHUD] setCancelBlock:nil];
    
  if (loading_call_id) {
    [NSObject bk_cancelBlock:loading_call_id];
  }
}

- (void)dismissWithError:(NSString*)title afterDelay:(CGFloat)delay {
  if (_delay_error_id) {
    [NSObject bk_cancelBlock:_delay_error_id];
  }
    
  [self cancelPendingCall];
    
  if (delay > 0) {
    _delay_error_id = [self bk_performBlock:^(id sender) {
        
      [MMProgressHUD dismissWithError:title afterDelay:3.0f];
        
    }
                                 afterDelay:delay];
      
  } else {
    [MMProgressHUD dismissWithError:title afterDelay:3.0f];
  }
}

- (void)dismissAfterDelay:(CGFloat)delay {
  if (_delay_error_id) {
    [NSObject bk_cancelBlock:_delay_error_id];
  }
    
  [self cancelPendingCall];
    
  if (delay > 0) {
    _delay_error_id = [self bk_performBlock:^(id sender) {
        
      [MMProgressHUD dismiss];
    }
                                 afterDelay:delay];
  } else {
    [MMProgressHUD dismiss];
  }
}
@end
