# Cica
URL="$(curl --silent 'https://api.github.com/repos/miiton/Cica/releases/latest' | grep browser_download_url |grep -v without|awk '{print $NF}')"

WORKDIR="/tmp/Cica"
mkdir -p $WORKDIR
cd $WORKDIR

wget "$URL"

unzip ./Cica_*
rm ./Cica_*
cd ../

mv Cica ~/.local/share/fonts/
