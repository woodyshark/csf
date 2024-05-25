<script language="JavaScript">

function trim(input) {
	if (input==null) return null;
	return input.replace(/^\s+|\s+$/g, "");
}

function hasInput(input) {
	if (input==null) return false;
	if (trim(input)=="") return false;
	return true;
}

function hasCheckBoxInput(chkItems) {
	for (i=0; i<chkItems.length; i++) {
		if (chkItems[i].checked) {
			return true;
		}
	}
	return false;
}

function isAlpha(input) {
	var reg = /^[A-Za-z]*$/;
	return reg.test(trim(input));
}

function isNumber(input) {
	var reg = /^\d*$/;
	return reg.test(trim(input));
}

function isAlphaNumber(input) {
	var reg = /^[A-Za-z0-9]*$/;
	return reg.test(trim(input));
}

function isSymbolNumber(input) {
	var reg = /^[A-Za-z0-9\-]*$/;
	return reg.test(trim(input));
}

function isDate() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true;	//未入力

	if (input.length != 6) return false;
	if (!isNumber(input)) return false;
	
	var flag = false;
	if (arguments.length > 1) flag = arguments[1];
	if (input=="999999") return flag;
	
	var strYear = input.substr(0,2);
	if (parseFloat(strYear)>=70) {
		strYear = "19" + strYear;
	} else {
		strYear = "20" + strYear;
	}
	var strMonth = input.substr(2,2);
	var strDay = input.substr(4,2);
	
	return _isDate(strYear, strMonth, strDay);
}

function isDate8() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true;	//未入力

	if (input.length != 8) return false;
	if (!isNumber(input)) return false;
	
	var strYear = input.substr(0,4);
	var strMonth = input.substr(4,2);
	var strDay = input.substr(6,2);
	
	return _isDate(strYear, strMonth, strDay);
}

function _isDate(strYear, strMonth, strDay) {
	var year = parseFloat(strYear);
	var month = parseFloat(strMonth);
	var day = parseFloat(strDay);
	var leap = false;

	if (((year%4)==0) && ((year%100)!=0) || ((year%400)==0)) {
		leap = true;
	}

	if (month<1 || month>12) {
		return false;
	}
	
	switch (month) {
		case 4 : 
		case 6 :
		case 9 :
		case 11 : {
			if (day>30) return false;
			break;
		}
		case 2: {
			if (leap) {
			    if (day>29) return false;
			}
			else {
			    if (day>28) return false;
			}
			break;
		}
		default : {
			if (day>31) return false;
			break;
		}
	}  // end of switch

	return true;
	
}

function isPastDate() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true;	//未入力
	
	var flag = false;
	if (arguments.length > 1) flag = arguments[1];
	if (input=="999999") return flag;

	if (!isDate(input, flag)) return false;
	if (compareDateWithNow(input) == -1) {
		return true;
	} else {
		return false;
	}
}

function isFutureDate() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true;	//未入力

	var flag = false;
	if (arguments.length > 1) flag = arguments[1];
	if (input=="999999") return flag;

	if (!isDate(input, flag)) return false;
	if (compareDateWithNow(input) == 1) {
		return true;
	} else {
		return false;
	}
}

function isCurrentDate() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true;	//未入力

	var flag = false;
	if (arguments.length > 1) flag = arguments[1];
	if (input=="999999") return flag;

	if (!isDate(input, flag)) return false;
	if (compareDateWithNow(input) == 0) {
		return true;
	} else {
		return false;
	}
}

function compareDateWithNow(input) {
	var strYear = input.substr(0,2);
	if (parseFloat(strYear)>=70) {
		input = "19" + input;
	} else {
		input = "20" + input;
	}

	var today = new Date();
	var intMonth = today.getMonth() + 1;
	var intDay = today.getDate()
	
	var strMonth = "" + intMonth;
	if (strMonth.length==1)	strMonth = "0" + strMonth;
	
	var strDay = "" + intDay;
	if (strDay.length==1)	strDay = "0" + strDay;
	
	var strToday = "" + today.getFullYear() + strMonth + strDay;
	
	var intInput = parseFloat(input);
	var intToday = parseFloat(strToday);

	if (intInput == intToday) {
		return 0;
	} else if (intInput > intToday) {
		return 1;
	} else {
		return -1;
	}
}

