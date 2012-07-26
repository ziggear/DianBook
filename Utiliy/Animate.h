#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Animate:NSObject
{
   NSMutableArray *arr;}

-(NSArray *) initWithMySpriteFrameName:(int)page anim:(int)animationNum count:(int)count;
@end
