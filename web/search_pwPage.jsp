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

    <link rel="stylesheet" type="text/css" href="css/search_page.css">

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
        <form action="complete.jsp/pwSearch_complete.jsp" method="post">
        <div class="inform"> 
            <a>아이디</a>
            <input id="id" class="text_input" placeholder="ID" type="text" name="id">
        </div> 
        <div class="inform">
            <a>이름</a>
            <input id="name" class="text_input" placeholder="홍길동" type="text" name="name">
        </div>        
        <div class="inform"> 
            <a>연락처</a>
            <input id="phone" class="text_input" placeholder="010-0000-0000" type="text" name="phone">
        </div> 
        <div> 
            <input id ="search_btn" type="button" value="비밀번호 찾기" onclick="searchpwEvent()">
        </div>
        </form>
    </main>

    <script type="text/javascript">
        function searchpwEvent() {
            var id = document.getElementById("id").value;
            var name = document.getElementById("name").value;
            var phone = document.getElementById("phone").value;

            if (!id) {
                alert("아이디를 입력해주세요");
            }
            else if (!name) {
                alert("이름을 입력해주세요");
            }
            else if (!phone) {
                alert("연락처를 입력해주세요");
            }
            else {
                document.getElementById("search_btn").type = "submit"
            }
        }
    </script>
    
</body>
</html>