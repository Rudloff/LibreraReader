#git clone https://github.com/foobnix/LibreraReader.git --branch 7.12.67
git clone https://github.com/foobnix/LibreraReader.git
git clone --recursive git://git.ghostscript.com/mupdf.git --branch 1.11

mkdir release

cp ant.properties LibreraReader/Builder

cd LibreraReader
git fetch
git reset --hard origin/master
#git pull origin master
cd ..

cd mupdf
make
cd ..

cd mupdf
MUPDF=`pwd`
cd ..

cd LibreraReader
LibreraReader=`pwd`
cd ..

echo "LINK MUPDF"
echo $MUPDF $LibreraReader
LibreraReader/Builder/link_to_mupdf_1.11.sh $MUPDF $LibreraReader


cd LibreraReader
./update_all.sh
./update_fix_build.sh

cd Builder
./update_jars.sh




ant clean-apk
ant arm+arm64 pro-fdroid
