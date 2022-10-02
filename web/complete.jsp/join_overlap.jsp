<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

    //이전 페이지로부터 값 받아오는 부분
    String get_id = request.getParameter("id");
    String name = request.getParameter("input_name");

    Class.forName("com.mysql.jdbc.Driver"); //커넥터를 불러오는 명령어 줄
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234");

    String sql = "SELECT id FROM user WHERE id=?";

    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, get_id);

    ResultSet result = query.executeQuery();

    String id_check = "";

    while(result.next()){
        id_check = result.getString(1);
    }

    int overlap = 0;

    if (id_check.equals(get_id)) {
        overlap++;
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
            if ("<%=overlap%>" == 1) {
                alert("중복된 아이디입니다.")
                window.location.href = "../join.jsp?name=<%=name%>"
            }
            else {
                alert("사용가능한 아이디입니다.")
                window.location.href = "../join.jsp?name=<%=name%>&get_id=<%=get_id%>"
            }
            
        }

    </script>
</body>
</html>