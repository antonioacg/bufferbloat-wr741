# bufferbloat-wr741
Experiment to evidence the presence of bufferbloat in modern networks


## Introduction

On connecting two digital circuits operating at different rates, it is necessary use a buffer, a
temporary storage memory for data while it’s been moved from one circuit to the other. In
digital communications networks, like Internet, the data link with the Internet Service
Provider has a limited rate, usually very lower than the rate at a local network, thus requiring
a buffer between the local network and the Internet. Furthermore, the data are grouped in
packets and transmitted via a medium that can be shared by multiple simultaneous
communications sessions. On traversing network nodes, like routes or switches, the buffer is
utilized to queue the packets with the same egress interface.
When the buffer has an excessive capacity, even a high-capacity link may become unusable.
Applications that consume too much bandwidth, like file download, attachments upload, peer-to-peer
file sharing, tend to fill the buffer rapidly with their packets. Other applications
sensible to latency and packet delay variation (jitter) such as VoIP, on-line gaming, web
browsing are affected, because many other packets queued before theirs. In extreme cases, the
effective rate of transmitted data may be reduced to zero, lowering the users’ quality of
service and quality of experience. This phenomenon is named Bufferbloat.
The Bufferbloat is one of the major reasons why consumers complain about the quality of the
service provided by their ISPs and one of the reasons for providers to use traffic shapping,
classifying and prioritizing traffic according to its own policy, in order to optimize the
available bandwidth.
This project will use a low cost wireless router, with similar technology to those most
consumers have today, to show the Bufferbloat and will detail its causes

## Expected Results
![bufferbload1](https://b2aqlq.dm2304.livefilestore.com/y4mtsTB0xYHTBBL1QGV4L5QBGJo3HgNWyi-MpLkmfvya7UNuzu1gW6Bv4BVxface258KS6DV33dASJI-QN4iO_zNbcfRGFiD5b7SgaaCULodVnTY3jH43bW0u63B-M7Y_F7_Zjvtz3q7zjfL9xrPf0zsNoqdQiDpzmn9AnbdMYnPLg4PFJGMt8JCtziC-m81t4TeviDEcgQK-ybegP9djF7eg?width=689&height=349&cropmode=none)

![bufferbloat2](https://1oux8g.dm2304.livefilestore.com/y4mf01Tzpc7tvVbO6HH9M2DqC91siIlYJdz6X6xgwXJqubEjSmOUOIsSRT9ZcK5uuzaxGmTnTXAoz1Zr3k85JYtTtc5nX-q3ZA5-a9-l7GvNV8NioiEm0SSXngIRFI2Wscgd2JNdgz1kuUQEACmBdSlGS8faXo6aY7iMxoZEFwhechxwpAN1SbZzNpqmBec2Kh4zgSHyDvROeMdlW4vxwcuiw?width=460&height=352&cropmode=none)

RTT (GETTYS e NICHOLS, 2012)

## TCP Protocol
![tcp](https://oxfwtw.dm2304.livefilestore.com/y4mQ017KXYk_hnSJgsCrbnBJcyFFwcJRP_fLxcyFvfHzt--J9hQZk_mNlrv8J0-F6FDcUHCiVC4lG4DYxr-sFobc9UerofuTO-wPk8DEl0wNh7O3nZeVC42S7svx8cr2DjxFa6p7hx4tebjSiTWOg3TzmkNOW9LSAmTBhHGHCaDZ6Ba5MXUA2AQfTtjzP6y23WBT5tmQQmOyJtvKnbKeyTYkw?width=784&height=518&cropmode=none)

## RRD Graph Code

```shell
rrdtool graph "$2_bw.png" -a PNG -w 550 -h 240 \
--x-grid SECOND:10:SECOND:30:SECOND:30:0:"%H:%M:%S" \
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
--x-grid SECOND:10:SECOND:30:SECOND:30:0:"%H:%M:%S" \
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
```

## Results

![bufferbloat30msbw](https://pumn2g.dm2304.livefilestore.com/y4mgsh8oibUqjqQMmh6LbW_68_Rd4UR0MHL_8D9lMeGdjN6G1k5dC1PuYEph3e-SWHlzcnuzFaLQYB3FnTgHKSZXs3sgGloieleKqNARZafbzL8t0UTH1dsTQVXL95eZh0ZQcpPIATk4MTq-uCxk5UpzkGmiPAsv7xbAXaCfG637VU0sTrucD1l1gT7UPyg-A4GKgaM2OoLSlbY3CgFQvQRAA?width=630&height=338&cropmode=none)
![bufferbloat30msrtt](https://ctxlnw.dm2304.livefilestore.com/y4mALUeHkRHtSOBY_xx8eTgp7Kl4CJrk6sLpm5ZwVaaYEWUzV6yuipAJDzqrwqUthPexXd27oh2BU3FdALqI5XIToZIuX2AuOMrEt3_4XoIGY4yFab8qdibzKPRjttf1obj_411vxPMp9hP5EGf-bDs1muczpCNxlOgYV7iEpksHr7FPiyQQdWcSKMRBd5LblKmMZWgrn7JK8mKSxnVoGPt0Q?width=630&height=325&cropmode=none)

![bufferbloat100msbw](https://a46gcg.dm2304.livefilestore.com/y4mAsLC_xmuH_cDfS8LdcoDtunqym_atMRRsuff7EkL_jEr_42pgHcY0MN9weIWMCFSI_2kmMn-K7XOk1flR-yWO54VvgmZ6GT-W2fKb8h-VvGysUmWbTMkm7FF9fup8D53_aOOCyj-DpeRV-VstLVFLpGuvDTY9l7_sxkdqL4fwUBx3MSN1BH7Qr76w8GxNGAXghACBMS7X5xumIzudwrsJw?width=630&height=338&cropmode=none)
![bufferbloat100msrtt](https://dad8wg.dm2304.livefilestore.com/y4mwrYmzLQRh6zscUyu7gOUemhI1BlX033zW3F7E1PnTiL9U86TVXDeXSC04Y3sjcpTbIYe24stnJNuKf9iskBXIM5JV6kkxkEMDC39VCT-xX-NC2iNYRW81DgQpeNZ_R0L7ml6YYX2lv3EQFm13PSL5AXg9VexWX4DBLLN95leLnPR1tGrcogly6n4Ggzw4Z9XFvQxuaYp7GCs6ZM4ZZl7iA?width=630&height=325&cropmode=none)

## References
GETTYS, J.; NICHOLS, K. Bufferbloat: Dark Buffers in the Internet. Communications of the ACM, v. 55, n. 1, p. 55-65, January 2012.

[Link to view full work [PT-BR]](https://1drv.ms/b/s!At5b46FlLw7IhfB8lznIJbg6qkrm3g)