function isCurrency() {
	var input = arguments[0];
	var flag = (arguments.length>1 && arguments[1]==true ? true : false);
	
	if (!hasInput(input)) return true;	//未入力
	input = trim(input);

	if (!flag) {
		var reg = /^\+?[0-9]*$|^\-?[0-9]*$/;
		if (reg.test(input)) return true;
	}
	
	var reg = /^\+?[0-9\,]*$|^\-?[0-9\,]*$/;
	if (!reg.test(input)) return false;

	if (input.charAt(0)=='+' || input.charAt(0)=='-') 
		input = input.substr(1);
		
	var arr = input.split(',');
	if (arr[0].length==0 || arr[0].length>3) return false;
	
	for (var i=1; i<arr.length; i++) {
		if (arr[i].length != 3) return false;
	}
	
	return true;

}

function isFloat() {
	var input = arguments[0];
	if (!hasInput(input)) return true;	//未入力
	input = trim(input);
	
	var num1 = "";
	var num2 = "";
	if (arguments.length > 1) num1 = arguments[1];
	if (arguments.length > 2) num2 = arguments[2];
	
	if (num1==null) num1="";
	if (num2==null) num2="";

	if (isNaN(parseFloat(input)) ) return false;	//非実数
	
	var arr = input.split('.');
	if (arr.length > 2) return false; //非実数

	if (num1=="" && num2=="") return true; //桁数範囲無

	var len1 = arr[0].length;		//整数部桁数
	var len2 = 0;
	if (arr.length > 1) len2 = arr[1].length;	//小数部桁数
	
	if (num1 != "" && len1 > num1) return false;	//整数部桁数範囲外
	if (num2 != "" && len2 > num2) return false;	//小数部桁数範囲外
	
	return true;
}

function checkFromTo(from, to) {
	from = trim(from);
	to = trim(to);
	
	if (!hasInput(from)) return true;	//未入力
	if (!hasInput(to)) return false;	//未入力
	
	if (isNumber(from) && isNumber(from)) {
		var fromNum = parseFloat(from);
		var toNum = parseFloat(to);

		if (fromNum > toNum) {
			return false;
		} else {
			return true;
		}
	} else {
		if (from > to) {
			return false;
		} else {
			return true;
		}
	}
}

function checkRange() {
	var num = trim(arguments[0]);
	if (!hasInput(num)) return true;	//未入力
	if (!isNumber(num))	return false;	//非数字

	var min = ( (arguments.length>1 && arguments[1]!=null) ? arguments[1] : "");
	var max = ( (arguments.length>2 && arguments[2]!=null) ? arguments[2] : "");
	if (min=="" && max=="") return true; //範囲無
	
	intNum = parseFloat(num);
	if (min != "" && intNum < parseFloat(min)) return false;	//範囲外
	if (max != "" && intNum > parseFloat(max)) return false;	//範囲外
	
	return true;	//範囲内数字
}

function checkFloatRange() {

	var num = trim(arguments[0]);
	if (!hasInput(num)) return true;	//未入力
	if (!isFloat(num))	return false;	//非数字

	var min = ( (arguments.length>1 && arguments[1]!=null) ? arguments[1] : "");
	var max = ( (arguments.length>2 && arguments[2]!=null) ? arguments[2] : "");
	if (min=="" && max=="") return true; //範囲無
	
	var intNum = parseFloat(num);
	if (min != "" && intNum < parseFloat(min)) return false;	//範囲外
	if (max != "" && intNum > parseFloat(max)) return false;	//範囲外
	
	return true;	//範囲内実数
}

