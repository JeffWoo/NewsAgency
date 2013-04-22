

#import <Foundation/Foundation.h>

@protocol EGOImageLoadConnectionDelegate;

@interface EGOImageLoadConnection : NSObject {
@private
	NSURL* _imageURL;
	NSURLResponse* _response;
	NSMutableData* _responseData;
	NSURLConnection* _connection;
	NSTimeInterval _timeoutInterval;
	
	id<EGOImageLoadConnectionDelegate> _delegate;
}

- (id)initWithImageURL:(NSURL*)aURL delegate:(id)delegate;

- (void)start;
- (void)cancel;

@property(nonatomic,readonly) NSData* responseData;
@property(nonatomic,readonly,getter=imageURL) NSURL* imageURL;

@property(nonatomic,retain) NSURLResponse* response;
@property(nonatomic,assign) id<EGOImageLoadConnectionDelegate> delegate;

@property(nonatomic,assign) NSTimeInterval timeoutInterval; // Default is 30 seconds

#if __EGOIL_USE_BLOCKS
@property(nonatomic,readonly) NSMutableDictionary* handlers;
#endif

@end

@protocol EGOImageLoadConnectionDelegate<NSObject>
- (void)imageLoadConnectionDidFinishLoading:(EGOImageLoadConnection *)connection;
- (void)imageLoadConnection:(EGOImageLoadConnection *)connection didFailWithError:(NSError *)error;	
@end