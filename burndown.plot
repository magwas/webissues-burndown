set boxwidth 0.80 absolute
set style fill   solid 1.00 border lt -1
set key outside right top vertical Left reverse noenhanced autotitles columnhead nobox
set key invert samplen 4 spacing 1 width 0 height 0 
set style histogram rowstacked title  offset character 0, 0, 0
set datafile missing '-'
set style data histograms
#set xtics border in scale 0,0 nomirror rotate by -45  offset character 0, 0, 0 
#set xtics  norangelimit font ",2"
#set xtics   ()
set timefmt "%Y-%m-%d"
set xtics rotate by -90
set title "Burndown" 
set datafile separator ","
set terminal png size 1024,480 font arial 7
set output "sprint.png"
#set yrange [ 0.00000 : 7.00000e+06 ] noreverse nowriteback
i = 5
plot 'sprint.dat' using 3:xtic(1), for [i=4:7] '' using i

