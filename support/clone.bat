rem clone.bat

echo off

rem clone all iplApps module from GitHub

set GIT_BASE=https://github.com

set drivers=iplApps
set git_admin=IPL-CONTROLS

git clone --recursive %GIT_BASE%/%git_admin%/%drivers%.git