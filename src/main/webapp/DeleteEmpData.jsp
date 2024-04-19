<!DOCTYPE html>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Employee</title>
<style>
	
</style>
</head>
<body>
	<%
	String mobile = request.getParameter("mobile");
	String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
	String query = "delete from aita.employee where mobile=?";
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection connection = DriverManager.getConnection(url);
	PreparedStatement pstmt = connection.prepareStatement(query);
	pstmt.setString(1, mobile);
	int value = pstmt.executeUpdate();
	if(value>0){
	%>
	<script type="text/javascript">
		alert("One Record Deleted");
	</script>
	<%} %>
</body>
</html>