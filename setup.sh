#!/bin/bash
printf "What is your project's name? (No Spaces)  -> "
read NAME
pattern=" |'"
if [[ $NAME =~ $pattern ]]
then
   echo 'Make sure there is no space in the name'
   exit
else
   echo "Ok, coolio, the name is $NAME"
fi
printf "What do you want the new Bundle Id to be? (ex. com.swarmnyc.SwarmApp) -> "
read BUNDLEID
if [[ $BUNDLEID =~ $pattern ]]
then
echo 'Make sure there is no space in the bundle id'
exit
else
echo "Ok, coolio, the bundle id is $BUNDLEID"
fi

printf "What is the new remote repo url for git (ex. https://github.com/swarmnyc/TestBaseApp.git) -> "
read REMOTEREPO

#printf "What is the google analytics tracking id? -> "
#read TRACKINGID
#printf "What is the google analytics project id? -> "
#read PROJECTID
#printf "What is the google app id? ->"
#read GOOGLEAPPID


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
find -name "TestApp*.*" -exec rename 's/^$NAME//' {} ";"



for file in $(grep -l -R "com.swarmnyc.SwarmApp" $DIR)
    do
    #echo "$file"
    if [[ "$file" == *"setup.sh"* ]] ; then
        echo 'found shell'
        continue;
    fi
    if [[ "$file" == *".git"* ]] ; then
        echo "found git"
        continue;
    fi
    LANG=C LC_ALL=C sed -i '' "s/com.swarmnyc.SwarmApp/$BUNDLEID/g" $file > tmpfile.tmp
    let i++;
    echo "Modified: " $file
done

for file in $(grep -l -R "SwarmApp" $DIR)
  do
#echo "$file"
if [[ "$file" == *"setup.sh"* ]] ; then
        echo 'found shell'
        continue;
    fi
    if [[ "$file" == *".git"* ]] ; then
        echo "found git"
        continue;
    fi
    LANG=C LC_ALL=C sed -i '' "s/SwarmApp/$NAME/g" $file > tmpfile.tmp
    let i++;
    echo "Modified: " $file
  done





#com.swarmnyc.SwarmApp
for file in $(find . -name 'SwarmApp*');
    do
    RENAME=`echo "$file" | sed -e "s/SwarmApp/${NAME}/g"`
    mv "$file" "$RENAME"
    done
for file in $(find . -name 'SwarmApp*'); #we need to do it again for files such as /SwarmApp/folder/testSwarmApp.swift
    do
    RENAME=`echo "$file" | sed -e "s/SwarmApp/${NAME}/g"`
    mv "$file" "$RENAME"
    done
for file in $(find . -name 'SwarmApp*'); #we need to do it again for files such as /SwarmApp/folder/testSwarmApp.swift
    do
    RENAME=`echo "$file" | sed -e "s/SwarmApp/${NAME}/g"`
    mv "$file" "$RENAME"
    done


git remote remove origin
git remote add origin $REMOTEREPO

pod install
echo 'Wooh yeah, the script is complete. You should be good to go. Close the base project if it is open and reopen $NAME'



