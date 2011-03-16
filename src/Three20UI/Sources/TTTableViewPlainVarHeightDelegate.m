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

#import "Three20UI/TTTableViewPlainVarHeightDelegate.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

#import "Three20UI/TTView.h"
#import "Three20UI/TTSectionedDataSource.h"
#import "Three20UI/UINSObjectAdditions.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTableViewPlainVarHeightDelegate

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	tableView.sectionHeaderHeight = 28;
	TTView *headerView = [[TTView alloc] initWithFrame:CGRectMake(0, 0, 320, tableView.sectionHeaderHeight)];
	headerView.style = TTSTYLE(tableHeader);
	
	TTSectionedDataSource *datasource = (TTSectionedDataSource *) tableView.dataSource;
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, tableView.sectionHeaderHeight)];
	label.backgroundColor = [UIColor clearColor];
	label.text = [datasource tableView:tableView titleForHeaderInSection:section];
	label.font = TTSTYLEVAR(tableHeaderPlainFont);
	label.textColor = TTSTYLEVAR(tableHeaderTextColor);
	[headerView addSubview:label];
	[label release];
	
	return [headerView autorelease];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	[super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
	
	id<TTTableViewDataSource> dataSource = (id<TTTableViewDataSource>)tableView.dataSource;
	id item = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    
	if([[item URLValue] length] == 0)
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	else{
		cell.selectionStyle = TTSTYLEVAR(tableSelectionStyle);
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
}

@end
