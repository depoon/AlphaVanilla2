//
//  CreateBetViewController.h
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGKeyboardInputAccessoryAction.h"
#import "ParseCreateBetRequestDelegate.h"

@interface CreateBetViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, PGKeyboardInputAccessoryAction, UITextFieldDelegate, UITextViewDelegate, ParseCreateBetRequestDelegate>

@end
