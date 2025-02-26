<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" href="css/n9.css">
<style>
table, th, td {
  border: 1px solid black;
}
.btn btn-danger{
	margin-top: -13px;
}
</style>
</head>
<body>

<div class="kuna38">
<h1><marquee>WELCOME TO DRIEMS</marquee></h1>
</div>
<div class="kuna37">
<a href="AdminPanel.html" class="btn btn-danger">BACK</a><br><br>
</div>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
	    "jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", 
	    "root", 
	    ""
	);
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from car_table");
while(rs.next())
{

 %>
 <table align='center' border='1' width="100" style="width:100%" class="table table-dark">
 <tbody>
 <tr>
 <th width="25%">Email_Id</th>
 <th width="25%">User_Id</th>
 <th width="25%">Password</th>
 <th width="25%">Password1</th>
 </tr>
 <tr>
 <td width="25%"><%= rs.getString(1) %></td>
 <td width="25%"><%=rs.getString(2) %></td>
 <td width="25%"><%=rs.getString(3) %></td>
 <td width="25%"><%=rs.getString(4) %></td>
 </tr>
 </tbody>
  </table>
 

<%
}

}
catch(Exception e)
{
e.printStackTrace();
}
 %>

</body>
</html>