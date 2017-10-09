//
//  StoreExportPanelSketchPanel.h
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreExportPanelSketchPanelDataSource.h"
#import "StoreExportPanelMSInspectorStackView.h"

@class StoreExportPanelSketchPanelCell;

@interface StoreExportPanelSketchPanel : NSObject

@property (nonatomic, strong, readonly) NSArray *views;
@property (nonatomic, weak) id <StoreExportPanelMSInspectorStackView> stackView;
@property (nonatomic, weak) id <StoreExportPanelSketchPanelDataSource> datasource;

- (instancetype)initWithStackView:(id <StoreExportPanelMSInspectorStackView>)stackView;
- (void)reloadData;
- (StoreExportPanelSketchPanelCell *)dequeueReusableCellForReuseIdentifier:(NSString *)identifier;

@end
