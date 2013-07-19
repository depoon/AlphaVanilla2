//
//  CreateBetViewController.m
//  AlphaVanilla2
//
//  Created by Kenneth on 18/7/13.
//  Copyright (c) 2013 Kenneth. All rights reserved.
//

#import "CreateBetViewController.h"
#import <Parse/Parse.h>
#import "BetObject.h"
#import <QuartzCore/QuartzCore.h>
#import "PGKeyboardInputAccessoryViewGenerator.h"
#import "ParseManager.h"

@implementation CreateBetViewController{
    @private BetObject* betObject;
    @private UIButton* betImageButton;
    @private UITextView* offerDescriptionTextView;
    @private UITextField* predictionTextField;
    @private ParseManager* parseManager;
}

-(id) init{
    self = [super init];
    parseManager = [[ParseManager alloc]init];
    [parseManager setParseCreateBetRequestDelegate:self];
    betObject = [[BetObject alloc]init];

    NSDictionary* userProfileDictionary = [parseManager getCurrentFacebookUserProfile];
    NSString* facebookId = [userProfileDictionary objectForKey:@"facebookId"];
    NSString* offerName = [userProfileDictionary objectForKey:@"name"];
    betObject.offerFacebookId = facebookId;
    betObject.offerUserObject = [parseManager getCurrentUser];
    betObject.offerName = offerName;

    return self;
}

-(void) dealloc{
    if (betObject){
        [betObject release];
        betObject = nil;
    }
    if (betImageButton){
        [betImageButton release];
        betImageButton = nil;
    }
    if (offerDescriptionTextView){
        [offerDescriptionTextView release];
        offerDescriptionTextView = nil;
    }
    if (predictionTextField){
        [predictionTextField release];
        predictionTextField = nil;
    }
    if (parseManager){
        [parseManager release];
        parseManager = nil;
    }
    [super dealloc];
}

-(void) setBetImageButton: (UIButton*) _betImageButton{
    if (betImageButton){
        [betImageButton release];
        betImageButton = nil;
    }
    betImageButton = [_betImageButton retain];
}

-(void) setOfferDescriptionTextView: (UITextView*) _offerDescriptionTextView{
    if (offerDescriptionTextView){
        [offerDescriptionTextView release];
        offerDescriptionTextView = nil;
    }
    offerDescriptionTextView = [_offerDescriptionTextView retain];
}

-(void) setPredictionTextField: (UITextField*) _predictionTextField{
    if (predictionTextField){
        [predictionTextField release];
        predictionTextField = nil;
    }
    predictionTextField = [_predictionTextField retain];
}

-(void) setupBackgroundView{
    UIImage* backgroundImage = [UIImage imageNamed:@"generalBackground"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [self setupBackgroundView];
    /*
    UIButton* takePhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 310, 300, 40)];
    [takePhotoButton addTarget:self action:@selector(askPhoto) forControlEvents:UIControlEventTouchUpInside];
    [takePhotoButton setTitle:@"Take Photo" forState:UIControlStateNormal];
    [takePhotoButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:takePhotoButton];
    [takePhotoButton release];
    */
    self.title = @"Create a Bet";
    
    PGKeyboardInputAccessoryViewGenerator* keyboardInputAccessoryViewGenerator = [[PGKeyboardInputAccessoryViewGenerator alloc]init];
    UIView* inputAccessoryView = [keyboardInputAccessoryViewGenerator generateInputAccessoryView:self];
    [keyboardInputAccessoryViewGenerator release];
    
    
    UIView* imageBaseView = [[UIView alloc]initWithFrame:CGRectMake(20, 90, 84, 125)];
    [imageBaseView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:imageBaseView];
    [imageBaseView release];
    
    
    UIButton* _betImageButton = [[UIButton alloc]initWithFrame:CGRectMake(2, 2, 80, 121)];
    [_betImageButton addTarget:self action:@selector(askPhoto) forControlEvents:UIControlEventTouchUpInside];
    [imageBaseView addSubview:_betImageButton];
    [_betImageButton release];
    [self setBetImageButton:_betImageButton];
    
    UIView* summaryBaseView = [[UIView alloc]initWithFrame:CGRectMake(120, 90, 180, 125)];
    [summaryBaseView setBackgroundColor:[UIColor blackColor]];
    summaryBaseView.layer.cornerRadius = 5;
    summaryBaseView.layer.masksToBounds = YES;
    [self.view addSubview:summaryBaseView];
    [summaryBaseView release];

    

    
    UITextView* _offerDescriptionTextView = [[UITextView alloc]initWithFrame:CGRectMake(2, 2, 176, 121)];
    [_offerDescriptionTextView setDelegate:self];
    [_offerDescriptionTextView setBackgroundColor:[UIColor whiteColor]];
    [_offerDescriptionTextView setFont:[UIFont systemFontOfSize:26]];
    [_offerDescriptionTextView setEditable:YES];
    _offerDescriptionTextView.layer.cornerRadius = 5;
    _offerDescriptionTextView.layer.masksToBounds = YES;
    [_offerDescriptionTextView setInputAccessoryView:inputAccessoryView];
    
    
    [summaryBaseView addSubview:_offerDescriptionTextView];
    [_offerDescriptionTextView release];
    
    [self setOfferDescriptionTextView:_offerDescriptionTextView];

    
    UIView* predictionBaseView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, 40)];
    [predictionBaseView setBackgroundColor:[UIColor blackColor]];
    predictionBaseView.layer.cornerRadius = 5;
    predictionBaseView.layer.masksToBounds = YES;
    [self.view addSubview:predictionBaseView];
    [predictionBaseView release];

    
    
    
    UITextField* _predictionTextField = [[UITextField alloc]initWithFrame:CGRectMake(2, 2, 276, 36)];
    [_predictionTextField setPlaceholder:@"Prediction"];
    [_predictionTextField setFont:[UIFont systemFontOfSize:18]];
    [_predictionTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_predictionTextField setBackgroundColor:[UIColor whiteColor]];
    _predictionTextField.layer.cornerRadius = 5;
    _predictionTextField.layer.masksToBounds = YES;
    [_predictionTextField setDelegate:self];
    [predictionBaseView addSubview:_predictionTextField];
    [_predictionTextField setInputAccessoryView:inputAccessoryView];
    [_predictionTextField release];
    [self setPredictionTextField:_predictionTextField];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    _predictionTextField.leftView = paddingView;
    _predictionTextField.leftViewMode = UITextFieldViewModeAlways;
    [paddingView release];
    
    UIView* createBetBaseView = [[UIView alloc]initWithFrame:CGRectMake(imageBaseView.frame.origin.x, imageBaseView.frame.origin.y+imageBaseView.frame.size.height+20, 280, 40 )];
    createBetBaseView.layer.cornerRadius = 5;
    createBetBaseView.layer.masksToBounds = YES;
    [createBetBaseView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:createBetBaseView];
    [createBetBaseView release];
    
    UIButton* createBetButton = [[UIButton alloc]initWithFrame:CGRectMake(2,2,276,36)];
    createBetButton.layer.cornerRadius = 5;
    createBetButton.layer.masksToBounds = YES;
    [createBetButton setTitle:@"Create Bet" forState:UIControlStateNormal];
    [createBetButton setBackgroundColor:[UIColor darkGrayColor]];
    [createBetButton addTarget:self action:@selector(createBet) forControlEvents:UIControlEventTouchUpInside];
    [createBetBaseView addSubview:createBetButton];
    [createBetButton release];
    
}

