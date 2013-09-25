#import "XBHttpClient.h"

@class MAMovie;

typedef void(^MABoxOfficeCallbackBlock)(NSArray *array);

@interface MAMovieAppAPIClient : XBHttpClient

+ (MAMovieAppAPIClient *)sharedClient;
- (void)downloadBoxOfficeWithCallback:(MABoxOfficeCallbackBlock)callback;
- (void) updateMovieData:(MAMovie*)movie withCallback:(void (^)(void))callback;

@end
