//
//  RURProductCatalogVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURProductCatalogVC.h"
#import "RURHeaderView.h"
#import "RURDetalProductVC.h"
@interface RURProductCatalogVC ()
@property (nonatomic, strong) IBOutlet UICollectionView *catalogItems;
@end

@implementation RURProductCatalogVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithItems:(NSArray*)objects {
    self = [super init];
    if (self) {
        self.items = [[NSArray alloc] initWithArray:objects];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"windowBackground"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    UINib *cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.catalogItems registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    [self.catalogItems registerClass:[RURHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(280, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.catalogItems setCollectionViewLayout:flowLayout];
    NSLog(@"%@", self.items);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *lbl = (UILabel*)[cell viewWithTag:102];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:103];

    [imageView setImageWithURL:[NSURL URLWithString:[self.items[indexPath.row] objectForKey:@"image"]] placeholderImage:nil];
    /*BBObject *obj = [self.items objectAtIndex:indexPath.row];
    [lbl setText:[obj stringForField:@"name"]];*/
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(0, 20);
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    RURHeaderView *header = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//        header = (RURHeaderView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        [header setBackgroundColor:[UIColor grayColor]];
//        UILabel *lbl = [[UILabel alloc] initWithFrame:header.frame];
//        [lbl setFont:[UIFont systemFontOfSize:14.0]];
//        [lbl setTag:1];
//        [lbl setText:[NSString stringWithFormat:@"Section %d", indexPath.section]];
//        [header addSubview:lbl];
//    }
//        
//    
//    return header;
//}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RURDetalProductVC *detail = [[RURDetalProductVC alloc] initWithDictionary:[self.items objectAtIndex:indexPath.row]];
    //Set Details attibuttes
    [self.navigationController pushViewController:detail animated:YES];
}

@end
