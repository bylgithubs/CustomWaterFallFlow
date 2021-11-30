//
//  WaterFallFlowLayout.m
//  CustomWaterFallFlow
//
//  Created by BaoYu Liao on 2021/11/30.
//

#import "WaterFallFlowLayout.h"

@interface WaterFallFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary *colunMaxYDic;

@end

@implementation WaterFallFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSpacing = 10;
        self.lineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.colCount = 2;
    }
    return self;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    for(NSInteger i = 0;i < self.colCount; i++)
    {
        NSString * col = [NSString stringWithFormat:@"%ld",(long)i];
        self.colunMaxYDic[col] = @0;
    }
    NSMutableArray * attrsArray = [NSMutableArray array];
    NSInteger section = [self.collectionView numberOfSections];
    for (NSInteger i = 0 ; i < section; i++) {
        //获取item的UICollectionViewLayoutAttributes
        NSInteger count = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < count; j++) {
            UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            [attrsArray addObject:attrs];
        }
    }
    return attrsArray;
}

- (CGSize)collectionViewContentSize
{
    __block NSString * maxCol = @"0";
    //遍历找出最高的列
    [self.colunMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.colunMaxYDic[maxCol] floatValue]) {
            maxCol = column;
        }
    }];
    return CGSizeMake(0, [self.colunMaxYDic[maxCol] floatValue]);
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    __block NSString * minCol = @"0";
    //遍历找出最短的列
    [self.colunMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.colunMaxYDic[minCol] floatValue]) {
            minCol = column;
        }
    }];
    
    //    宽度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right- (self.colCount-1) * self.itemSpacing)/self.colCount;
    //    高度
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForWidth:atIndexPath:)]) {
        height = [self.delegate collectionView:self.collectionView layout:self heightForWidth:width atIndexPath:indexPath];
    }
    
    CGFloat x = self.sectionInset.left + (width + self.itemSpacing) * [minCol intValue];
    
    CGFloat space = 0.0;
    if (indexPath.item < self.colCount) {
        space = 0.0;
    }else{
        space = self.lineSpacing;
    }
    CGFloat y =[self.colunMaxYDic[minCol] floatValue] + space;
    
    //    跟新对应列的高度
    self.colunMaxYDic[minCol] = @(y + height);
    
    //    计算位置
    UICollectionViewLayoutAttributes * attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(x, y, width, height);
    
    return attri;
}

- (NSMutableDictionary *)colunMaxYDic {
    if (!_colunMaxYDic) {
        _colunMaxYDic = @{}.mutableCopy;
    }
    return _colunMaxYDic;
}


@end
