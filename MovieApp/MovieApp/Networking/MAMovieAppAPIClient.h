#import "AFHTTPClient.h"
#import "XBHttpClient.h"

@class XBReloadableArrayDataSource, MAMovie;

typedef void(^MACallbackBlock)(NSArray *array);

@interface MAMovieAppAPIClient : XBHttpClient

+ (MAMovieAppAPIClient *)sharedClient;
- (XBReloadableArrayDataSource *)downloadBoxOfficeWithCallback:(MACallbackBlock)callback;
- (void) updateMovieData:(MAMovie*)movie withCallback:(void (^)(void))callback;

@end
