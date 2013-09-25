#import "MAMovieAppAPIClient.h"
#import "XBReloadableArrayDataSource.h"
#import "XBJsonToArrayDataMapper.h"
#import "XBHttpJsonDataLoader.h"
#import "MAMovie.h"
#import "XBArrayDataSource+protected.h"

static NSString *kAPI_KEY = @"bfjwrz7p5hzam6t79xbwhvpx";
static NSString *kBoxOfficePath = @"lists/movies/box_office.json";
static NSString *kMAMovieAppAPIBaseURLString = @"http://api.rottentomatoes.com/api/public/v1.0/";

@implementation MAMovieAppAPIClient

+ (instancetype)sharedClient {
    static MAMovieAppAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseUrl:kMAMovieAppAPIBaseURLString];
    });

    return _sharedClient;
}

- (id)initWithBaseUrl:(NSString *)url {
    self = [super initWithBaseUrl:url];
    if (!self) {
        return nil;
    }

    return self;
}

- (void)downloadBoxOfficeWithCallback:(MABoxOfficeCallbackBlock)callback {

    // Instantiate an dataLoader from your HTTP client and a given resourcePath:
    XBHttpJsonDataLoader *boxOfficeDataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:self resourcePath:[self rottenTomatoesUrlForPath:kBoxOfficePath]];

    // Instantiate an dataMapper, allowing the response to be deserialized to a given class (e.g. MAMovie):
    XBJsonToArrayDataMapper *boxOfficeDataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"movies" typeClass:[MAMovie class]];

    // Create the data source from the dataLoader and the dataMapper:
    XBReloadableArrayDataSource *dataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:boxOfficeDataLoader dataMapper:boxOfficeDataMapper];

    [dataSource loadDataWithCallback:^{
        if (callback) {
            callback(dataSource.array);
        }
    }];
}

- (NSString *)rottenTomatoesUrlForPath:(NSString *)relativePath {

    // Retrieve the current user country code
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];

    // Create the params dictionary
    NSDictionary *params = @{@"country": countryCode,
            @"limit": @20};

    // Create a new mutable string starting with our base URI
    NSMutableString *urlString = [NSMutableString stringWithString:@""];

    // Append the relative path and our api key
    [urlString appendString:relativePath];
    [urlString appendFormat:@"?apikey=%@",kAPI_KEY];

    // Append all params in the dictionary as key = obj
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [urlString appendFormat:@"&%@=%@", key, obj];
    }];

    NSLog(@"Loading data from : '%@'", urlString);

    return urlString;
}

@end
