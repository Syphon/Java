#!sh -x
git submodule update --init &&
cd Syphon-Framework/ &&
git pull origin main &&
cd ../Shared/ &&
git pull origin master &&
cd .. &&
git add Syphon-Framework &&
git add Shared &&
git commit -m "Updated Syphon submodules" || true &&
cd JSyphon &&
(ant -version || brew install ant || sudo port install apache-ant) &&
cd ant &&
ant dist &&
cd .. &&
cd native_src &&
./gen_headers.sh &&
cd .. &&
if [ `uname -m` = "arm64" ]; then
  if ls /Library/Java/JavaVirtualMachines/microsoft-*.jdk 1> /dev/null 2>&1; then
    echo Microsoft OpenJDK found;
  else
    curl -L https://aka.ms/download-jdk/microsoft-jdk-17.0.7-macOS-aarch64.pkg > microsoft-jdk-17.0.7-macOS-aarch64.pkg && open microsoft-jdk-17.0.7-macOS-aarch64.pkg && echo && echo && echo "Opening Microsoft JDK -- please install, then return here and PRESS RETURN to continue" && read ans;
  fi
fi &&
if ls jdk 1> /dev/null 2>&1; then
  echo github.com/openjdk/jdk found in jdk;
else
  git clone --depth=1 https://github.com/openjdk/jdk/;
fi &&
xcodebuild -scheme libJSyphon build -project native_src/JSyphon.xcodeproj
