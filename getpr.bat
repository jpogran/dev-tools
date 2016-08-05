@ECHO OFF

SETLOCAL

SET /P PROJECT=Enter project name (e.g. puppet): 
SET /P PRNUM=Enter PR number (e.g. 12345): 

SET REPO=%~dp0%PROJECT%-pr%PRNUM%

ECHO Cleaning...
RD /S /Q "%REPO%" > NUL

ECHO Cloning..
git clone https://github.com/puppetlabs/%PROJECT%.git "%REPO%"

PUSHD "%REPO%"

ECHO Fetching PR...
git fetch origin refs/pull/%PRNUM%/head:pr_%PRNUM%

ECHO Merging PR...
git merge pr_%PRNUM% --no-ff

POPD