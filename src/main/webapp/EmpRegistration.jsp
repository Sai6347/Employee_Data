<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Emp Registration</title>
<style>
	#form1
	{
		padding:30px;
		border:5px solid black;
		background-color:papayawhip;
		border-radius:20px;
		width:50%;
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
</style>
</head>
<body>
<center>
<form action="" method="post" id="form1">
	<h1>Employee Registration</h1>
	<input type="text" name="name" id="name" placeholder="Enter Your Name" required=""> <br> <br>
	<input type="text" name="mobile" id="mbl" placeholder="Enter Your Mobile Number" required=""> <br> <br>
	<input type="email" name="mail" id="mail" placeholder="Enter Your Mail Id" required=""> <br> <br>
	<input type="password" name="password" id="pwd" placeholder="Enter Your Password" required=""> <br> <br>
	<input type="password" name="cpassword" id="cpwd" placeholder="Confirm Your Password" required=""> <br> <br>
	<input type="text" name="job" id="job" placeholder="Enter Your Job Role" required=""> <br> <br>
	<input type="text" name="location" id="loc" placeholder="Enter Your Location" required=""> <br> <br>
	<input type="text" name="salary" id="sal" placeholder="Enter Your Salary" required=""> <br> <br>
	<button type="submit" id="btn">Register</button>			
</form>  
</center>
<%
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String mailId = request.getParameter("mail");
		String password = request.getParameter("password");
		String cPassword  = request.getParameter("cpassword");
		String job = request.getParameter("job");
		String location = request.getParameter("location");
		String salary = request.getParameter("salary");
		 
		if(password !=null && password.equals(cPassword))
		{
			String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
			String query = "insert into aita.employee values(?,?,?,?,?,?,?,?)";
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, name);
			pstmt.setString(2, mobile);
			pstmt.setString(3, mailId);
			pstmt.setString(4, password);
			pstmt.setString(5, cPassword);
			pstmt.setString(6, job);
			pstmt.setString(7, location);
			pstmt.setString(8, salary);
			
			int value = pstmt.executeUpdate();
			if(value>0)
			{
				response.sendRedirect("EmpLogin.jsp");
			}	
		}
		
%>

</body>
</html>