function checkLength() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true ;	//未入力

	var minLen = ( (arguments.length>1 && arguments[1]!=null) ? arguments[1] : "");
	var maxLen = ( (arguments.length>2 && arguments[2]!=null) ? arguments[2] : "");
	if (minLen=="" && maxLen=="") return true; //範囲無

	if (minLen != "" && input.length < parseFloat(minLen)) return false;	//範囲外
	if (maxLen != "" && input.length > parseFloat(maxLen)) return false;	//範囲外

	return true;	//範囲内
}

function checkCurrencyLength() {
	var input = trim(arguments[0]);
	if (!hasInput(input)) return true ;	//未入力

	var minLen = ( (arguments.length>1 && arguments[1]!=null) ? arguments[1] : "");
	var maxLen = ( (arguments.length>2 && arguments[2]!=null) ? arguments[2] : "");
	if (minLen=="" && maxLen=="") return true; //範囲無
	
	var inputNum = input.replace(/^\+|^\-|\,/g, "");	//文字列から、'+'、'-'、','を取り除く
	var len = inputNum.length;

	if (minLen != "" && len < parseFloat(minLen)) return false;	//範囲外
	if (maxLen != "" && len > parseFloat(maxLen)) return false;	//範囲外

	return true;	//範囲内
}

function getReturnCount(input) {
	var arr = input.split("\n");
	return arr.length-1;
}

function checkInput(pattern) {
	recoverDefaultColor();
	var arr = _checkInputValue(pattern);
	if (arr != null && arr.length > 0) {
		alertError(arr);
		return false;
	}
	return true;
}

