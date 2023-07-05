<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="model.*"%>
<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html lang="en">
<head>
<title>Products - The MJ Store</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Electronic Store Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
	SmartPhone Compatible web template, free web designs for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
	function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<!-- Custom Theme files -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" /> 
<link href="css/fasthover.css" rel="stylesheet" type="text/css" media="all" />
<!-- //Custom Theme files -->
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<!-- js -->
<script src="js/jquery.min.js"></script> 
<!-- //js -->  
<link rel="stylesheet" href="css/jquery.countdown.css" />
<!-- countdown -->
<!-- //js -->
<!-- web fonts -->
<link href='//fonts.googleapis.com/css?family=Glegoo:400,700'
	rel='stylesheet' type='text/css'>
<!-- web fonts --><!--  
<link href='//fonts.googleapis.com/css?family=Glegoo:400,700' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Vollkorn" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Aleo" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Lilita+One" rel="stylesheet">
 --><!-- //web fonts --> 
<!-- for bootstrap working -->
<script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
<!-- //for bootstrap working -->
<!-- start-smooth-scrolling -->
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event){		
			event.preventDefault();
			$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		});
	});
</script>
<!-- //end-smooth-scrolling --> 
</head> 
<body> 
	<%
		Logics logic = new Logics();	
		Connection con = new DB(new MySQL_Connection()).getConnection();
	%>
	<%
		String signin = request.getParameter("Sign_In");
		String register = request.getParameter("Register");

		if (request.getParameter("Register") != null || request.getParameter("Sign_In") != null) {
		String signin_email = request.getParameter("Signin_Email");
		String signin_password = request.getParameter("Signin_Password");

		String register_name = request.getParameter("Register_Name");
		String register_email = request.getParameter("Register_Email");
		String register_password = request.getParameter("Register_Password");
		String register_repassword = request.getParameter("Register_RePassword");
		String register_shippingaddress = request.getParameter("Register_ShippingAddress");

	   
		if (signin != null) {

			ResultSet rs1 = logic.userCheck(signin_email, signin_password);
			if(rs1.first() == true) {
				rs1.beforeFirst();
				while (rs1.next()) {					
					Integer customer_id = rs1.getInt("id");
					String customer_name = rs1.getString("name");
					String customer_email = rs1.getString("email");
					String customer_password = rs1.getString("password");
					String shipping_address = rs1.getString("shipping_address");

					session.setAttribute("name", customer_name);
					session.setAttribute("email", customer_email);
					session.setAttribute("shipping_address", shipping_address);						
									
				}
	
			} else if(rs1.next() == false) {				
				%>
				<script type="text/javascript">
				$(document).ready(function($) {
					$("#signin").click(function() {
						alert("Your username/password is incorrect.");
					});
				});
				</script>
				<% 
			}
			
					} else if (register != null && !register_password.equals(register_repassword)) {
	%>
	<script type="text/javascript">
		$(document).ready(function($) {
			$("#register").click(function() {
				alert("Your Passwords do not match.");
			});

		});
	</script>
	<%		
		} else if (register != null && register_password.equals(register_repassword)) {
			
				int x = logic.registerUser(register_email);

				if (x == 1) {

					PreparedStatement stmt3 = con.prepareStatement("insert into customer_info(name,email,password,shipping_address) values(?,?,?,?)");

					stmt3.setString(1, register_name);
					stmt3.setString(2, register_email);
					stmt3.setString(3, register_password);
					stmt3.setString(4, register_shippingaddress);

					stmt3.executeUpdate();

					session.setAttribute("name", register_name);
					session.setAttribute("email", register_email);
					session.setAttribute("shippingaddress", register_shippingaddress);
				} else {
	%>
	<script type="text/javascript">
		$(document).ready(function($) {
			$("#register").click(function() {
				alert("Account already exists.");
			});

		});
	</script>
	<%
		}
			}
		}
	%>
	<script>
		$('#myModal88').modal({
			backdrop : 'static',
			keyboard : false
		// to prevent closing with Esc button (if you want this too)    
		});
	</script>
	<!-- //for bootstrap working -->
	<!-- header modal -->

	<%
		String name = (String) session.getAttribute("name");		
		name = (name == null) ? "Guest" : name;
		if (name.equals("Guest")) {
	%>
	<div class="modal fade" id="myModal88" tabindex="-1" role="dialog"
		aria-labelledby="myModal88" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="width: 65%; margin-left: 20%">
				<div class="modal-header" style="width: 100%">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel" style="margin-left: 80px">Don't
						Wait, Login now!</h4>
				</div>
				<div class="modal-body modal-body-sub"
					style="width: 110%; margin-left: 80px">
					<div class="row">
						<div class="col-md-8 modal_body_left modal_body_left1">
							<div class="sap_tabs">
								<div id="horizontalTab"
									style="display: block; width: 100%; margin: 0px;">
									<ul>
										<li class="resp-tab-item" aria-controls="tab_item-0"><span>Sign
												in</span></li>
										<li class="resp-tab-item" aria-controls="tab_item-1"><span>Sign
												up</span></li>
									</ul>
									<div class="tab-1 resp-tab-content"
										aria-labelledby="tab_item-0">
										<div class="facts">
											<div class="register">
												<form method="post">
													<input name="Signin_Email" placeholder="Email Address"
														type="text" required=""> <input
														name="Signin_Password" placeholder="Password"
														type="password" required="">
													<div class="sign-up">
														<input type="submit" value="Sign in" name="Sign_In" id="signin" />
													</div>
												</form>
											</div>
										</div>
									</div>
									<div class="tab-2 resp-tab-content"
										aria-labelledby="tab_item-1">
										<div class="facts">
											<div class="register">
												<form method="post">
													<input placeholder="Name" name="Register_Name" type="text"
														required=""> <input placeholder="Email Address"
														name="Register_Email" type="email" required=""> <input
														placeholder="Password" name="Register_Password"
														type="password" required=""> <input
														placeholder="Confirm Password" name="Register_RePassword"
														type="password" required="" style="margin-bottom: 15px">
													<input
														placeholder="Shipping Address (H. No, Street, City, State, Country)"
														name="Register_ShippingAddress" type="text" required="">
													<div class="sign-up">
														<input type="submit" value="Create Account"
															name="Register" id="register" />
													</div>
												</form>
												<%
													}
												%>

											</div>
										</div>
									</div>
								</div>
							</div>
							<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
							<script type="text/javascript">
								$(document).ready(function() {
									$('#horizontalTab').easyResponsiveTabs({
										type : 'default', //Types: default, vertical, accordion           
										width : 'auto', //auto or any width like 600px
										fit : true
									// 100% fit in a container
									});
								});
							</script>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<!-- header modal -->
	<!-- header -->
	<div class="header" id="home1">
		<div class="container">
			<div class="">
				<%
					if (name == null || name.equals("Guest")) {
						name = "Guest";
				%>
				<div class="w3l_login">
					<a href="#" data-toggle="modal" data-target="#myModal88"><span
						class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
				</div>
				<br>
				<br>
				<br>
				<h5 style="margin-top: 15px; margin-left: -10px">
					Welcome,
					<%=name%></h5>
				<%
					} else {
				%>
				<h5 style="margin-top: 15px; margin-left: -10px">
					Welcome,
					<span style="color:#f08804"><%=name%></span></h5>
				<br> <a href="logout.jsp"><span
					class="glyphicon glyphicon-log-out"></span> Log Out</a>

				<%
					}
				%>
			</div>
			<style>
				.w3l_logo h1 a {
				margin-left: 70px;
				}
			</style>
			<div class="w3l_logo" style="margin-top: -80px; margin-left: 400px">
				<h1>
					<a href="index.jsp">MJ Store<span>Your stores.
							Your place.</span></a>
				
			</div>
			<div class="search" style="margin-top: -90px; margin-left: 775px">
				<input class="search_box" type="checkbox" id="search_box"> <label
					class="icon-search" for="search_box"><span
					class="glyphicon glyphicon-search" aria-hidden="true"></span></label>
				<div class="search_form">
					<form action="#" method="post">
						<input type="text" name="Search" placeholder="Search...">
						<input type="submit" value="Send" size="300px">
					</form>
				</div>
			</div>
			<div class="cart cart box_1">
				<form action="#" method="post" class="last">
					<input type="hidden" name="cmd" value="_cart" /> <input
						type="hidden" name="display" value="1" />
					<button class="w3view-cart" type="submit" name="submit" value="">
						<i class="fa fa-cart-arrow-down" aria-hidden="true"></i>
					</button>
				</form>
			</div>
		</div>
	</div>
	<!-- //header -->
	<!-- navigation -->
	<div class="navigation">
		<div class="container">
			<nav class="navbar navbar-default">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header nav_2">
					<button type="button" class="navbar-toggle collapsed navbar-toggle1" data-toggle="collapse" data-target="#bs-megadropdown-tabs">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div> 
				<div class="collapse navbar-collapse" id="bs-megadropdown-tabs" style="width : 80%; margin-left:10%">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp">Home</a></li>	
						<!-- Mega Menu -->
						<li class="dropdown">
							<a href="#" class="dropdown-toggle act" data-toggle="dropdown" >Products <b class="caret"></b></a>
							<ul class="dropdown-menu multi-column columns-3">
								<div class="row">
									<div class="col-sm-3">
										<ul class="multi-column-dropdown">
											<h6>Gadgets</h6>
											<li><a href="products_laptops.jsp">Laptops</a></li>
											<li><a href="products_mobiles.jsp">Mobile Phones <span>New</span></a></li> 																					
										</ul>
									</div>
									<div class="col-sm-3">
										<ul class="multi-column-dropdown">
											<h6>Accessories</h6>
											<li><a href="products_watches.jsp">Watches <span>New</span></a></li>
											<li><a href="products_headphones.jsp">Headphones</a></li>																						
										</ul>
									</div>
									<div class="col-sm-2">
										<ul class="multi-column-dropdown">
											<h6>Home</h6>
											<li><a href="products_tv.jsp">TV</a></li>											
											<li><a href="products_ac.jsp">Air Conditioners</a></li>											
										</ul>
									</div>
									<div class="col-sm-4">
										<div class="w3ls_products_pos">
											<h4>30%<i>Off/-</i></h4>
											<img src="images/1.jpg" alt=" " class="img-responsive" />
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</ul>
						</li>
						<li><a href="about.jsp">About Us</a></li> 						  
						<li><a href="mail.jsp">Mail Us</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<!-- //navigation -->
	<!-- banner -->
	<div class="banner banner1">
		<div class="container">
			<h2>Great Offers on <span>Mobiles</span> Flat <i>35% Discount</i></h2> 
		</div>
	</div> 
	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="index.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li>Air Conditioners</li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs --> 
	<!-- mobiles -->
	<div class="mobiles">
		<div class="container">
			<div class="w3ls_mobiles_grids">
				<div class="col-md-4 w3ls_mobiles_grid_left">
					<div class="w3ls_mobiles_grid_left_grid">
						<h3>Categories</h3>
						<div class="w3ls_mobiles_grid_left_grid_sub">
							<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
							  <div class="panel panel-default">
								<div class="panel-heading" role="tab" id="headingOne">
								  <h4 class="panel-title asd">
									<a class="pa_italic collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
									  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span><i class="glyphicon glyphicon-minus" aria-hidden="true"></i>New Arrivals
									</a>
								  </h4>
								</div>
								<div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
								  <div class="panel-body panel_text">
									<ul>
										<li><a href="products_mobiles.jsp">Mobiles</a></li>
										<li><a href="products_watches.jsp">Watches</a></li>										
									</ul>
								  </div>
								</div>
							  </div>
							  <div class="panel panel-default">
								<div class="panel-heading" role="tab" id="headingTwo">
								  <h4 class="panel-title asd">
									<a class="pa_italic collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
									  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span><i class="glyphicon glyphicon-minus" aria-hidden="true"></i>Accessories
									</a>
								  </h4>
								</div>
								<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
								   <div class="panel-body panel_text">
									<ul>
										<li><a href="products_watches.jsp">Watches</a></li>
										<li><a href="products_headphones.jsp">Headphones</a></li>																				
									</ul>
								  </div>
								</div>
							  </div>
							  <div class="panel panel-default">
								<div class="panel-heading" role="tab" id="headingThree">
								  <h4 class="panel-title asd">
									<a class="pa_italic collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
									  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span><i class="glyphicon glyphicon-minus" aria-hidden="true"></i>Home Appliances
									</a>
								  </h4>
								</div>
								<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
								   <div class="panel-body panel_text">
									<ul>
										<li><a href="products_ac.jsp">Air Conditioner</a></li>
										<li><a href="products_tv.jsp">TV</a></li>																				
									</ul>
								  </div>
								</div>
							  </div>
							</div>							
						</div>
					</div>					
				</div>
				<div class="col-md-8 w3ls_mobiles_grid_right">
					<div class="col-md-6 w3ls_mobiles_grid_right_left">
						<div class="w3ls_mobiles_grid_right_grid1">
							<img src="images/46.jpg" alt=" " class="img-responsive" />
							<div class="w3ls_mobiles_grid_right_grid1_pos1">
								<h3>Smart Phones<span>Up To</span> 15% Discount</h3>
							</div>
						</div>
					</div>
					<div class="col-md-6 w3ls_mobiles_grid_right_left">
						<div class="w3ls_mobiles_grid_right_grid1">
							<img src="images/47.jpg" alt=" " class="img-responsive" />
							<div class="w3ls_mobiles_grid_right_grid1_pos">
								<h3>Top 10 Latest<span>Mobile </span>& Accessories</h3>
							</div>
						</div>
					</div>
					<div class="clearfix"> </div>

					<div class="w3ls_mobiles_grid_right_grid2">
						<div class="w3ls_mobiles_grid_right_grid2_left">
							<h3>Showing Results: 0-1</h3>
						</div>
						<div class="w3ls_mobiles_grid_right_grid2_right">
							<select name="select_item" class="select_item">
								<option selected="selected">Default sorting</option>
								<option>Sort by popularity</option>
								<option>Sort by average rating</option>
								<option>Sort by newness</option>
								<option>Sort by price: low to high</option>
								<option>Sort by price: high to low</option>
							</select>
						</div>
						<div class="clearfix"> </div>
					</div>
