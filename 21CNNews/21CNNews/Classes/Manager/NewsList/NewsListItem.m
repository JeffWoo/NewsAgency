
#import "NewsListItem.h"

@implementation NewsListItem

- (id)initWithArticleId:(int)articleId
             articleUrl:(NSString*)articleUrl
            publishTime:(NSDate*)publishTime
               regionId:(int)regionId
               sourceId:(int)sourceId
             sourceName:(NSString*)sourceName
                summary:(NSString*)summary
            thumbImgUrl:(NSString*)thumbImgUrl
                  title:(NSString*)title
                topTime:(NSDate*)topTime
                  isHot:(BOOL)isHot
            isRecommend:(BOOL)isRecommend
              isSpecial:(BOOL)isSpecial
              reviewNum:(int)reviewNum
             showBigPic:(BOOL)showBigPic
             reviewList:(NSArray*)reviewList
                 pageNo:(int)pageNo
{
    self = [super init];
    if (self)
    {
        _articleId = articleId;
        _articleUrl = [articleUrl copy];
        _publishTime = [publishTime copy];
        _regionId = regionId;
        _sourceId = sourceId;
        _sourceName = [sourceName copy];
        _summary = [summary copy];
        _thumbImgUrl = [thumbImgUrl copy];
        _title = [title copy];
        _topTime = [topTime copy];
        _isHot = isHot;
        _isRecommend = isRecommend;
        _isSpecial = isSpecial;
        _reviewNum = reviewNum;
        _showBigPic = showBigPic;
        _reviewList = [reviewList copy];
        _pageNo = pageNo;
    }
    
    return self;
}


+ (NewsListItem*)newsListItemWithArticleId:(int)articleId
                                articleUrl:(NSString*)articleUrl
                               publishTime:(NSDate*)publishTime
                                  regionId:(int)regionId
                                  sourceId:(int)sourceId
                                sourceName:(NSString*)sourceName
                                   summary:(NSString*)summary
                               thumbImgUrl:(NSString*)thumbImgUrl
                                     title:(NSString*)title
                                   topTime:(NSDate*)topTime
                                     isHot:(BOOL)isHot
                               isRecommend:(BOOL)isRecommend
                                 isSpecial:(BOOL)isSpecial
                                 reviewNum:(int)reviewNum
                                showBigPic:(BOOL)showBigPic
                                reviewList:(NSArray*)reviewList
                                    pageNo:(int)pageNo
{
    return [[[NewsListItem alloc] initWithArticleId:articleId
                                        articleUrl:articleUrl
                                       publishTime:publishTime
                                          regionId:regionId
                                          sourceId:sourceId
                                        sourceName:sourceName
                                           summary:summary
                                       thumbImgUrl:thumbImgUrl
                                             title:title
                                           topTime:topTime
                                             isHot:isHot
                                       isRecommend:isRecommend
                                         isSpecial:isSpecial
                                         reviewNum:reviewNum
                                        showBigPic:showBigPic
                                         reviewList:reviewList
                                             pageNo:pageNo] autorelease];
}



- (void)dealloc
{
    [_articleUrl release];
    [_publishTime release];
    [_sourceName release];
    [_summary release];
    [_thumbImgUrl release];
    [_title release];
    [_topTime release];
    [_reviewList release];
    
    [super dealloc];
}


@end
