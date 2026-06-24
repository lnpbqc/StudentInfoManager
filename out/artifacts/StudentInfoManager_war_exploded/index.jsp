<%--
  Created by IntelliJ IDEA.
  User: lnpbqc
  Date: 2022/12/20
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="statics/css/index.css">
    <script type="text/javascript" src="statics/js/jQuery-3.6.1.min.js"></script>
</head>
<body>
    <div id="info">
        <div id="l">登录</div>
        <div id="r">注册</div>
    </div>
    <form action="user" id="login" method="post">
        <input type="hidden" name="actionName" value="login">
        <input type="text" name="name" placeholder="请输入用户名" autocomplete="off" id="loginName" value="${name}">
        <input type="password" name="pwd" placeholder="请输入密码" id="loginPwd" value="${pwd}">
        <div id="loginMsg"></div>
        <input type="submit" onclick="return checkLogin()" value="登录">
    </form>
    <form action="user" id="register" method="post">
        <input type="hidden" name="actionName" value="register">
        <input type="text" name="name" placeholder="请输入用户名" autocomplete="off" id="registerName">
        <input type="password" name="pwd" placeholder="请输入密码" id="registerPwd">
        <div id="registerMsg"></div>
        <input type="submit" onclick="return checkRegister()" value="注册">
    </form>
    <script>
        let login = $("#login");
        let register = $("#register");
        let lmsg = $("#loginMsg");
        let rmsg = $("#registerMsg");
        $(()=>{
            register.hide();
            lmsg.hide();
            rmsg.hide();
        })
        let l = $("#l");
        let r = $("#r");
        l.click(()=>{
            register.hide();
            rmsg.hide();
            login.show();
        })
        r.click(()=>{
            login.hide();
            lmsg.hide();
            register.show();
        })
        function checkLogin(){
            let name = $("#loginName").val();
            let pwd = $("#loginPwd").val();
            if(name==null||name==""){
                lmsg.html("用户名为空");
                lmsg.show();
                return false;
            }
            if(pwd==null||pwd==""){
                lmsg.html("密码为空");
                lmsg.show();
                return false;
            }
            lmsg.hide();
            return true;
        }
        function checkRegister(){
            let name = $("#registerName").val();
            let pwd = $("#registerPwd").val();
            if(name==null||name==""){
                rmsg.html("用户名为空");
                rmsg.show();
                return false;
            }
            if(pwd==null||pwd==""){
                rmsg.html("密码为空");
                rmsg.show();
                return false;
            }
            rmsg.show();
            return true;
        }
    </script>
</body>
</html>
