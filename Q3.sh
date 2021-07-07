#!/bin/bash
echo "Enter name of directory to move to: "
read dir_name
check=0
for dir in *
do
    if [ -d "$dir" ] && [ "$dir" = $dir_name ]; then
        check=1
    fi
done

while [ $check -ne 1 ]
do
    echo -e "The directory $dir_name is not present in the current directory.\nPlease enter directory currently present in current directory."
    read dir_name
    for dir in *
    do
        if [ -d "$dir" ] && [ "$dir" = $dir_name ]; then
            check=1
        fi
    done
done

cd $dir_name
while [ true ]
do
echo -e "For forward action, enter forward.\nFor backward action, enter backward.\nTo exit, enter exit.\n"
read action
while [ "$action" != "forward" ] && [ "$action" != "Forward" ] && [ "$action" != "backward" ] && [ "$action" != "Backward" ] && [ "$action" != "exit" ] && [ "$action" != "Exit" ]; 
do
    echo "Please only enter the provided options."
    echo -e "For forward action, enter forward./nFor backward action, enter backward.\nTo exit, enter exit.\n"
    read action
done
case $action in
forward|Forward)
    mkdir java
    mkdir cpp
    mkdir txt
    mkdir cc
    mkdir others
    for directory in *
    do
        if [ -d "$directory" ] && [ "$directory" != "java" ] && [ "$directory" != "cpp" ] && [ "$directory" != "cc" ] && [ "$directory" != "others" ] && [ "$directory" != "txt" ]; then
            #echo "dir: "$directory
            cd $directory
            for filename in *
            do
                if [ -f "$filename" ]; then
                newname=$filename
                newname="-${newname}"
                newname=$directory$newname
                mv $filename $newname
                #STR=$(file $filename)
                #echo "file: " $filename
                #STR=$(echo $filename | cut -d'.' -f 2)
                #echo "filetype:" $STR
                fi
            done
                mv *.java ../java
                mv *.txt ../txt
                mv *.cpp ../cpp
                mv *.cc ../cc
                mv * ../others
            cd ..
            rm -rf $directory
        fi
    done
;;

backward|Backward)  
    for directory in *
    do
        if [ -d "$directory" ] && ( [ "$directory" = "java" ] || [ "$directory" = "cpp" ] || [ "$directory" = "cc" ] || [ "$directory" = "others" ] || [ "$directory" = "txt" ] ); then
            echo "dir: "$directory
            cd $directory
            for filename in *
            do
                if [ -f "$filename" ]; then
                Dirname=$(echo $filename | cut -d'-' -f 1)
                newname=$(echo $filename | cut -d'-' -f 2)
                mv $filename $newname
                cd ..
                mkdir $Dirname
                cd $directory
                mv $newname ../$Dirname
                fi
            done
            cd ..
            rm -rf $directory
        fi
    done

;;

exit|Exit)
    echo "Exiting program..."
    exit
;;

esac
done
exit
