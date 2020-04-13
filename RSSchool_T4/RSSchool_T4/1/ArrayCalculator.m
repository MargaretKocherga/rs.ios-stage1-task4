#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    
    if (numberOfItems == 0) {
        return 0;
    }
    
    NSMutableArray<NSNumber *> *numberArray = [NSMutableArray new];
    for (NSNumber *element in array) {
        if ([element isKindOfClass:[NSNumber class]]) {
            [numberArray addObject:element];
        }
    }
    
    if (numberArray.count == 0) {
        return 0;
    }
    
    [numberArray sortUsingComparator: ^NSComparisonResult(NSNumber* a, NSNumber *b) {
        NSNumber *first = @(labs(a.integerValue));
        NSNumber *second = @(labs(b.integerValue));
        return [first compare:second];
    }];
    
    NSInteger product = 1;
    if (numberOfItems >= numberArray.count) {
        for (NSNumber *element in numberArray) {
            product *= element.integerValue;
        }
        
    } else {
        NSInteger maxNegative = 1;
        for (NSInteger i = 0; i < numberOfItems; i++) {
            NSInteger element = numberArray[numberArray.count - i - 1].integerValue;
            product *= element;
            if (element < 0) {
                maxNegative = element;
            }
        }
        if (product < 0) {
            NSInteger element;
            for (NSInteger i = 0; i + numberOfItems < numberArray.count - 1; i++) {
                element = numberArray[numberArray.count - i - numberOfItems - 1].integerValue;
                if (element > 0) {
                    product /= maxNegative;
                    product *= element;
                    break;
                }
            }
        }
    }
    
    return product;
}
@end
