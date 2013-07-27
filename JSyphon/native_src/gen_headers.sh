cd ../bin

javah  jsyphon.JSyphonClient
javah  jsyphon.JSyphonImage
javah  jsyphon.JSyphonServer
javah  jsyphon.JSyphonServerList
mv jsyphon_*.h ../native_src/

cd ../native_src
