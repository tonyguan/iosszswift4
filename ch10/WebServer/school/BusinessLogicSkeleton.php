<?php
header("Content-Type: text/text;charset=utf-8");
require_once("db_config.php");
require_once("DBHelper.php");
require_once("BusinessLogicObject.php");

//获得操作action
$action = $_REQUEST["action"];
if (!isset($action)) {
	echo '{"ResultCode":-1}';
	return;
}

if ($action == 'q1') {//根据类别1查询类别2

	$bl1 = new BusinessLogicObject();
	$cid1 = $_REQUEST["cid1"];
	if (!isset($cid1)) {
		echo '{"ResultCode":-2}';
		return;
	}
	$bl1->findCategory2ByCategory1($cid1);
	
} else if ($action == 'q2') {//根据类别2查询课程
	$bl2 = new BusinessLogicObject();
	$cid2 = $_REQUEST["cid2"];
	if (!isset($cid2)) {
		echo '{"ResultCode":-3}';
		return;
	}
	$bl2->findCourseByCategory2($cid2);
	
} else if ($action == 'q3') {//根据类别1查询课程
	$bl3 = new BusinessLogicObject();
	$cid1 = $_REQUEST["cid1"];
	if (!isset($cid1)) {
		echo '{"ResultCode":-4}';
		return;
	}
	$bl3->findCourseByCategory1($cid1);
}

?>