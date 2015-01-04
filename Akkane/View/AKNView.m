//
// This file is part of Akkane
//
// Created by JC on 02/01/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

#import "AKNView.h"
#import "AKNViewContext.h"

@implementation AKNView

- (void)setContext:(id<AKNViewContext>)context {
    if (context == _context)
        return;

    _context = context;
    [self configure];
}

- (void)configure {
    // Default implementation do nothing
}

- (void)bindContext:(id<AKNViewContext>)subcontext to:(UIView<AKNViewContextAware> *)subview {
    if (![subview isDescendantOfView:self]) {
        return;
    }

    [subcontext setupView:subview];
    [self.context didSetupContext:subcontext];
}

@end