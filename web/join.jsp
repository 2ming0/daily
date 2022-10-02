<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

    String name = request.getParameter("name");
    String get_id = request.getParameter("get_id");


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>

    <link rel="stylesheet" type="text/css" href="css/join.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
    <style>
    *{font-family: 'Do Hyeon', sans-serif;}
    </style>
</head>
<body>
    <header>
        <h1>Daily</h1>
    </header>

    <main>
         
        <form action="complete.jsp/join_overlap.jsp" method="post">   
            <div class="inform">
                <a class="inform_nav">이름</a>
                <input id="name" class="text_input" placeholder="홍길동" type="text" name="input_name">
            </div>     
            
            <div class="inform">
                <a class="inform_nav">아이디</a>
                <input id="id" class="text_input"  placeholder="ID" type="text" name="id">
                <input id="check_overlap_btn" type="button" value="중복확인" onclick="overlap_event()">
            </div>
        </form> 
        <form action="complete.jsp/join_complete.jsp?name=<%=name%>&get_id=<%=get_id%>" method="post">
            <div class="inform">
                <a class="inform_nav">비밀번호</a>
                <input id="pw" class="text_input" placeholder="password" type="password" name="pw">
            </div>
            <div class="inform">
                <a class="inform_nav">비밀번호 확인</a>
                <input id="pw_check" class="text_input" placeholder="check password" type="password" name="pw_check">
            </div>
            <div class="inform"> 
                <a class="inform_nav">전화번호</a>
                <input id="phone" class="text_input" placeholder="ex)010-1234-1234" type="text" name="phonenumber">
            </div>       
            <div class="inform"> 
                <a class="inform_nav">이메일</a>
                <input id="mail" class="text_input" placeholder="ex)abcd@office.kr" type="text" name="mail">
            </div> 
            <select name="department" class="select" id="select_department">
                <option value="choose">부서 선택</option>
                <option value="none">-</option>
                <option value="develop">개발</option>
                <option value="educate">교육</option>
                <option value="marketing">마케팅</option>
            </select>
            <select name="position" class="select" id="select_position">
                <option value="choose">직급 선택</option>
                <option value="manager">관리자</option>
                <option value="leader">팀장</option>
                <option value="employee">사원</option>
            </select>
            <div> 
                <input id ="join_btn" type="button" value="회원가입" onclick="joinEvent()">
            </div>
        </form>
          
    </main>

    <script type="text/javascript">
        var check;

        function overlap_event() {
            check++;
            document.getElementById("check_overlap_btn").type="submit";
        }
        function joinEvent() {
            var id = document.getElementById("id").value;
            var pw = document.getElementById("pw").value;
            var name = document.getElementById("name").value;
            var mail = document.getElementById("mail").value;
            var phone = document.getElementById("phone").value;
            if (!name) {
                alert("이름을 입력해주세요");
            }
            else if (!id) {
                alert("아이디를 입력해주세요");
            }
            else if (check == 0) {
                alert("아이디 중복을 확인해주세요");
            }
            else if (!pw) {
                alert("비밀번호를 입력해주세요");
            }
            else if (document.getElementById("pw").value != document.getElementById("pw_check").value) {
                alert("비밀번호를 확인해주세요");
            }
            else if (!phone) {
                alert("번호를 입력해주세요");
            }            
            else if (!mail) {
                alert("이메일을 입력해주세요");
            }
            else if (document.getElementById("select_department").value == "choose") {
                alert("부서를 선택해주세요");
            }
            else if (document.getElementById("select_position").value == "choose") {
                alert("직급을 선택해주세요");
            }
            // else if (document.getElementById("select_department").value == "none") {
            //     if (document.getElementById("select_position").value == "employee") {
            //         alert("부서와 직급을 확인해주세요");
            //     }
            //     else if (document.getElementById("select_position").value == "leader") {
            //         alert("부서와 직급을 확인해주세요")
            //     }
            //     else {
            //         continue;
            //     }
            // }
            // else if (document.getElementById("select_department").value != "none") {
            //     if (document.getElementById("select_position").value == "manager") {
            //         alert("부서와 직급을 확인해주세요")
            //     }
            // }
            else {
                console.log("SSS")
                document.getElementById("join_btn").type="submit";
            }
        }

        window.onload = function() {
            console.log("<%=get_id%>")
            console.log("<%=name%>")

            if ("<%=name%>" == "null") {
                document.getElementById("name").value = ""
            }
            else {
                document.getElementById("name").value = "<%=name%>"
            }

            if("<%=get_id%>" == "null") {
                document.getElementById("id").value = ""
                check = 0;
            }
            else {
                document.getElementById("id").value = "<%=get_id%>"
                document.getElementById("id").disabled = true;
                check = 1;
            }
        }
    </script>
    
</body>
</html>