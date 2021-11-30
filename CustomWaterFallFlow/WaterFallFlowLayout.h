//
//  WaterFallFlowLayout.h
//  CustomWaterFallFlow
//
//  Created by BaoYu Liao on 2021/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WaterFallFlowLayout;

//typedef NS_ENUM(NSUInteger, UICollectionViewSectionType) {
//    UICollectionViewSectionTypeHeader = 1,
//    UICollectionViewSectionTypeFooter,
//};

@protocol CustomWaterFallFlowLayoutDelegate <NSObject>

@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterFallFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@optional
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WaterFallFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(WaterFallFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end

@interface WaterFallFlowLayout : UICollectionViewLayout

@property(nonatomic, assign)UIEdgeInsets sectionInset; //cell 间距
@property(nonatomic, assign)CGFloat lineSpacing;  //line space
@property(nonatomic, assign)CGFloat itemSpacing; //item space
@property(nonatomic, assign)CGFloat colCount; //设置colleciton 的列数

@property(nonatomic, weak)id<CustomWaterFallFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
