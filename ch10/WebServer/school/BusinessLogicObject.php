<?php 

class BusinessLogicObject  {
	/**
	* 根据类别1查询类别2
	*/
	function findCategory2ByCategory1($cid1) {
		
		$con = connectDB();
		
		$res =  '{"ResultCode":-1}';
		
		if (isset($con)) {
			$sql = 	"SELECT _id,_name,_id1 FROM Category2 where _id1=$cid1 ORDER BY _id asc";
			$result = mysql_query($sql);
			if (isset($result)) {
				$r = '';
				$res = '';
				while($row = mysql_fetch_array($result)) {					
					$r .= '{"ID":'.$row["_id"].',"name":"'.$row["_name"].'","ID1":'.$row["_id1"].'},';
				}		
				if ($r != '') {
					$len = strlen($r);
					//截取掉后面的,\ 两个字符
					$r = substr($r, 0, $len - 1);
					$res =  '{"ResultCode":0,"Record":['.$r.']}';
				}
			}
		}
		//向客户端输出
		echo $res;
		closeDB($con);
		return;	
	} 
	
	
	/**
	* 根据类别2查询课程
	*/
	function findCourseByCategory2($cid2) {
		
		$con = connectDB();
		
		$res =  '{"ResultCode":-1}';

		
		if (isset($con)) {
			$sql = 	"SELECT _id,_name,People_Number,Class_Hour,Charges,Teacher,Picture,URL,Description,_id2
							 FROM Course where _id2=$cid2 ORDER BY _id asc";
			$result = mysql_query($sql);
			if (isset($result)) {
				
				$r = '';
				$res = '';
				while($row = mysql_fetch_array($result)) {
					$r .= '{"ID":'.$row["_id"].'
						,"name":"'.$row["_name"].'"
						,"PeopleNumber":'.$row["People_Number"].'
						,"ClassHour":'.$row["Class_Hour"].'
						,"Charges":'.$row["Charges"].'
						,"Teacher":"'.$row["Teacher"].'"
						,"Picture":"'.$row["Picture"].'"
						,"URL":"'.$row["URL"].'"
						,"Description":"'.$row["Description"].'"
						,"ID2":'.$row["_id2"].'},';
				}		
				if ($r != '') {
					$len = strlen($r);
					//截取掉后面的,\ 两个字符
					$r = substr($r, 0, $len - 1);
					$res =  '{"ResultCode":0,"Record":['.$r.']}';
				}
			}
		}
		//向客户端输出
		echo $res;
		closeDB($con);
		return;	
	} 
	
	/**
	* 根据类别1查询课程
	*/
	function findCourseByCategory1($cid1) {
		
		$con = connectDB();
		
		$res =  '{"ResultCode":-1}';

		if (isset($con)) {
			$sql = 	"select c1._name as c1name,c2._id as c2id,c2._name as c2name,
						cos._id as cosid,cos._name as cosname,cos.Picture,
						cos.People_Number, cos.Class_Hour, cos.Charges,cos.Teacher,
						cos.Picture, cos.URL, cos.Description 
						from Category1 c1 
							inner join Category2 c2 on c1._id  = c2._id1  
							inner join Course cos on cos._id2 = c2._id  where c1._id =$cid1 ORDER BY cosname asc";
			$result = mysql_query($sql);
			
			if (isset($result)) {
				
				$r = '';
				$res = '';
				while($row = mysql_fetch_array($result)) {
					$r .= '{"ID":'.$row["cosid"].'
						,"name":"'.$row["cosname"].'"
						,"PeopleNumber":'.$row["People_Number"].'
						,"ClassHour":'.$row["Class_Hour"].'
						,"Charges":'.$row["Charges"].'
						,"Teacher":"'.$row["Teacher"].'"
						,"Picture":"'.$row["Picture"].'"
						,"URL":"'.$row["URL"].'"
						,"Description":"'.$row["Description"].'"
						,"ID2":'.$row["c2id"].'},';
				}		
				if ($r != '') {
					$len = strlen($r);
					//截取掉后面的,\ 两个字符
					$r = substr($r, 0, $len - 1);
					$res =  '{"ResultCode":0,"Record":['.$r.']}';
				}
			}
		}
		//向客户端输出
		echo $res;
		closeDB($con);
		return;	
	} 
}

?>