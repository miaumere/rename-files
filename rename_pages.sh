#!/bin/bash
PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'

NC='\033[0m' # No Color
echo -e "${PURPLE}----- Select a directory: -----${NC}"

PS3=$'\e[01;33mSelect a directory: \e[0m'

select dir in */; do
echo $dir
  if [ -n "$dir" ]; then
    cd "$dir"
    while true; do

    read -p "----- Do you want to proceed? (y/n)" yn
    case $yn in  
        [yY] ) echo -e "${GREEN}Ok, we will proceed...${NC}";
            # Define the directory where the pages are located
            ext=png
            # Get the list of pages in the directory
            pages=$(find ./ -maxdepth 1 -name "*.$ext");

            counter=1
            for page in $pages; do
                ext=png
                # Construct the new page name
                page_with_new_name="temp_name_$(printf "%02d" $counter).$ext"
                # Rename the page
                echo "Renaming $page to $page_with_new_name..."
                mv "$page" "$page_with_new_name"
                # Increment the counter
                counter=$((counter+1))
            done

            temp_pages=$(find ./ -maxdepth 1 -name "*.$ext");

            counter=1
            for page in $temp_pages; do
                ext=png
                # Construct the new page name
                page_with_new_name="$(printf "%02d" $counter).$ext"
                # Rename the page
                echo "Renaming $page to ./$page_with_new_name..."
                mv "$page" "$page_with_new_name"
                # Increment the counter
                counter=$((counter+1))
            done

            break;;
        [nN] ) echo "Exiting...";
            exit;;
        * ) echo -e "${RED}Invalid response...${NC}";

    esac
    done
    break
  else
    echo -e "${RED}Invalid selection${NC}";
  fi
done