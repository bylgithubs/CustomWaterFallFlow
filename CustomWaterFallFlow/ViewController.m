//
//  ViewController.m
//  CustomWaterFallFlow
//
//  Created by BaoYu Liao on 2021/11/30.
//

#import "ViewController.h"
#import "WaterFallFlowLayout.h"
#import <Masonry/Masonry.h>

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate,CustomWaterFallFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createConstraints];
}

- (void)createConstraints {
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark CustomWaterFallFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterFallFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row%2 == 0) {
        return 200;
    } else {
        return 300;
    }
    //CGFloat cellHeight = arc4random_uniform(150)+40;
    //return cellHeight;
}

#pragma mark - UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1];
    //cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WaterFallFlowLayout *layout = [[WaterFallFlowLayout alloc] init];
        layout.lineSpacing = 10;
        layout.itemSpacing = 10;
        layout.colCount = 3;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    }
    return _collectionView;
}

@end