function _checkInputValue(pattern) {
	if (pattern == null) return null;
	
	var arrItems = new Array();
	var arr;
	var baseMsg = new _Message();

	for (var i=0; i<pattern.length; i++) {
		if (pattern[i].length < 2) continue;	//パターン不正
		
		var checkIDs = pattern[i][0].split(",");
		var item = pattern[i][1];
		if (item==null || item=="") continue;	//パターン不正
		
		//チェックボックスの必須入力チェック
		if (trim(checkIDs[0]) == "CHK") {
			var chkItems = pattern[i][1];
			if (chkItems.length == 0) continue;	//パターン不正

			var msgItemName = ( (pattern[i].length>2 && pattern[i][2]!=null) ? pattern[i][2] : "");
			var redItem = ( (pattern[i].length>3 && pattern[i][3]!=null && pattern[i][3]!="") ? pattern[i][3] : chkItems[0]);

			if (!hasCheckBoxInput(chkItems)) {
				//チェックNG
				arr = new Array(redItem, "");
				if (msgItemName != "") arr[1] = msgItemName + "123";
				arrItems[arrItems.length] = arr;
			}

			continue;
		}
	
		var itemValue;
		if (item.tagName == 'INPUT') {
			itemValue = item.value;
		} else {
			itemValue = (item.innerHTML).toString();
		}

		var msgItemName = ( (pattern[i].length>2 && pattern[i][2]!=null) ? pattern[i][2] : "");
		var redItem = ( (pattern[i].length>3 && pattern[i][3]!=null && pattern[i][3]!="") ? pattern[i][3] : item);
		var must = ( (pattern[i].length>4 && pattern[i][4]!=null && pattern[i][4]==true) ? true : false);
		
		//必須入力チェック
		if (!hasInput(itemValue)) {
			//未入力
			if (must) {
				//必須入力項目が未入力
				arr = new Array(redItem, "");
				if (msgItemName != "") arr[1] = "｡ﾃﾘｳﾒ｡ﾃﾍ｡" + msgItemName ;
				arrItems[arrItems.length] = arr;
			}
			continue;
		}
		
		for (var j=0; j<checkIDs.length; j++) {
			var checkID = trim(checkIDs[j]);

			if (checkID == "N" || checkID == "A" ||
				checkID == "AN" || checkID == "SN" || checkID == "D8") {
				if ((checkID == "N" && !isNumber(itemValue)) ||				//数字チェック
					(checkID == "A" && !isAlpha(itemValue)) ||				//英字チェック
					(checkID == "AN" && !isAlphaNumber(itemValue))  ||		//英数チェック
					(checkID == "SN" && !isSymbolNumber(itemValue)) ||		//型番チェックック
					(checkID == "D8" && !isDate8(itemValue))				//8桁日付チェック
				   ){
					//チェックNG
					arr = new Array(redItem, "");
					if (msgItemName != ""){
						arr[1] = msgItemName + " 狃郢" + baseMsg[checkID]+"｡ﾃﾘｳﾒ｡ﾃﾍ｡耆鮓ﾙ｡ｵ鯱ｧ";
					}
					arrItems[arrItems.length] = arr;
					break;
				} else {
					continue;
				}
			
			} else if (checkID == "NR" || checkID == "FR" ||
					   checkID == "SL" || checkID == "CL" ) {
				var min = ( (pattern[i].length>5 && pattern[i][5]!=null) ? pattern[i][5] : "");
				var max = ( (pattern[i].length>6 && pattern[i][6]!=null) ? pattern[i][6] : "");

				if ((checkID == "NR" && !checkRange(itemValue, min, max)) ||		//範囲内数字チェック
					(checkID == "FR" && !checkFloatRange(itemValue, min, max)) ||	//範囲内実数チェック
					(checkID == "SL" && !checkLength(itemValue, min, max)) ||		//文字数チェック
					(checkID == "CL" && !checkCurrencyLength(itemValue, min, max))	//金額の文字数チェック
				   ){
					//チェックNG
					arr = new Array(redItem, "");
					if (msgItemName != "") {
						if (min == "" && max == "") {
							arr[1] = msgItemName + "に" + baseMsg[checkID] + "789";
						} else {
							var scope = min + "～"+ max;
							if (parseFloat(min) == parseFloat(max) &&
								(checkID == "SL" || checkID == "CL")) {
								scope = min;
							}
							arr[1] = msgItemName + "に" + scope + baseMsg[checkID] + "789-1";
						}
					}
					arrItems[arrItems.length] = arr;
					break;
				} else {
					//チェックOK
					continue;
				}
				
			} else if (checkID == "F") {	//実数チェック
				var num1 = ( (pattern[i].length>7 && pattern[i][7]!=null) ? pattern[i][7] : "");
				var num2 = ( (pattern[i].length>8 && pattern[i][8]!=null) ? pattern[i][8] : "");

				if (!isFloat(itemValue, num1, num2)){
					//チェックNG
					arr = new Array(redItem, "");
					if (msgItemName != "") {
						var scope = "";
						if (num1 != "") scope = "" ;
						if (scope != "" && num2 != "") scope += "";
						if (num2 != "") scope += "" ;
						if (scope != "") scope += "";
						arr[1] = msgItemName + "狃郢ｨﾓｹﾇｹ爰ﾔｹ ｷﾈｹﾔﾂﾁ菽鞨｡ﾔｹ 2 ｵﾓ睛ｹ隗"
					}
					arrItems[arrItems.length] = arr;
					break;
				} else {
					//チェックOK
					continue;
				}
				
			} else if (checkID == "C" ||
					   checkID == "D" || checkID == "CD" ||
					   checkID == "FD" || checkID == "NFD"  ||
					   checkID == "PD" || checkID == "NPD" ) {
				var flag = ( (pattern[i].length>9 && pattern[i][9]!=null && pattern[i][9]==true) ? true : false);

				if ((checkID == "C" && !isCurrency(itemValue, flag))  ||	//金額チェック
					(checkID == "D" && !isDate(itemValue, flag)) ||			//日付チェック
					(checkID == "PD" && !isPastDate(itemValue, flag)) ||	//過去日付チェック
					(checkID == "FD" && !isFutureDate(itemValue, flag)) ||	//未来日付チェック
					(checkID == "CD" && !isCurrentDate(itemValue, flag)) ||	//現日付チェック
					(checkID == "NPD" && (!isDate(itemValue, flag) || isPastDate(itemValue, false))) ||	//非過去の日付チェック
					(checkID == "NFD" && (!isDate(itemValue, flag) || isFutureDate(itemValue, false)))	//非未来の日付チェック
				   ){

					//チェックNG
					arr = new Array(redItem, "");
					if (msgItemName != "") {
						arr[1] = msgItemName + "に";
						if (checkID != "C" && flag) arr[1] += "999999又は";
						arr[1] += baseMsg[checkID] + "を入力して下さい。";
					}
					arrItems[arrItems.length] = arr;
					break;
				} else {
					//チェックOK
					continue;
				}
				
			} else if (checkID == "FT") {	//from項目<=to項目のチェック
				if (pattern[i].length < 11) {
					//パターン不正
					continue;
				}
				var toItemValue = pattern[i][10].value;
				if (!hasInput(toItemValue)) continue;	//比較項目が未入力
				
				if (!checkFromTo(itemValue, toItemValue)) {
					//チェックNG
					arr = new Array(redItem, "");
					if (msgItemName != "") {
						arr[1] = msgItemName + "";
						arr[1] += ".";
					}
					arrItems[arrItems.length] = arr;
					break;
				} else {
					//チェックOK
					continue;
				}
			}				
		
		} //for(j)

	} //for(i)

	return arrItems;
}

