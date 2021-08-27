# Installing
Tested on `MacOS` and `Linux`

## Prerequirements
```bash
python >= 3.7
pip3 >= 19.0
go >= 1.14
```

## Dependencies
- To start using lazyrecon script, please clone and setup the dependencies bellow
- Note that many dependencies are tuned for recon needs and differ from the original ones
- Make sure environment variables are filled in `./lazyconfig`
- If you operate under VPS: first call `./helpers/linux-apt-install.sh`
- Update your local `~/.gf` with `./gfpatterns/*`
- Use option `nuclei -update-templates` to use it properly under `$HOMEDIR`, but for LFI update templates with [storenth-lfi](https://github.com/storenth/nuclei-templates/blob/master/vulnerabilities/other/storenth-lfi.yaml) till the time [projectdiscovery](https://github.com/projectdiscovery) introduce feature for dynamic replacement of parameters.
- Not forget to include [LFI-Payload-List](https://github.com/storenth/LFI-Payload-List) to the `./wordlist/lfi-payload.txt`
- Make sure all tools correctly installed and enabled with execute permissions: `chmod +x`
- Take care about appropriate tokens and API keys
- Don't forget that the script act as a root user
1. [subfinder](https://github.com/projectdiscovery/subfinder)
2. [interactsh](https://github.com/projectdiscovery/interactsh)
3. [assetfinder](https://github.com/tomnomnom/assetfinder)
4. [github-subdomains](https://github.com/storenth/github-search/blob/master/github-subdomains.py)
5. [github-endpoints](https://github.com/storenth/github-search/blob/master/github-endpoints.py)
6. [waybackurls](https://github.com/tomnomnom/waybackurls)
7. [gau](https://github.com/lc/gau)
8. [altdns](https://github.com/infosec-au/altdns)
9. [dnsgen](https://github.com/ProjectAnte/dnsgen/)
10. [puredns](github.com/d3mondev/puredns)
11. [masscan](https://github.com/robertdavidgraham/masscan)
11. [massdns](https://github.com/blechschmidt/massdns)
12. [dnsx](https://github.com/projectdiscovery/dnsx)
13. [httpx](https://github.com/projectdiscovery/httpx)
14. [nuclei](https://github.com/projectdiscovery/nuclei)
15. [nuclei-templates](https://github.com/storenth/nuclei-templates)
16. [smuggler](https://github.com/storenth/requestsmuggler)
17. [ffuf](https://github.com/ffuf/ffuf)
18. [gf](https://github.com/tomnomnom/gf)
19. [qsreplace](https://github.com/tomnomnom/qsreplace)
20. [unfurl](https://github.com/tomnomnom/unfurl)
21. [sqlmap](https://github.com/sqlmapproject/sqlmap)
22. [gospider](https://github.com/jaeles-project/gospider)
23. [ssrf-headers-tool](https://github.com/storenth/Bug-Bounty-Toolz/blob/master/ssrf.py)
24. [storenth-lfi](https://github.com/storenth/nuclei-templates/blob/master/vulnerabilities/other/storenth-lfi.yaml)
25. [nmap](https://nmap.org/download.html)
26. [chromium](https://github.com/storenth/chromium-latest-linux.git)
27. [interlace](https://github.com/codingo/Interlace.git)
28. [page-fetch](https://github.com/detectify/page-fetch)
29. [gowitness](https://github.com/sensepost/gowitness)
30. [bypass-403](https://github.com/storenth/bypass-403)
31. [linkfinder](https://github.com/storenth/LinkFinder.git)
32. [secretfinder](https://github.com/storenth/SecretFinder.git)

> (You may copy each executable dependency to `/usr/local/bin/`, create symlinc like: `ln -s $HOME/github-subdomains.py /usr/local/bin/github-subdomains`, or just export it to the PATH `export PATH=~/masscan/bin/masscan:$PATH`)

## Testing
You can check if the dependencies are installed correctly on your machine by running the following tests:
```bash
./test/test_nuclei_templates.sh "./test/nuclei_templates_list.txt"
./test/test_install.sh "./test/dependencies_list.txt"
```