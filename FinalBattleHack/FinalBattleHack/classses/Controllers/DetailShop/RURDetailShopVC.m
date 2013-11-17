//
//  RURDetailShopVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetailShopVC.h"
#import "RUR_Shop.h"
#import "RURProductCatalogVC.h"
#import "RURRestManager.h"
#import "RURcaptureViewController.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface RURDetailShopVC ()

//@property (nonatomic, strong) PFObject *shop;
@property (nonatomic, strong) RUR_Shop *shop;
// view
@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *logoImage, *bigImage;

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, strong) IBOutlet UIView *holderView;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic, strong) SVProgressHUD *hud;

@end

@implementation RURDetailShopVC

- (id)initWithShop:(PFObject *)shop
{
    self = [super init];
    if (self) {
        //self.shop = shop;
        RUR_Shop *shopaux = [[RUR_Shop alloc] init];
        
        if ([[shop objectForKey:@"name"] isEqualToString:@"Apple Store"]) {
            [shopaux setName:@"Apple Store"];
            [shopaux setDesc:@"Opening times:\nMon-Fry: 10am - 5pm\nSat: 9am - 6pm\nSun: Closed"];
            [shopaux setAddress:@"Address Test"];
            [shopaux setLon:122.33];
            [shopaux setLat:37.89];
            NSArray *pr = [[NSArray alloc] initWithObjects:
                           @{@"name":@"Magic Mouse!", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x.jpg", @"price":@"60.0"},
                           @{@"name":@"Magic Mug!", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront.jpg", @"price":@"23.0"},
                           @{@"name":@"Magic Mouse! 2", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x.jpg", @"price":@"60.0"},
                           @{@"name":@"Magic Mug! 2", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront.jpg", @"price":@"23.0"},
                           @{@"name":@"Magic Mouse! 3", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x.jpg", @"price":@"60.0"},
                           @{@"name":@"Magic Mug! 3", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront.jpg", @"price":@"23.0"}, nil];
            [shopaux setProducts:pr];
            [self.bigImage setImage:[UIImage imageNamed:@"passeigdegracia.png"]];
        } else {
            [shopaux setName:@"Zara"];
            [shopaux setDesc:@"Opening times:\nMon-Fry: 10am - 5pm\nSat: 9am - 6pm\nSun: Closed"];
            [shopaux setAddress:@"Address Test"];
            [shopaux setLon:122.33];
            [shopaux setLat:37.89];
            NSArray *pr = [[NSArray alloc] initWithObjects:
                           @{@"name":@"Structured Bowling", @"desc":@"Structured Bowling bag with pocket and studs",  @"image":@"Bolso1.png", @"price":@"80.0"},
                           @{@"name":@"Mini Fur Shopper", @"desc":@"Furry leather high heel ankie bool",  @"image":@"Bolso2.png", @"price":@"59.0"},
                           @{@"name":@"Wellies", @"desc":@"Mini messenger bag with clasp",  @"image":@"Bolso3.png", @"price":@"102.0"},nil];
            [shopaux setProducts:pr];
            [self.bigImage setImage:[UIImage imageNamed:@"zara.png"]];
        }
        
        self.shop = shopaux;
    }
    
    return self;
}

- (IBAction)takePicture:(id)sender {
    [self takeCamPicture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup view
    // title
    self.holderView.layer.cornerRadius = 15;
    self.holderView.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.holderView.layer.shadowOpacity = 1;
    self.holderView.layer.shadowOffset = CGSizeMake(0, 0);
    self.holderView.layer.shadowRadius = 10.0f;
    UIView *header = [self.view viewWithTag:100];
    header.layer.cornerRadius = 15;
    header.layer.shadowColor = [[UIColor blackColor]CGColor];
    header.layer.shadowOpacity = 1;
    header.layer.shadowOffset = CGSizeMake(0, 0);
    header.layer.shadowRadius = 10.0f;
    //self.titleLabel.text = [self.shop objectForKey:@"name"];
    self.descriptionTextView.text = @"Opening times:            Mon-Fry: 10am - 5pm             Sat: 9am - 6pm               Sun: Closed";
    self.titleLabel.text = [self.shop name];
    self.descriptionTextView.text = [self.shop desc];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    if ([[self.shop name] isEqualToString:@"Apple Store"]) {
        [self.bigImage setImage:[UIImage imageNamed:@"passeigdegracia.png"]];
    } else {
        
        [self.bigImage setImage:[UIImage imageNamed:@"zara.png"]];
    }
}

- (IBAction)openProductsVC:(id)sender
{
    //NSArray *array = [[self.shop joinResultForField:@"products"] objects];
    
    //RURProductCatalogVC *controller = [[RURProductCatalogVC alloc] initWithItems:[[self.shop joinResultForField:@"products"] objects]];
    RURProductCatalogVC *controller = [[RURProductCatalogVC alloc] initWithItems:[self.shop products]];
    
    [self.navigationController pushViewController:controller animated:YES];
    //Get array products & create catalog controller
}

#pragma mark - camera Delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [SVProgressHUD showWithStatus:@"Recognized product..."];
    
    _image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //save picture
    
    [[RURRestManager sharedInstance] setDel:self];
    [[RURRestManager sharedInstance] sendImage:_image];
}

- (void)takeCamPicture {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *camera = [[UIImagePickerController alloc]init];
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        //camera.cameraCaptureMode = UIImagePickerControllerCameraDeviceFront;
        camera.delegate = self;
        
        [self presentViewController:camera animated:YES completion:^{
            //
        }];
    } else {
    }
}

#pragma mark - API Delegate

- (void) weGotAnswer:(NSDictionary *)json
{
    [SVProgressHUD dismiss];
    
    NSLog(@"json");
    if ([json objectForKey:@"results"] && [[json objectForKey:@"results"] count] > 0 ) {
        [self dismissViewControllerAnimated:YES completion:^{
            RURcaptureViewController *capture = [[RURcaptureViewController alloc] init];
            capture.image = _image;
            capture.serverInfo = json;
            [self.navigationController pushViewController:capture animated:NO];
        }];
        
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Product detected" message:@"Please try again" delegate:self cancelButtonTitle:@"I'll be more precise!" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - alert delegates
- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self takeCamPicture];
}

@end