function _Message() {
	this["N"]="ｵﾑﾇ倏｢";
	this["A"]="英字";
	this["AN"]="英数";
	this["SN"]="英数又は'-'";
	this["C"]="金額";
	this["K"]="カタカナ";
	this["FK"]="全角カタカナ";
	this["HK"]="半角カタカナチェック";
	this["NR"]="範囲内の数字";
	this["FR"]="範囲内の実数";
	this["SL"]="桁文字";
	this["CL"]="桁金額";
	this["D"]="日付(yymmdd)";
	this["PD"]="過去日付(yymmdd)";
	this["FD"]="未来日付(yymmdd)";
	this["CD"]="現日付(yymmdd)";
	this["NPD"]="非過去の日付(yymmdd)";
	this["NFD"]="非未来の日付(yymmdd)";
	this["D8"]="日付(yyyymmdd)";
}

var _redItems = new Array();		//赤色になる項目のオブジェクト名の記憶場所
var _defaultColors = new Array();	//赤色になる項目の本来の背景色の記憶場所

function recoverDefaultColor() {
	for (var i=0; i<_redItems.length; i++) {
		_redItems[i].style.backgroundColor = _defaultColors[i];
	}
	
	_redItems = new Array();
	_defaultColors = new Array();
}

function alertError(objAndMsgs) {
	for (var i=0; i<objAndMsgs.length; i++) {
		_redItems[_redItems.length] = objAndMsgs[i][0];
		_defaultColors[_defaultColors.length] = objAndMsgs[i][0].currentStyle.backgroundColor;
	}
	
	var allMsg = "";
	for (var i=0; i<objAndMsgs.length; i++) {
		objAndMsgs[i][0].style.backgroundColor = '#8FC0E6';
		if (objAndMsgs[i][1] != "") allMsg += objAndMsgs[i][1] + "\r\n";
	}
		
	if (objAndMsgs.length > 0) {
		if (allMsg != "") {
			alert(allMsg);
		} else {
			alert("入力内容不正");
		}
	}
}

function setErrorColor(objs) {
	recoverDefaultColor();
	for (var i=0; i<objs.length; i++) {
		_redItems[_redItems.length] = objs[i];
		_defaultColors[_defaultColors.length] = 'red';//objs[i].currentStyle.backgroundColor;
	}

	for (var i=0; i<objs.length; i++) {
		objs[i].style.backgroundColor = '#8FC0E6';
	}
}
</script>
