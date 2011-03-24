#! /bin/sh

svn co http://svn.php.net/repository/phpdoc/modules/doc-en phpdoc
find . -name "reference" -print > references.txt
find . -name "*.ent" -print > ent.txt
mkdir out
