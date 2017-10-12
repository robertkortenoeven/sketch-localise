var onStartup = function(context) {
  var StoreExportPanel_FrameworkPath = StoreExportPanel_FrameworkPath || COScript.currentCOScript().env().scriptURL.path().stringByDeletingLastPathComponent().stringByDeletingLastPathComponent();
  var StoreExportPanel_Log = StoreExportPanel_Log || log;
  (function() {
    var mocha = Mocha.sharedRuntime();
    var frameworkName = "StoreExportPanel";
    var directory = StoreExportPanel_FrameworkPath;
    if (mocha.valueForKey(frameworkName)) {
      StoreExportPanel_Log("😎 loadFramework: `" + frameworkName + "` already loaded.");
      return true;
    } else if ([mocha loadFrameworkWithName:frameworkName inDirectory:directory]) {
      StoreExportPanel_Log("✅ loadFramework: `" + frameworkName + "` success!");
      mocha.setValue_forKey_(true, frameworkName);
      return true;
    } else {
      StoreExportPanel_Log("❌ loadFramework: `" + frameworkName + "` failed!: " + directory + ". Please define StoreExportPanel_FrameworkPath if you're trying to @import in a custom plugin");
      return false;
    }
  })();
};

var onSelectionChanged = function(context) {
  StoreExportPanel.onSelectionChanged(context);
};

