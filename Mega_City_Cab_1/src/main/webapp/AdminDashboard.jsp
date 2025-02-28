<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("Login.jsp"); // Redirect if session is missing
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Roboto', sans-serif;
  }
  body {
    height: 100vh;
    display: flex;
    flex-direction: column;
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
    color: #333;
  }
  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 20px;
    background: linear-gradient(135deg, #89f7fe, #66a6ff);
    color: white;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
  .header h1 {
    font-size: 24px;
    font-weight: 700;
  }
  .menu-btn {
    font-size: 20px;
    cursor: pointer;
    background: none;
    border: none;
    color: white;
    outline: none;
  }
  .sidebar {
    width: 250px;
    background: linear-gradient(135deg, #66a6ff, #89f7fe);
    color: #fff;
    display: flex;
    flex-direction: column;
    padding: 20px 15px;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
    z-index: 1000;
  }
  .sidebar.open {
    transform: translateX(0);
  }
  .sidebar h2 {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 20px;
    text-align: center;
    color: #ffffff;
  }
  .menu-item {
    font-size: 16px;
    color: #ffffff;
    padding: 12px 15px;
    margin-bottom: 12px;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
    text-align: center;
  }
  .menu-item:hover {
    background: linear-gradient(135deg, #66a6ff, #ff7eb3);
    color: #fff;
  }
  .logout-btn {
    font-size: 16px;
    margin-top: auto;
    padding: 12px 15px;
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
    color: #fff;
    text-align: center;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    cursor: pointer;
  }
  .logout-btn:hover {
    background: linear-gradient(135deg, #d32f2f, #f44336);
  }
  .content {
    margin-top: 60px;
    padding: 40px;
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
  }
  .content h1 {
    font-size: 36px;
    font-weight: 700;
    margin-bottom: 15px;
    color: #344955;
  }
  .content p {
    font-size: 18px;
    color: #666;
    max-width: 600px;
    line-height: 1.6;
  }
</style>
<script>
  function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('open');
  }
</script>
<script>
  function confirmLogout() {
    const isConfirmed = confirm("Are you sure you want to logout?");
    if (isConfirmed) {
      window.location.href = "AdminLogout.jsp"; // Call the logout script
    }
  }
</script>
</head>

<body>
  <!-- Header -->
  <header class="header">
    <h1>Admin Dashboard</h1>
    <button class="menu-btn" onclick="toggleSidebar()">☰ Menu</button>
  </header>

  <!-- Sidebar -->
  <aside class="sidebar">
    <h2>Admin Dashboard</h2>
    <a href="ManageCars.jsp" class="menu-item">Manage Cabs</a>
    <a href="ManageBookings.jsp" class="menu-item">Manage Bookings</a>
    <div class="logout-btn" onclick="confirmLogout()">Logout</div>
  </aside>

  <!-- Content -->
  <main class="content">
    <h1>Welcome, Admin!</h1>
    <p>
      Use the sidebar to navigate through your Admin Dashboard and manage 
      key sections efficiently. Keep everything organized to ensure a smooth 
      experience for your users.
    </p>
  </main>
</body>
</html>