<%
	ResultSet productlist_rs1 = logic.productDisplay("AC", "Dorosin");
	while(productlist_rs1.next())
	{
			
%>
				<div style="width: 760px; height: 240px; float: left ; border-bottom:1px solid grey ; margin-bottom:25px">
						<div style="width: 250px; height: 200px; float: left">
							<a href="<%=productlist_rs1.getString("Page") %>"><img src="<%=productlist_rs1.getString("Image_Display") %>" height="200px"/></a>
						</div>					
						<div class="simpleCart_shelfItem" style="width: 510px; height:200px; float: left">
						<a href="<%=productlist_rs1.getString("Page") %>"><b><h5 style="width: 560px"><font color="#0066c0" size="5"><%=productlist_rs1.getString("Name") %></font></h5></b></a>
						<h6>by <%=productlist_rs1.getString("Manufacturer") %></h6>					
						<strong><h4 style="margin-top:40px"><font color="red" weight="900">$<%=productlist_rs1.getString("Discounted_Price") %></font></h4></strong>
						<h6>FREE Delivery in <%=productlist_rs1.getString("Delivery_Time") %> business days</h6>
						<form action="#" method="post">
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="add" value="1"> 
						<input type="hidden" name="w3ls_item" value="<%=productlist_rs1.getString("Short_Name") %>"> 
						<input type="hidden" name="amount" value="<%=productlist_rs1.getString("Discounted_Price") %>">   
						<button type="submit" class="w3ls-cart" style="margin-top : 25px">Add to cart</button>
					</form>								   
															
						</div>																						
				</div>
<%
	}
