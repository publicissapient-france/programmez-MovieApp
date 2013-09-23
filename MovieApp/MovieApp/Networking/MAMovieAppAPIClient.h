#import "AFHTTPClient.h"
#import "XBHttpClient.h"

@class XBReloadableArrayDataSource;

typedef void(^MACallbackBlock)(NSArray *array);

@interface MAMovieAppAPIClient : XBHttpClient

+ (MAMovieAppAPIClient *)sharedClient;
- (XBReloadableArrayDataSource *)downloadBoxOfficeWithCallback:(MACallbackBlock)callback;

@end
