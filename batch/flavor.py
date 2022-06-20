import os
import shutil
import sys

# Default value
CONFIG = {
    "RUN_MODE": "debug",

    "FLAVOR": "original",

    "SITE": "original",

    "IS_OBFUSCATED": "true",

    "IOS_BUNDLE_ID": "com.flavor.original",
    "AOS_APPLICATION_ID": "com.flavor.original",

    "IOS_BUNDLE_SHORT_VERSION_STRING": "1",
    "AOS_VERSION_NAME": "1.000",

    "IOS_BUNDLE_VERSION": "1.0.0",
    "AOS_VERSION_CODE": "1",

    "IOS_BUNDLE_NAME": "original",
    "AOS_APP_NAME": "original",

    "IOS_BUNDLE_URL_SCHEMES": "test",
    "AOS_SCHEME": "test",
    "IOS_APP_STORE_ID": "1234",

    "AOS_KEY_ALIAS": "test",
    "AOS_KEY_PASSWORD": "test.",
    "AOS_STORE_FILE": ".keystore",
    "AOS_STORE_PASSWORD": "test",
}


def loadTextFile(textPath):
    if os.path.exists(textPath):
        file = open(textPath, "r", encoding='cp949')
        while True:
            line = file.readline()
            if not line:
                break

            line = line.replace("\n", "")
            line = line.replace("\t", "")
            line = line.strip()
            array = line.split("=")
            if len(array) == 2:
                key = array[0]
                value = array[1]
                CONFIG[key] = value
                print(key + " : " + value)

        file.close()


def createFileIfNot(path):
    if not os.path.exists(path):
        os.mkdir(path)


def copyFile(src, dest):
    if os.path.exists(src):
        shutil.copyfile(src, dest)

# os.chdir("F:/uprism_dart/batch") # TEST window
# os.chdir('/Users/uprism/Documents/GitHub/uprism_dart/batch') # TEST MAC

currentPath = os.path.abspath(os.path.join(sys.argv[0], os.pardir))
print("currentPath : " + currentPath)

projectPath = os.path.abspath(os.path.join(currentPath, os.pardir))
print("projectPath : " + projectPath)

androidResPath = f"{projectPath}/android/app/src/main/res"
print("androidResPath : " + androidResPath)

try:
    # path pop
    sys.argv.pop(0)
    for i in range(len(sys.argv)):
        print(f"sys.arg[{i}] = {sys.argv[i]}")

    if len(sys.argv) == 1:
        arg1 = sys.argv[0].lower()

        if arg1 == 'debug' or arg1 == 'release':
            CONFIG['RUN_MODE'] = arg1
        else:
            CONFIG['FLAVOR'] = arg1

    elif len(sys.argv) == 2:
        arg1 = sys.argv[0].lower()
        arg2 = sys.argv[1].lower()

        if arg1 == 'debug' or arg1 == 'release':
            # first value is mode
            CONFIG['RUN_MODE'] = arg1
            CONFIG['FLAVOR'] = arg2
        else:
            # first value is site
            CONFIG['FLAVOR'] = arg1
            CONFIG['RUN_MODE'] = arg2
except:
    print("arg info is invalid")

flavorPath = currentPath + f"/flavors/{CONFIG['FLAVOR']}"

# Load data from text file
loadTextFile(flavorPath + "/config.txt")

# Android Icon, logo
createFileIfNot(androidResPath + "/mipmap-hdpi")
createFileIfNot(androidResPath + "/mipmap-mdpi")
createFileIfNot(androidResPath + "/mipmap-xhdpi")
createFileIfNot(androidResPath + "/mipmap-xxhdpi")
createFileIfNot(androidResPath + "/mipmap-xxxhdpi")

copyFile(flavorPath + "/AppIcons/android/mipmap-hdpi/ic_launcher.png",
         androidResPath + "/mipmap-hdpi/ic_launcher.png")
copyFile(flavorPath + "/AppIcons/android/mipmap-mdpi/ic_launcher.png",
         androidResPath + "/mipmap-mdpi/ic_launcher.png")
copyFile(flavorPath + "/AppIcons/android/mipmap-xhdpi/ic_launcher.png",
         androidResPath + "/mipmap-xhdpi/ic_launcher.png")
copyFile(flavorPath + "/AppIcons/android/mipmap-xxhdpi/ic_launcher.png",
         androidResPath + "/mipmap-xxhdpi/ic_launcher.png")
copyFile(flavorPath + "/AppIcons/android/mipmap-xxxhdpi/ic_launcher.png",
         androidResPath + "/mipmap-xxxhdpi/ic_launcher.png")

createFileIfNot(androidResPath + "/drawable")
copyFile(flavorPath + "/logo_image.png", androidResPath + "/drawable/logo_image.png")

