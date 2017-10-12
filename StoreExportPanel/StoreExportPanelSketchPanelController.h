//
//  StoreExportPanelSketchPanelController.h
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

@import Cocoa;
#import "StoreExportPanelMSDocument.h"
#import "StoreExportPanelMSInspectorStackView.h"
#import "StoreExportPanelSketchPanelDataSource.h"
@class StoreExportPanelSketchPanel;

@interface StoreExportPanelSketchPanelController : NSObject <StoreExportPanelSketchPanelDataSource>

@property (nonatomic, strong, readonly) id <StoreExportPanelMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, strong, readonly) id <StoreExportPanelMSDocument> document;
@property (nonatomic, strong, readonly) StoreExportPanelSketchPanel *panel;
@property (nonatomic, strong) NSDictionary *pluginContext;

- (instancetype)initWithDocument:(id <StoreExportPanelMSDocument>)document;
- (void)selectionDidChange:(NSArray *)selection;

@end