%>

<%
	ResultSet productlist_rs2 = logic.productDisplay("AC", "DWHX");
	while(productlist_rs2.next())
	{
			
%>
				<div style="width: 760px; height: 240px; float: left ; border-bottom:1px solid grey ; margin-bottom:25px">
						<div style="width: 250px; height: 200px; float: left">
							<a href="<%=productlist_rs2.getString("Page") %>"><img src="<%=productlist_rs2.getString("Image_Display") %>" height="200px"/></a>
						</div>					
						<div class="simpleCart_shelfItem" style="width: 510px; height:200px; float: left">
						<a href="<%=productlist_rs2.getString("Page") %>"><b><h5 style="width: 560px"><font color="#0066c0" size="5"><%=productlist_rs2.getString("Name") %></font></h5></b></a>
						<h6>by <%=productlist_rs2.getString("Manufacturer") %></h6>					
						<strong><h4 style="margin-top:40px"><font color="red" weight="900">$<%=productlist_rs2.getString("Discounted_Price") %></font></h4></strong>
						<h6>FREE Delivery in <%=productlist_rs2.getString("Delivery_Time") %> business days</h6>								   
						<form action="#" method="post">
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="add" value="1"> 
						<input type="hidden" name="w3ls_item" value="<%=productlist_rs2.getString("Short_Name") %>"> 
						<input type="hidden" name="amount" value="<%=productlist_rs2.getString("Discounted_Price") %>">   
						<button type="submit" class="w3ls-cart" style="margin-top : 25px">Add to cart</button>
					</form>								
						</div>																						
				</div>
<%
	}
