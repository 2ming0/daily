<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

    //이전 페이지로부터 값 받아오는 부분
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");

    Class.forName("com.mysql.jdbc.Driver"); //커넥터를 불러오는 명령어 줄
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234");

    String sql = "SELECT id FROM user WHERE phone=?";

    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, phone);

    ResultSet result = query.executeQuery();

    String search_id = "";

    while(result.next()){
        search_id = result.getString(1);
    }

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

    

    <script type="text/javascript">

        window.onload = function() {

                alert("당신의 아이디는 <%=search_id%> 입니다")
                window.location.href = "../../loginPage.jsp"

            
        }

    </script>
</body>
</html>