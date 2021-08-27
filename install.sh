#!/bin/bash -x

# Script works in current directory

# https://golang.org/doc/install#install
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$HOME/go/bin:$HOMEDIR/go/bin

MACOS=
if [[ "$OSTYPE" == "darwin"* ]]; then
  MACOS="1"
fi

# sqlmap and linkfinder needs
if ! /usr/bin/env python -h; then
    sudo ln -s /usr/bin/python3 /usr/bin/python
fi

# CI/CD dependencies
third_party_go_dependencies(){
    # Third-party tools
    gotools[0]="go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder"
    gotools[1]="go get -v github.com/projectdiscovery/interactsh/cmd/interactsh-client"
    gotools[2]="go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei"
    gotools[3]="go get -v github.com/projectdiscovery/mapcidr/cmd/mapcidr"
    gotools[4]="go get -v github.com/projectdiscovery/httpx/cmd/httpx@v1.0.6"
    gotools[5]="go get -v github.com/projectdiscovery/dnsx/cmd/dnsx"
    gotools[6]="go get -v github.com/tomnomnom/assetfinder"
    gotools[7]="go get -v github.com/tomnomnom/waybackurls"
    gotools[8]="go get -v github.com/tomnomnom/qsreplace"
    gotools[9]="go get -v github.com/tomnomnom/unfurl"
    gotools[10]="go get -u github.com/tomnomnom/gf"
    gotools[11]="go get -u github.com/jaeles-project/gospider"
    gotools[12]="go get -u -v github.com/lc/gau"
    gotools[13]="go get github.com/detectify/page-fetch"
    gotools[14]="go get github.com/d3mondev/puredns/v2"
    gotools[15]="go get -u github.com/sensepost/gowitness"

    for gotool in "${gotools[@]}"; do
        $gotool
    done

    nuclei -ut -ud "$HOMEDIR/nuclei-templates"

    mkdir -p $HOMEDIR/.gf
    cp -r ./gfpatterns/* $HOMEDIR/.gf
}

custom_origin_dependencies() {
    if ! type bypass-403; then
        git clone https://github.com/storenth/bypass-403.git
        ln -s $PWD/bypass-403/bypass-403.sh /usr/local/bin/bypass-403
        ln -s $PWD/bypass-403/bypass-403.sh /usr/local/bin/bypass-403
    fi

    if ! type github-endpoints; then
        git clone https://github.com/storenth/github-search.git
        ln -s $PWD/github-search/github-endpoints.py /usr/local/bin/github-endpoints
        ln -s $PWD/github-search/github-subdomains.py /usr/local/bin/github-subdomains
    fi

    if ! type ssrf-headers-tool; then
        git clone https://github.com/storenth/Bug-Bounty-Toolz.git
        ln -s $PWD/Bug-Bounty-Toolz/ssrf.py /usr/local/bin/ssrf-headers-tool
    fi

    wget -nc https://raw.githubusercontent.com/storenth/nuclei-templates/master/vulnerabilities/other/storenth-lfi.yaml
    mv -f $PWD/storenth-lfi.yaml $HOMEDIR/nuclei-templates/vulnerabilities/other

    find . -name "requirements.txt" -type f -exec pip3 install -r '{}' ';'
}

third_party_dependencies(){
    pip3 install setuptools

    if ! type interlace; then
        git clone https://github.com/codingo/Interlace.git
        if cd Interlace; then
            python3 setup.py install
            cd -
        fi
    fi

    if ! type ffuf; then
        if [[ -n "$MACOS" ]]; then
            wget -nc https://github.com/ffuf/ffuf/releases/download/v1.2.1/ffuf_1.2.1_macOS_amd64.tar.gz
        else
            wget -nc https://github.com/ffuf/ffuf/releases/download/v1.2.1/ffuf_1.2.1_linux_amd64.tar.gz
        fi
        tar xfzv ffuf_1.2.1_* && ln -s $PWD/ffuf /usr/local/bin/ffuf
    fi

    if ! type massdns; then
        git clone https://github.com/blechschmidt/massdns.git
        if cd massdns; then
            if [[ -n "$MACOS" ]]; then
                make nolinux
            else
                make
            fi
            ln -s $PWD/bin/massdns /usr/local/bin/massdns
            cd -
        fi
    fi

    if ! type masscan; then
        git clone https://github.com/robertdavidgraham/masscan.git
        if cd masscan; then
            make
            ln -s $PWD/bin/masscan /usr/local/bin/masscan
            cd -
        fi
    fi

    if ! type dnsgen; then
        git clone https://github.com/ProjectAnte/dnsgen
        if cd dnsgen; then
            pip3 install -r requirements.txt
            python3 setup.py install
            cd -
        fi
    fi

    if ! type sqlmap; then
        git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
        ln -s $PWD/sqlmap-dev/sqlmap.py /usr/local/bin/sqlmap
    fi

    if ! type linkfinder; then
        git clone --depth 1 https://github.com/storenth/LinkFinder.git
        if cd LinkFinder; then
            python3 setup.py install
            pip3 install -r requirements.txt
            ln -s $PWD/linkfinder.py /usr/local/bin/linkfinder
            cd -
        fi
    fi

    if ! type secretfinder; then
        git clone --depth 1 https://github.com/storenth/SecretFinder.git
        if cd SecretFinder; then
            pip3 install -r requirements.txt
            chmod +x $PWD/SecretFinder.py
            ln -s $PWD/SecretFinder.py /usr/local/bin/secretfinder
            cd -
        fi
    fi
}

# need to be in $PATH in case no chrome installed: ./chromium-latest-linux/latest/chrome
chromium_dependencies(){
    if ! type /usr/local/bin/chromium; then
        git clone https://github.com/storenth/chromium-latest-linux.git
        if cd chromium-latest-linux; then
            if [[ -n "$MACOS" ]]; then
                # mac development https://github.com/storenth/chromium-latest-linux
                ./install-update-mac.sh
                ln -s $PWD/latest/Chromium.app/Contents/MacOS/Chromium /usr/local/bin/chromium
            else
                ./update.sh
                ln -s $PWD/latest/chrome /usr/local/bin/chromium
            fi
            cd -
        fi
    fi
}

third_party_wordlists(){
    if ! wget -nc https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt; then
        exit 1
    fi
    if wget -nc https://raw.githubusercontent.com/storenth/LFI-Payload-List/master/lfi-payload.txt; then
        mv -f $PWD/lfi-payload.txt $PWD/wordlist/lfi-payload.txt
    else
        exit 1
    fi
    if wget -nc https://raw.githubusercontent.com/storenth/bruteforce-lists/master/api.txt; then
        mv -f $PWD/api.txt $PWD/wordlist/api.txt
    else
        exit 1
    fi
}

notification(){
    echo
    echo "Dependencies insalled in $PWD"
}

main() {
    # Entry point
    third_party_go_dependencies
    third_party_dependencies
    custom_origin_dependencies
    chromium_dependencies
    third_party_wordlists

    notification
}

main
exit 0
