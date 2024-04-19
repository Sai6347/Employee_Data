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
<title>Emp Data Update</title>
<style>
	#form{
		padding:30px;
		border:5px solid black;
		background-color:lightgrey;
		border-radius:20px;
		width:500px;
		position:relative;
		top:50px;
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
	#h2
	{
		color:green;
		font-weight:bold;
	}
	a
	{
		text-decoration:none;
		color:black;
	}
</style>
</head>
<body>
	<center>
		<form action="UpdatedDataStore.jsp" method="post" id="form">
			<h2>Update Employee Data</h2>
			<%
				String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
				String query = "select * from aita.employee where mobile=?";
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection(url);
				String mblno = request.getParameter("mobile");
				PreparedStatement pstmt = connection.prepareStatement(query);
				pstmt.setString(1, mblno);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next())
				{
			%>
				<input type="text" name="name" id="name" value="<%=rs.getString("name")%>" placeholder="Enter Your Name" class="input"> <br> <br>
				<input type="text" name="mobile" id="mbl" value="<%=rs.getString("mobile")%>" placeholder="Enter Your Mobile Number" class="input"> <br> <br>
				<input type="email" name="mail" id="mail" value="<%=rs.getString("email")%>" placeholder="Enter Your Mail Id" class="input"> <br> <br>
				<input type="password" name="password" id="pwd" value="<%=rs.getString("password")%>" placeholder="Enter Your Password" class="input"> <br> <br>
				<input type="password" name="cpassword" id="cpwd" value="<%=rs.getString("cpassword")%>" placeholder="Confirm Your Password" class="input"> <br> <br>
				<input type="text" name="job" id="job" value="<%=rs.getString("jobrole")%>" placeholder="Enter Your Job Role" class="input"> <br> <br>
				<input type="text" name="location" id="loc" value="<%=rs.getString("location")%>" placeholder="Enter Your Location" class="input"> <br> <br>
				<input type="text" name="salary" id="sal" value="<%=rs.getString("salary")%>" placeholder="Enter Your Salary" class="input"> <br> <br>
			<%
				}
			%>
				<button type="submit" id="btn" name="submit">UPDATE</button>
		</form>
	</center>
			
</body>
</html>