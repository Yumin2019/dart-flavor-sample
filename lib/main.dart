import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:untitled1/build_config.dart';

class DartDefines {
  //  Flavor 정보(BuildConfig 초기화 용도)
  static const flavor = String.fromEnvironment("FLAVOR", defaultValue: "original");

  // SITE 정보(회사별 구분 정보)
  static const site = String.fromEnvironment("SITE", defaultValue: "original");

  // 다트 코드 난독화 여부
  static const isObfuscated = String.fromEnvironment("IS_OBFUSCATED", defaultValue: "true");

  // 앱 아이디(패키지명)
  static const iosBundleId = String.fromEnvironment("IOS_BUNDLE_ID", defaultValue: "com.flavor.original");
  static const aosApplicationId = String.fromEnvironment("AOS_APPLICATION_ID", defaultValue: "com.flavor.original");

  // 출력되는 버전 정보
  static const iosBundleShortVersionString = String.fromEnvironment("IOS_BUNDLE_SHORT_VERSION_STRING", defaultValue: "1");
  static const aosVersionName = String.fromEnvironment("AOS_VERSION_NAME", defaultValue: "1.000");

  // 빌드 버전 정보
  static const iosBundleVersion = String.fromEnvironment("IOS_BUNDLE_VERSION", defaultValue: "1.0.0");
  static const aosVersionCode = String.fromEnvironment("AOS_VERSION_CODE", defaultValue: "1");

  // 앱 이름
  static const iosBundleName = String.fromEnvironment("IOS_BUNDLE_NAME", defaultValue: "original");
  static const aosAppName = String.fromEnvironment("AOS_APP_NAME", defaultValue: "original");

  // 스킴정보
  static const iosBundleUrlSchemes = String.fromEnvironment("IOS_BUNDLE_URL_SCHEMES", defaultValue: "test");
  static const aosScheme = String.fromEnvironment("AOS_SCHEME", defaultValue: "test");

  // 앱 스토어 식별 정보
  static const iosAppStoreId = String.fromEnvironment("IOS_APP_STORE_ID", defaultValue: "");

  // 사이닝 컨피그 정보
  static const aosKeyAlias = String.fromEnvironment("AOS_KEY_ALIAS", defaultValue: "test");
  static const aosKeyPassword = String.fromEnvironment("AOS_KEY_PASSWORD", defaultValue: "test");
  static const aosStoreFile = String.fromEnvironment("AOS_STORE_FILE", defaultValue: ".keystore");
  static const aosStorePassword = String.fromEnvironment("AOS_STORE_PASSWORD", defaultValue: "test");

  static void printInfo() {
    print("======= DartDefines ======="
        "\n FLAVOR : " + flavor +
        "\n SITE : " + site +
        "\n IS_OBFUSCATED : " + isObfuscated +
        "\n IOS_BUNDLE_ID : " + iosBundleId +
        "\n AOS_APPLICATION_ID : " + aosApplicationId +
        "\n IOS_BUNDLE_SHORT_VERSION_STRING : " + iosBundleShortVersionString +
        "\n AOS_VERSION_NAME : " + aosVersionName +
        "\n IOS_BUNDLE_VERSION : " + iosBundleVersion +
        "\n AOS_VERSION_CODE : " + aosVersionCode +
        "\n IOS_BUNDLE_NAME : " + iosBundleName +
        "\n AOS_APP_NAME : " + aosAppName +
        "\n IOS_BUNDLE_URL_SCHEMES : " + iosBundleUrlSchemes +
        "\n AOS_SCHEME : " + aosScheme +
        "\n IOS_APP_STORE_ID : " + iosAppStoreId +
        "\n AOS_KEY_ALIAS : " + aosKeyAlias +
        "\n AOS_KEY_PASSWORD : " + aosKeyPassword +
        "\n AOS_STORE_FILE : " + aosStoreFile +
        "\n AOS_STORE_PASSWORD : " + aosStorePassword
    );
  }
}

late PackageInfo packageInfo;
main() async {
  WidgetsFlutterBinding.ensureInitialized();

  packageInfo = await PackageInfo.fromPlatform();
  print("======= PackageInfo =======");
  print("AppName : " + packageInfo.appName);
  print("getPackageName : " + packageInfo.packageName);
  print("getVersion : " + packageInfo.version);
  print("getBuildNumber : " + packageInfo.buildNumber);
  DartDefines.printInfo();

  bool isInitialized = false;
  for(int i = 0; i < Flavor.length.index; ++i) {
    if(DartDefines.flavor == Flavor.values[i].name) {
      BuildConfig.initialize(Flavor.values[i]);
      isInitialized = true;
      break;
    }
  }

  if(!isInitialized) {
    BuildConfig.initialize(Flavor.original);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String splashMethodChannel = "flutter_splash_screen";
  static const platform = MethodChannel(splashMethodChannel);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> hideSplash() async {
    try{
      await MyApp.platform.invokeMethod("hide");
    }
    on PlatformException catch(e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    hideSplash();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("AppName: ${packageInfo.appName}", style: const TextStyle(fontSize: 14, color: Colors.black)),
            Text("getPackageName: ${packageInfo.packageName}", style: const TextStyle(fontSize: 14, color: Colors.black)),
            Text("version: ${packageInfo.version}", style: const TextStyle(fontSize: 14, color: Colors.black)),
            Text("buildNumber: ${packageInfo.buildNumber}", style: const TextStyle(fontSize: 14, color: Colors.black)),
          ],
        )
      ),
    );
  }
}
