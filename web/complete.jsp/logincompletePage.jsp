<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<% 

    //이전 페이지로부터 온 값의 인코딩을 설정하는 부분(한글 안 깨지게)
    request.setCharacterEncoding("utf-8");

    //이전 페이지로부터 값 받아오는 부분
    String id_get = request.getParameter("id");
    String pw_get = request.getParameter("pw");   

    //데이터베이스 연결 작업
    Class.forName("com.mysql.jdbc.Driver"); //커넥터를 불러오는 명령어 줄
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234");

    //sql문 준비 작업
    String sql = "SELECT id, pw, name, department, position FROM user WHERE id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id_get);

    ResultSet result = query.executeQuery();

    String pw = "";
    String id = "";
    String name = "";
    String department = "";
    String position = "";

    while(result.next()){
        id = result.getString(1);
        pw = result.getString(2);
        name = result.getString(3);
        position = result.getString(4);
        department = result.getString(5);
    }

    if (pw.equals(pw_get)){
        session.setAttribute("name", name);
        session.setAttribute("id", id);
        session.setAttribute("position", position);
        session.setAttribute("department", department);
    }



%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>

</head>
<body>

    <script>
        window.onload = function() {
            console.log("<%=pw%>")
            console.log("<%=pw_get%>")

            if("<%=pw_get%>" == "<%=pw%>") {
                alert("로그인 성공!")
                window.location.href = "../mainPage.jsp"
            }
            else {
                alert("로그인 실패! 비밀번호를 확인해주세요")
                window.location.href = "../../loginPage.jsp"
            }
        }

    </script>
</body>
</html>