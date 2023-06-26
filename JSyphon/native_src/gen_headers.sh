cd ../bin

files=(JSyphonClient JSyphonImage JSyphonServer JSyphonServerList)

ARCH=`uname -m`
OS=`uname -s`

# macOS ARM: if OS is Darwin and arch is ARM, use `javac -h` on the .java files directly
if [ "$OS" = "Darwin" ] && ([ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]); then
  echo "macOS ARM64 detected"
  JAVAH="javac -h ."
  PRE="../src/jsyphon/"
  END=".java"
else
  JAVAH="javah"
  END=""
  PRE="jsyphon."
fi

for i in "${files[@]}"
do
  echo $JAVAH $PRE$i$END
  $JAVAH $PRE$i$END
done
mv jsyphon_*.h ../native_src/

cd ../native_src
