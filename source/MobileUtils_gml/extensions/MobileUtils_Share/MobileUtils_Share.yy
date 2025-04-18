{
  "$GMExtension":"",
  "%Name":"MobileUtils_Share",
  "androidactivityinject":"",
  "androidclassname":"MobileUtils_Share",
  "androidcodeinjection":"<YYAndroidGradleDependencies>\r\n\r\nandroid {\r\n    lintOptions {\r\n        abortOnError false\r\n    }\r\n}\r\n</YYAndroidGradleDependencies>\r\n\r\n<YYAndroidManifestActivityInject>\r\n\r\n<intent-filter>\r\n                    <action\r\n                        android:name=\"android.intent.action.PICK\"/>\r\n                    <category\r\n                        android:name=\"android.intent.category.DEFAULT\"/>\r\n                    <category\r\n                        android:name=\"android.intent.category.OPENABLE\"/>\r\n                    <data android:mimeType=\"text/*\"/>\r\n                    <data android:mimeType=\"image/*\"/>\r\n                </intent-filter>\r\n\r\n</YYAndroidManifestActivityInject>\r\n\r\n\r\n<YYAndroidManifestManifestInject>\r\n\r\n<uses-permission\r\n    android:name=\"android.permission.WRITE_EXTERNAL_STORAGE\"\r\n    tools:remove=\"android:maxSdkVersion\"/>\r\n\r\n</YYAndroidManifestManifestInject>\r\n\r\n<YYAndroidManifestApplicationAttributes_>\r\nandroid:requestLegacyExternalStorage=\"true\"\r\n</YYAndroidManifestApplicationAttributes_>\r\n\r\n<YYAndroidManifestApplicationInject>\r\n<provider\r\n    android:name=\"androidx.core.content.FileProvider\"\r\n    android:authorities=\"${YYAndroidPackageName}.fileprovider\"\r\n    android:exported=\"false\"\r\n    android:grantUriPermissions=\"true\">\r\n    <meta-data\r\n        android:name=\"android.support.FILE_PROVIDER_PATHS\"\r\n        android:resource=\"@xml/file_paths\" />\r\n</provider>\r\n</YYAndroidManifestApplicationInject>\r\n",
  "androidinject":"\r\n<provider android:name=\"androidx.core.content.FileProvider\" android:authorities=\"${YYAndroidPackageName}\" android:exported=\"false\" android:grantUriPermissions=\"true\">\r\n    <meta-data android:name=\"android.support.FILE_PROVIDER_PATHS\" android:resource=\"@xml/file_provider_paths_share\"></meta-data>\r\n</provider>\r\n",
  "androidmanifestinject":"\r\n\r\n<uses-permission android:name=\"android.permission.WRITE_EXTERNAL_STORAGE\" tools:remove=\"android:maxSdkVersion\"></uses-permission>\r\n\r\n",
  "androidPermissions":[],
  "androidProps":true,
  "androidsourcedir":"",
  "author":"",
  "classname":"MobileUtils_Share",
  "copyToTargets":12,
  "description":"",
  "exportToGame":true,
  "extensionVersion":"1.0.7",
  "files":[
    {"$GMExtensionFile":"","%Name":"Share.ext","constants":[],"copyToTargets":52777614151918,"filename":"Share.ext","final":"","functions":[
        {"$GMExtensionFunction":"","%Name":"MobileUtils_Share_Open","argCount":2,"args":[1,1,1,],"documentation":"","externalName":"MobileUtils_Share_Open","help":"MobileUtils_Share_Open(title,path,MIME)","hidden":false,"kind":11,"name":"MobileUtils_Share_Open","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
      ],"init":"","kind":4,"name":"Share.ext","order":[
        {"name":"MobileUtils_Share_Open","path":"extensions/MobileUtils_Share/MobileUtils_Share.yy",},
      ],"origname":"extensions\\Share.ext","ProxyFiles":[],"resourceType":"GMExtensionFile","resourceVersion":"2.0","uncompress":false,"usesRunnerInterface":false,},
  ],
  "gradleinject":"\r\n\r\nandroid {\r\n    lintOptions {\r\n        abortOnError false\r\n    }\r\n}\r\n",
  "hasConvertedCodeInjection":true,
  "helpfile":"",
  "HTML5CodeInjection":"",
  "html5Props":false,
  "IncludedResources":[
    "Sprites\\Share\\sprite2",
    "Sprites\\Share\\sprite1",
    "Sprites\\Share\\sprite4",
    "Sprites\\Share\\sprite5",
    "Sprites\\Share\\sprite3",
    "Backgrounds\\Share\\background0",
    "Objects\\Share\\Obj_Share_Text",
    "Objects\\Share\\Obj_Share_Sprite",
    "Objects\\Share\\Obj_Create_Share",
    "Objects\\Share\\Obj_SharePictureImage_Parent",
    "Objects\\Share\\Obj_SharePictureImage_H",
    "Objects\\Share\\Obj_SharePictureImage_V",
    "Rooms\\Share\\room0",
  ],
  "installdir":"",
  "iosCocoaPodDependencies":"",
  "iosCocoaPods":"",
  "ioscodeinjection":"<YYIosPlist>\r\n<key>NSPhotoLibraryAddUsageDescription</key>\r\n<string>Necesary permission if you want save the share image on your device</string>\r\n</YYIosPlist>\r\n\r\n",
  "iosdelegatename":null,
  "iosplistinject":"\r\n<key>NSPhotoLibraryAddUsageDescription</key>\r\n<string>Necesary permission if you want save the share image on your device</string>\r\n",
  "iosProps":true,
  "iosSystemFrameworkEntries":[],
  "iosThirdPartyFrameworkEntries":[],
  "license":"Free to use, also for commercial games.",
  "maccompilerflags":"",
  "maclinkerflags":"",
  "macsourcedir":"",
  "name":"MobileUtils_Share",
  "options":[],
  "optionsFile":"options.json",
  "packageId":"com.Kaguva.ShareImage",
  "parent":{
    "name":"Extensions",
    "path":"folders/MobileUtils/Extensions.yy",
  },
  "productId":"F87F1752EF5676078DB4BED8477B99A8",
  "resourceType":"GMExtension",
  "resourceVersion":"2.0",
  "sourcedir":"",
  "supportedTargets":105554172285166,
  "tvosclassname":null,
  "tvosCocoaPodDependencies":"",
  "tvosCocoaPods":"",
  "tvoscodeinjection":"",
  "tvosdelegatename":null,
  "tvosmaccompilerflags":null,
  "tvosmaclinkerflags":null,
  "tvosplistinject":"",
  "tvosProps":false,
  "tvosSystemFrameworkEntries":[],
  "tvosThirdPartyFrameworkEntries":[],
}