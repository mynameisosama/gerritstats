This docker container pulls project information from local gerrit service and runs gerritstats. Gerritstats is based on https://github.com/holmari/gerritstats, the output generated is hosted on nginx and the service runs hourly via cron.

There are a few changes from the original gerritstats repo. The logic of evaluating Self Reviews has been modified, because our commits could be merged with two +1 instead of a regular +2.

diff -r gerritstats/GerritStats/src/main/java/com/holmsted/gerrit/processors/perperson/IdentityRecord.java stats/GerritStats/src/main/java/com/holmsted/gerrit/processors/perperson/IdentityRecord.java

Prerequisites:

1. Make sure nginx service is disabled on host (port 80 should be free)
`sudo service nginx stop`
2. Gerrit should be up on a reachable network and you should be able to SSH onto it using host machine.
3. Create two files in the pulled repo: `gerrit_user`, `gerrit_ip`
4. Generate SSH public key, on host, in the default home directory.
5. Your host machines public key should be added to a gerrit-user. You will put that username in file `gerrit_user`
6. Put your gerrit host ip in `gerrit_ip` 

Usage:
`docker-compose run --rm generate`
`docker-compose up -d ui`
