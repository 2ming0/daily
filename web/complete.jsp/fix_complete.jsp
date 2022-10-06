<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<%
    request.setCharacterEncoding("utf-8");
    String id = "";
    String dateValue = "";
    id = (String)session.getAttribute("id");

    dateValue = request.getParameter("inquireDateValue");
    LocalDateTime dateTime = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
    String modifyDate = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateTime);
    String idxValue = request.getParameter("indexValue");
    String textValue = request.getParameter("textValue");
    
    Class.forName("com.mysql.jdbc.Driver");
    
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234"); 
    
    String sql = "UPDATE schedule SET content=? WHERE idx=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, textValue);
    query.setString(2, idxValue);
     
    query.executeUpdate();

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
</head>
<body>
    <script>
        window.onload = function(){
            var form = document.createElement('form')
            var input = document.createElement('input')
            input.type = 'hidden'
            input.value = '<%=dateValue%>'
            input.name = 'inquireDateValue'
            console.log(input.value)
            form.action = '../mainPage.jsp'
            form.appendChild(input)
            document.body.appendChild(form)
            form.submit()
        }
    </script>
</body>
</html>