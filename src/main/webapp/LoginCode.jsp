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
<title>Login</title>
<style>
	#formL
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
	#btn:hover
	{
		background-color:green;
		color:white;
	}
	a
	{
		text-decoration:none;
		color:black;
	}
	tr
	{
		height:30px;
		text-align:center;
	}
	td
	{
		width:90px;
	}
	.table
	{
		margin-left: auto;
  		margin-right: auto;
 		position:relative;
 		top:30px;
 		margin-bottom:50px;
	}
	#ed
	{
		background-color:green;
		color:white;
		border-radius:5px;
	}
	#del
	{
		background-color:red;
		color:white;
		border-radius:5px;
	}
	#add
	{
		background-color:skyblue;
		border-radius:5px;
	}
</style>
</head>
<script type="text/javascript">
	function addData()
	{
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
		if(this.readyState == 4 && this.status == 200)
		{
			document.getElementById("addDt").innerHTML = this.responseText;
		}
		};
		xhttp.open("GET","EmpRegistration.jsp");
		xhttp.send();
	}
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
		
		xhttp.open("GET","EmployeeLogin.jsp?pg="+pg);
		console.log(pg);
		xhttp.send();
		
	}
	function editData(mbl)
	{
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
		if(this.readyState == 4 && this.status == 200)
		{
			document.getElementById("display").innerHTML = this.responseText;
		}
		};
		xhttp.open("GET","EmpDataUpdate.jsp?mobile="+mbl);
		xhttp.send();
	}
	function deleteData(mbl)
	{
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function()
		{
		if(this.readyState == 4 && this.status == 200)
		{
			document.getElementById("delete").innerHTML = this.responseText;
		}
		};
		xhttp.open("GET","DeleteEmpData.jsp?mobile="+mbl);
		xhttp.send();
	}
</script>
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
				<th colspan=2>Action</th>
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
					<td><button onclick="editData(<%=rs.getString(2)%>)" id="ed"> EDIT</button></td>
					<td><button onclick="editData(<%=rs.getString(2)%>)" id="del"> DELETE</button></td> 
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
			<th colspan="8">
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
<div id="delete"></div>
</body>
</html>