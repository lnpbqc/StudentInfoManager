<%@ page import="com.lnpbqc.po.tclass" %>
<%@ page import="java.util.*" %>
<%@ page import="com.lnpbqc.po.department" %><%--
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
        你好,${admin}
        <a href="user?actionName=logout">LOGOUT</a>
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
                    姓名：<input type="text" name="name">
                    性别：<select class="studentSex">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                    班级:<select class="studentClass">
                        <%
                            for (int i = 0; i <tclassList.size(); i++) {
                                response.setCharacterEncoding("UTF-8");
                                out.write("<option value="+String.valueOf(tclassList.get(i).getId())+">");
                                out.write(String.valueOf(tclassList.get(i).getId()));
                                out.write("</option>");
                            }
                        %>
                    </select>
                    学院:<select class="studentDepartment">
                        <%
                            for (int i = 0; i <departments.size(); i++) {
                                response.setCharacterEncoding("UTF-8");
                                out.write("<option value="+String.valueOf(departments.get(i).getId())+">");
                                out.write(String.valueOf(departments.get(i).getId()));
                                out.write("</option>");
                            }
                        %>
                    </select>
                    生日：<input type="date" name="birthday" />
                    住址：<input type="text" name="nativePlace" />
                    状态:<span id="studentMsg"></span>
                </form>
                <button id="studentSubmit" type="button" onclick="return checkStudent()" style="width: 100px;height: 20px;">提交</button>
                <script>
                    let student = $("#studentInfo");
                    let studentSubmit = $("#studentSubmit");
                    function checkStudent(){
                        let name = $("input[name='name']").val();
                        let sex = $("#studentSex option:selected").val();
                        let c = $("#studentClass option:selected").val();
                        let d = $("#studentDepartment option:selected").val();
                        let b = $("input[name='birthday']").val();
                        let n = $("input[name='nativePlace']").val();
                        let parameter = "&name="+name+"&sex="+sex+"&class="+c+"&department="+d+"&birthday="+b+"&native="+n;
                        $.ajax({
                            type:"POST",
                            url:"/user?actionName=updateStudent"+parameter,
                            dataType:"text",
                            success:function (data){
                                $("#studentMsg").html("成功了："+data);
                            },
                            error:function (data){
                                console.log(data);
                                $("#studentMsg").html("出错了：");
                            }
                        })
                    };
                </script>
            </div>
        </section>
        <section>
            <form>
                <input type="text" name="aaa">
                <input type="button" value="提交" id="asa">
                <script>
                    $("#asa").click(function () {
                        $.ajax({
                            url:"/StudengInfoManager_Web_exploded/user",
                            dataType: "text",
                            type: "POST",
                            success:function (data){
                                alert("成功:"+data);
                            },
                            error:function (data){
                                alert("失败"+data);
                            }
                        })
                        }
                    );
                </script>
            </form>
        </section>
        <section>4</section>
        <section>5</section>
        <section>6</section>
        <section>7</section>
    </main>
    <footer>

    </footer>
    <script type="text/javascript" src="statics/js/main.js"></script>
</body>
</html>