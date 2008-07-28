#!/bin/sh
cd ..
rake db:drop db:create db:migrate
cd bin