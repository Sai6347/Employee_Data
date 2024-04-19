<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Updated Data Store</title>
</head>
<body>
<%
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String mailId = request.getParameter("mail");
		String password = request.getParameter("password");
		String cPassword  = request.getParameter("cpassword");
		String job = request.getParameter("job");
		String location = request.getParameter("location");
		String salary = request.getParameter("salary");
		
		String url1 = "jdbc:mysql://localhost:3307?user=root&password=1234";
		String query1 = "update aita.employee set name=?,email=?,password=?,cpassword=?,jobrole=?,location=?,salary=? where mobile=?";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection connection1 = DriverManager.getConnection(url1);
		PreparedStatement pstmt1 = connection1.prepareStatement(query1);
		pstmt1.setString(1, name);
		pstmt1.setString(2, mailId);
		pstmt1.setString(3, password);
		pstmt1.setString(4, cPassword);
		pstmt1.setString(5, job);
		pstmt1.setString(6, location);
		pstmt1.setString(7, salary);
		pstmt1.setString(8, mobile);
		
		int value = pstmt1.executeUpdate();
		if(value>0)
		{
	%>	
			<script>
				alert("One Employee Record Updated...")
			</script>
	<%		
		}
		else
		{
	%>	
			<script>
				alert("No Record Updated...")
			</script>
	<%		
			}
		connection1.close();
		%>
</body>
</html>