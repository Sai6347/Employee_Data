<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Emp Data Login</title>
<style>
	form
	{
		padding:30px;
		border:5px solid black;
		background-color:lightgrey;
		border-radius:20px;
	}
	input
	{
		width:250px;
		padding:15px;
		font-size:15px;
		border-radius:10px;
	}
	#btn
	{
		padding:10px;
		border-radius:10px;
		background-color:skyblue;
		font-weight:bold;
	}
	a
	{
		text-decoration:none;
		color:black;
	}
	td
	{
		padding:10px;
	}
</style>
</head>
<script type="text/javascript">
	function editData()
	{
		//var mbl = document.forms["table1"]["rs.getString[2]"].value;
		//alert(mbl);
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
		if(this.readyState == 4 && this.status == 200)
		{
			document.getElementById("demo").innerHTML = this.responseText;
		}
		};
		xhttp.open("GET","UpdateEmp.jsp");
		xhttp.send();
	}

</script>
<body>
	<center>
		<form action="" method="post" name="form1">
			<h2>EMPLOYEE LOGIN</h2>
			<input type="text" name="mobile" id="mbl" placeholder="Enter Your Mobile Number"> <br> <br>
			<input type="password" name="password" id="pwd" placeholder="Enter Your Password"> <br> <br>
			<button type="submit" id="btn">LOGIN</button>
		</form>
		</center>
		<%
			String mobile = request.getParameter("mobile");
			String password = request.getParameter("password");
			
			String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
			String query = "select * from aita.employee";
			
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection  = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
		
		%>
		<table border="" width=700px; name="table1">
			<tr>
				<th>Name</th>
				<th>Mobile</th>
				<th>Email</th>
				<th>Password</th>
				<th>cPassword</th>
				<th>Job</th>
				<th>Location</th>
				<th>Salary</th>
				<th></th>
				<th></th>
			</tr>
		<%
		while(rs!=null && rs.next())
		{
		%>
			<tr>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
				<td><%=rs.getString(7) %></td>
				<td><%=rs.getString(8) %></td>
				<td><button type="button" name="submit"><a href="EmpDataUpdate.jsp?mobile=<%=rs.getString(2)%>"> EDIT</a> </button></td>
				<td><button type="button" name="submit"><a href="DeleteEmpData.jsp?mobile=<%=rs.getString(2)%>"> DELETE </a> </button></td>
			</tr>
		<%
		}
		connection.close();
		%>
</table>
<div id="demo"></div>
</body>
</html>

<!-- <a href="EmpDataUpdate.jsp?mobile=" target="self"> -->