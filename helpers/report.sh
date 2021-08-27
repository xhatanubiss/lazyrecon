#!/bin/bash
# Script create HTML report
# invokation: ./report.sh "my.games" "/Users/storenth/lazytargets/my.games/recon-21-04-18_23-16-43"


# Variables
TITLE="Powered by storenth"
TARGETDIR=$2
CURRENT_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"
INVOKATION=$(cat ${TARGETDIR}/_call_params.txt)
PUBLICIP=$(curl -s https://api.ipify.org)

# Images
images() {
    echo '<div>'
    for line in ${TARGETDIR}/screenshots/*; do
        FILENAME=$(basename $line | sed 's/[.]png//')
        URL=$(echo "${FILENAME}" | sed -E 's/^(.*)_/\1\:/; s/_/./g')
        echo "<p><a href=$URL>${URL}</a></p>"
        echo "<img src=${line} width=400px height=auto alt=${URL}>"
        # get nuclei's output
        if [ -s ${TARGETDIR}/nuclei/nuclei_output_technology.txt ]; then
        technote="$(grep $URL ${TARGETDIR}/nuclei/nuclei_output_technology.txt | cut -d ' ' -f 3,5,6 | awk '{ print $2 $1 $3}')"
            for tech in $technote; do
                echo "<p style='color: #404040; font-size: 10px;'>${tech}</p>"
            done
        fi
        if [ -s ${TARGETDIR}/nuclei/nuclei_output.txt ]; then
            techissue="$(grep $URL ${TARGETDIR}/nuclei/nuclei_output.txt | cut -d ' ' -f 3,5,6 | awk '{ print $2 $1 $3}')"
            for issue in $techissue; do
                echo "<p style='color: #AD3F60; font-size: 10px;'>${issue}</p>"
            done
        fi
    done
    echo '</div>'
}

serverlogs(){
    if [ -s ${TARGETDIR}/_listen_server.log ]; then
        echo '<div>'
        awk 'NR>11' $TARGETDIR/_listen_server.log
        echo '</div>'
    fi
}

# Main entry point
echo "<!DOCTYPE html>
<HTML lang=en>
<HEAD>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<TITLE>$TITLE</TITLE>
</HEAD>
<BODY>
<p>Invoked by <a href=https://github.com/storenth/lazyrecon>lazyrecon v2.0</a> with next parameters: $INVOKATION</p>
<p>$TIME_STAMP</p>
<p>Public IP=$PUBLICIP</p>
<H1>Security report for $1</H1>
"

images
serverlogs

echo "</BODY>
</HTML>
"
