<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Data</title>
<style>
	form
	{
		padding:20px;
		border:5px solid black;
		background-color:lightgrey;
	}
	input
	{
		width:250px;
		padding:12px;
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
</style>
</head>
<script type="text/javascript">
	function editData(mbl)
	{	 
		var xhttp =  new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
			if (this.readyState == 4 && this.status === 200) 
			{
				document.getElementById("demo").innerHTML = this.responseText;
			}
		};
		
		xhttp.open("GET","UpdateEmp.jsp?mobile=");
		console.log(mbl);
		xhttp.send();
		
	}
	
	
</script>
<body>
	
			<center>
				<form action="UpdateEmp.jsp" method="get">
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
			String query = "select * from aita.employee ";
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection  = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			
			ResultSet rs = pstmt.executeQuery();
			
	%>		
			<table border="" width=750px;>
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
						
					</tr>
					
	<%			
				while(rs!=null && rs.next())
				{
	%>
					<tr>
						<td><%=rs.getString(1)%></td>
						<td><%=rs.getString(2)%></td>
						<td><%=rs.getString(3)%></td>
						<td><%=rs.getString(4)%></td>
						<td><%=rs.getString(5)%></td>
						<td><%=rs.getString(6)%></td>
						<td><%=rs.getString(7)%></td>
						<td><%=rs.getString(8)%></td>
						<td><button type="submit" onclick= "editData(<%=rs.getString(2) %>)">EDIT</button></td>
						
					</tr>
	<%
				}
				connection.close();
	%>
</table>
<div id="demo"></div>
</body>
</html>

<!-- 
	function deleteData(mbl)
	{
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
			if(this.readyState ==4 && this.status == 200)
			{
				document.getElementById("demo").innerHTML = this.responsiveText;
			}
		};
		console.log(mbl);
		xhttp.open("GET","DeleteEmpData.jsp?mobile=mbl");
		xhttp.send();
	}-->
	
	
	
	<!-- 
		$.ajax({
			url:'UpdateEmp.jsp'+mbl,
			method='GET',
			success: function(data){
				$('#name').val(data.name);
				$('#mobile').val(data.mobile);
				$('#email').val(data.email);
				$('#pwd').val(data.pwd);
				$('#cpwd').val(data.cpwd);
				$('#job').val(data.job);
				$('#loc').val(data.loc);
				$('#sal').val(data.sal);
			}
		})	
	 -->