#!/bin/bash
# This script syncs the Apache & Varnish logs from all appservers & varnishservers, respectively, 
# and then it merges them into a single file for Webalizer to digest
# By David Jurick
VAR_SOURCE=/var/log/httpd/
VAR_SOURCEVAR=/var/log/varnish/
VAR_LOG=access_log
VAR_DATE=-`date +%Y%m%d`
VAR_DIR=/usr/share/webalizer/logs/
#################################################
# Archiving old access_logs
#################################################
echo -n "Archiving old access_logs at "
date
rm -rf ${VAR_DIR}merged/*${VAR_LOG}.1
# 0 to 1
mv ${VAR_DIR}merged/coolmom.com-${VAR_LOG} ${VAR_DIR}merged/coolmom.com-${VAR_LOG}.1
#mv ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG} ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG}.1
#mv ${VAR_DIR}merged/web.coolmom.com-${VAR_LOG} ${VAR_DIR}merged/web.coolmom.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/goodbite.com-${VAR_LOG} ${VAR_DIR}merged/goodbite.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG} ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/web.goodbite.com-${VAR_LOG} ${VAR_DIR}merged/web.goodbite.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/momversation.com-${VAR_LOG} ${VAR_DIR}merged/momversation.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/app.momversation.com-${VAR_LOG} ${VAR_DIR}merged/app.momversation.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/web.momversation.com-${VAR_LOG} ${VAR_DIR}merged/web.momversation.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/parentsask.com-${VAR_LOG} ${VAR_DIR}merged/parentsask.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG} ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/web.parentsask.com-${VAR_LOG} ${VAR_DIR}merged/web.parentsask.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/smosh.com-${VAR_LOG} ${VAR_DIR}merged/smosh.com-${VAR_LOG}.1
#mv ${VAR_DIR}merged/app.smosh.com-${VAR_LOG} ${VAR_DIR}merged/app.smosh.com-${VAR_LOG}.1
#mv ${VAR_DIR}merged/web.smosh.com-${VAR_LOG} ${VAR_DIR}merged/web.smosh.com-${VAR_LOG}.1
mv ${VAR_DIR}merged/combined-${VAR_LOG} ${VAR_DIR}merged/combined-${VAR_LOG}.1
#mv ${VAR_DIR}merged/app.combined-${VAR_LOG} ${VAR_DIR}merged/app.combined-${VAR_LOG}.1
#mv ${VAR_DIR}merged/web.combined-${VAR_LOG} ${VAR_DIR}merged/web.combined-${VAR_LOG}.1
echo -n "Finished archiving old access_logs at "
date
#################################################
# Sync logs
#################################################
echo -n "Deleting old access_logs at "
date
rm -rf ${VAR_DIR}app01/*
rm -rf ${VAR_DIR}app02/*
rm -rf ${VAR_DIR}app03/*
rm -rf ${VAR_DIR}app04/*
#app05_dead#rm -rf ${VAR_DIR}app05/*
rm -rf ${VAR_DIR}app06/*
rm -rf ${VAR_DIR}app07/*
rm -rf ${VAR_DIR}web01/*
rm -rf ${VAR_DIR}web02/*
echo -n "Finished deleting old access_logs at "
date
echo -n "Syncing /var/log/httpd/*access_log-`date +%Y%m%d` from all appservers at "
date
echo -n "This may take a while....To kill some time (and yourself), go outside, and play in the street"
rsync -al -e "ssh -p 222" root@app01.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app01/
rsync -al -e "ssh -p 222" root@app02.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app02/
rsync -al -e "ssh -p 222" root@app03.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app03/
rsync -al -e "ssh -p 222" root@app04.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app04/
#app05_dead#rsync -al -e "ssh -p 222" root@app05.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app05/
rsync -al -e "ssh -p 222" root@app06.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app06/
rsync -al -e "ssh -p 222" root@app07.deca.tv:${VAR_SOURCE}*${VAR_LOG}${VAR_DATE} ${VAR_DIR}app07/
echo -n "Finished syncing appserver logs at "
date
echo -n "Syncing /var/log/varnish/varnish.log.1 and /var/log/varnish/varnish.log.2 from all varnishservers at "
date
echo -n "This may take a while....To kill some time (and yourself), go outside, and play in the street"
rsync -al -e "ssh -p 222" admin@web01.deca.tv:${VAR_SOURCEVAR}varnish.log.2 ${VAR_DIR}web01/
rsync -al -e "ssh -p 222" admin@web01.deca.tv:${VAR_SOURCEVAR}varnish.log.1 ${VAR_DIR}web01/
rsync -al -e "ssh -p 222" admin@web02.deca.tv:${VAR_SOURCEVAR}varnish.log.2 ${VAR_DIR}web02/
rsync -al -e "ssh -p 222" admin@web02.deca.tv:${VAR_SOURCEVAR}varnish.log.1 ${VAR_DIR}web02/
echo -n "Finished syncing varnishserver logs at "
date
##################################################
# Merging the newly synced appserver logs
##################################################
echo -n "Merging all appserver access_logs at "
date
logresolvemerge.pl ${VAR_DIR}app0*/coolmom.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG}.very.dirty
logresolvemerge.pl ${VAR_DIR}app0*/goodbite.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG}.very.dirty
logresolvemerge.pl ${VAR_DIR}app0*/momversation.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/app.momversation.com-${VAR_LOG}.very.dirty
logresolvemerge.pl ${VAR_DIR}app0*/parentsask.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG}.very.dirty
logresolvemerge.pl ${VAR_DIR}app0*/smosh.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/app.smosh.com-${VAR_LOG}.very.dirty
echo -n "Finished merging all appserver access_logs at "
date
##################################################
# Cleaning the merged appserver logs
##################################################
echo -n "Initiating Log Cleanup at "
date
echo -n "Phase 1: Removing lines that lack host IPs at "
date
grep -E '^.*\..*\..*\..*\, .*\..*\..*\..*' ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG}.very.dirty > ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG}.kinda.dirty
grep -E '^.*\..*\..*\..*\, .*\..*\..*\..*' ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG}.very.dirty > ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG}.kinda.dirty
grep -E '^.*\..*\..*\..*\, .*\..*\..*\..*' ${VAR_DIR}merged/app.momversation.com-${VAR_LOG}.very.dirty > ${VAR_DIR}merged/app.momversation.com-${VAR_LOG}.kinda.dirty
grep -E '^.*\..*\..*\..*\, .*\..*\..*\..*' ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG}.very.dirty > ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG}.kinda.dirty
grep -E '^.*\..*\..*\..*\, .*\..*\..*\..*' ${VAR_DIR}merged/app.smosh.com-${VAR_LOG}.very.dirty > ${VAR_DIR}merged/app.smosh.com-${VAR_LOG}.kinda.dirty
echo -n "Phase 2: Removing duplicate host IPs at "
date
sed 's/^.*[0-9]\,\s//g' ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG}.kinda.dirty >	${VAR_DIR}merged/app.coolmom.com-${VAR_LOG}
sed 's/^.*[0-9]\,\s//g' ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG}.kinda.dirty > ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG}
sed 's/^.*[0-9]\,\s//g' ${VAR_DIR}merged/app.momversation.com-${VAR_LOG}.kinda.dirty > ${VAR_DIR}merged/app.momversation.com-${VAR_LOG}
sed 's/^.*[0-9]\,\s//g' ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG}.kinda.dirty > ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG}
sed 's/^.*[0-9]\,\s//g' ${VAR_DIR}merged/app.smosh.com-${VAR_LOG}.kinda.dirty > ${VAR_DIR}merged/app.smosh.com-${VAR_LOG}
echo -n "Deleting appserver junk files at "
date
rm -rf ${VAR_DIR}merged/*.dirty
echo -n "Completed Log Cleanup at "
date
##################################################
# Splitting the newly synced varnish logs by vhost
##################################################
echo -n "Extracting vhost accesses from varnishserver logs at "
date
grep 'GET http://www.coolmom.com' ${VAR_DIR}web01/varnish.log.2 > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.2a
grep 'GET http://coolmom.com' ${VAR_DIR}web01/varnish.log.2 > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.2b
logresolvemerge.pl ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.2a ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.2b > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.2
grep 'GET http://www.coolmom.com' ${VAR_DIR}web01/varnish.log.1 > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.1a
grep 'GET http://coolmom.com' ${VAR_DIR}web01/varnish.log.1 > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.1b
logresolvemerge.pl ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.1a ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.1b > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.1
grep 'GET http://www.coolmom.com' ${VAR_DIR}web02/varnish.log.2 > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.2a
grep 'GET http://coolmom.com' ${VAR_DIR}web02/varnish.log.2 > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.2b
logresolvemerge.pl ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.2a ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.2b > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.2
grep 'GET http://www.coolmom.com' ${VAR_DIR}web02/varnish.log.1 > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.1a
grep 'GET http://coolmom.com' ${VAR_DIR}web02/varnish.log.1 > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.1b
logresolvemerge.pl ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.1a ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.1b > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.1
rm -rf ${VAR_DIR}web0*/coolmom.com-${VAR_LOG}.*a && rm -rf ${VAR_DIR}web0*/coolmom.com-${VAR_LOG}.*b
grep 'GET http://www.goodbite.com' ${VAR_DIR}web01/varnish.log.2 > ${VAR_DIR}web01/goodbite.com-${VAR_LOG}.2
grep 'GET http://www.goodbite.com' ${VAR_DIR}web01/varnish.log.1 > ${VAR_DIR}web01/goodbite.com-${VAR_LOG}.1
grep 'GET http://www.goodbite.com' ${VAR_DIR}web02/varnish.log.2 > ${VAR_DIR}web02/goodbite.com-${VAR_LOG}.2
grep 'GET http://www.goodbite.com' ${VAR_DIR}web02/varnish.log.1 > ${VAR_DIR}web02/goodbite.com-${VAR_LOG}.1
grep 'GET http://www.momversation.com' ${VAR_DIR}web01/varnish.log.2 > ${VAR_DIR}web01/momversation.com-${VAR_LOG}.2 
grep 'GET http://www.momversation.com' ${VAR_DIR}web01/varnish.log.1 > ${VAR_DIR}web01/momversation.com-${VAR_LOG}.1   
grep 'GET http://www.momversation.com' ${VAR_DIR}web02/varnish.log.2 > ${VAR_DIR}web02/momversation.com-${VAR_LOG}.2
grep 'GET http://www.momversation.com' ${VAR_DIR}web02/varnish.log.1 > ${VAR_DIR}web02/momversation.com-${VAR_LOG}.1
grep 'GET http://www.parentsask.com' ${VAR_DIR}web01/varnish.log.2 > ${VAR_DIR}web01/parentsask.com-${VAR_LOG}.2 
grep 'GET http://www.parentsask.com' ${VAR_DIR}web01/varnish.log.1 > ${VAR_DIR}web01/parentsask.com-${VAR_LOG}.1
grep 'GET http://www.parentsask.com' ${VAR_DIR}web02/varnish.log.2 > ${VAR_DIR}web02/parentsask.com-${VAR_LOG}.2
grep 'GET http://www.parentsask.com' ${VAR_DIR}web02/varnish.log.1 > ${VAR_DIR}web02/parentsask.com-${VAR_LOG}.1
grep 'GET http://www.smosh.com' ${VAR_DIR}web01/varnish.log.2 > ${VAR_DIR}web01/smosh.com-${VAR_LOG}.2
grep 'GET http://www.smosh.com' ${VAR_DIR}web01/varnish.log.1 > ${VAR_DIR}web01/smosh.com-${VAR_LOG}.1
grep 'GET http://www.smosh.com' ${VAR_DIR}web02/varnish.log.2 > ${VAR_DIR}web02/smosh.com-${VAR_LOG}.2
grep 'GET http://www.smosh.com' ${VAR_DIR}web02/varnish.log.1 > ${VAR_DIR}web02/smosh.com-${VAR_LOG}.1
echo -n "Finished extracting vhost accesses from varnishserver logs at "
date
##################################################
# Merging the newly split varnish logs by server
##################################################
echo -n "Merging the AM and PM vhost logs from each varnishserver at "
date
logresolvemerge.pl ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.2 ${VAR_DIR}web01/coolmom.com-${VAR_LOG}.1 > ${VAR_DIR}web01/coolmom.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.2 ${VAR_DIR}web02/coolmom.com-${VAR_LOG}.1 > ${VAR_DIR}web02/coolmom.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web01/goodbite.com-${VAR_LOG}.2 ${VAR_DIR}web01/goodbite.com-${VAR_LOG}.1 > ${VAR_DIR}web01/goodbite.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web02/goodbite.com-${VAR_LOG}.2 ${VAR_DIR}web02/goodbite.com-${VAR_LOG}.1 > ${VAR_DIR}web02/goodbite.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web01/momversation.com-${VAR_LOG}.2 ${VAR_DIR}web01/momversation.com-${VAR_LOG}.1 > ${VAR_DIR}web01/momversation.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web02/momversation.com-${VAR_LOG}.2 ${VAR_DIR}web02/momversation.com-${VAR_LOG}.1 > ${VAR_DIR}web02/momversation.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web01/parentsask.com-${VAR_LOG}.2 ${VAR_DIR}web01/parentsask.com-${VAR_LOG}.1 > ${VAR_DIR}web01/parentsask.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web02/parentsask.com-${VAR_LOG}.2 ${VAR_DIR}web02/parentsask.com-${VAR_LOG}.1 > ${VAR_DIR}web02/parentsask.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web01/smosh.com-${VAR_LOG}.2 ${VAR_DIR}web01/smosh.com-${VAR_LOG}.1 > ${VAR_DIR}web01/smosh.com-${VAR_LOG}${VAR_DATE}
logresolvemerge.pl ${VAR_DIR}web02/smosh.com-${VAR_LOG}.2 ${VAR_DIR}web02/smosh.com-${VAR_LOG}.1 > ${VAR_DIR}web02/smosh.com-${VAR_LOG}${VAR_DATE}
echo -n "Deleting varnishserver junk files at "
date
rm -rf ${VAR_DIR}web0*/*-${VAR_LOG}.1 && rm -rf ${VAR_DIR}web0*/*-${VAR_LOG}.2
rm -rf ${VAR_DIR}web0*/varnish.log.*
echo -n "Finished merging the AM and PM vhost logs from each varnishserver at "
date
##################################################
# Merging the varnish logs even more!
##################################################
echo -n "Merging all varnishserver access_logs at "
date
logresolvemerge.pl ${VAR_DIR}web0*/coolmom.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/web.coolmom.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}web0*/goodbite.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/web.goodbite.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}web0*/momversation.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/web.momversation.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}web0*/parentsask.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/web.parentsask.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}web0*/smosh.com-${VAR_LOG}${VAR_DATE} > ${VAR_DIR}merged/web.smosh.com-${VAR_LOG}
echo -n "Finished merging all varnishserver access_logs at "
date
##################################################
# Combining all vhost logs into a single log
##################################################
echo -n "Combining all appserver access_logs at "
date
logresolvemerge.pl ${VAR_DIR}merged/app.*.com-${VAR_LOG} > ${VAR_DIR}merged/app.combined-${VAR_LOG}
echo -n "Finished combining all appserver access_logs at "
date
echo -n "Combining all varnishserver access_logs at "
date
logresolvemerge.pl ${VAR_DIR}merged/web.*.com-${VAR_LOG} > ${VAR_DIR}merged/web.combined-${VAR_LOG}
echo -n "Finished combining all varnishserver access_logs at "
date
##################################################
# Combining all appserver and varnishserver logs
##################################################
echo -n "Combining all appserver access_logs with varnishserver access_logs at "
date
logresolvemerge.pl ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG} ${VAR_DIR}merged/web.coolmom.com-${VAR_LOG} > ${VAR_DIR}merged/coolmom.com-${VAR_LOG}
chmod 777 ${VAR_DIR}merged/coolmom.com-${VAR_LOG}
rm -rf ${VAR_DIR}merged/app.coolmom.com-${VAR_LOG} && rm -rf ${VAR_DIR}merged/web.coolmom.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}merged/app.goodbite.com-${VAR_LOG} ${VAR_DIR}merged/web.goodbite.com-${VAR_LOG} > ${VAR_DIR}merged/goodbite.com-${VAR_LOG}
chmod 777 ${VAR_DIR}merged/goodbite.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}merged/app.momversation.com-${VAR_LOG} ${VAR_DIR}merged/web.momversation.com-${VAR_LOG} > ${VAR_DIR}merged/momversation.com-${VAR_LOG}
chmod 777 ${VAR_DIR}merged/momversation.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}merged/app.parentsask.com-${VAR_LOG} ${VAR_DIR}merged/web.parentsask.com-${VAR_LOG} > ${VAR_DIR}merged/parentsask.com-${VAR_LOG}
chmod 777 ${VAR_DIR}merged/parentsask.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}merged/app.smosh.com-${VAR_LOG} ${VAR_DIR}merged/web.smosh.com-${VAR_LOG} > ${VAR_DIR}merged/smosh.com-${VAR_LOG}
chmod 777 ${VAR_DIR}merged/smosh.com-${VAR_LOG}
rm -rf ${VAR_DIR}merged/app.smosh.com-${VAR_LOG} && rm -rf ${VAR_DIR}merged/web.smosh.com-${VAR_LOG}
logresolvemerge.pl ${VAR_DIR}merged/app.combined-${VAR_LOG} ${VAR_DIR}merged/web.combined-${VAR_LOG} > ${VAR_DIR}merged/combined-${VAR_LOG}
chmod 777 ${VAR_DIR}merged/combined-${VAR_LOG}
rm -rf ${VAR_DIR}merged/app.combined-${VAR_LOG} && rm -rf ${VAR_DIR}merged/web.combined-${VAR_LOG}
echo -n "Finished combining all appserver access_logs with varnishserver access_logs at "
date
