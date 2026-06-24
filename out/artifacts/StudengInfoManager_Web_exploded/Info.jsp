<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: lnpbqc
  Date: 2022/12/23
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
</body>
</html>
