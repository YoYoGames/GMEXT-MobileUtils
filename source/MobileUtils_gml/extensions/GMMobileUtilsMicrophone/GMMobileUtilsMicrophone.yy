{
  "$GMExtension": "",
  "%Name": "GMMobileUtilsMicrophone",
  "androidactivityinject": null,
  "androidclassname": "GMMobileUtilsMicrophone",
  "androidcodeinjection": "",
  "androidinject": null,
  "androidmanifestinject": null,
  "androidPermissions": [
    "android.permission.RECORD_AUDIO"
  ],
  "androidProps": true,
  "androidsourcedir": "",
  "author": "",
  "classname": "GMMobileUtilsMicrophone",
  "copyToTargets": 12,
  "description": "",
  "exportToGame": true,
  "extensionVersion": "0.0.1",
  "files": [
    {
      "$GMExtensionFile": "v1",
      "%Name": "",
      "constants": [],
      "copyToTargets": -1,
      "filename": "GMMobileUtilsMicrophone.ext",
      "final": "",
      "functions": [
        {
          "$GMExtensionFunction": "",
          "%Name": "mobile_utils_mic_request",
          "argCount": 0,
          "args": [],
          "documentation": "@returns {Real}",
          "externalName": "__EXT_NATIVE__mobile_utils_mic_request",
          "help": "",
          "hidden": false,
          "kind": 4,
          "name": "mobile_utils_mic_request",
          "resourceType": "GMExtensionFunction",
          "resourceVersion": "2.0",
          "returnType": 2
        },
        {
          "$GMExtensionFunction": "",
          "%Name": "__mobile_utils_mic_check",
          "argCount": 2,
          "args": [
            1,
            2
          ],
          "documentation": "@param {Pointer} _arg_buffer\r\n@param {Real} _arg_buffer_length\r\n@returns {Real}",
          "externalName": "__EXT_NATIVE__mobile_utils_mic_check",
          "help": "",
          "hidden": true,
          "kind": 4,
          "name": "__mobile_utils_mic_check",
          "resourceType": "GMExtensionFunction",
          "resourceVersion": "2.0",
          "returnType": 2
        },
        {
          "$GMExtensionFunction": "",
          "%Name": "__GMMobileUtilsMicrophone_invocation_handler",
          "argCount": 2,
          "args": [
            1,
            2
          ],
          "documentation": "@param {Pointer} _buffer_ptr\r\n@param {Real} _buffer_size",
          "externalName": "__EXT_NATIVE__GMMobileUtilsMicrophone_invocation_handler",
          "help": "",
          "hidden": true,
          "kind": 4,
          "name": "__GMMobileUtilsMicrophone_invocation_handler",
          "resourceType": "GMExtensionFunction",
          "resourceVersion": "2.0",
          "returnType": 2
        }
      ],
      "init": "",
      "kind": 4,
      "name": "",
      "origname": "",
      "ProxyFiles": [],
      "resourceType": "GMExtensionFile",
      "resourceVersion": "2.0",
      "uncompress": false,
      "usesRunnerInterface": false
    }
  ],
  "gradleinject": null,
  "hasConvertedCodeInjection": true,
  "helpfile": "",
  "HTML5CodeInjection": "",
  "html5Props": false,
  "IncludedResources": [],
  "installdir": "",
  "iosCocoaPodDependencies": "",
  "iosCocoaPods": "",
  "ioscodeinjection": "\r\n\u003CYYIosPlist\u003E\r\n\u003Ckey\u003ENSMicrophoneUsageDescription\u003C/key\u003E\r\n\u003Cstring\u003E${YYEXTOPT_GMMobileUtilsMicrophone_iosMicAccessDesc}\u003C/string\u003E\r\n\u003C/YYIosPlist\u003E",
  "iosdelegatename": "",
  "iosplistinject": null,
  "iosProps": true,
  "iosSystemFrameworkEntries": [
    {
      "$GMExtensionFrameworkEntry": "",
      "%Name": "AVFoundation.framework",
      "embed": 0,
      "name": "AVFoundation.framework",
      "resourceType": "GMExtensionFrameworkEntry",
      "resourceVersion": "2.0",
      "weakReference": false
    }
  ],
  "iosThirdPartyFrameworkEntries": [
    {
      "$GMExtensionFrameworkEntry": "",
      "%Name": "GMMobileUtilsMicrophone.xcframework",
      "embed": 0,
      "name": "GMMobileUtilsMicrophone.xcframework",
      "resourceType": "GMExtensionFrameworkEntry",
      "resourceVersion": "2.0",
      "weakReference": false
    }
  ],
  "license": "",
  "maccompilerflags": "",
  "maclinkerflags": "-ObjC",
  "macsourcedir": "",
  "name": "GMMobileUtilsMicrophone",
  "options": [
    {
      "$GMExtensionOption": "",
      "%Name": "__extOptLabel",
      "defaultValue": "iOS CONFIG",
      "description": "",
      "displayName": "",
      "exportToINI": false,
      "extensionId": null,
      "guid": "90a56faf-ac79-4349-8513-07a62754daf4",
      "hidden": false,
      "listItems": [],
      "name": "__extOptLabel",
      "optType": 5,
      "resourceType": "GMExtensionOption",
      "resourceVersion": "2.0"
    },
    {
      "$GMExtensionOption": "",
      "%Name": "iosMicAccessDesc",
      "defaultValue": "This app needs microphone access for voice chat.",
      "description": "",
      "displayName": "Mic Access Description",
      "exportToINI": false,
      "extensionId": null,
      "guid": "9cd895cd-d227-4cd4-8b30-dfb7f6bddb26",
      "hidden": false,
      "listItems": [],
      "name": "iosMicAccessDesc",
      "optType": 2,
      "resourceType": "GMExtensionOption",
      "resourceVersion": "2.0"
    }
  ],
  "optionsFile": "options.json",
  "packageId": "",
  "parent": {
    "name": "Microphone",
    "path": "folders/MobileUtils/Extensions/Microphone.yy"
  },
  "productId": "",
  "resourceType": "GMExtension",
  "resourceVersion": "2.0",
  "sourcedir": "",
  "supportedTargets": -1,
  "tvosclassname": null,
  "tvosCocoaPodDependencies": "",
  "tvosCocoaPods": "",
  "tvoscodeinjection": "",
  "tvosdelegatename": null,
  "tvosmaccompilerflags": "",
  "tvosmaclinkerflags": "",
  "tvosplistinject": null,
  "tvosProps": false,
  "tvosSystemFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": []
}