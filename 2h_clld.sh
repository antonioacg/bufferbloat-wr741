rrdtool graph "$2_bw.png" -a PNG -w 550 -h 240 \
--x-grid MINUTE:5:MINUTE:15:MINUTE:15:0:"%H:%M:%S" \
-t "$2" \
-s -$1 \
'DEF:in='/tmp/rrd/openwrt/interface-eth1/if_octets.rrd':rx:AVERAGE' \
'DEF:out='/tmp/rrd/openwrt/interface-eth1/if_octets.rrd':tx:AVERAGE' \
'CDEF:out_inv=out,-1,*' \
'AREA:in#32CD32:Entrada:STACK' \
'LINE1:in#336600' \
GPRINT:in:"MAX:  Maxima\\: %5.1lf %sb/s" \
GPRINT:in:"AVERAGE:Media\\: %5.1lf %Sb/s" \
GPRINT:in:"LAST: Atual\\: %5.1lf %Sb/s\\n" \
'AREA:out#4169E1:Saida:STACK' \
'LINE1:out#0033CC' \
GPRINT:out:"MAX:    Maxima\\: %5.1lf %sb/s" \
GPRINT:out:"AVERAGE:Media\\: %5.1lf %Sb/s" \
GPRINT:out:"LAST: Atual\\: %5.1lf %Sb/s\\n" \
'HRULE:0#000000' \

rrdtool graph "$2_rtt.png" -a PNG -w 550 -h 240 \
--x-grid MINUTE:5:MINUTE:15:MINUTE:15:0:"%H:%M:%S" \
-t "$2" \
-s -$1 \
'DEF:rttu='/tmp/rrd/openwrt/ping/ping-www.uol.com.br.rrd':value:AVERAGE' \
'DEF:rttg='/tmp/rrd/openwrt/ping/ping-www.google.com.br.rrd':value:AVERAGE' \
'CDEF:scaled_rttu=rttu,20000,*' \
'CDEF:scaled_rttg=rttg,20000,*' \
'LINE2:rttu#CC3300:RTT www.uol.com.br   ' \
GPRINT:rttu:"MAX:Maximo\\: %5.1lf %sms" \
GPRINT:rttu:"AVERAGE:Media\\: %5.1lf %sms" \
GPRINT:rttu:"LAST:Atual\\: %5.1lf%Sms\\n" \
'LINE2:rttg#CC9900:RTT www.google.com.br' \
GPRINT:rttg:"MAX:Maximo\\: %5.1lf %sms" \
GPRINT:rttg:"AVERAGE:Media\\: %5.1lf %sms" \
GPRINT:rttg:"LAST:Atual\\: %5.1lf%Sms\\n"