%>

<%
	ResultSet productlist_rs3 = logic.productDisplay("AC", "Friedrich");
	while(productlist_rs3.next())
	{
			
%>
				<div style="width: 760px; height: 240px; float: left ; border-bottom:1px solid grey ; margin-bottom:25px">
						<div style="width: 250px; height: 200px; float: left">
							<a href="<%=productlist_rs3.getString("Page") %>"><img src="<%=productlist_rs3.getString("Image_Display") %>" height="200px"/></a>
						</div>					
						<div class="simpleCart_shelfItem" style="width: 510px; height:200px; float: left">
						<a href="<%=productlist_rs3.getString("Page") %>"><b><h5 style="width: 560px"><font color="#0066c0" size="5"><%=productlist_rs3.getString("Name") %></font></h5></b></a>
						<h6>by <%=productlist_rs3.getString("Manufacturer") %></h6>					
						<strong><h4 style="margin-top:40px"><font color="red" weight="900">$<%=productlist_rs3.getString("Discounted_Price") %></font></h4></strong>
						<h6>FREE Delivery in <%=productlist_rs3.getString("Delivery_Time") %> business days</h6>								   
						<form action="#" method="post">
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="add" value="1"> 
						<input type="hidden" name="w3ls_item" value="<%=productlist_rs3.getString("Short_Name") %>"> 
						<input type="hidden" name="amount" value="<%=productlist_rs3.getString("Discounted_Price") %>">   
						<button type="submit" class="w3ls-cart" style="margin-top : 25px">Add to cart</button>
					</form>								
						</div>																						
				</div>
<%
	}
