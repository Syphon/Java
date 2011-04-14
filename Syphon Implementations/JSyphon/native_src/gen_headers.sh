cd ../bin

javah  jsyphon.JSyphonClient
javah  jsyphon.JSyphonImage
javah  jsyphon.JSyphonServer
mv jsyphon_*.h ../native_src/

cd ../native_src
