//
//  StoreExportPanelSketchPanelCellHeader.m
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import "StoreExportPanelSketchPanelCellHeader.h"

@implementation StoreExportPanelSketchPanelCellHeader

- (void)drawRect:(NSRect)frame {
    [super drawRect:frame];

    //// Color Declarations
    NSColor* inspectorSectionHeaderColor = [NSColor colorWithCalibratedRed: 0.973 green: 0.973 blue: 0.973 alpha: 1];
    NSColor* inspectorSectionHeaderColor2 = [NSColor colorWithCalibratedRed: 0.902 green: 0.902 blue: 0.902 alpha: 1];

    //// Gradient Declarations
    NSGradient* inspectorSectionHeader = [[NSGradient alloc] initWithStartingColor: inspectorSectionHeaderColor endingColor: inspectorSectionHeaderColor2];

    //// Rectangle Drawing
    NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(NSMinX(frame), NSMinY(frame), NSWidth(frame), NSHeight(frame))];
    [inspectorSectionHeader drawInBezierPath: rectanglePath angle: 0];

}

@end
