REM *******************************************
REM *** Filename   : laika_code_coverage.bat
REM *** Created by : Rob McCready 
REM *******************************************

REM ******************************************* 
REM Move up one directory so the paths are set
REM *******************************************
pushd ..

REM *******************************************
REM Start up the Healthstories server
REM *******************************************
rake spec:rcov

REM *******************************************
REM Once the server terminates, return to the 
REM orginating 'bin' directory from where this 
REM script was called
REM *******************************************
popd

