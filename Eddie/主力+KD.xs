{@type:filter}
input:period(60,"計算區間"), Length(60, "均線期間");
setbarfreq("D");
settotalbar(period);

variable:rsv1(0),k1(0),d1(0);
stochastic(9,3,3,rsv1,k1,d1);

value1=GetField("分公司買進家數","D");
value2=GetField("分公司賣出家數","D");
condition1=false;
if countif(value1<value2,period)>period/2
then condition1=true;

// K線黃金交叉
condition2 = k1 crosses over d1;
condition3 = close crosses over average(close,Length) or close[1] crosses over average(close[1],Length);
// 確認有一定的成交量
condition4 = average(volume,20) > 1000;

if condition1
and close>open*1.035
and GetField("主力買賣超張數","D")>0
and summation(GetField("主力買賣超張數","D"),5)>0
and summation(GetField("主力買賣超張數","D"),20)>0
and summation(GetField("主力買賣超張數","D"),60)>0
and summation(GetField("主力買賣超張數","D"),120)>0
and condition2 and condition3 and condition4
then ret=1;

outputfield(1,average(close,Length),2,"60日均線", order := -1);
