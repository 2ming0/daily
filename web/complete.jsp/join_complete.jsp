<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

    //이전 페이지로부터 값 받아오는 부분
    String id = request.getParameter("get_id");
    String pw = request.getParameter("pw");   
    String input_name = request.getParameter("name");
    String phonenumber = request.getParameter("phonenumber");
    String mail = request.getParameter("mail");    
    String department = request.getParameter("department"); 
    String position = request.getParameter("position"); 

    //데이터베이스 연결 작업
    Class.forName("com.mysql.jdbc.Driver"); //커넥터를 불러오는 명령어 줄
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234");

    String sql="INSERT INTO user (id, pw, name, phone, mail, department, position) VALUES (?, ?, ?, ?, ?, ?, ?)";

    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1, id);
    query.setString(2, pw);
    query.setString(3, input_name);
    query.setString(4, phonenumber);
    query.setString(5, mail);
    query.setString(6, department);
    query.setString(7, position);

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
        alert("회원가입 완료")
        window.location.href = "../../loginPage.jsp";
    }
</script>  
</body>
</html>

