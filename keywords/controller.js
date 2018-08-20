// var resultStr = testStr.replace(/\ +/g, ""); //去掉空格
// resultStr = testStr.replace(/[ ]/g, "");    //去掉空格
// resultStr = testStr.replace(/[\r\n]/g, ""); //去掉回车换行
// resultStr = testStr.replace(/[\n]/g, ""); //去掉换行
// resultStr = testStr.replace(/[\r]/g, ""); //去掉回车

function intailSetting() {
	document.getElementById('exceptKWs').innerHTML = "best\nfor\nby\nstore\nbuy\nsale\nnew\na\nan\nand\nby\nfor\nof\nthe\nwith\ngood\namazon\nuk\nfba";
}

function array_diff(a, b) {
    for(var i=0;i<b.length;i++)
    {
      	for(var j=0;j<a.length;j++)
      	{
	        if(a[j]==b[i]){
	          a.splice(j,1);
	          j=j-1;
	        }
      	}
    } 
	return a;
}

function unique2(array){
		var n = {}, r = [], len = array.length, val, type;
  	for (var i = 0; i < array.length; i++) {
    	val = array[i];
    	type = typeof val;
    	if (!n[val]) {
      		n[val] = [type];
      		r.push(val);
    	} else if (n[val].indexOf(type) < 0) {
      		n[val].push(type);
      		r.push(val);
    	}
 	}
		return r;
}

function getOriginKWs() {
	var keywordsString = document.getElementById('originKWs').value;
	keywordsString = keywordsString.replace(/\ +/g, "\n");
	keywordsString = keywordsString.replace(/[\r\n]/g, " ");
	var wordsArr = keywordsString.split(" ");

	return wordsArr;
}

function getDeleteKWs() {
	var deleteItemsString = document.getElementById('exceptKWs').value;
	deleteItemsString = deleteItemsString.replace(/\ +/g, "\n");
	deleteItemsString = deleteItemsString.replace(/[\r\n]/g, " ");
	var wordsArr = deleteItemsString.split(" ");

	return wordsArr;
}



function getResult(){

	// var $textArea = $('#originKWs');
	
	var originKWs = getOriginKWs();
	
	var temp = unique2(originKWs);

	var deleteItems = getDeleteKWs();

	temp = array_diff(temp, deleteItems);
	
	for (var i = temp.length - 1; i >= 0; i--) {
		deleteItems.push(temp[i]+"s");
	}

	var result = array_diff(temp, deleteItems);

	return result;
}

function printResultsStr() {

	var result = getResult();

	var resultStr = result.join(" ");


	document.getElementById('result').innerHTML = resultStr;
}


function printResultsWords() {

	var result = getResult();

	var resultStr = result.join("<br>");


	document.getElementById('result').innerHTML = resultStr;
}














