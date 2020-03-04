author=""
stanzas=()
current_stanza=""
f=$(find $DOTFILES/zen/poems -type f | sort -R | head -n1)
while read line; do
    if [ -z $author ]; then
        author=$line
        continue
    fi
    if [ ! -z $line ]; then
        current_stanza+=$line"\n"
    else
        # End of stanza
        stanzas+=($current_stanza)
        current_stanza=""
    fi
done < $f

# Print a random stanza, if one was found
if [ ! -z $author ]; then
    echo -en "\e[3;37m${stanzas[$RANDOM % ${#stanzas[@]} + 1 ]}\n~ $author" # arrays in zsh start at 1
fi

echo -n " ("
for word in ${$(basename $f .txt)//-/ }; do
    echo -n ${(C)word}
done
echo -n ")"
echo "\e[0m"

