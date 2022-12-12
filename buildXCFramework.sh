ProjectName="Ticker"
ARCHIVE_PATH="output/"
SchemeName="JCTicker"
# build iphone framework
xcodebuild archive \
 -scheme $SchemeName \
 -archivePath "${ARCHIVE_PATH}${ProjectName}-iphoneos.xcarchive" \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO

# build simulator framework
xcodebuild archive \
 -scheme $SchemeName \
 -archivePath "${ARCHIVE_PATH}${ProjectName}-iphonesimulator.xcarchive" \
 -sdk iphoneos \
 SKIP_INSTALL=NO

# combine two framework
xcodebuild -create-xcframework \
 -framework "${ARCHIVE_PATH}${ProjectName}-iphoneos.xcarchive/Products/Library/Frameworks/${SchemeName}.framework" \
 -framework "${ARCHIVE_PATH}${ProjectName}-iphonesimulator.xcarchive/Products/Library/Frameworks/${SchemeName}.framework" \
 -output "${ARCHIVE_PATH}${ProjectName}.xcframework"
