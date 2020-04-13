#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    
    NSInteger integerNumber = number.integerValue;
    if (integerNumber <= 4) {
        return nil;
    }
    NSMutableArray <NSNumber *> *resultArray = [self decompose:integerNumber with:integerNumber * integerNumber];
    
    return resultArray;
}

- (NSMutableArray <NSNumber *> *)decompose:(NSInteger)number with:(NSInteger)square {
    NSMutableArray <NSNumber *> *resultArray = [NSMutableArray new];
    if (square == 0) {
        return resultArray;
    }
    
    for (NSInteger maxNumber = number - 1; maxNumber > 0; maxNumber--) {
        NSInteger left = square - maxNumber * maxNumber;
        if (left >= 0) {
            resultArray = [self decompose:maxNumber with:left];
            if (resultArray != nil) {
                [resultArray addObject:@(maxNumber)];
                return resultArray;
            }
        }
    }
    return nil;
}
@end
