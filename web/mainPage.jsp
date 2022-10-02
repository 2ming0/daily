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
    
    //데이터베이스 연결 작업
    Class.forName("com.mysql.jdbc.Driver"); //커넥터를 불러오는 명령어 줄
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily", "ming", "11234");

    //String get_date = "";
    //String get_content = "";

    //String[] get_date = new String[10];
    //String[] get_content = new String[10];

    //String[][] get_date;
    //get_content = [][];

    //int idx =0;

    //while(result.next()){
    //    get_date[idx] = result.getString("datetime");
    //    get_content[idx] = result.getString("content");
    //    idx++;
    //}

    //String currdate = new java.text.SimpleDateFormat("yyyy/MM").format( new java.util.Date() );

    //String[] date_ = get_date[1]

    //String[] date1 = get_date[0].split(" ");
    //String[] date2 = date1[0].split("-");

    //date__ = integer.toString(get_date[1])

    //String[] date_ = date__.split("-")

    String currentMonth = "";
    String nextMonth = "";
    String writer = "";

    ArrayList<String> team = new ArrayList<String>();

    ArrayList<String> dev_team = new ArrayList<String>();
    ArrayList<String> edu_team = new ArrayList<String>();
    ArrayList<String> mk_team = new ArrayList<String>();
    ArrayList<String> mng_team = new ArrayList<String>();

    
    ArrayList<String> sc_data = new ArrayList<String>();
    


        if (department.equals("manager")){
            String sql = "SELECT name, position, department FROM user WHERE id NOT IN (?) ORDER BY department ASC, position DESC";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, id);
            ResultSet result = query.executeQuery();
        
            while(result.next()) {
                if (result.getString(3).equals("develop")){
                    dev_team.add("[" + "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "," + "'" + result.getString(4) + "'" + "]");
                }
                else if (result.getString(3).equals("education")){
                    edu_team.add("[" + "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "," + "'" + result.getString(4) + "'" + "]");
                }
                else if (result.getString(3).equals("marketing")){
                    mk_team.add("[" + "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "," + "'" + result.getString(4) + "'" + "]");
                }
                else{
                    mng_team.add("[" + "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "," + "'" + result.getString(4) + "'" + "]");
                } 
            }
        }
        else{
            
            String sql = "SELECT name, position, department FROM user WHERE department=? AND id NOT IN (?) ORDER BY department ASC, position DESC";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, department);
            query.setString(2, id);

            ResultSet result = query.executeQuery();
        
            while(result.next()) { 
                team.add("[" +  "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "," + "'" + result.getString(4) + "'" + "]");
            }
        }
        

        currentMonth = request.getParameter("inquireDateValue");
        writer = id;
        if (currentMonth == null || currentMonth.equals("")){
            LocalDateTime dateTime = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
            currentMonth = dateTime.withDayOfMonth(1).format(DateTimeFormatter.ISO_DATE);
            nextMonth = dateTime.plusMonths(1).withDayOfMonth(1).minusDays(1).format(DateTimeFormatter.ISO_DATE) + " 23:59:59";
            String sql = "SELECT content, datetime, idx FROM schedule WHERE datetime BETWEEN ? AND ? AND writer=? ORDER BY datetime ASC";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, currentMonth);
            query.setString(2, nextMonth);
            query.setString(3, writer);
    
            // SQL문 전송 및 결과 받기
            ResultSet result = query.executeQuery();
    
            // result.next 읽어온 테이블에서 읽을 수 있는 다음 줄이 있을때까지 계속 읽기
            while(result.next()) {
                sc_data.add("[" + "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "]");
            }
        }
        else{
            String[] tmp = currentMonth.split("-");
            currentMonth = tmp[0] + "-" + tmp[1] + "-" + "01";
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");         
            LocalDate dateTime = LocalDate.parse(currentMonth, formatter);
            nextMonth = dateTime.plusMonths(1).withDayOfMonth(1).minusDays(1).format(DateTimeFormatter.ISO_DATE) + " 23:59:59";
            String sql = "SELECT content, datetime, idx FROM schedule WHERE datetime BETWEEN ? AND ? AND writer=? ORDER BY datetime ASC";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, currentMonth);
            query.setString(2, nextMonth);
            query.setString(3, writer);
    
            // SQL문 전송 및 결과 받기
            ResultSet result = query.executeQuery();
    
            // result.next 읽어온 테이블에서 읽을 수 있는 다음 줄이 있을때까지 계속 읽기
            while(result.next()) {
                sc_data.add("[" + "'" + result.getString(1) + "'" + "," + "'" + result.getString(2) + "'" + "," + "'" + result.getString(3) + "'" + "]");
            }
        }





