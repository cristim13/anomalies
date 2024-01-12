#!/bin/bash

IONEX="gage0150.23i"

start=`grep "START OF TEC MAP" $IONEX | head -1`


###WE FIRST EXTRACT THE DATA FROM THE IONEX
###EPOCH LAT LON1 LON2 LON3 ... LON72 
### 72 divisions for a 5 degree grid in longitude

gawk '{if( substr($0,61,16) =="START OF TEC MAP"){start=1};if( substr($0,61,14) =="END OF TEC MAP"){start=0};

        if(start==1 && substr($0,61,20)=="EPOCH OF CURRENT MAP"){year=$1;month=$2;day=$3;hour=$4;minute=$5;seconds=$6; date=1};
                if(start==1 && date==1 && substr($0,61,20)=="LAT/LON1/LON2/DLON/H"){lat=$1;lon1=$2;lon2=$3;dlon=$4;H=$5;rec=NR;count=1};
			if(H==270.0){
                        if(start==1 && date==1 && NR==rec+1){k1=$1;k2=$2;k3=$3;k4=$4;k5=$5;k6=$6;k7=$7;k8=$8;k9=$9;k10=$10;k11=$11;k12=$12;k13=$13;k14=$14;k15=$15;k16=$16;count=count+1};
			if(start==1 && date==1 && NR==rec+2){k17=$1;k18=$2;k19=$3;k20=$4;k21=$5;k22=$6;k23=$7;k24=$8;k25=$9;k26=$10;k27=$11;k28=$12;k29=$13;k30=$14;k31=$15;k32=$16;count=count+1};
			if(start==1 && date==1 && NR==rec+3){k33=$1;k34=$2;k35=$3;k36=$4;k37=$5;k38=$6;k39=$7;k40=$8;k41=$9;k42=$10;k43=$11;k44=$12;k45=$13;k46=$14;k47=$15;k48=$16;count=count+1};
			if(start==1 && date==1 && NR==rec+4){k49=$1;k50=$2;k51=$3;k52=$4;k53=$5;k54=$6;k55=$7;k56=$8;k57=$9;k58=$10;k59=$11;k60=$12;k61=$13;k62=$14;k63=$15;k64=$16;count=count+1};
			if(start==1 && date==1 && NR==rec+5){k65=$1;k66=$2;k67=$3;k68=$4;k69=$5;k70=$6;k71=$7;k72=$8;k73=$9;k74=$10;k75=$11;k76=$12;k77=$13;k78=$14;k79=$15;k80=$16;count=0;printf "%5d %4d %5d %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d  %5d \n", hour*3600+minute*60+seconds,lat, k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32,k33,k34,k35,k36,k37,k38,k39,k40,k41,k42,k43,k44,k45,k46,k47,k48,k49,k50,k51,k52,k53,k54,k55,k56,k57,k58,k59,k60,k61,k62,k63,k64,k65,k66,k67,k68,k69,k70,k71,k72,k73,k74,k75,k76,k77,k78,k79,k80 > "vtec1.txt" }};	
				
			}' gage0150.23i > vtec1.txt

rm diff.txt
t1=18300
t2=61500

for (( i=0;i<=72;i++)) do
	j=$(($i+3))
	k=$(($i*5))
	gawk -v time1=$t1 -v time2=$t2 -v m=$i -v n=$j -v l=$k '{if($1==time1){epoch=$1;lat=$2;k1=$m;next};if($1==time2 && $2==lat){print epoch,$1,l,lat,sqrt(($n-k1)**2);lat=1000}}' vtec1.txt >> diff.txt
done

#gawk '{a1[$1" "$2]=$3}END{for (key in a1){print a1[key],"        ",a1[18000" "27],key }}' vtec1.txt | more
