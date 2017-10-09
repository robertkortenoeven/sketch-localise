//
//  StoreExportPanelSketchPanelCell.h
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class StoreExportPanelSketchPanelCell;

@interface StoreExportPanelSketchPanelCell : NSView

@property (nonatomic, copy) NSString *reuseIdentifier;

+ (instancetype)loadNibNamed:(NSString *)nibName;

@end
