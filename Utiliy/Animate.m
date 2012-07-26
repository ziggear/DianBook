#import "Animate.h"

@implementation Animate
-(NSArray *) initWithMySpriteFrameName:(int)page anim:(int)animationNum count:(int)count;
{
    arr = [NSMutableArray array];        
    for (int i = 1; i <= count; i++) {
        NSLog(@"%d_%d_00%d.png",page,animationNum,i);
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString  stringWithFormat:@"%d_%d_00%d.png",page,animationNum,i]];
        [arr addObject: frame];
    }    
    return (NSArray*)arr;
} 
@end