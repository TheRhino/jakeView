//
//  MMViewController.m
//  jakeView
//
//  Created by RHINO on 3/5/13.
//  Copyright (c) 2013 RHINO. All rights reserved.
//

#import "MMViewController.h"
#import "UIView+jakeAnimationTools.h"

@interface MMViewController ()

{
    UIImage *jake;
    UIImageView *myViewOfJake;
    __weak IBOutlet UISlider *mySlider;
    __weak IBOutlet UIButton *buttonWasPressed;
}

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Get our image
    jake = [UIImage imageNamed:@"jake.png"];
    UIImage *mask = [UIImage imageNamed:@"mask.png"];
    
    //Create a masked image
    UIImage *maskedJake = [self createMaskWith:mask onImage:jake];
    
    //Create an image view with this new image and center it on our view
    myViewOfJake = [[UIImageView alloc]initWithImage:maskedJake];
    [self.view addSubview:myViewOfJake];
    myViewOfJake.center = self.view.center;
}

- (IBAction)buttonWasPressed:(id)sender
{
    [buttonWasPressed shakeIt];
}


- (IBAction)valueOfSlider:(id)sender
{
    //This is called whenever the slider is moved - Drag in View Changed from Storyboard
    NSLog(@"value is %f", mySlider.value);
    float sizeScaled = mySlider.value * 256;
    
    //Some resizeing
    CGSize sizeOfNewImage = CGSizeMake(sizeScaled, sizeScaled);
    
    //This gets a new context of size sizeOfNewImage
    UIGraphicsBeginImageContext(sizeOfNewImage);
    
    //
    //The beginning of doing stuff on a new desk(context)
    //
    
    //Get a reference to the new desk(context)
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Set the quality of the image through Interpolation
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    //Draw our Jake picture on our new desk(context)
    [jake drawInRect:CGRectMake(0, 0, sizeOfNewImage.width, sizeOfNewImage.height)];
    
    //Pick up the image from the desk(context)
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //
    //The end of doing stuff
    //
    
    myViewOfJake.image = scaledImage;
    
    //Resizing the frame of the view of the image to match
    myViewOfJake.frame = CGRectMake(0, 0, sizeOfNewImage.width, sizeOfNewImage.height);
    
    //Recenter the view after changing the frame
    myViewOfJake.center = self.view.center;
}

- (UIImage *) createMaskWith:(UIImage *)maskImage onImage:(UIImage *)subjectImage
{
    //Get a raw CGImageRef of our mask image
    CGImageRef maskRef = maskImage.CGImage;
    
    //Create a raw CGImageRef of our mask from the mask image
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef),
                                        NULL,
                                        false);
   
    //Create the mask on top of the subject image with CGImageRefs
    CGImageRef masked = CGImageCreateWithMask(subjectImage.CGImage, mask);
    
    //Convert this data to a UImage and return it
    UIImage *finalImage = [UIImage imageWithCGImage:masked];
    return finalImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
