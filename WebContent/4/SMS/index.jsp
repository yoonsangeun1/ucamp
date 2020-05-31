<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
     <html>

    <head>
        <title>sms - jsp </title>
        <script type="text/javascript">
            function setPhoneNumber(val) {
                var numList = val.split("-");
                document.smsForm.sphone1.value = numList[0];
                document.smsForm.sphone2.value = numList[1];
            if(numList[2] != undefined){
                    document.smsForm.sphone3.value = numList[2];
        }
            }

            function loadJSON() {
                var data_file = "/calljson.jsp";
                var http_request = new XMLHttpRequest();
                try {
                    // Opera 8.0+, Firefox, Chrome, Safari
                    http_request = new XMLHttpRequest();
                } catch (e) {
                    // Internet Explorer Browsers
                    try {
                        http_request = new ActiveXObject("Msxml2.XMLHTTP");

                    } catch (e) {

                        try {
                            http_request = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                            // Eror
                            alert("지원하지 않는브라우저!");
                            return false;
                        }

                    }
                }
                http_request.onreadystatechange = function() {
                    if (http_request.readyState == 4) {
                        // Javascript function JSON.parse to parse JSON data
                        var jsonObj = JSON.parse(http_request.responseText);
                        if (jsonObj['result'] == "Success") {
                            var aList = jsonObj['list'];
                            var selectHtml = "<select name=\"sendPhone\" onchange=\"setPhoneNumber(this.value)\">";
                            selectHtml += "<option value='' selected>발신번호를 선택해주세요</option>";
                            for (var i = 0; i < aList.length; i++) {
                                selectHtml += "<option value=\"" + aList[i] + "\">";
                                selectHtml += aList[i];
                                selectHtml += "</option>";
                            }
                            selectHtml += "</select>";
                            document.getElementById("sendPhoneList").innerHTML = selectHtml;
                        }
                    }
                }

                http_request.open("GET", data_file, true);
                http_request.send();
            }
        </script>
    </head>

    <body onload="loadJSON()">

    <form method="post" name="smsForm" action="smssend.jsp">
        <input type="hidden" name="action" value="go">
        <input type="hidden" name="smsType" value="L">
        <h2>추천 식단</h2>
        <textarea name="msg" cols="30" rows="10" style="width:455px;">내용입력</textarea>
        <br />
        <!-- 밑에 rphone 번호는 고객 번호(입력해서 전송하면됩니다) -->
        <input type="hidden" name="rphone" value="010-4200-6313">
        <!-- 발신번호 발신번호 등록된걸로 값입력후 보내시면됩니다. -->
        <input type="hidden" name="sphone1" value="010">
        <input type="hidden" name="sphone2" value="2683">
        <input type="hidden" name="sphone3" value="6932">
        <span id="sendPhoneList"></span>
        <br>
        <!-- test flag
        <input type="text" name="testflag" maxlength="1"> -->
        <!-- 예) 테스트시: Y를 입력시 메시지가 제대로 작동되는지 테스트 하는기능 !-->
        <input type="submit" value="메세지 전송">
    </form>
    </body>

    </html>
            