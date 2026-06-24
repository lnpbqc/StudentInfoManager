<%@ page import="java.util.*" %>
<%@ page import="com.lnpbqc.po.*" %><%--
  Created by IntelliJ IDEA.
  User: lnpbqc
  Date: 2022/12/21
  Time: 12:16
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
    <link rel="stylesheet" href="statics/css/main.css">
    <script type="text/javascript" src="statics/js/jQuery-3.6.1.min.js"></script>
</head>
<body>
    <header>
        你好,${admin},欢迎来到学生信息管理系统
        <a href="/StudentInfoManager/user?actionName=logout">LOGOUT</a>
    </header>
    <aside>
        <ul>
            <li>
                首页
            </li>
            <li>
                学生信息录入
            </li>
            <li>
                学生信息修改
            </li>
            <li>
                学生学籍变更
            </li>
            <li>
                学生奖励录入
            </li>
            <li>
                学生惩罚录入
            </li>
            <li>
                等级变更
            </li>
        </ul>
    </aside>
    <main>
        <section>
            <table>
                <%
                    HashMap dbInfo = (HashMap<String,Object>)session.getAttribute("DBInfo");
                    if(dbInfo!=null){
                        Iterator iterator = dbInfo.keySet().iterator();
                        while(iterator.hasNext()){
                            Object next = iterator.next();
                            Object o = dbInfo.get(next);
                            if(o==null)dbInfo.put(next,Integer.valueOf(0));
                        }
                    }
                %>
                <thead>
                <tr>
                    <th>项目名称</th>
                    <th>数目</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>学生</td>
                    <td><%=dbInfo==null?"":dbInfo.get("studentNum")%></td>
                </tr>
                <tr>
                    <td>班级</td>
                    <td><%=dbInfo==null?"":dbInfo.get("classNum")%></td>
                </tr>
                <tr>
                    <td>学籍变更</td>
                    <td><%=dbInfo==null?"":dbInfo.get("changeNum")%></td>
                </tr>
                <tr>
                    <td>惩罚</td>
                    <td><%=dbInfo==null?"":dbInfo.get("punishmentNum")%></td>
                </tr>
                <tr>
                    <td>奖励</td>
                    <td><%=dbInfo==null?"":dbInfo.get("rewardNum")%></td>
                </tr>
                <tr>
                    <td>学院</td>
                    <td><%=dbInfo==null?"":dbInfo.get("departmentNum")%></td>
                </tr>
                <tr>
                    <td>学籍变更类型</td>
                    <td><%=dbInfo==null?"":dbInfo.get("changeCodeNum")%></td>
                </tr>
                <tr>
                    <td>惩罚类型</td>
                    <td><%=dbInfo==null?"":dbInfo.get("punishLevelNum")%></td>
                </tr>
                <tr>
                    <td>奖励类型</td>
                    <td><%=dbInfo==null?"":dbInfo.get("rewardLevelNum")%></td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <small>注：只为页面载入时的数据。</small>
                </tr>
                </tfoot>
            </table>
        </section>
        <section>
            <div>
                <%
                    List<tclass> tclassList = (List<tclass>) request.getSession().getAttribute("classs");
                    List<department> departments = (List<department>)request.getSession().getAttribute("department");
                %>
                <form action="/user" method="post" id="studentInfo">
                    <table>
                        <tr>
                            <th>学号</th>
                            <th><input type="text" name="studentid" autocomplete="off"></th>
                        </tr>
                        <tr>
                            <th>姓名:</th>
                            <th><input type="text" name="name" autocomplete="off"></th>
                        </tr>
                        <tr>
                            <th>性别:</th>
                            <th>
                                <select class="studentSex" name="gender">
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </th>
                        </tr>
                        <tr>
                            <th>班级:</th>
                            <th>
                                <select class="studentClass">
                                    <%
                                        for (int i = 0; i <tclassList.size(); i++) {
                                            response.setCharacterEncoding("UTF-8");
                                            out.write("<option value="+String.valueOf(tclassList.get(i).getId())+">");
                                            out.write(String.valueOf(tclassList.get(i).getName()));
                                            out.write("</option>");
                                        }
                                    %>
                                </select>
                            </th>
                        </tr>
                        <tr>
                            <th>学院:</th>
                            <th>
                                <select class="studentDepartment">
                                    <%
                                        for (int i = 0; i <departments.size(); i++) {
                                            response.setCharacterEncoding("UTF-8");
                                            out.write("<option value="+departments.get(i).getId()+">");
                                            out.write(String.valueOf(departments.get(i).getName()));
                                            out.write("</option>");
                                        }
                                    %>
                                </select>
                            </th>
                        </tr>
                        <tr>
                            <th>生日:</th>
                            <th><input type="date" name="birthday" /></th>
                        </tr>
                        <tr>
                            <th>住址:</th>
                            <th><input type="text" name="nativePlace" autocomplete="off"/></th>
                        </tr>
                    </table>
                    <span class="studentMsg"></span>
                </form>
                <button id="studentSubmit" type="button" onclick="checkStudent()">提交</button>
                <script>
                    let student = $("#studentInfo");
                    let studentSubmit = $("#studentSubmit");
                    function checkStudent(){
                        let id = $("input[name='studentid']").val();
                        let name = $("input[name='name']").val();
                        let sex = $(".studentSex option:selected").val();
                        let c = $(".studentClass").val();
                        let d = $(".studentDepartment").val();
                        let b = $("input[name='birthday']").val();
                        let n = $("input[name='nativePlace']").val();
                        let parameter = "&id="+id+"&name="+name+"&sex="+sex+"&class="+c+"&department="+d+"&birthday="+b+"&native="+n;
                        $.ajax({
                            type:"POST",
                            url:"/StudentInfoManager/user?actionName=updateStudent"+parameter,
                            dataType:"text",
                            success:function (data){
                                $(".studentMsg").html(data);
                            },
                            error:function (data){
                                console.log(data);
                                $(".studentMsg").html("出错了：");
                            }
                        })
                    };
                </script>
            </div>
        </section>

        <section>
            <form id="searchById">
                请输入查询学生的学号:<input type="text" name="id" autocomplete="off">
                <input type="button" value="搜索" id="asa">
                <script>
                    $("#asa").click(function () {
                            let id = document.querySelector("#searchById").querySelector("input[name='id']").value;
                            $.ajax({
                                url:"/StudentInfoManager/user?actionName=searchById"+"&studentid="+id,
                                dataType: "json",
                                type: "POST",
                                success:function (data){
                                    console.log(data);
                                    $("#infoOfStudent").html("<tr>"
                                        +"<td>"+data.studentid+"</td>"
                                        +"<td>"+data.name+"</td>"
                                        +"<td>"+data.sex+"</td>"
                                        +"<td>"+data.tclass+"</td>"
                                        +"<td>"+data.department+"</td>"
                                        +"<td>"+data.birthday+"</td>"
                                        +"<td>"+data.native_place+"</td>"
                                        +"<td>"+"<a href='/StudentInfoManager/modify?actionName=in&id="+data.studentid+"'>修改</a>"+"</td>"
                                        +"</tr>")
                                },
                                error:function (data){
                                    console.log("失败");
                                    console.log(data);
                                }
                            })
                        }
                    );
                </script>
            </form>

            <div class="Info">
                <table border="1" cellspacing="2px" style="margin: auto;">
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>班级</th>
                        <th>学院</th>
                        <th>生日</th>
                        <th>地址</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="infoOfStudent">

                    </tbody>
                </table>
            </div>

        </section>
        <section>
            <%
                List<change_code> changeCodeList = (List<change_code>) session.getAttribute("change_code");
            %>
            <form action="" id="createChange">
                编号: <input type="text" name="id" autocomplete="off">
                学生学号: <input type="text" name="studentid" autocomplete="off">
                变更原由: <select name="reason">
                <%
                    for(change_code c:changeCodeList){
                        out.write("<option value="+c.getCode()+">"+c.getDescription()+"</option>");
                    }
                %>
            </select>
                时间: <input type="date" name="rec_time" autocomplete="off">
                备注: <input type="text" name="description" autocomplete="off">
                <button type="button" onclick="checkChange()">提交</button>
                <script>
                    function checkChange(){
                        let form = $("#createChange");
                        let id = form.find("input[name='id']").val();
                        let studentid = form.find("input[name='studentid']").val();
                        let reason = form.find("select option:selected").val();
                        let rec_time = form.find("input[name='rec_time']").val();
                        let description = form.find("input[name='description']").val();
                        let parameter = "";
                        // if(id===""||studentid===""||reason===""||rec_time===""||description==="")return;
                        parameter = "&id="+id+"&studentid="+studentid+"&reason="+reason+"&rec_time="+rec_time+"&description="+description;
                        $.ajax({
                            url:"/StudentInfoManager/change?actionName=update"+parameter,
                            type:"POST",
                            dataType:"text",
                            success:function (data){
                                alert(data);
                            },
                            error:function (data){
                                alert(data);
                            }
                        })
                    }
                </script>
            </form>

            <div class="Info">
                <button onclick="searchInfoOfChange()">查找</button>
                <script>
                    function searchInfoOfChange(){
                        $.ajax({
                            url:"/StudentInfoManager/change?actionName=search",
                            dataType: "json",
                            type: "POST",
                            success:function (data){
                                let str = "";
                                for (let i = 0; i < data.length; i++) {
                                    str+="<tr>"
                                        +"<td>"+data[i].id+"</td>"
                                        +"<td>"+data[i].studentid+"</td>"
                                        +"<td>"+data[i].change+"</td>"
                                        +"<td>"+data[i].rec_time+"</td>"
                                        +"<td>"+data[i].description+"</td>"
                                        +"</tr>"
                                }
                                $("#infoOfChange").html(str);
                            },
                            error:function (data){
                                console.log("失败");
                                console.log(data);
                            }
                        })
                    }
                </script>
                <table border="1" cellspacing="2px" style="margin: auto;">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>学号</th>
                        <th>变更原由</th>
                        <th>时间</th>
                        <th>备注</th>
                    </tr>
                    </thead>
                    <tbody id="infoOfChange">

                    </tbody>
                </table>
            </div>


        </section>
        <section>
            <%
                List<reward_levels> rewardLevelsList = (List<reward_levels>) session.getAttribute("reward_code");
            %>
            <form action="" id="createReward">
                编号: <input type="text" name="id" autocomplete="off">
                学生学号: <input type="text" name="studentid" autocomplete="off">
                奖励级别: <select name="reason">
                <%
                    for(reward_levels r:rewardLevelsList){
                        out.write("<option value="+r.getCode()+">"+r.getDescription()+"</option>");
                    }
                %>
            </select>
                时间: <input type="date" name="rec_time" autocomplete="off">
                备注: <input type="text" name="description" autocomplete="off">
                <button type="button" onclick="checkReward()">提交</button>
                <script>
                    function checkReward(){
                        let form = $("#createReward");
                        let id = form.find("input[name='id']").val();
                        let studentid = form.find("input[name='studentid']").val();
                        let reason = form.find("select option:selected").val();
                        let rec_time = form.find("input[name='rec_time']").val();
                        let description = form.find("input[name='description']").val();
                        let parameter = "";
                        if(id===""||studentid===""||reason===""||rec_time===""||description==="")return;
                        else parameter = "&id="+id+"&studentid="+studentid+"&reason="+reason+"&rec_time="+rec_time+"&description="+description;
                        $.ajax({
                            url:"/StudentInfoManager/reward?actionName=update"+parameter,
                            type:"POST",
                            dataType:"text",
                            success:function (data){
                                alert(data);
                            },
                            error:function (data){
                                alert(data);
                            }
                        })
                    }
                </script>
            </form>

            <div class="Info">
                <button onclick="searchInfoOfReward()">查找</button>
                <script>
                    function searchInfoOfReward(){
                        $.ajax({
                            url:"/StudentInfoManager/reward?actionName=search",
                            dataType: "json",
                            type: "POST",
                            success:function (data){
                                let str = "";
                                for (let i = 0; i < data.length; i++) {
                                    str+="<tr>"
                                        +"<td>"+data[i].id+"</td>"
                                        +"<td>"+data[i].studentid+"</td>"
                                        +"<td>"+data[i].levels+"</td>"
                                        +"<td>"+data[i].rec_time+"</td>"
                                        +"<td>"+data[i].description+"</td>"
                                        +"</tr>"
                                }
                                $("#infoOfReward").html(str);
                            },
                            error:function (data){
                                console.log("失败");
                                console.log(data);
                            }
                        })
                    }
                </script>
                <table border="1" cellspacing="2px" style="margin: auto;">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>学号</th>
                        <th>奖励级别</th>
                        <th>时间</th>
                        <th>备注</th>
                    </tr>
                    </thead>
                    <tbody id="infoOfReward">

                    </tbody>
                </table>
            </div>


        </section>
        <section>
            <%
                List<punish_levels> punishLevelsList = (List<punish_levels>) session.getAttribute("punish_code");
            %>
            <form action="" id="createPunish">
                编号: <input type="text" name="id" autocomplete="off">
                学生学号: <input type="text" name="studentid" autocomplete="off">
                惩罚级别: <select name="reason">
                <%
                    for(punish_levels p:punishLevelsList){
                        out.write("<option value="+p.getCode()+">"+p.getDescription()+"</option>");
                    }
                %>
            </select>
                是否生效: <select name="enable">
                <option value="1">是</option>
                <option value="0">否</option>
            </select>
                时间: <input type="date" name="rec_time" autocomplete="off">
                备注: <input type="text" name="description" autocomplete="off">
                <button type="button" onclick="checkPunish()">提交</button>
                <script>
                    function checkPunish(){
                        let form = $("#createPunish");
                        let id = form.find("input[name='id']").val();
                        let studentid = form.find("input[name='studentid']").val();
                        let reason = form.find("select[name='reason'] option:selected").val();
                        let rec_time = form.find("input[name='rec_time']").val();
                        let enable = form.find("select[name='enable'] option:selected").val();
                        let description = form.find("input[name='description']").val();
                        let parameter = "";
                        if(id===""||studentid===""||reason===""||rec_time===""||description==="")return;
                        else parameter = "&id="+id+"&studentid="+studentid+"&reason="+reason+"&rec_time="+rec_time+"&enable="+enable+"&description="+description;
                        $.ajax({
                            url:"/StudentInfoManager/punish?actionName=update"+parameter,
                            type:"POST",
                            dataType:"text",
                            success:function (data){
                                alert(data);
                            },
                            error:function (data){
                                alert(data);
                            }
                        })
                    }
                </script>
            </form>

            <div class="Info">
                <button onclick="searchInfoOfPunish()">查找</button>
                <script>
                    function searchInfoOfPunish(){
                        $.ajax({
                            url:"/StudentInfoManager/punish?actionName=search",
                            dataType: "json",
                            type: "POST",
                            success:function (data){
                                let str = "";
                                for (let i = 0; i < data.length; i++) {
                                    str+="<tr>"
                                        +"<td>"+data[i].id+"</td>"
                                        +"<td>"+data[i].studentid+"</td>"
                                        +"<td>"+data[i].levels+"</td>"
                                        +"<td>"+data[i].rec_time+"</td>"
                                        +"<td>"+data[i]['enable']+"</td>"
                                        +"<td>"+data[i].description+"</td>"
                                        +"</tr>"
                                }
                                $("#infoOfPunish").html(str);
                            },
                            error:function (data){
                                console.log("失败");
                                console.log(data);
                            }
                        })
                    }
                </script>
                <table border="1" cellspacing="2px" style="margin: auto;">
                    <thead>
                    <tr>
                        <th>编号</th>
                        <th>学号</th>
                        <th>惩罚级别</th>
                        <th>时间</th>
                        <th>是否生效</th>
                        <th>备注</th>
                    </tr>
                    </thead>
                    <tbody id="infoOfPunish">

                    </tbody>
                </table>
            </div>

        </section>
        <section>
            <form action="" id="tableOfDB">
                编号: <input type="text" name="code" autocomplete="off">
                备注: <input type="text" name="description" autocomplete="off">
                表单: <select name="table">
                <option value="change_code">学籍变更</option>
                <option value="reward_levels">奖励等级</option>
                <option value="punish_levels">惩罚等级</option>
            </select>
                <button type="button" onclick="checkGrade()">提交</button>
                <script>
                    function checkGrade(){
                        let form = $("#tableOfDB");
                        let code = form.find("input[name='code']").val();
                        let description = form.find("input[name='description']").val();
                        let table = form.find("select option:selected").val();
                        let parameter = "&code="+code+"&description="+description+"&table="+table;
                        $.ajax({
                            url:"/StudentInfoManager/modifyTable?actionName=update"+parameter,
                            type:"POST",
                            dataType:"text",
                            success:function (data){
                                alert(data);
                            },
                            error:function (data){
                                alert(data);
                            }
                        })
                    }
                </script>
            </form>
        </section>
    </main>
    <footer>

    </footer>
    <script type="text/javascript" src="statics/js/main.js"></script>
</body>
</html>