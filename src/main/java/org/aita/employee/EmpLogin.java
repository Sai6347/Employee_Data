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



@WebServlet("/EmpLogin")
public class EmpLogin extends HttpServlet 
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String mobile = request.getParameter("mobile");
		String password = request.getParameter("password");
		PrintWriter writer = response.getWriter();
		String url = "jdbc:mysql://localhost:3307?user=root&password=1234";
		String query = "select * from aita.employee where mobile=? and password=?";
		
		
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection  = DriverManager.getConnection(url);
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, mobile);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			
			writer.println("<table border='1' width=800px; style='padding:10px'>");
			writer.println("<tr>");
			writer.println("<th>Name</th>");
			writer.println("<th>Mobile</th>");
			writer.println("<th>Email</th>");
			writer.println("<th>Password</th>");
			writer.println("<th>cPassword</th>");
			writer.println("<th>Job</th>");
			writer.println("<th>Salary</th>");
			writer.println("<th>Location</th>");
			writer.println("</tr>");
			while(rs!=null && rs.next())
			{				
				writer.println("<tr>");
				writer.println("<td>"+rs.getString(1)+"</td>");
				writer.println("<td>"+rs.getString(2)+"</td>");
				writer.println("<td>"+rs.getString(3)+"</td>");
				writer.println("<td>"+rs.getString(4)+"</td>");
				writer.println("<td>"+rs.getString(6)+"</td>");
				writer.println("<td>"+rs.getString(7)+"</td>");
				writer.println("<td>"+rs.getString(8)+"</td>");
				String mblNo = rs.getString(2);
				writer.println("<td><button><a href='EmpDataUpdate.jsp?mblNo='+mblNo>EDIT</a><button></td>");
				
				
			}
			writer.println("</tr>");
			writer.println("</table>");
			connection.close();
//			
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
	}

}
