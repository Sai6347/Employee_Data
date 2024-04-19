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
<title>Employee Login</title>
<style>
	#formL
	{
		padding:30px;
		border:5px solid black;
		background-color:lightgray;
		border-radius:20px;
		position:relative;
		top:30px;
		width:60%;
		margin-bottom:100px;
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
<div ></div>
 	<center>
		<form action="LoginCode.jsp" method="post" id="formL">
			<h2>EMPLOYEE LOGIN</h2>
			<input type="text" name="mobile" id="mbl" placeholder="Enter Your Mobile Number"> <br> <br>
			<input type="password" name="password" id="pwd" placeholder="Enter Your Password"> <br> <br>
			<button type="submit" id="btn" >LOGIN</button>
			<button type="button" id="btn" onclick="addData()">REGISTER</button>
		</form>
	</center> 
		
<div id="display"></div>
<div id="delete"></div>
<div id="addDt"></div>
</body>
</html>