%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="wlogin_useridth=device-width, initial-scale=1.0">
    <title>Daily</title>

    <link rel="stylesheet" type="text/css" href="css/mainPage.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
    <style>
    *{font-family: 'Do Hyeon', sans-serif;}
    </style>
    <!-- css에 쓰기 이 전용으로만 따로 만들기-->
</head>
<body>
    <header>
        <h1>Daily</h1>
        <span id="log">
            <a id="user"></a>
            <a href="../loginPage.jsp" id="return_login">logout</a>
        </span>
    </header>    
    <div id="media_nav">
        <img id="media_menu" src="https://cdn-icons-png.flaticon.com/512/4204/4204600.png" onclick="navXEvent()">
        <!-- <div class="member">
            <div id="me">관리자 이00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/753/753345.png" class="access">관리자 안00</div>
        </div>
        <div class="member">
            <div><img src="https://cdn-icons-png.flaticon.com/512/1688/1688400.png" class="access">개발</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">팀장 박00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 김00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 이00</div>
        </div>
        <div class="member">
            <div><img src="https://cdn-icons-png.flaticon.com/512/2849/2849198.png" class="access">교육</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">팀장 한00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 김00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 김00</div>
        </div>
        <div class="member">
            <div><img src="https://cdn-icons-png.flaticon.com/512/3188/3188341.png" class="access">마케팅</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">팀장 하00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 최00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 은00</div>
        </div> -->
    </div>


    <div id="container">

    <nav>
        <!-- <div class="member">
            <div id="me">관리자 이00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/753/753345.png" class="access">관리자 안00</div>
        </div>
        <div class="member">
            <div><img src="https://cdn-icons-png.flaticon.com/512/1688/1688400.png" class="access">개발</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">팀장 박00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 김00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 이00</div>
        </div>
        <div class="member">
            <div><img src="https://cdn-icons-png.flaticon.com/512/2849/2849198.png" class="access">교육</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">팀장 한00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 김00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 김00</div>
        </div>
        <div class="member">
            <div><img src="https://cdn-icons-png.flaticon.com/512/3188/3188341.png" class="access">마케팅</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">팀장 하00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 최00</div>
            <div class="member_name"><img src="https://cdn-icons-png.flaticon.com/512/6276/6276686.png" class="access">사원 은00</div>
        </div> -->
    </nav>


    <main id="main">
        <img id="menu" src="https://cdn-icons-png.flaticon.com/512/4204/4204600.png" onclick="navEvent()">
        <div id="date">
            <img class="next" src="https://cdn-icons-png.flaticon.com/512/271/271220.png" onclick="premonthEvent()">
            <div class="year"></div>
            <div class="year">년</div>
            <div class="month"></div>
            <div class="month">월</div>
            <img class="next" src="https://cdn-icons-png.flaticon.com/512/271/271228.png" onclick="nextmonthEvent()">
        </div>
        <a id="add" onclick="addEvent()">+</a>
        <form action="complete.jsp/mainPage_add.jsp" method="post">
            <div id="add_box">
                <div id="add_box_title">일정 추가</div>
                <input type="date" id="add_date" value="2022-10-01" min="2018-01-01" max="2025-12-31" name="todo_date">
                <select id="select_time1" name="select_time1">
                    <option value="morning">오전</option>
                    <option value="afternoon">오후</option>
                </select>
                <select id="select_time2" name="select_time2">
                    <option value="00">00</option>
                    <option value="01">01</option>
                    <option value="02">02</option>
                    <option value="03">03</option>
                    <option value="04">04</option>
                    <option value="05">05</option>
                    <option value="06">06</option>
                    <option value="07">07</option>
                    <option value="08">08</option>
                    <option value="09">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select>
                <a id="hour">시</a>
                <select id="select_time3" name="select_time3">
                    <option value="00">00</option>
                    <option value="15">15</option>
                    <option value="30">30</option>
                    <option value="45">45</option>
                </select>
                <a id="minute">분</a>
                <input id="input_todo" placeholder="할일이 무엇인가요?" type="text" name="todo_content">
                <input type="submit" value="완료" id="submit">
            </div>
        </form>
        <div class="day">
    <!--         <a id="1date"></a>
            <div>
                <a></a>
                <a class="todo"><del id="schedule1"></del></a>
                <a class="fix" id="fix_1" onclick="fix()">수정</a>
                <a class="del" onclick="del_todo()">삭제</a>                
            </div>
            <div>
                <a>오전 10:00</a>
                <a class="todo"><del>8월 마무리 안된 일정 넘기기</del></a>
                <a class="fix">수정</a>
                <a class="del" onclick="del_todo()">삭제</a>                
            </div>
        </div>
        <div class="day">
            <a>5일</a>
            <div>
                <a>오전 11:00</a>
                <a class="todo"><del>비품 주문</del></a>
                <a class="fix">수정</a>
                <a class="del" onclick="del_todo()">삭제</a>                
            </div>
            <div>
                <a>오후 3:00</a>
                <a class="todo">회식 장소 찾기 & 예약</a>
                <a class="fix">수정</a>
                <a class="del" onclick="del_todo()">삭제</a>                
            </div>
        </div>
        <div class="day">
            <a>8일</a>
            <div>
                <a>오후 6:00</a>
                <a class="todo">회식</a>
                <a class="fix">수정</a>
                <a class="del" onclick="del_todo()">삭제</a>                
            </div>-->
        </div> 
    </main>
