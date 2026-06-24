<%--
  Created by IntelliJ IDEA.
  User: lnpbqc
  Date: 2022/12/30
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script type="text/javascript" src="statics/js/jQuery-3.6.1.min.js"></script>
</head>
<body>
    <form action="/modify" method="post" id="rechangeStudent">
        <table>
            <tr>
                <th>姓名:</th>
                <th><input type="text" name="name" autocomplete="off" value="${name}"></th>
            </tr>
            <tr>
                <th>性别:</th>
                <th>
                    <input type="text" name="gender" autocomplete="off" value="${gender}">
                </th>
            </tr>
            <tr>
                <th>班级:</th>
                <th>
                    <input type="text" name="tclass" autocomplete="off" value="${tclass}">
                </th>
            </tr>
            <tr>
                <th>学院:</th>
                <th>
                    <input type="text" name="department" autocomplete="off" value="${department}">
                </th>
            </tr>
            <tr>
                <th>生日:</th>
                <th><input type="date" name="birthday" value="${birthday}"/></th>
            </tr>
            <tr>
                <th>住址:</th>
                <th><input type="text" name="nativePlace" autocomplete="off" value="${requestScope.get("native")}"/></th>
            </tr>
        </table>
    </form>
    <button type="button" onclick="checkStudent()">修改</button>
    <%
        Cookie[] cookies = request.getCookies();
        String name = null;
        String pwd = null;
        for (Cookie c:cookies){
            if(c.getName().equals("user")){
                String[] split = c.getValue().split("-");
                name = split[0];
                pwd = split[1];
            }
        }
        out.write("<input type='hidden' name='un' value='"+name+"'><input type='hidden' name='up' value='"+pwd+"'>");
    %>
    <script>
        function checkStudent(){
            let name = $("input[name='name']").val();
            let sex = $("input[name='gender']").val();
            let c = $("input[name='tclass']").val();
            let d = $("input[name='department']").val();
            let b = $("input[name='birthday']").val();
            let n = $("input[name='nativePlace']").val();
            let parameter = "&name="+name+"&sex="+sex+"&class="+c+"&department="+d+"&birthday="+b+"&native="+n;
            let un = $("input[name='un']").val();
            let up = $("input[name='up']").val();
            $.ajax({
                type:"POST",
                url:"/StudentInfoManager/modify?actionName=update"+parameter,
                dataType:"text",
                success:function (data){
                    alert("成功了："+data);
                    // window.location.replace("/StudentInfoManager/user?actionName=login&name="+un+"&pwd="+up);
                    window.location.replace("/StudentInfoManager/user?actionName=login");
                },
                error:function (data){
                    console.log(data);
                    alert("出错了：");
                }
            })
        }
    </script>
</body>
</html>
