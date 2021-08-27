# Usage
site:target.com intitle:index.of
site:target.com filetype:csv OR filetype:bak OR filetype:dll OR filetype:xls OR filetype:txt OR filetype:json OR filetype:php OR filetype:log OR filetype:sql OR filetype:xlsx OR filetype:jsp OR filetype:doc
site:target.com filetype:php | jsp | json | xlsx | tar | sql | zip | pdf | log | csv | .old, .bak, .inc, .src
site:target.com inurl:/login/ | inurl:admin | inurl:test | graphql
site:target.com intitle:setup | admin | login | tomcat
site:target.com ext:.vcf

inurl:trello.com intext:"advcash.com"
intitle:"phpLDAPadmin" inurl:cmd.php

site:target.com intext:tomcat-users.xml
site:target.com intext:"tomcat.manager.password"

site:target.com intext:password
site:target.com inurl:access_token

site:target.com inurl:admin intext:files ext:aspx

site:target.com filetype:env
site:target.com filetype:env "DB_PASSWORD"
site:target.com filetype:env
site:target.com filetype:env
site:target.com filetype:txt intext:"-----BEGIN RSA PRIVATE KEY-----"
site:target.com DOCKER-REGISTRY=
DOCKER_POSTGRES_URL=
DOCKER_RABBITMQ_HOST=
docker_repo=
DOCKER_TOKEN=

 "docker_key=" or "DOCKER_PASSWD="

# Other dorks
site:trello.com "target.com"
site:gitter.im "target.com"

site:codepad.co "target.com"
site:scribd.com "target.com"
site:npmjs.com "target.com"
site:npm.runkit.com "target.com"
site:libraries.io "target.com"
site:ycombinator.com "target.com"
site:coggle.it "target.com"

site:sharecode.io "target.com"
site:pastebin.com "target.com"
site:repl.it "target.com"
site:productforums.google.com "target.com"
site:bitbucket.org "target.com"
site:atlassian.net "target.com"

inurl:gitlab "target.com"

site:papaly.com "target.com"
site:google.com "target.com"
site:prezi.com "target.com"
site:jsdelivr.net "target.com"
site:codepen.io "target.com"
site:codeshare.io "target.com"