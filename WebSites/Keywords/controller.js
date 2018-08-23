// var resultStr = testStr.replace(/\ +/g, ""); //去掉空格
// resultStr = testStr.replace(/[ ]/g, "");    //去掉空格
// resultStr = testStr.replace(/[\r\n]/g, ""); //去掉回车换行
// resultStr = testStr.replace(/[\n]/g, ""); //去掉换行
// resultStr = testStr.replace(/[\r]/g, ""); //去掉回车

function intailSetting() {
	document.getElementById('exceptKWs').innerHTML = "best\nfor\nby\nstore\nbuy\nsale\nnew\na\nan\nand\nby\nfor\nof\nthe\nwith\ngood\namazon\nuk\nfba";
}

//删除b数组中的
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

// 去除重复
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

function getOriginKWs(keywordsString) {

	keywordsString = keywordsString.replace(/[,，/]/g, " ");
	keywordsString = keywordsString.replace(/\ +/g, "\n");
	keywordsString = keywordsString.replace(/[\r\n]/g, " ");

	var wordsArr = keywordsString.split(" ");


	return wordsArr;
}

function getDeleteKWs(deleteItemsString) {
	
	deleteItemsString = deleteItemsString.replace(/[,，/]/g, " ");
	deleteItemsString = deleteItemsString.replace(/\ +/g, "\n");
	deleteItemsString = deleteItemsString.replace(/[\r\n]/g, " ");
	var wordsArr = deleteItemsString.split(" ");
	return wordsArr;
}

function getResult(){
	
	var originKWs = getOriginKWs(document.getElementById('originKWs').value);
	
	// var temp = unique2(originKWs);

	var deleteItems = getDeleteKWs(document.getElementById('exceptKWs').value);

	
	var AllkeyWords = unique2(originKWs);
	AllkeyWords = array_diff(AllkeyWords, deleteItems);

	
	var result = Array();


	var count = 50;

	for (var i = 0; i < AllkeyWords.length; i+=count) {
		var topKWs = Array();

		if (i+count > AllkeyWords.length) {
			topKWs = AllkeyWords.slice(i, AllkeyWords.length);

		}
		else {
			topKWs = AllkeyWords.slice(i, i+count);
		
		}

		var topKWResults = array_diff(topKWs, deleteItems);

		for (var j = 0; j < topKWResults.length; j++) {
			// topKWResults[i]
			deleteItems.push(topKWResults[j]+"s");
		}

		topKWResults = array_diff(topKWResults, deleteItems);

		// document.getElementById('result').innerHTML = topKWResults.join(" ");
			
		result.push(topKWResults);
		deleteItems.concat(topKWs);
	}



	return result;
}

function printResultsStr() {

	var result = getResult();
	var resultDiv = document.getElementById('result');
	resultDiv.innerHTML = "";

	for (var i = 0; i < result.length; i++) {
		var keywordsString = result[i].join(" ");

		
		var para=document.createElement("p");
		var node=document.createTextNode(keywordsString);
		para.appendChild(node);

		resultDiv.appendChild(para);		
	}
}


function printResultsWords() {

	var result = getResult();
	var resultDiv = document.getElementById('result');
	resultDiv.innerHTML = "";

	var innerHTMLStr = ""; 
	for (var i = 0; i < result.length; i++) {
		var keywordsString = result[i].join('<br>');

		innerHTMLStr+= "<div>"+keywordsString+"</div>";
	}
	
	resultDiv.innerHTML = innerHTMLStr;
}














