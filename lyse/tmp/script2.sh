svn co --depth empty https://pl3.projectlocker.com/TheatroLabs/Main/svn/Operations/chain%20specific/ here
cd here
svn ls --recursive . | grep -i name | grep -i ".wav" | grep -v " " | while read line; do svn update --parents "$line"; done

