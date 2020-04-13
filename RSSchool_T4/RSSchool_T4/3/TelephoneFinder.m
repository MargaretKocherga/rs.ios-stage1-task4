#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    
    NSDictionary *digitsDictionary = @{
        @"0" : @[@"8"],
        @"1" : @[@"2", @"4"],
        @"2" : @[@"1", @"3", @"5"],
        @"3" : @[@"2", @"6"],
        @"4" : @[@"1", @"5", @"7"],
        @"5" : @[@"2", @"4", @"6", @"8"],
        @"6" : @[@"3", @"5", @"9"],
        @"7" : @[@"4", @"8"],
        @"8" : @[@"5", @"7", @"9", @"0"],
        @"9" : @[@"6", @"8"]
    };
    
    if (number.length == 0 || number.integerValue < 0) {
        return nil;
    }
    
    NSMutableArray <NSString *> *resultArray = [NSMutableArray new];
    
    for (NSInteger i = 0; i < number.length; i++) {
        NSArray <NSString *> *neighbors = [digitsDictionary objectForKey:
                                           [number substringWithRange:NSMakeRange(i, 1)]];
        
        for (NSString *digit in neighbors) {
            NSString *newNumber = [number stringByReplacingCharactersInRange:
                                   NSMakeRange(i, 1) withString:digit];
            [resultArray addObject:newNumber];
        }
    }
    
    return resultArray;
}
@end
