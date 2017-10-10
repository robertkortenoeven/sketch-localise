//
//  StoreExportPanelSketchPanelController.m
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import "StoreExportPanelSketchPanelController.h"
#import "StoreExportPanelSketchPanelCell.h"
#import "StoreExportPanelSketchPanelCellHeader.h"
#import "StoreExportPanelSketchPanelCellDefault.h"
#import "StoreExportPanelSketchPanelCellSelectFolder.h"
#import "StoreExportPanelSketchPanelCellStart.h"
#import "StoreExportPanelSketchPanel.h"
#import "StoreExportPanelSketchPanelDataSource.h"


@interface StoreExportPanelSketchPanelController ()

@property (nonatomic, strong) id <StoreExportPanelMSInspectorStackView> stackView; // MSInspectorStackView
@property (nonatomic, strong) id <StoreExportPanelMSDocument> document;
@property (nonatomic, strong) StoreExportPanelSketchPanel *panel;
@property (nonatomic, copy) NSArray *selection;

@end

@implementation StoreExportPanelSketchPanelController

- (instancetype)initWithDocument:(id <StoreExportPanelMSDocument>)document {
    if (self = [super init]) {
        _document = document;
        _panel = [[StoreExportPanelSketchPanel alloc] initWithStackView:nil];
        _panel.datasource = self;
    }
    return self;
}

- (void)selectionDidChange:(NSArray *)selection {
    self.selection = [selection valueForKey:@"layers"];         // To get NSArray from MSLayersArray

    self.panel.stackView = [(NSObject *)_document valueForKeyPath:@"inspectorController.currentController.stackView"];
    [self.panel reloadData];
}

#pragma mark - StoreExportPanelSketchPanelDataSource

- (StoreExportPanelSketchPanelCell *)headerForStoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel {
    StoreExportPanelSketchPanelCellHeader *cell = (StoreExportPanelSketchPanelCellHeader *)[panel dequeueReusableCellForReuseIdentifier:@"header"];
    if ( ! cell) {
        cell = [StoreExportPanelSketchPanelCellHeader loadNibNamed:@"StoreExportPanelSketchPanelCellHeader"];
        cell.reuseIdentifier = @"header";
    }
    cell.titleLabel.stringValue = @"Localise";
    return cell;
}

- (NSUInteger)numberOfRowsForStoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel {
    return 3;    // Using self.selection as number of rows in the panel
}

- (StoreExportPanelSketchPanelCell *)StoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel itemForRowAtIndex:(NSUInteger)index {
    id layer = self.selection[index];

    if (index == 0) {
        StoreExportPanelSketchPanelCellSelectFolder *cell = (StoreExportPanelSketchPanelCellSelectFolder *)[panel dequeueReusableCellForReuseIdentifier:@"selectFolderCell"];
        if ( ! cell) {
            cell = [StoreExportPanelSketchPanelCellSelectFolder loadNibNamed:@"StoreExportPanelSketchPanelCellSelectFolder"];
            cell.reuseIdentifier = @"selectFolderCell";
            cell.selectButton.stringValue = @"Select…"; //check if localised file is selected
        }
        return cell;
    } else if (index == 1) {
        StoreExportPanelSketchPanelCellDefault *cell = (StoreExportPanelSketchPanelCellDefault *)[panel dequeueReusableCellForReuseIdentifier:@"layerCell"];
        if ( ! cell) {
            cell = [StoreExportPanelSketchPanelCellDefault loadNibNamed:@"StoreExportPanelSketchPanelCellDefault"];
            cell.reuseIdentifier = @"layerCell";
        }
        cell.titleTextView.string = [NSString stringWithFormat:@"%lu artboards selected", (unsigned long)[self.selection count]];
        cell.imageView.image = [layer valueForKeyPath:@"previewImages.LayerListPreviewUnfocusedImage"];
        return cell;
    } else { 
        StoreExportPanelSketchPanelCellStart *cell = (StoreExportPanelSketchPanelCellStart *)[panel dequeueReusableCellForReuseIdentifier:@"startLocaliseCell"];
        if ( ! cell) {
            cell = [StoreExportPanelSketchPanelCellStart loadNibNamed:@"StoreExportPanelSketchPanelCellStart"];
            cell.reuseIdentifier = @"startLocaliseCell";
            cell.selectButton.stringValue = @"Confirm"; //check if localised file is selected
        }
        return cell;
    }
    
    return nil;
}

@end
