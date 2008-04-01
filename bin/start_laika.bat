@echo off

REM *******************************************
REM *** Filename   : start_laika.bat
REM *** Created by : Rob McCready 
REM ***            : Automates the startup of
REM ***            : the healthstories WeBrick
REM ***            : server on MS Windows
REM *******************************************

REM ******************************************* 
REM Move up one directory so the paths are set
REM *******************************************
pushd ..

REM *******************************************
REM Start up the Laika server
REM *******************************************
ruby script/server

REM *******************************************
REM Once the server terminates, return to the 
REM orginating 'bin' directory from where this 
REM script was called
REM *******************************************
popd