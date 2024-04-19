package org.aita.employee;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EmployeeRegistration")
public class EmployeeRegistration extends HttpServlet 
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String mailId = request.getParameter("mail");
		String password = request.getParameter("password");
		String cPassword  = request.getParameter("cpassword");
		String job = request.getParameter("job");
		String location = request.getParameter("location");
		String salary = request.getParameter("salary");
		
		PrintWriter writer = response.getWriter();
		if(password.equals(cPassword))
		{
			String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
			String query = "insert into aita.employee values(?,?,?,?,?,?,?,?)";
			
			try 
			{
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
//					writer.println("<h1 style='color:green'>User Registration Done Successfully....<h1>");
					RequestDispatcher dispatcher = request.getRequestDispatcher("EmpLogin.html");
					dispatcher.include(request, response);
				}
				else
				{
					RequestDispatcher dispatcher = request.getRequestDispatcher("EmployeeRegistration.html");
					dispatcher.include(request, response);
					writer.println("<h2 style='color:red'> PLEASE ENTER VALID DETAILS<h2>");
				}
				connection.close();
			}
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			
		}
		else
		{
			RequestDispatcher dispatcher = request.getRequestDispatcher("EmployeeRegistration.html");
			dispatcher.include(request, response);
			writer.println("<h2 style='color:red'> PLEASE ENTER VALID PASSWORD<h2>");
			System.err.println("Enter Valid Password");
		}
	}

}
