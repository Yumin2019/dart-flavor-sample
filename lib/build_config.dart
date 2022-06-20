
import 'package:flutter/foundation.dart';

enum Flavor {
  original,
  test,
  length,
}

class BuildConfig {
  static late final BuildConfig instance;
  factory BuildConfig() => instance;
  bool isDebug = kDebugMode;

  late final Flavor flavor;
  late final String strSiteMode;
  late final String strWebHost;
  late final bool isConstructive;
  late final bool isCloudActive;
  late final bool isRootingAllowed;
  late final bool isUpdateEnabled;
  late final bool useStoreUpdate;
  late final bool isUpdateForced;
  late final bool usePreviewMode;
  late final String strWebUpdateUrl;
  late final String strVersionUrl;
  late final String strSubVersion;

  static void initialize(Flavor flavor) {
    switch(flavor) {
      case Flavor.original:
        BuildConfig._init(
          flavor: flavor,
          strSiteMode: "main",
          strWebHost: "https://test.io",
          isConstructive: false,
          isCloudActive: false,
          isRootingAllowed: true,
          isUpdateEnabled: true,
          useStoreUpdate: true,
          isUpdateForced: false,
          usePreviewMode: false,
          strWebUpdateUrl:
          "https://play.google.com/store/apps/details?id=com.flavor.test",
          strVersionUrl: "https://www.test.com/",
          strSubVersion: "v1.0.3",
        );
        break;
      case Flavor.test:
        BuildConfig._init(
          flavor: flavor,
          strSiteMode: "test",
          strWebHost: "https://test.kr",
          isConstructive: true,
          isCloudActive: false,
          isRootingAllowed: true,
          isUpdateEnabled: true,
          useStoreUpdate: false,
          isUpdateForced: false,
          usePreviewMode: false,
          strWebUpdateUrl:
          "https://test.kr/",
          strVersionUrl: "https://www.test.co.kr/mobile/test/",
          strSubVersion: "v1.0.0",
        );
        break;
      case Flavor.length:
        break;
    }
  }

  BuildConfig._init({
      required this.flavor,
      required this.strSiteMode,
      required this.strWebHost,
      required this.isConstructive,
      required this.isCloudActive,
      required this.isRootingAllowed,
      required this.isUpdateEnabled,
      required this.useStoreUpdate,
      required this.isUpdateForced,
      required this.usePreviewMode,
      required this.strWebUpdateUrl,
      required this.strVersionUrl,
      required this.strSubVersion
  }) {
    BuildConfig.instance = this;
    print("======= Flavor =======  : " + flavor.name +
        "\n strSiteMode : " + strSiteMode +
        "\n strWebHost : " + strWebHost +
        "\n isConstructive : " + isConstructive.toString() +
        "\n isCloudActive : " + isCloudActive.toString() +
        "\n isRootingAllowed : " + isRootingAllowed.toString() +
        "\n isUpdateEnabled : " + isUpdateEnabled.toString() +
        "\n useStoreUpdate : " + useStoreUpdate.toString() +
        "\n isUpdateForced : " + isUpdateForced.toString() +
        "\n usePreviewMode : " + usePreviewMode.toString() +
        "\n strWebUpdateUrl : " + strWebUpdateUrl +
        "\n strVersionUrl : " + strVersionUrl +
        "\n strSubVersion : " + strSubVersion);
  }
}