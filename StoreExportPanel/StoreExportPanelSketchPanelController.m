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

@property (nonatomic, strong) NSMutableArray<NSURL *> *languages;

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


- (void) selectProjectFolder:(id)sender {
        // create an open documet panel
        NSOpenPanel *panel = [NSOpenPanel openPanel];
        [panel setCanChooseFiles:NO];
        [panel setCanChooseDirectories:YES];
        [panel setCanCreateDirectories:NO];
        [panel setTitle:@"Select a folder with Localizations"];
        
        // display the panel
        [panel beginWithCompletionHandler:^(NSInteger result) {
                if (result == NSModalResponseOK) {
                        
                        // grab a reference to what has been selected
                        NSURL *documentURL = [[panel URLs]objectAtIndex:0];
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
                        _languages = [NSMutableArray array];
                        
                        NSDirectoryEnumerator *enumerator = [fileManager
                                                             enumeratorAtURL:documentURL
                                                             includingPropertiesForKeys:keys
                                                             options:0
                                                             errorHandler:^(NSURL *url, NSError *error) {
                                                                     // Handle the error.
                                                                     // Return YES if the enumeration should continue after the error.
                                                                     return YES;
                                                             }];
                        
                        for (NSURL *url in enumerator) {
                                NSError *error;
                                NSNumber *isDirectory = nil;
                                if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                                        // handle error
                                }
                                else if ([isDirectory boolValue] && ![[url lastPathComponent] isEqualToString:@"Base.lproj"]) {
                                        // No error and it’s not a directory; do something with the file
                                        [_languages addObject:url];
                                        
                                        //for reading in the languages:
                                        //http://alejandromp.com/blog/2017/6/24/loading-translations-dynamically-generating-localized-string-runtime/
                                        // func NSLocalizedString(_ key: String, tableName: String? = default, bundle: Bundle = default, value: String = default, comment: String) -> String The two important new parameters are `tableName` and `bundle`. By default when using NSLocalizedString the system uses the App main bundle and the Localizable table, *table* meaning the name of the strings file. So to hook into the localization system we just need to convert the object structure that we have in memory to the proper file hierarchy that is expected on disk.
                                        
                                }
                        }
                        [self.panel reloadData];
                }
        }];
}

- (void) clearProjectFolder:(id)sender {
        _languages = nil;
        [self.panel reloadData];
}

- (void) startLocalisation:(id)sender {
        NSLog(@"Start localisation");
}

#pragma mark - StoreExportPanelSketchPanelDataSource

- (StoreExportPanelSketchPanelCell *)headerForStoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel {
        StoreExportPanelSketchPanelCellHeader *cell = (StoreExportPanelSketchPanelCellHeader *)[panel dequeueReusableCellForReuseIdentifier:@"header"];
        if ( ! cell) {
                cell = [StoreExportPanelSketchPanelCellHeader loadNibNamed:@"StoreExportPanelSketchPanelCellHeader"];
                cell.reuseIdentifier = @"header";
        }
        cell.titleLabel.stringValue = @"Localize Screens";
        return cell;
}

- (NSUInteger)numberOfRowsForStoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel {
        return 3;    // Using self.selection as number of rows in the panel
}

- (StoreExportPanelSketchPanelCell *)StoreExportPanelSketchPanel:(StoreExportPanelSketchPanel *)panel itemForRowAtIndex:(NSUInteger)index {
        
        if (index == 0) {
                StoreExportPanelSketchPanelCellSelectFolder *cell = (StoreExportPanelSketchPanelCellSelectFolder *)[panel dequeueReusableCellForReuseIdentifier:@"selectFolderCell"];
                if ( ! cell) {
                        cell = [StoreExportPanelSketchPanelCellSelectFolder loadNibNamed:@"StoreExportPanelSketchPanelCellSelectFolder"];
                        cell.reuseIdentifier = @"selectFolderCell";
                        cell.selectButton.title = _languages.count ? @"Clear" : @"Select…"; //check if localised file is selected
                        [cell.selectButton setAction:_languages.count ? @selector(clearProjectFolder:) : @selector(selectProjectFolder:)];
                        [cell.selectButton setTarget:self];
                }
                return cell;
        } else if (index == 1) {
                StoreExportPanelSketchPanelCellDefault *cell = (StoreExportPanelSketchPanelCellDefault *)[panel dequeueReusableCellForReuseIdentifier:@"layerCell"];
                if ( ! cell) {
                        cell = [StoreExportPanelSketchPanelCellDefault loadNibNamed:@"StoreExportPanelSketchPanelCellDefault"];
                        cell.reuseIdentifier = @"layerCell";
                }
                cell.titleTextView.string = _languages.count ? [NSString stringWithFormat:@"\n\nCreate %lu new pages with translated versions of the current page?", _languages.count] : @"Select the 'Localizations' folder for your project. This can usually be found in the 'Resources' folder for standard Xcode projects.";
                NSParagraphStyle* tStyle = [NSParagraphStyle defaultParagraphStyle];
                NSMutableParagraphStyle* tMutStyle = [tStyle mutableCopy];
                [tMutStyle setAlignment:NSTextAlignmentLeft];
                [cell.titleTextView setDefaultParagraphStyle:tMutStyle];
                [cell.titleTextView setHorizontallyResizable:YES];
                [cell.titleTextView
                 setAutoresizingMask:(NSViewWidthSizable|NSViewHeightSizable)];
                return cell;
        } else {
                StoreExportPanelSketchPanelCellStart *cell = (StoreExportPanelSketchPanelCellStart *)[panel dequeueReusableCellForReuseIdentifier:@"startLocaliseCell"];
                if ( ! cell) {
                        cell = [StoreExportPanelSketchPanelCellStart loadNibNamed:@"StoreExportPanelSketchPanelCellStart"];
                        cell.reuseIdentifier = @"startLocaliseCell";
                        cell.selectButton.title = @"Translate"; //check if localised file is selected
                        [cell.selectButton setAction:@selector(startLocalisation:)];
                        [cell.selectButton setTarget:self];
                        cell.selectButton.enabled = _languages.count;
                }
                return cell;
        }
        
        return nil;
}




@end
