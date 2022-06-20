========= Flavor 생성 방법 ============
1. https://appicon.co/ 
접속하여 아이폰, 아이패드, Android를 클릭하여 파일을 생성해준다. 

2. sites 폴더에 사이트명으로 폴더를 생성한다.
	1. AppIcons
	2. gray_logo_image, logo_image 이미지도 넣어준다. 
	3. Config.txt 파일 생성

flavor.py 처리 내용 >>
1. 각 네이티브 사이드에서 필요한 Splash 이미지 교체
2. 로고 이미지 다트 assets폴더에서 교체
3. 아이콘 교체
4. 이미지 교체후 프로그램 실행 (필요한 config 값은 config.txt 파일에서 읽는다)

python을 설치하여 flavor.py을 실행시킨다.

사용 예시(Win):
python F:\test\batch\flavor.py
python F:\test\batch\flavor.py debug
python F:\test\batch\flavor.py original
python F:\test\batch\flavor.py original debug
python F:\test\batch\flavor.py debug original

Mac에서는 Finder에서 flavor.py의 경로를 복사하여 python 명령어를 실행한다. 
python3 /test/batch/flavor.py original

# python flavor.py original을 실행하여 리소스를 정리하고 커밋할 것.

========= Dart Define 정보 ============
# Flavor 정보(BuildConfig 초기화 용도)
FLAVOR=original

# SITE 정보(회사별 구분 정보)
SITE=original

# 다트 코드 난독화 여부		
IS_OBFUSCATED=true

# 앱 아이디(패키지명)
IOS_BUNDLE_ID=com.flavor.original
AOS_APPLICATION_ID=com.flavor.original

# 출력 버전 정보
IOS_BUNDLE_SHORT_VERSION_STRING=1
AOS_VERSION_NAME=1.000

# 빌드 버전 정보		
IOS_BUNDLE_VERSION=1.0.0						
AOS_VERSION_CODE=1								

# 앱 이름	
IOS_BUNDLE_NAME=original
AOS_APP_NAME=original

# 스킴정보	
IOS_BUNDLE_URL_SCHEMES=test
AOS_SCHEME=test
	
# 앱 스토어 식별 정보		
IOS_APP_STORE_ID=1234
	
# 사이닝 컨피그 정보 	
AOS_KEY_ALIAS=test
AOS_KEY_PASSWORD=test
AOS_STORE_FILE=.keystore
AOS_STORE_PASSWORD=test