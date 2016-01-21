#import "NSString+QCKSelectorName.h"

@implementation NSString (QCKSelectorName)

- (NSString *)qck_selectorName {
    static NSMutableCharacterSet *invalidCharacters = nil;
    static NSString *separator = @"_";
    static NSCharacterSet *separatorSet = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        separatorSet = [NSCharacterSet characterSetWithCharactersInString:separator];
        invalidCharacters = [NSMutableCharacterSet new];

        NSCharacterSet *whitespaceCharacterSet = [NSCharacterSet whitespaceCharacterSet];
        NSCharacterSet *newlineCharacterSet = [NSCharacterSet newlineCharacterSet];
        NSCharacterSet *illegalCharacterSet = [NSCharacterSet illegalCharacterSet];
        NSCharacterSet *controlCharacterSet = [NSCharacterSet controlCharacterSet];
        NSCharacterSet *punctuationCharacterSet = [NSCharacterSet punctuationCharacterSet];
        NSCharacterSet *nonBaseCharacterSet = [NSCharacterSet nonBaseCharacterSet];
        NSCharacterSet *symbolCharacterSet = [NSCharacterSet symbolCharacterSet];

        [invalidCharacters formUnionWithCharacterSet:whitespaceCharacterSet];
        [invalidCharacters formUnionWithCharacterSet:newlineCharacterSet];
        [invalidCharacters formUnionWithCharacterSet:illegalCharacterSet];
        [invalidCharacters formUnionWithCharacterSet:controlCharacterSet];
        [invalidCharacters formUnionWithCharacterSet:punctuationCharacterSet];
        [invalidCharacters formUnionWithCharacterSet:nonBaseCharacterSet];
        [invalidCharacters formUnionWithCharacterSet:symbolCharacterSet];
    });

    NSArray *validComponents = [self componentsSeparatedByCharactersInSet:invalidCharacters];

    NSString *selector = [validComponents componentsJoinedByString:separator];
    selector = [selector stringByTrimmingCharactersInSet:separatorSet];
    if ([selector length] == 0) {
        selector = @"blank";
    }

    return selector;
}

@end
