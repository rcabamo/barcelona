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

@interface RURDetailShopVC ()

//@property (nonatomic, strong) PFObject *shop;
@property (nonatomic, strong) RUR_Shop *shop;
// view
@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *logoImage;

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;

@property (nonatomic,strong) UIImage *image;

@end

@implementation RURDetailShopVC

- (id)initWithShop:(PFObject *)shop
{
    self = [super init];
    if (self) {
        //self.shop = shop;
        RUR_Shop *shopaux = [[RUR_Shop alloc] init];
        [shopaux setName:@"American Eagle"];
        [shopaux setDesc:@"Opening times:                                             Mon-Fry: 10am - 5pm                                             Sat: 9am - 6pm                                          Sun: Closed"];
        [shopaux setAddress:@"Address Test"];
        [shopaux setLon:122.33];
        [shopaux setLat:37.89];
        NSArray *pr = [[NSArray alloc] initWithObjects:@{@"name":@"Magic Mouse!", @"desc":@"It began with iPhone. Then came iPod touch. Then MacBook Pro. Intuitive, smart, dynamic. Multi-Touch technology introduced a remarkably better way to interact with your portable devices — all using gestures. Now we’ve reached another milestone by bringing gestures to the desktop with a mouse that’s unlike anything ever before. It's called Magic Mouse. It's the world's first Multi-Touch mouse",  @"image":@"gestures_2x.jpg", @"price":@"60.0"}, @{@"name":@"Magic Mug!", @"desc":@"Magic mug it's unique in it's design. When you drop hot liquid on it, the legs begin to run in circles of about 30cm of radius. Be carefull where you place it, even being magic it breaks",  @"image":@"WhiteMugFront.jpg", @"price":@"23.0"}, nil];
        [shopaux setProducts:pr];
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
    //self.titleLabel.text = [self.shop objectForKey:@"name"];
    self.descriptionTextView.text = @"Opening times:            Mon-Fry: 10am - 5pm             Sat: 9am - 6pm               Sun: Closed";
    self.titleLabel.text = [self.shop name];
    self.descriptionTextView.text = [self.shop desc];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
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
