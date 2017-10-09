//
//  StoreExportPanelMSInspectorStackView.h
//  WeLiveLikeThis-Store-Export
//
//  Created by Robert Kortenoeven on 09.10.17.
//Copyright © 2017 WeLiveLikeThis. All rights reserved.
//

#ifndef StoreExportPanelMSInspectorStackView_h
#define StoreExportPanelMSInspectorStackView_h

@protocol StoreExportPanelMSInspectorStackView <NSObject>

@property (nonatomic, strong) NSArray *sectionViewControllers;
- (void)reloadWithViewControllers:(NSArray *)controllers;

@end

#endif /* StoreExportPanelMSInspectorStackView_h */
