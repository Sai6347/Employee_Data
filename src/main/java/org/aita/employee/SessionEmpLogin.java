package org.aita.employee;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/SessionEmpLogin")
public class SessionEmpLogin extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String mobileIp = request.getParameter("mobile");
		String passwordIp = request.getParameter("password");
		
		String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
		String query = "select * from aita.employee where mobile=? and password=?";
		
		PrintWriter writer = response.getWriter();
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, mobileIp);
			pstmt.setString(2, passwordIp);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next())
			{
				String name = rs.getString("name");
				String mobile = rs.getString("mobile");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String cpassword = rs.getString("cpassword");
				String jobrole = rs.getString("jobrole");
				String location = rs.getString("location");
				double salary = rs.getDouble("salary");
				System.out.println("Data Fetched Successfully");
				
				//Access session Object
				HttpSession session = request.getSession();
				System.out.println("Session object accessed");
				
				//store data in session
				session.setAttribute("ename", name);
				session.setAttribute("mobile", mobile);
				session.setAttribute("mail", email);
				session.setAttribute("pwd", password);
				session.setAttribute("cpwd", cpassword);
				session.setAttribute("job", jobrole);
				session.setAttribute("loc", location);
				session.setAttribute("sal", salary);
				System.out.println("Data stored in session object");
				
				//display data in browser
				writer.println("EMPLOYEE DATA");
				writer.println("Employee Name : "+name);
				writer.println("Employee Mobile No : "+mobile);
				writer.println("Employee Mail : "+email);
				writer.println("Employee Password : "+password);
				writer.println("Employee JobRole : "+jobrole);
				writer.println("Employee Location : "+location);
				writer.println("Employee Salary : "+salary);
				
				//time interval
				session.setMaxInactiveInterval(20);
//				RequestDispatcher dispatcher = request.getRequestDispatcher("EmployeeLogout.html");
//				dispatcher.include(request, response);
				response.sendRedirect("EmployeeLogout.html");
				writer.println("<h2 style='color:green'>Employee Logged in Successfully...</h2>");
			}
			else
			{
				response.sendRedirect("EmployeeLogin.html");
				writer.println("<h2 style='color:red'> No Data Fetched....!!! </h2>");
			}
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}

}
