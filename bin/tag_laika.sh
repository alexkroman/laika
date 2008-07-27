#!/bin/sh
cd ..
svn delete https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/production -m "Recreating the Laika tags"
svn copy https://laika.svn.sourceforge.net/svnroot/laika/webapp/trunk https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/production -m "Recreating the production tag"
svn delete https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/stage -m "Recreating the Laika tags"
svn copy https://laika.svn.sourceforge.net/svnroot/laika/webapp/trunk https://laika.svn.sourceforge.net/svnroot/laika/webapp/tags/stage -m "Recreating the stage tag"
