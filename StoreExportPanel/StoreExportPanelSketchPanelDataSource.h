//
//  StoreExportPanelSketchPanelDataSource.h
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoreExportPanelSketchPanel;
@class StoreExportPanelSketchPanelCell;

@protocol StoreExportPanelSketchPanelDataSource <NSObject>

- (NSUInteger)numberOfRowsForStoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel;
- (StoreExportPanelSketchPanelCell *)StoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel itemForRowAtIndex:(NSUInteger)index;
- (StoreExportPanelSketchPanelCell *)headerForStoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel;

@end
