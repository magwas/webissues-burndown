#!/bin/bash
set -xe

rm -f stamps.csv changes.csv wi.db burndown.dat sprint.dat
iconv -f utf-8 -t utf-8//IGNORE <webissues.xml |saxon9 -xsl:wi2.xslt -s:-
cat wischema.sql |sqlite3 wi.db
./burndown.py
echo "<html><head> <meta http-equiv=\"Content-Type\" content=\"text/xhtml;charset=UTF-8\"/> <title>Burndown</title> </head><body>">out/index.html
sqlite3 wi.db "select distinct value_new from changes where attr_id=15" | while read
do
	echo $REPLY
	echo "<h1>$REPLY</h1><a name=\"$REPLY\"/><img src=\"$REPLY.png\"/><br/>">>out/index.html
	(head -1 burndown.dat;grep "$REPLY," burndown.dat) >sprint.dat
	gnuplot burndown.plot
	mv sprint.png out/"$REPLY".png
done
echo "</body></html>">>out/index.html
rm -f stamps.csv changes.csv wi.db burndown.dat sprint.dat