-(void) updateImagePlaceholder{
    if (betObject.offerBetImage == nil){
        [betImageButton setImage:[UIImage imageNamed:@"createBetImagePlaceholder"] forState:UIControlStateNormal];
    }else{
        [betImageButton setImage:betObject.offerBetImage  forState:UIControlStateNormal];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateImagePlaceholder];
}

-(void) askPhoto{

    
    // Check for camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        // Create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        
        // Show image picker
//        [self presentModalViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else{
        /*
        // Device has no camera
        UIImage *image;
        int r = arc4random() % 5;
        switch (r) {
            case 0:
                image = [UIImage imageNamed:@"ParseLogo.jpg"];
                break;
            case 1:
                image = [UIImage imageNamed:@"Crowd.jpg"];
                break;
            case 2:
                image = [UIImage imageNamed:@"Desert.jpg"];
                break;
            case 3:
                image = [UIImage imageNamed:@"Lime.jpg"];
                break;
            case 4:
                image = [UIImage imageNamed:@"Sunflowers.jpg"];
                break;
            default:
                break;
        }
        
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(640, 960));
        [image drawInRect: CGRectMake(0, 0, 640, 960)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
       // NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
       // [self uploadImage:imageData];
         */
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    // Access the uncropped image from info dictionary
   // UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissModalViewControllerAnimated:YES];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(320, 480));
    [image drawInRect: CGRectMake(0, 0, 320, 480)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
  //  NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    
    betObject.offerBetImage = smallImage;
    [self updateImagePlaceholder];

    /*
    PFFile *file = [PFFile fileWithName:@"uploadedImage" data:imageData];
    PFObject *testobj = [PFObject objectWithClassName:@"testObj"];
    [testobj setObject:file forKey:@"imageFile"];
    
    [file saveInBackground];
    [testobj saveInBackground];
   // [self uploadImage:imageData];
     */
}

-(void) keyboardInputAccessoryDoneButtonPressed{
    [offerDescriptionTextView resignFirstResponder];
    [predictionTextField resignFirstResponder];
}

-(void) createBet{
    NSLog(@"createBet: %@", betObject);
    [self createNewBet:betObject];
    
}

-(void) createNewBet: (BetObject*) _betObject{
    
    [parseManager createNewBetByOffer:_betObject];

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==predictionTextField){
        NSString* predictionText = [predictionTextField.text stringByReplacingCharactersInRange:range withString:string];
        betObject.prediction = predictionText;
    }

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView==offerDescriptionTextView){
        NSString* offerDescriptionText = textView.text;
        betObject.offerDescription = offerDescriptionText;
    }
}

-(void) didSuccessfullyCreatedBet{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bet Created"
                                                    message:@"Successful"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void) didFailToCreateBet: (NSString*) errorMessage{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:errorMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


@end
