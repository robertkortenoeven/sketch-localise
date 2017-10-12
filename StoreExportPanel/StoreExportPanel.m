//
//  StoreExportPanel.m
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreExportPanel.h"
#import <CocoaScript/COScript.h>
#import "StoreExportPanelSketchPanelController.h"
@import JavaScriptCore;
#import <Mocha/Mocha.h>
#import <Mocha/MOClosure.h>
#import <Mocha/MOJavaScriptObject.h>
#import <Mocha/MochaRuntime_Private.h>


@interface StoreExportPanel : NSObject

@property (nonatomic, strong) StoreExportPanelSketchPanelController *panelController;
@property (nonatomic, strong) id <StoreExportPanelMSDocument> document;
@property (nonatomic, copy) NSString *panelControllerClassName;
@property (nonatomic, strong) NSDictionary *pluginContext;

+ (instancetype)onSelectionChanged:(id)context;
- (void)onSelectionChange:(NSArray *)selection;
+ (void)setSharedCommand:(id)command;

@end



@implementation StoreExportPanel

static id _command;

+ (void)setSharedCommand:(id)command {
    _command = command;
}

+ (id)sharedCommand {
    return _command;
}

+ (instancetype)onSelectionChanged:(id)context {

//    COScript *coscript = [COScript currentCOScript];
    id <StoreExportPanelMSDocument> document = [context valueForKeyPath:@"actionContext.document"];
    if ( ! [document isKindOfClass:NSClassFromString(@"MSDocument")]) {
        document = nil;  // be safe
        return nil;
    }

    if ( ! [self sharedCommand]) {
        [self setSharedCommand:[context valueForKeyPath:@"command"]]; // MSPluginCommand
    }

    NSString *key = [NSString stringWithFormat:@"%@-StoreExportPanel", [document description]];
    __block StoreExportPanel *instance = [[Mocha sharedRuntime] valueForKey:key];

    if ( ! instance) {
//        [coscript setShouldKeepAround:YES];
        instance = [[self alloc] initWithDocument:document];
        [[Mocha sharedRuntime] setValue:instance forKey:key];
    }
    instance.pluginContext = context;

    NSArray *selection = [context valueForKeyPath:@"actionContext.document.selectedLayers"];
//    NSLog(@"selection %p %@ %@", instance, key, selection);
    [instance onSelectionChange:selection];
    return instance;
}

- (instancetype)initWithDocument:(id <StoreExportPanelMSDocument>)document {
    if (self = [super init]) {
        _document = document;
        _panelController = [[StoreExportPanelSketchPanelController alloc] initWithDocument:_document];
    }
    return self;
}

- (void)onSelectionChange:(NSArray *)selection {
    _panelController.pluginContext = _pluginContext;
    [_panelController selectionDidChange:selection];
}

@end
