//
//  NewChannelList.m
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "NewChannelList.h"

@interface NewChannelList()

@property (nonatomic, retain) NSMutableArray* list;

@end


@implementation NewChannelList

+ (NewChannelList*)getNewChannelList
{
    return [[[NewChannelList alloc] init] autorelease];
}


- (id)init
{
    self = [super init];
    if (self)
    {
        _list = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    [_list removeAllObjects];
    [_list release];
    
    [super dealloc];
}


- (int)count
{
    return [self.list count];
}


- (BOOL)insertNewsChannelObject:(NewsChannelObject*)object
{
    BOOL bRet = NO;
    if (object)
    {
        if (object.isCurrentPage)
        {
            _currentPageIndex = [self count];
        }
        
        [self.list addObject:object];
        
        bRet = YES;
    }
    
    return bRet;
}


- (NewsChannelObject*)getNewsChannelObject:(NSInteger)index
{
    NewsChannelObject* retObject = nil;
    if (index >= 0 && index < [self count])
    {
        retObject = [self.list objectAtIndex:index];
    }
    
    return retObject;
}


@end
