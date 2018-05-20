<?php
 $y = $_GET[y];
 $m = $_GET[m];

 $fw = getDate(mktime(0,0,0,$m,1,$y)); //해당 월 1일의 요일
 $fw = $fw[wday]+1;
 $ld = date("t", mktime(0,0,0,$m,1,$y)); //해당 월의 마지막 날자
 $lw = getDate(mktime(0,0,0,$m,$ld,$y));//해당 월의 마지막 날의 요일
 $lw = $lw[wday];
 
 $fc = ceil(($fw+$ld-1)/7); //총 주의 수
 $ffc = $fc*7; //포문 돌아야 할 횟수

##################

 $j=1;
echo "<table border='6'>";
 for($i=1; $i<=$ffc; $i++){
  if($i%7==1){
   echo "<tr>";
  }
  echo "<td>";
  if($i>=$fw && $j<=$ld){
   echo $j;
   $j++;
  }else{
   echo "&nbsp;";
  }
  echo "</td>";
  if($i%7==0){
   echo "</tr>";
  }
 }
echo "</table>";
echo "<br/>";

##################

?>
<form method="get">
Year: <select name="y" value="<?=$y?>">
   <?php
    $thisY = date("Y");
    for($i=$thisY;$i>($thisY-10);$i--){
     if($y==$i){
      $se = "selected='selected'";
     }else{
      $se = "";
     }
     echo "<option value='".$i."' ".$se.">".$i."</option>";
    }
   ?>
  </select>
Month:  <select name="m" value="<?=$m?>">
  <?php
   for($i=1;$i<=12;$i++){
     if($m==$i){
      $se = "selected='selected'";
     }else{
      $se = "";
     }
    echo  "<option value='".$i."' ".$se.">".$i."</option>";
   }
  ?>
  </select>
  <input type="submit" value="Select"/>
</form>
