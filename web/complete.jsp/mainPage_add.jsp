<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

    String name = "";
    String id = "";
    String position = "";
    String department = "";

    id = (String)session.getAttribute("id");
    name = (String)session.getAttribute("name");
    position = (String)session.getAttribute("position");
    department = (String)session.getAttribute("department");

    //이전 페이지로부터 값 받아오는 부분
    String todo_date = request.getParameter("todo_date");
    String select_time1 = request.getParameter("select_time1");   
    String select_time2 = request.getParameter("select_time2");
    String select_time3 = request.getParameter("select_time3");
    String todo_content = request.getParameter("todo_content"); 

    int select_time = 0;

    if(select_time1.equals("afternoon")){
        select_time = Integer.parseInt(select_time2)+12;
    }
    else {
        select_time = Integer.parseInt(select_time2);
    }

    String date = todo_date + "-" + select_time + "-" + select_time3;

    //데이터베이스 연결 작업
    Class.forName("com.mysql.jdbc.Driver"); //커넥터를 불러오는 명령어 줄
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234");

    String sql="INSERT INTO schedule (writer, datetime, content) VALUES (?, ?, ?)";

    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1, id);
    query.setString(2, date);
    query.setString(3, todo_content);

    query.executeUpdate(); 

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        window.onload = function() {
            var form = document.createElement('form')
            var input = document.createElement('input')
            input.type = 'hidden'
            input.value = '<%=date%>'.slice(0, 10)
            input.name = 'inquireDateValue'
            form.action = '../mainPage.jsp'
            form.appendChild(input)
            document.body.appendChild(form)
            form.submit()
        }
    </script>
</body>
</html>