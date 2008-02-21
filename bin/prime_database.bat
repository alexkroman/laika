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
REM Populate the Laika database with the test data in fixtures
REM *******************************************
rake db:fixtures:load_from_dir env="development" FIXTURE_DIR="spec/fixtures" --trace

REM *******************************************
REM Once the server terminates, return to the 
REM orginating 'bin' directory from where this 
REM script was called
REM *******************************************
popd

