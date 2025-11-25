<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("student_roll") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    
    String equipmentName = request.getParameter("equipment_name");
    Object rollObj = session.getAttribute("student_roll");
    String rollNo = rollObj != null ? rollObj.toString() : "";
    
    if(equipmentName == null || equipmentName.trim().isEmpty()){
        response.sendRedirect("studentDashboard.jsp?error=Invalid equipment");
        return;
    }
    
    try {
        String url = "jdbc:mysql://localhost:3306/sem";
        String dbUser = "root";
        String dbPass = "admin";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPass);
        
        // Check if equipment is available (check quantity > 0)
        PreparedStatement checkStmt = conn.prepareStatement(
            "SELECT quantity FROM equipments WHERE name = ?"
        );
        checkStmt.setString(1, equipmentName);
        ResultSet checkRs = checkStmt.executeQuery();
        
        int availableCount = 0;
        if(checkRs.next()){
            availableCount = checkRs.getInt("quantity");
        }
        checkRs.close();
        checkStmt.close();
        
        if(availableCount > 0){
            // Insert borrow request into issued table
            // Assuming there's an 'issued' table with columns: equipment_name, student_roll, issue_date, status
            PreparedStatement insertStmt = conn.prepareStatement(
                "INSERT INTO issued (equipment_name, student_roll, issue_date, status) VALUES (?, ?, NOW(), 'pending')"
            );
            insertStmt.setString(1, equipmentName);
            insertStmt.setString(2, rollNo);
            insertStmt.executeUpdate();
            insertStmt.close();
            
            response.sendRedirect("studentDashboard.jsp?success=Borrow request submitted successfully");
        } else {
            response.sendRedirect("studentDashboard.jsp?error=Equipment not available");
        }
        
        conn.close();
    } catch(Exception e) {
        response.sendRedirect("studentDashboard.jsp?error=Error processing request: " + e.getMessage());
    }
%>

