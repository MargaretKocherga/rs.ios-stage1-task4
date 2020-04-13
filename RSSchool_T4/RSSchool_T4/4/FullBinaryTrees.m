#import "FullBinaryTrees.h"

@interface Node : NSObject

@property(nonatomic, retain) Node *right;
@property(nonatomic, retain) Node *left;

@end

@implementation Node @end

typedef NSMutableArray<NSMutableArray<NSString *> *> Matrix;


@implementation FullBinaryTrees : NSObject

- (NSArray<Node *> *)getPossibleTreesWithNodesCount:(NSInteger)count {
    
    if (count == 1) {
        return @[[Node new]];
    }
    
    NSMutableArray *possibleTrees = [NSMutableArray new];
    
    if (count % 2 == 1) {
        for (int i = 0; i < count; i++) {
            NSArray *leftTrees = [self getPossibleTreesWithNodesCount:i];
            
            for (Node *leftTree in leftTrees) {
                NSArray *rightTrees = [self getPossibleTreesWithNodesCount:count - i - 1];
                
                for (Node *rightTree in rightTrees) {
                    Node *rootNode = [Node new];
                    rootNode.left = leftTree;
                    rootNode.right = rightTree;
                    [possibleTrees addObject:rootNode];
                }
            }
        }
    }
        
    return possibleTrees;
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    NSArray<Node *> *trees = [self getPossibleTreesWithNodesCount:count];
    
    NSMutableArray *parsedTrees = [NSMutableArray new];
    for (Node *tree in trees) {
        [parsedTrees addObject:[self encodeTreeToStringRepresentation:tree]];
    }
    return [NSString stringWithFormat:@"[%@]", [parsedTrees componentsJoinedByString:@","]];
}

- (NSString *)encodeTreeToStringRepresentation:(Node *)rootNode { 
    Matrix *matrix = [NSMutableArray array];
    [self saveNodes:rootNode onLevel:0 toArray:matrix];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSMutableArray *row in matrix) {
        for (NSUInteger i = 0; i < ceil((float)row.count / 4); i++) {
            NSRange range = NSMakeRange(i * 4, (i + 1) * 4 > row.count ? row.count - i * 4 : 4);
            NSArray *filterArr = [row subarrayWithRange:range];
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self isEqual: %@", @"0"];
            NSArray *nodesArray = [filterArr filteredArrayUsingPredicate:predicate];
            
            if (nodesArray.count > 0) {
                NSString *levelStr = [row componentsJoinedByString:@","];
                [result addObject:levelStr];
            }
        }
    }
    
    NSArray *bstWithTrailingNulls = [[result componentsJoinedByString:@","] componentsSeparatedByString:@","];
    NSArray *bst = [self removeTrailingNulls:bstWithTrailingNulls];
    
    return [NSString stringWithFormat:@"[%@]", [bst componentsJoinedByString:@","]];
}

- (void)saveNodes:(Node *)node onLevel:(NSUInteger)currentLevel toArray:(Matrix *)matrix {
    while (matrix.count <= currentLevel)
        [matrix addObject:[NSMutableArray new]];
    
    NSMutableArray<NSString *> *currentRow = matrix[currentLevel];
    
    if (node != nil) {
        [currentRow addObject:@"0"];
        [self saveNodes:node.left onLevel:(currentLevel + 1) toArray:matrix];
        [self saveNodes:node.right onLevel:(currentLevel + 1) toArray:matrix];
    } else {
        [currentRow addObject:@"null"];
    }
}

- (NSArray *)removeTrailingNulls:(NSArray<NSString *> *)bst {
    NSMutableArray<NSString *> *result = [bst mutableCopy];
    
    while(true) {
        NSString *node = result[0];
        
        if ([node isEqualToString:@"null"]) {
            [result removeObjectAtIndex:0];
        } else {
            break;
        }
    }
    
    while(true) {
        NSUInteger lastIndex = result.count - 1;
        NSString *node = result[lastIndex];
        
        if ([node isEqualToString:@"null"]) {
            [result removeObjectAtIndex:lastIndex];
        } else {
            break;
        }
    }
    
    return result;
}

@end
