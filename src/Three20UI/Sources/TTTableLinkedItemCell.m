//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20UI/TTTableLinkedItemCell.h"

// UI
#import "Three20UI/TTNavigator.h"
#import "Three20UI/TTTableLinkedItem.h"
#import "Three20UI/UINSObjectAdditions.h"

// UINavigator
#import "Three20UINavigator/TTURLMap.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableLinkedItemCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_item);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)object {
  return _item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[_item release];
		_item = [object retain];
		
		TTTableLinkedItem* item = object;
		self.textLabel.font = TTSTYLEVAR(tableTitleFont);
        
		if ([item.URLValue length] > 0) {
			TTNavigationMode navigationMode = [[TTNavigator navigator].URLMap
											   navigationModeForURL:item.URL];
			if (item.accessoryURL) {
				self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
				
			} else if (navigationMode == TTNavigationModeCreate ||
					   navigationMode == TTNavigationModeShare) {
				//self.accessoryView = DETAIL_ICON;
				self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				
			} else {
				self.accessoryType = UITableViewCellAccessoryNone;
			}
			
			self.selectionStyle = TTSTYLEVAR(tableSelectionStyle);
			
		} else {
			self.accessoryType = UITableViewCellAccessoryNone;
			//self.selectionStyle = UITableViewCellSelectionStyleNone;
		}
	}
}


@end
