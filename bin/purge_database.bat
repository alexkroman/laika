REM *******************************************
REM *** Filename   : start_laika.bat
REM *** Created by : Rob McCready 
REM ***            : primes the Laika database 
REM ***	           : with test data
REM *******************************************

REM ******************************************* 
REM Move up one directory so the paths are set
REM *******************************************
pushd ..

REM *******************************************
REM Destroy, create and migrate the Laika database
REM *******************************************
rake db:drop db:create db:migrate

REM *******************************************
REM Once the server terminates, return to the 
REM orginating 'bin' directory from where this 
REM script was called
REM *******************************************
popd

