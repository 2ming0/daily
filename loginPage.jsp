<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>

    <link rel="stylesheet" type="text/css" href="loginPage.css">

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
        <form action="web/complete.jsp/logincompletePage.jsp" method="post">
            <div>
                <input id="id" class="text_input" placeholder="ID" type="text" name="id">
            </div>
            <div> 
                <input id="pw" class="text_input" placeholder="password" type="password" name="pw">
            </div> 
            <div> 
                <input id ="login_btn" type="button" value="Login" onclick="loginEvent()">
            </div>
            <div id="text">
                <a href="web/join.jsp"><span id="join">회원가입</span></a>
                <span id="search">
                    <a href="web/search_idPage.jsp"><span>아이디/</span></a>
                    <a href="web/search_pwPage.jsp"><span>비밀번호 찾기</span></a> 
                </span>            
            </div>
        </form>
    </main>

    <script type="text/javascript">
        function loginEvent() {
            var id = document.getElementById("id").value;
            var pw = document.getElementById("pw").value;

            if (!id) {
                alert("아이디를 입력해주세요");
            }
            else if (!pw) {
                alert("비밀번호를 입력해주세요");
            }
            else {
                document.getElementById("login_btn").type="submit";
            }
        }
    </script>
    
</body>
</html>