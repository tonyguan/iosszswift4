<?php 

/*
* 连接数据库
*/
function connectDB() {
	echo $db_server;
	$con = mysql_connect($GLOBALS['db_server'], $GLOBALS['db_user'], $GLOBALS['db_pwd']);
	if (!$con) {
		mysql_close($con);
		return;
	}
	//提交数据库中文乱码问题
	mysql_query("set names 'utf8'",$con); 
	mysql_select_db($GLOBALS['db_name'], $con);

	return $con;
}

/*
* 关闭数据库连接
*/
function closeDB($con) {
	if (isset($con) && $con) {
		mysql_close($con);
	}
}

?>