</div>

<script type="text/javascript">
    var fix_check = 0;

    function dateEvent(yearValue, monthValue){
            var month = document.getElementsByClassName('month')[0]
            var year = document.getElementsByClassName('year')[0]
            year.innerHTML = yearValue
            month.innerHTML = monthValue
    }

        function monthEvent(year, month){
            if (String(month).length == 1){
                month = '0' + month
            }
            var date = year + '-' + month + '-' + '01'
            var form = document.createElement('form')
            var input = document.createElement('input')
            input.type = 'hidden'
            input.value = date
            input.name = 'inquireDateValue'
            form.action = 'mainPage.jsp'
            form.method = 'POST'
            form.appendChild(input)
            document.body.appendChild(form)
            form.submit()
    }

    function premonthEvent() {
        var month = document.getElementsByClassName('month')[0].innerHTML
        var year = document.getElementsByClassName('year')[0].innerHTML

        month = parseInt(month) - 1
        if (month == 0){ 
                    monthEvent(parseInt(year) - 1, 12)
                }
                else{
                    monthEvent(year, month)
                }
    }

    function nextmonthEvent() {
        var month = document.getElementsByClassName('month')[0].innerHTML
        var year = document.getElementsByClassName('year')[0].innerHTML

        month = parseInt(month) + 1
        if (month == 13){ 
                    monthEvent(parseInt(year) + 1, 1)
                }
                else{
                    monthEvent(year, month)
                }
    }

    function addEvent() {
        document.getElementById("add_box").style.display = "block";
        document.getElementById("container").style = 'background-blend-mode: multiply;';
    }

    function add_submit() {
        document.getElementById("add_box").style.display = "none";
    }

    function fix() {
        const todo_fix = document.getElementById("schedule1").innerHTML
        var df = "wr"
        if (fix_check == 1) {
            
            alert("수정하시겠습니까?")
        }
        else {
            console.log(todo_fix)
            document.getElementById("schedule1").innerHTML = "<input type='text' value=todo_fix>";

            document.getElementById("fix_1").innerHTML = "완료";
            fix_check++;            
        }
    }

    function del_todo() {
        alert("삭제하시겠습니까?")
    }

    function navEvent() {
        document.getElementById("media_nav").style.display = "block";
    }

    function navXEvent() {
        document.getElementById("media_nav").style.display = "none";
    }

    window.onload = function() {





        var currentDate = "<%=currentMonth%>".split('-')
        console.log(currentDate)
        dateEvent(currentDate[0], currentDate[1])


        document.getElementById("add_box").style.display = "none";
        document.getElementById("media_nav").style.display = "none";

        var login_user = "<%=name%>";
            console.log("<%=id%>");
            console.log("<%=name%>");
            console.log("<%=position%>");
            console.log("<%=department%>");

            if (!login_user) {
                console.log("로그인해야댐");
            }
            else {
                document.getElementById("user").innerHTML = login_user;
            }
        
        const offset = new Date().getTimezoneOffset() * 60000;
        const today = new Date(Date.now() - offset);
        const todayString = today.toISOString()
        var selectDate = document.getElementById('date')
        selectDate.value = todayString.slice(0, 10)

        var data = <%=sc_data%>;
            
        if (data.length == 0){
            var date = document.createElement('div')
            date.className = 'date'
            date.innerHTML = '일정을 추가해주세요!'
            document.getElementsByClassName('day')[0].appendChild(date)
        }

        const todayDate = todayString.slice(8, 10)
        const intTodayDay = parseInt(todayDate)
        const intTodayYear = parseInt(todayString.slice(0, 5))
        const intTodayMonth = parseInt(todayString.slice(5, 8))
        const intTodayHour = parseInt(todayString.slice(11, 13))
        const intTodayMin = parseInt(todayString.slice(14, 16))

        const tmpData = []
        for (var item of data){
            tmpData.push(item[1].slice(8, 10))
        }
        const set = new Set(tmpData)
        console.log(set)
        const DateArray = [...set]
        console.log(DateArray)
        for (var item of DateArray){
            var date = document.createElement('div')
            date.className = 'date'
            date.innerHTML = item + '일'
            if (item == todayDate){
                date.className += ' today'
            }
            document.getElementsByClassName('day')[0].appendChild(date)
        }
        for (var item of data){
            var day = item[1].slice(8, 10)
            var date = document.getElementsByClassName('date')
                // 내부 일정칸 생성
            var li = document.createElement('li')
            var time = document.createElement('time')
            var timeValue = item[1].slice(11, 16)
            time.datetime = timeValue 
                
            var intDay = parseInt(day)
            var intYear = parseInt(item[1].slice(0,5))
            var intMonth = parseInt(item[1].slice(5,8))
            var intHour = parseInt(timeValue.slice(0,2))
            var intMin = parseInt(timeValue.slice(3,5))
            console.log(intYear, intMonth)
            console.log(intTodayYear, intTodayMonth)
            if (intHour > 12){
                time.innerHTML = '오후 ' + (intHour -12) + '시 '
            }
            else if (intHour == 12){
                time.innerHTML = '오후 ' + intHour + '시 '
            }
            else if (intHour == 0){
                time.innerHTML = '오전 12시 '
            }
            else{
                time.innerHTML = '오전 ' + intHour + '시 '
            }
            if (intMin != 0){
                time.innerHTML += intMin + '분'
            }
            var planName = document.createElement('div')
            planName.className = 'date_plan'
            planName.innerHTML = item[0]

            console.log(intDay)
                console.log(intTodayDay)
                if (intYear <= intTodayYear && intMonth < intTodayMonth){
                    planName.className += ' past_plan'
                }
                else if (intYear == intTodayYear && intMonth == intTodayMonth && intDay < intTodayDay){
                    planName.className += ' past_plan'   
                }
                else if (intDay == intTodayDay && intHour <= intTodayHour && intMin <= intTodayMin){
                    planName.className += ' past_plan'
                }
                var modifybutton = document.createElement('button')
                modifybutton.className = 'modify_btn'
                modifybutton.innerHTML = '수정'
                modifybutton.id = item[2]
                modifybutton.type = 'button'
                //modifybutton.addEventListener('click', modifyEvent)
                var delbutton = document.createElement('button')
                delbutton.className = 'delete_btn'
                delbutton.innerHTML = '삭제'
                delbutton.id = item[2]
                delbutton.type = 'button'
                //delbutton.addEventListener('click', deleteEvent)
                li.appendChild(time)
                li.appendChild(planName)
                li.appendChild(modifybutton)
                li.appendChild(delbutton)
                for (var dateDiv of date){
                    if (dateDiv.innerText.split('\n')[0].slice(0, -1) == day){
                        dateDiv.appendChild(li)
                    }
                }

                var offsetElement = document.getElementsByClassName('today')[0]
            var location;
            if (offsetElement){
                location = offsetElement.offsetTop
                document.getElementsByClassName('day')[0].scrollTop = location - 150
            }

        }




    }

</script>
    
</body>
</html>