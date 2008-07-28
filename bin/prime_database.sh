#!/bin/sh
cd ..
rake db:fixtures:load_from_dir env="development" FIXTURE_DIR="spec/fixtures" --trace
cd bin