# IOS Icon
iosAssetPath = f"{projectPath}/ios/Runner/Assets.xcassets"
createFileIfNot(iosAssetPath)
createFileIfNot(iosAssetPath + "/AppIcon.appiconset")

iosIconFileList = [
    "100.png",
    "1024.png",
    "114.png",
    "120.png",
    "144.png",
    "152.png",
    "167.png",
    "180.png",
    "20.png",
    "29.png",
    "40.png",
    "50.png",
    "57.png",
    "58.png",
    "60.png",
    "72.png",
    "76.png",
    "80.png",
    "87.png",
    "Contents.json"
]

for fileName in iosIconFileList:
    copyFile(flavorPath + f"/AppIcons/Assets.xcassets/AppIcon.appiconset/{fileName}",
             iosAssetPath + f"/AppIcon.appiconset/{fileName}")

# IOS Splash Image
createFileIfNot(iosAssetPath + "/Logo.imageset")
copyFile(flavorPath + "/logo_image.png", iosAssetPath + "/Logo.imageset/ic_launcher_1.png")
copyFile(flavorPath + "/logo_image.png", iosAssetPath + "/Logo.imageset/ic_launcher_2.png")
copyFile(flavorPath + "/logo_image.png", iosAssetPath + "/Logo.imageset/ic_launcher_3.png")

iosSplashPath = iosAssetPath + "/Logo.imageset/Contents.json"
if not os.path.exists(iosSplashPath):
    f = open(iosSplashPath, "w")
    f.write("{ \"images\" : [ { \"filename\" : \"ic_launcher_1.png\", \"idiom\" : \"universal\", \"scale\" : \"1x\" "
            "}, { \"filename\" : \"ic_launcher_2.png\", \"idiom\" : \"universal\", \"scale\" : \"2x\"}, "
            "{ \"filename\" : \"ic_launcher_3.png\", \"idiom\" : \"universal\", \"scale\" : \"3x\" } ], \"info\" : { "
            "\"author\" : \"xcode\", \"version\" : 1 } }")
    f.close()

# Dart logo image
createFileIfNot(projectPath + "/assets")
createFileIfNot(projectPath + "/assets/images")

dartImagePath = projectPath + "/assets/images"
copyFile(flavorPath + "/logo_image.png", dartImagePath + "/logo_image.png")
copyFile(flavorPath + "/gray_logo_image.png", dartImagePath + "/gray_logo_image.png")

for key, value in CONFIG.items():
    print(key + ":" + value)
    CONFIG[key] = f"\"{CONFIG[key]}\""

os.chdir(projectPath)
run = (f"flutter run --{CONFIG['RUN_MODE']} "
       f"--dart-define=FLAVOR={CONFIG['FLAVOR']} "
       f"--dart-define=SITE={CONFIG['SITE']} "
       f"--dart-define=IS_OBFUSCATED={CONFIG['IS_OBFUSCATED']} "
       f"--dart-define=IOS_BUNDLE_ID={CONFIG['IOS_BUNDLE_ID']} "
       f"--dart-define=AOS_APPLICATION_ID={CONFIG['AOS_APPLICATION_ID']} "
       f"--dart-define=IOS_BUNDLE_SHORT_VERSION_STRING={CONFIG['IOS_BUNDLE_SHORT_VERSION_STRING']} "
       f"--dart-define=AOS_VERSION_NAME={CONFIG['AOS_VERSION_NAME']} "
       f"--dart-define=IOS_BUNDLE_VERSION={CONFIG['IOS_BUNDLE_VERSION']} "
       f"--dart-define=AOS_VERSION_CODE={CONFIG['AOS_VERSION_CODE']} "
       f"--dart-define=IOS_BUNDLE_NAME={CONFIG['IOS_BUNDLE_NAME']} "
       f"--dart-define=AOS_APP_NAME={CONFIG['AOS_APP_NAME']} "
       f"--dart-define=IOS_BUNDLE_URL_SCHEMES={CONFIG['IOS_BUNDLE_URL_SCHEMES']} "
       f"--dart-define=AOS_SCHEME={CONFIG['AOS_SCHEME']} "
       f"--dart-define=IOS_APP_STORE_ID={CONFIG['IOS_APP_STORE_ID']} "
       f"--dart-define=AOS_KEY_ALIAS={CONFIG['AOS_KEY_ALIAS']} "
       f"--dart-define=AOS_KEY_PASSWORD={CONFIG['AOS_KEY_PASSWORD']} "
       f"--dart-define=AOS_STORE_FILE={CONFIG['AOS_STORE_FILE']} "
       f"--dart-define=AOS_STORE_PASSWORD={CONFIG['AOS_STORE_PASSWORD']} "
       )

print(run)
os.system(run)
