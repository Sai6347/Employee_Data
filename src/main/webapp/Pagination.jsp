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
<title>Pagination</title>
<style>
	
	tr
	{
		
		text-align:center;
	}
	td
	{
		width:100px;
		height:30px;
	}
</style>

</head>
<script>
	function nextPage(pg)
	{	 
		var xhttp =  new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
			if(this.readyState == 4 && this.status === 200) 
			{
				document.getElementById("demo").innerHTML = xhttp.responseText;
			}
		};
		
		xhttp.open("GET","Pagination.jsp?pg="+pg);
		console.log(pg);
		xhttp.send();
		
	}
</script>
<body>
<div ></div>
	<%
			int total =0,start = 0, recordCount = 5;
			int pgno = request.getParameter("pg")==null?0:Integer.parseInt(request.getParameter("pg"));
			start = pgno*recordCount;
			String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
			String query = "select * from aita.employee limit ?,?";			
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection  = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, recordCount);
			ResultSet rs = pstmt.executeQuery();
			
	%>
		<table border="" width=90%; id="demo">
			<tr>
				<th>Name</th>
				<th>Mobile</th>
				<th>Email</th>
				<th>Password</th>
				<th>cPassword</th>
				<th>Job</th>
				<th>Location</th>
				<th>Salary</th>
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
			</tr>
		<%
		}
		String query1 = "select count(*) from aita.employee";
		PreparedStatement pstmt1 = connection.prepareStatement(query1);
		ResultSet rs1 = pstmt1.executeQuery();
		if(rs1.next())
		{
			total = rs1.getInt(1);
		}
		connection.close();
		%>
		<tr>
			<th colspan="8">
			<table width=100%>
			<tr>
			<%	for(int i=0;i<=total/recordCount;i++)
				{
			%>
				<td><button onclick=nextPage(<%=i%>)><%=i+1%></button></td>
			<%
				} 
			%>
			</tr>
			</table>
			</th>		
		</tr>
</table>
</body>
</html>