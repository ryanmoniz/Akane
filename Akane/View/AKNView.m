//
// This file is part of Akkane
//
// Created by JC on 02/01/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

#import "AKNView.h"
#import "AKNViewModel.h"
#import <EventListener.h>

@implementation AKNView

- (void)setViewModel:(id<AKNViewModel>)viewModel {
    if (_viewModel == viewModel) {
        return;
    }

    _viewModel = viewModel;
    _viewModel.nextDispatcher = (id<EVEEventDispatcher>)self.nextResponder;
    [self configure];
}

- (void)configure {
    // Default implementation do nothing
}

- (id<EVEEventDispatcher>)nextDispatcher {
    return self.viewModel ?: (id<EVEEventDispatcher>)self.nextResponder;
}

- (void)didMoveToSuperview {
	if (self.nextResponder) {
   		_viewModel.nextDispatcher = (id<EVEEventDispatcher>)self.nextResponder;
	}
}

@end
