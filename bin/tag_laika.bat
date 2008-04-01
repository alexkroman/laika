@echo off

REM *******************************************
REM *** Filename   : tag_laika.bat
REM *** Created by : Rob McCready 
REM ***            : Automates the subversion 
REM ***            : tagging process
REM *******************************************

REM ******************************************* 
REM Move up one directory so the paths are set
REM *******************************************
pushd ..

REM ******************************************* 
REM Destroy and re-tag based on the head/trunk
REM *******************************************
svn delete https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/production -m "Recreating the Laika tags"
svn copy https://laika.svn.sourceforge.net/svnroot/laika/webapp/trunk https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/production -m "Recreating the production tag"
svn delete https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/stage -m "Recreating the Laika tags"
svn copy https://laika.svn.sourceforge.net/svnroot/laika/webapp/trunk https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/stage -m "Recreating the stage tag"

REM *******************************************
REM Once the job terminates, return to the 
REM orginating 'bin' directory from where this 
REM script was called
REM *******************************************
popd