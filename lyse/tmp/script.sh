chain="$1"
store="$2"

wget --user "aniket@theatrolabs.com" --password 'theatro1' "https://pl3.projectlocker.com/TheatroLabs/Main/svn/Operations/chain%20specific/"$chain"/"$store"/names" -r --cut-dirs=10 -np -nH --reject "index.html"

if [ $? -ne 0 ]; then
    wget --user "aniket@theatrolabs.com" --password 'theatro1' "https://pl3.projectlocker.com/TheatroLabs/Main/svn/Operations/chain%20specific/"$chain"/"$store"/Names" -r --cut-dirs=10 -np -nH --reject "index.html"
fi

rm names
rm *\ *
