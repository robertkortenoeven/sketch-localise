//
//  StoreExportPanelSketchPanelCellDefault.h
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StoreExportPanelSketchPanelCell.h"

@interface StoreExportPanelSketchPanelCellDefault : StoreExportPanelSketchPanelCell

@property (nonatomic, weak) IBOutlet NSTextView *titleTextView;
@property (nonatomic, weak) IBOutlet NSImageView *imageView;

@end
