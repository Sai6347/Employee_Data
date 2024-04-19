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

@WebServlet("/DeleteEmp")
public class DeleteEmp extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String mobile = request.getParameter("mobile");
		
		String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
		String query = "delete from aita.employee where mobile=?";
		
		PrintWriter writer = response.getWriter();
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, mobile);
			
			int value = pstmt.executeUpdate();
			if(value>0)
			{
				writer.println("<h2 style='color:green'> EMPLOYEE DATA DELETED SUCCESSFULLY </h2>");
			}
			else
			{
				RequestDispatcher dispatcher = request.getRequestDispatcher("DeleteEmp.html");
				dispatcher.include(request, response);
				//writer.println("<h2 style='color:red'> PLEASE ENTER VALID MOBILE NUMBER </h2>");
			}
			connection.close();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
	}

}
