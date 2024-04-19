<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Data</title>
</head>
<body>
	<%
			int total =0,start = 0, recordCount = 5;
			int pgno = request.getParameter("pg")==null?0:Integer.parseInt(request.getParameter("pg"));
			start = pgno*recordCount;
			
			String mobile = request.getParameter("mobile");
			String resultSetMobile="";
			String password = request.getParameter("password");
			
			String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
			String query = "select * from aita.employee limit ?,?";
			
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection  = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, start);
			pstmt.setInt(2, recordCount);
			ResultSet rs = pstmt.executeQuery();
			
			String query1 = "select * from aita.employee where mobile=? and password=?";
			PreparedStatement pstmt1 = connection.prepareStatement(query1);
			pstmt1.setString(1, mobile);
			pstmt1.setString(2,password);
			ResultSet rs1 = pstmt1.executeQuery();
			
			if(rs1.next())
				resultSetMobile=rs1.getString("mobile");
				
		
		%>
		<table border="" name="table1" class="table" id="demo">
			<tr>	
				<th>Name</th>
				<th>Mobile</th>
				<th>Email</th>
				<th>Password</th>
				<th>Location</th>
				<th>Salary</th>
				<th>Action</th>
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
				<td><%=rs.getString(7)%></td>
				<td><%=rs.getString(8)%></td>
	<%	
				String mblNo=rs.getString(2);
				if( mblNo.equals(resultSetMobile))
				{
	%>
	<!-- 			<td><button><a href="EmpDataUpdate.jsp?mobile=<%=rs.getString(2)%>"+>EDIT</a></button></td> --> 
					<td><button onclick="editData(<%=rs.getString(2)%>)" id="edit"> EDIT</button></td> 
	<%
				}
	%>
				</tr>
				
	<%
		}
		String query2 = "select count(*) from aita.employee";
		PreparedStatement pstmt2 = connection.prepareStatement(query2);
		ResultSet rs2 = pstmt2.executeQuery();
		if(rs2.next())
		{
			total = rs2.getInt(1);
		}
		
	%>
		<tr>
			<th colspan="7">
			<table width=100%>
			<tr>
			<%	for(int i=0;i<=total/recordCount;i++)
				{
			%>
			<td><button onclick=nextPage(<%=i%>)><%=i+1%></button></td> 
<!-- 			<td><button><a href="EmpLogin.jsp?pg=<%=i%>"><%=i+1%></a></button></td> -->
			<%
				} 
			%>
			</tr>
			</table>
			</th>		
		</tr>
	<%
		connection.close();
	%>
</table>
<div id="display"></div>
<div ></div>
</body>
</html>