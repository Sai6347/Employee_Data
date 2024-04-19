<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Emp Details</title>
<style>
	#form1{
		padding:30px;
		border:5px solid black;
		background-color:lightgrey;
		border-radius:20px;
		width:500px;
	}
	.input
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
		<form action="" method="get" id="form1">
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
					<input type="text" name="name" id="name" value="<%=rs.getString("name") %>" placeholder="Enter Your Name" class="input"> <br> <br>
					<input type="text" name="mobile" id="mbl" value="<%=rs.getString("mobile") %>" placeholder="Enter Your Mobile Number" class="input"> <br> <br>
					<input type="email" name="mail" id="mail" value="<%=rs.getString("email") %>" placeholder="Enter Your Mail Id" class="input"> <br> <br>
					<input type="password" name="password" id="pwd" value="<%=rs.getString("password") %>" placeholder="Enter Your Password" class="input"> <br> <br>
					<input type="password" name="cpassword" id="cpwd" value="<%=rs.getString("cpassword") %>" placeholder="Confirm Your Password" class="input"> <br> <br>
					<input type="text" name="job" id="job" value="<%=rs.getString("jobrole") %>" placeholder="Enter Your Job Role" class="input"> <br> <br>
					<input type="text" name="location" id="loc" value="<%=rs.getString("location") %>" placeholder="Enter Your Location" class="input"> <br> <br>
					<input type="text" name="salary" id="sal" value="<%=rs.getString("salary") %>" placeholder="Enter Your Salary" class="input"> <br> <br>
			<%
				}
			%>
					<button type="submit" id="btn" name="submit">UPDATE</button>
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
		%>
			<script>
				//alert("Employee Data Updated....");
			</script>
		<%	
			connection1.close();
    	
	%>
</body>
</html>