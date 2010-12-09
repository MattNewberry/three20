//
// Copyright 2009-2010 Facebook
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

#import "Three20UI/TTTableRightCaptionItemCell.h"

// UI
#import "Three20UI/TTTableCaptionItem.h"

// UICommon
#import "Three20UICommon/TTGlobalUICommon.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"
#import "Three20Style/UIFontAdditions.h"

#import "Three20UI/UIViewAdditions.h"
#import "Three20UI/UITableViewAdditions.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableRightCaptionItemCell

static const CGFloat kKeySpacing = 12;
static const CGFloat kKeyWidth = 100;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
  if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
      
      self.textLabel.font = TTSTYLEVAR(tableTitleFont);
      self.textLabel.textColor = TTSTYLEVAR(linkTextColor);
      self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
      self.textLabel.textAlignment = UITextAlignmentLeft;
      self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
      self.textLabel.numberOfLines = 1;
      self.textLabel.adjustsFontSizeToFitWidth = YES;
      self.textLabel.backgroundColor = [UIColor clearColor];
      
      self.detailTextLabel.font = TTSTYLEVAR(tableSmallFont);
      self.detailTextLabel.textColor = TTSTYLEVAR(detailTextColor);
      self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
      self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
      self.detailTextLabel.minimumFontSize = 8;
      self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
      self.detailTextLabel.numberOfLines = 0;
      self.detailTextLabel.backgroundColor = [UIColor clearColor];

    // XXXjoe TODO
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	TTTableCaptionItem* item = object;
	
	CGFloat margin = [tableView tableCellMargin];
	CGFloat width = tableView.width - (kKeyWidth + kKeySpacing + kTableCellHPadding*2 + margin*2);
	
	CGSize detailTextSize = [item.text sizeWithFont:TTSTYLEVAR(tableSmallFont)
								  constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
									  lineBreakMode:UILineBreakModeWordWrap];
	
	CGFloat suggestedSize = detailTextSize.height + kTableCellVPadding*2;
	
	return suggestedSize < 44 ? 44 : suggestedSize;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.textLabel.frame = CGRectMake(kTableCellHPadding, kTableCellVPadding,
									  kKeyWidth, self.textLabel.font.ttLineHeight);
	
	CGFloat valueWidth = self.contentView.width - (kTableCellHPadding*2 + kKeyWidth + kKeySpacing);
	CGFloat innerHeight = self.contentView.height - kTableCellVPadding*2;
	self.detailTextLabel.frame = CGRectMake(kTableCellHPadding + kKeyWidth + kKeySpacing,
											kTableCellVPadding,
											valueWidth, innerHeight);
	
	if([_item.URL length] == 0)
		self.accessoryView = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		TTTableCaptionItem* item = object;
		self.textLabel.text = item.caption;
		self.detailTextLabel.text = item.text;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)captionLabel {
  return self.textLabel;
}


@end
