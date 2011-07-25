#!/bin/sh

#
# Get the latest chromium nightly build from the build bot
#

tempDir="/tmp/`whoami`/chrome-nightly/";
baseURL="http://commondatastorage.googleapis.com/chromium-browser-continuous/Mac";
dlURL="http://v12.lscache6.c.bigcache.googleapis.com/chromium-browser-continuous/Mac";
baseName="chrome-mac";
baseExt="zip";
appName="Chromium.app";
appDir="/Applications";
version=~/.CURRENT_CHROME;

# Check for errors
function checkForErrors {
    if [ "$?" != "0" ]; then
        echo "Unkown error (see above for help)!";
        exit 3;
    fi
}

# Echo progress
echo "Setup...";
mkdir -p "$tempDir";
cd "$tempDir";
checkForErrors;

# Get the current version of the installed chromium build
echo "Checking current version...";
touch $version
currentVersion=`cat $version`;
latestVersion=`curl -s $baseURL/LAST_CHANGE`;
echo "url is $baseURL/LAST_CHANGE"
checkForErrors;

# Echo our findings, and check if we are already up 2 date
echo " * your/latest build: $currentVersion / $latestVersion";
if [ "$currentVersion" == "$latestVersion" ]; then
    echo " * build $currentVersion is the latest one.";
    exit 1;
fi

# We are not up to date, proceed with downloading the stuff
# but make sure that the current build is closed down
echo "Downloading and unpacking...";
chromePID=`ps wwaux|grep -v grep|grep "$appName"|awk '{print $2}'`;
if [ "$chromePID" != "" ];then
    osascript -e '
  tell application "System Events"
    if exists (some process whose name contains "Chromium") then
      tell application "Chromium" to quit
    end if
  end tell
end run'
fi

# Download it, but with the dedicated download location of the file
curl -o $baseName.$baseExt "$dlURL/$latestVersion/$baseName.$baseExt";
unzip -qo $baseName.$baseExt;
checkForErrors;

# Install the files to the correct location
echo "Installing...";
cp -r $baseName/$appName $appDir
checkForErrors;

# Finish the installation and open the browser
echo $latestVersion > $version;
osascript -e 'tell application "Chromium"
activate
end tell'
echo "Done. You're now running build $latestVersion";