%>

<%
	ResultSet productlist_rs4 = logic.productDisplay("AC", "Haier");
	while(productlist_rs4.next())
	{
			
%>
				<div style="width: 760px; height: 240px; float: left ; border-bottom:1px solid grey ; margin-bottom:25px">
						<div style="width: 250px; height: 200px; float: left">
							<a href="<%=productlist_rs4.getString("Page") %>"><img src="<%=productlist_rs4.getString("Image_Display") %>" height="200px"/></a>
						</div>					
						<div class="simpleCart_shelfItem" style="width: 510px; height:200px; float: left">
						<a href="<%=productlist_rs4.getString("Page") %>"><b><h5 style="width: 560px"><font color="#0066c0" size="5"><%=productlist_rs4.getString("Name") %></font></h5></b></a>
						<h6>by <%=productlist_rs4.getString("Manufacturer") %></h6>					
						<strong><h4 style="margin-top:40px"><font color="red" weight="900">$<%=productlist_rs4.getString("Discounted_Price") %></font></h4></strong>
						<h6>FREE Delivery in <%=productlist_rs4.getString("Delivery_Time") %> business days</h6>								   
						<form action="#" method="post">
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="add" value="1"> 
						<input type="hidden" name="w3ls_item" value="<%=productlist_rs4.getString("Short_Name") %>"> 
						<input type="hidden" name="amount" value="<%=productlist_rs4.getString("Discounted_Price") %>">   
						<button type="submit" class="w3ls-cart" style="margin-top : 25px">Add to cart</button>
					</form>								
						</div>																						
				</div>
<%
	}
