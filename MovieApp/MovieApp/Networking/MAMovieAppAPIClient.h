#import "XBHttpClient.h"

typedef void(^MABoxOfficeCallbackBlock)(NSArray *array);

@interface MAMovieAppAPIClient : XBHttpClient

+ (MAMovieAppAPIClient *)sharedClient;
- (void)downloadBoxOfficeWithCallback:(MABoxOfficeCallbackBlock)callback;

@end