%>																				
				</div>											
				</div>
				</div>
				</div>
				</div>										
	<!-- newsletter -->
	<div class="newsletter">
		<div class="container">
			<div class="col-md-6 w3agile_newsletter_left">
				<h3>Newsletter</h3>
				<p>For latest updates and offers, subscribe to our newsletter!</p>
			</div>
			<div class="col-md-6 w3agile_newsletter_right">
				<form action="#" method="post">
					<input type="email" name="Email" placeholder="Email" required="">
					<input type="submit" value="" />
				</form>
			</div>
			<div class="clearfix"> </div>
		</div>
	</div>
	<!-- //newsletter -->
	<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="w3_footer_grids">
				<div class="col-md-3 w3_footer_grid">
					<h3>Contact</h3>
					<p>For further information, get in touch with us : </p>
					<ul class="address">
						<li><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>AU -1, Grandcity Plaza, <span>Ludhiana.</span></li>
						<li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i><a href="mailto:jainmahaan@gmail.com">jainmahaan@gmail.com</a></li>
						<li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>+91 - 87250 73002</li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>Information</h3>
					<ul class="info"> 
						<li><a href="about.jsp">About Us</a></li>
						<li><a href="mail.jsp">Contact Us</a></li>						
						<li><a href="faq.jsp">FAQ's</a></li>
						<li><a href="products_laptops.jsp">Special Products</a></li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>Category</h3>
					<ul class="info"> 
						<li><a href="products_mobiles.jsp">Mobiles</a></li>
						<li><a href="products_laptops.jsp">Laptops</a></li>
						<li><a href="products_watches.jsp">Watches</a></li>
						<li><a href="products_headphones.jsp">Headphones</a></li>
						<li><a href="products_tv.jsp">TV</a></li>
						<li><a href="products_ac.jsp">Air Conditioners</a></li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>Profile</h3>
					<ul class="info"> 
						<li><a href="index.jsp">Home</a></li>
						<li><a href="index.jsp">Today's Deals</a></li>
					</ul>					
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
		<div class="footer-copy">
			<div class="footer-copy1">
				<div class="footer-copy-pos">
					<a href="#home1" class="scroll"><img src="images/arrow.png" alt=" " class="img-responsive" /></a>
				</div>
			</div>
			<div class="container">
				<p>&copy; MJ Store. All rights reserved | Designed by Mahaan Jain</p>
			</div>
		</div>
	</div>
	<!-- //footer -->  
	<script type="text/javascript">
		$(window).load(function() {
			$("#flexiselDemo2").flexisel({
				visibleItems:4,
				animationSpeed: 1000,
				autoPlay: true,
				autoPlaySpeed: 3000,    		
				pauseOnHover: true,
				enableResponsiveBreakpoints: true,
				responsiveBreakpoints: { 
					portrait: { 
						changePoint:568,
						visibleItems: 1
					}, 
					landscape: { 
						changePoint:667,
						visibleItems:2
					},
					tablet: { 
						changePoint:768,
						visibleItems: 3
					}
				}
			});
			
		});
	</script>
	<script type="text/javascript" src="js/jquery.flexisel.js"></script>
	<!-- cart-js -->
	<script src="js/minicart.js"></script>
	<script>
        w3ls.render();

        w3ls.cart.on('w3sb_checkout', function (evt) {
        	var items, len, i;

        	if (this.subtotal() > 0) {
        		items = this.items();

        		for (i = 0, len = items.length; i < len; i++) { 
        		}
        	}
        });
    </script>  
	<!-- //cart-js --> 
</body>
</html>