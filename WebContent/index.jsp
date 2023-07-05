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
<title>Home Page - The MJ Store</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Electronic Store Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
	SmartPhone Compatible web template, free web designs for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
	function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!-- //for-mobile-apps -->
<!-- Custom Theme files -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/fasthover.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/popuo-box.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- //Custom Theme files -->
<!-- font-awesome icons -->
<link href="css/font-awesome.css" rel="stylesheet">
<!-- //font-awesome icons -->
<!-- js -->
<script src="js/jquery.min.js"></script>
<link rel="stylesheet" href="css/jquery.countdown.css" />
<!-- countdown -->
<!-- //js -->
<!-- web fonts -->
<link href='//fonts.googleapis.com/css?family=Glegoo:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'
	rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Vollkorn" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Aleo" rel="stylesheet">
<!-- //web fonts -->
<!-- for bootstrap working -->
<script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
<!-- //for bootstrap working -->
<!-- start-smooth-scrolling -->
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1000);
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
					<button type="button"
						class="navbar-toggle collapsed navbar-toggle1"
						data-toggle="collapse" data-target="#bs-megadropdown-tabs">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse" id="bs-megadropdown-tabs"
					style="width: 80%; margin-left: 10%">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp" class="act">Home</a></li>
						<!-- Mega Menu -->
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">Products <b class="caret"></b></a>
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
											<h4>
												30%<i>Off/-</i>
											</h4>
											<img src="images/1.jpg" alt=" " class="img-responsive" />
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
							</ul></li>
						<li><a href="about.jsp">About Us</a></li>
						<li><a href="mail.jsp">Mail Us</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<!-- //navigation -->
	<!-- banner -->
	<div class="banner">
		<div class="container">
			<h3>
				MJ Store, <span>Special Offers</span>
			</h3>
		</div>
	</div>
	<!-- //banner -->
	<!-- banner-bottom -->
	<div class="banner-bottom">
		<div class="container">
			<div class="col-md-5 wthree_banner_bottom_left">
				<div class="video-img">				
					<a class="play-icon popup-with-zoom-anim" href="#small-dialog">
						<span class="glyphicon glyphicon-expand" aria-hidden="true"></span>
					</a>
				</div>
				<!-- pop-up-box -->
				<script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
				<!--//pop-up-box -->
				<div id="small-dialog" class="mfp-hide">					
					<iframe src="https://www.youtube.com/embed/qSPaXr2tRbk"></iframe>
				</div>
				<script>
					$(document).ready(function() {
						$('.popup-with-zoom-anim').magnificPopup({
							type : 'inline',
							fixedContentPos : false,
							fixedBgPos : true,
							overflowY : 'auto',
							closeBtnInside : true,
							preloader : false,
							midClick : true,
							removalDelay : 300,
							mainClass : 'my-mfp-zoom-in'
						});

					});
				</script>
			</div>
			<div class="col-md-7 wthree_banner_bottom_right">
				<div class="bs-example bs-example-tabs" role="tabpanel"
					data-example-id="togglable-tabs">
					<ul id="myTab" class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#Mobile"
							id="Mobile-tab" role="tab" data-toggle="tab" aria-controls="Mobile">Mobiles</a></li>
						<li role="presentation"><a href="#Headphone" role="tab"
							id="Headphone-tab" data-toggle="tab" aria-controls="Headphone">Headphones</a></li>
						<li role="presentation"><a href="#Laptop" role="tab"
							id="Laptop-tab" data-toggle="tab" aria-controls="Laptop">Laptops</a></li>
						<li role="presentation"><a href="#TV" role="tab" id="TV-tab"
							data-toggle="tab" aria-controls="TV">TV</a></li>
						<li role="presentation"><a href="#Watch" role="tab"
							id="Watch-tab" data-toggle="tab" aria-controls="Watch">Watches</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div role="tabpanel" class="tab-pane fade active in" id="Mobile"
							aria-labelledby="Mobile-tab">
							<div class="agile_ecommerce_tabs">
<%
	ResultSet product_rs1 = logic.productDisplay("Mobile", "iPhoneXSMax");
	while(product_rs1.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs1.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs1.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs1.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs1.getString("Page") %>"><%=product_rs1.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs1.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs1.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs1.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs1.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs2 = logic.productDisplay("Mobile", "OnePlus6T");
	while(product_rs2.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs2.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs2.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs2.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs2.getString("Page") %>"><%=product_rs2.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs2.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs2.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs2.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs2.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs3 = logic.productDisplay("Mobile", "SamsungS9");
	while(product_rs3.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs3.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs3.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs3.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs3.getString("Page") %>"><%=product_rs3.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs3.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs3.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs3.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs3.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

								<div class="clearfix"></div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="Headphone"
							aria-labelledby="Headphone-tab">
							<div class="agile_ecommerce_tabs">
<%
	ResultSet product_rs4 = logic.productDisplay("Headphone", "AudezeLCD");
	while(product_rs4.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs4.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs4.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs4.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs4.getString("Page") %>"><%=product_rs4.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs4.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs4.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs4.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs4.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs5 = logic.productDisplay("Headphone", "AudioCouncil");
	while(product_rs5.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs5.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs5.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs5.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs5.getString("Page") %>"><%=product_rs5.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs5.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs5.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs5.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs5.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs6 = logic.productDisplay("Headphone", "FocalStellia");
	while(product_rs6.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs6.getString("Image_1")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs6.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs6.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs6.getString("Page") %>"><%=product_rs6.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs6.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs6.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs6.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs6.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>
								<div class="clearfix"></div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="Laptop"
							aria-labelledby="Laptop-tab">
							<div class="agile_ecommerce_tabs">
							
<!-- MacBook Pro -->							
<%
	ResultSet product_rs7 = logic.productDisplay("Laptop", "MacBookPro");
	while(product_rs7.next())
	{			
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs7.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs7.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs7.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs7.getString("Page") %>"><%=product_rs7.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs7.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs7.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs7.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs7.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs8 = logic.productDisplay("Laptop", "MacBookAir");
	while(product_rs8.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs8.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs8.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs8.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs8.getString("Page") %>"><%=product_rs8.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs8.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs8.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs8.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs8.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs9 = logic.productDisplay("Laptop", "MSI");
	while(product_rs9.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs9.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs9.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs9.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs9.getString("Page") %>"><%=product_rs9.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs9.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs9.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs9.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs9.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>
								<div class="clearfix"></div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="TV"
							aria-labelledby="TV-tab">
							<div class="agile_ecommerce_tabs">
							
<%
	ResultSet product_rs10 = logic.productDisplay("TV", "Hisense");
	while(product_rs10.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs10.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs10.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs10.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs10.getString("Page") %>"><%=product_rs10.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs10.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs10.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs10.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs10.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs11 = logic.productDisplay("TV", "LG");
	while(product_rs11.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs11.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs11.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs11.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs11.getString("Page") %>"><%=product_rs11.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs11.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs11.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs11.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs11.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs12 = logic.productDisplay("TV", "Sharp");
	while(product_rs12.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs12.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs12.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs12.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs12.getString("Page") %>"><%=product_rs12.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs12.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs12.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs12.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs12.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>
								<div class="clearfix"></div>
							</div>
						</div>
						<div role="tabpanel" class="tab-pane fade" id="Watch"
							aria-labelledby="Watch-tab">
							<div class="agile_ecommerce_tabs">
							
<%
	ResultSet product_rs13 = logic.productDisplay("Watch", "AudemarsPiguet");
	while(product_rs13.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs13.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs13.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs13.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs13.getString("Page") %>"><%=product_rs13.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs13.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs13.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs13.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs13.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs14 = logic.productDisplay("Watch", "PatekPhillipe");
	while(product_rs14.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs14.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs14.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs14.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs14.getString("Page") %>"><%=product_rs14.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs14.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs14.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs14.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs14.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>

<%
	ResultSet product_rs15 = logic.productDisplay("Watch", "RichardMille");
	while(product_rs15.next())
	{
				
%>							
								<div class="col-md-4 agile_ecommerce_tab_left">
									<div class="hs-wrapper" style="height:196px">
										<img src="<%=product_rs15.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" /> <img
											src="<%=product_rs15.getString("Image_Display")%>"
											alt=" " class="img-responsive" width="196" />
										<div class="w3_hs_bottom">
											<ul>
												<li><a href="#" data-toggle="modal"
													data-target="#<%=product_rs15.getString("ID")%>"><span
														class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
												</li>
											</ul>
										</div>
									</div>
									<h5>
										<a href="<%=product_rs15.getString("Page") %>"><%=product_rs15.getString("Short_Name") %></a>
									</h5>
									<div class="simpleCart_shelfItem">
										<p>
											<span>$<%=product_rs15.getInt("Original_Price") %></span> <i class="item_price">$<%=product_rs15.getInt("Discounted_price") %></i>
										</p>
										<form action="#" method="post">
											<input type="hidden" name="cmd" value="_cart" /> <input
												type="hidden" name="add" value="1" /> <input type="hidden"
												name="w3ls_item" value="<%=product_rs15.getString("Short_Name") %>" /> <input
												type="hidden" name="amount" value="<%=product_rs15.getInt("Discounted_price") %>" />
											<button type="submit" class="w3ls-cart">Add to cart</button>
										</form>
									</div>
								</div>
<%
	}
%>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- //banner-bottom -->
	<!-- modal-video -->

<%
	ResultSet productview_rs1 = logic.productDisplay("Mobile", "iPhoneXSMax");
	while(productview_rs1.next())
	{		
		String[] description_short = productview_rs1.getString("Description_Short").split("#",2);
				
%>
<!-- iPhone XS Max -->
	<div class="modal video-modal fade" id="<%=productview_rs1.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs1.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs1.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs1.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>
							<p>Size Name : <span style="color:black; font-weight:bold"><%=productview_rs1.getString("Size") %></span></p>
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs1.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs1.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs1.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs1.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs1.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs1.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs1.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	

<!-- OnePlus 6T -->	
<%
	ResultSet productview_rs2 = logic.productDisplay("Mobile", "OnePlus6T");
	while(productview_rs2.next())
	{		
		String[] description_short = productview_rs2.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs2.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs2.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs2.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs2.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>
							<p>Size Name : <span style="color:black; font-weight:bold"><%=productview_rs2.getString("Size") %></span></p>
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs2.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs2.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs2.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs2.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs2.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs2.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs2.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- Samsung S9 -->	
<%
	ResultSet productview_rs3 = logic.productDisplay("Mobile", "SamsungS9");
	while(productview_rs3.next())
	{		
		String[] description_short = productview_rs3.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs3.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs3.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs3.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs3.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>
							<p>Size Name : <span style="color:black; font-weight:bold"><%=productview_rs3.getString("Size") %></span></p>
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs3.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs3.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs3.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs3.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs3.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs3.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs3.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- Headphones -->
<!-- Audeze LCD -->
<%
	ResultSet productview_rs4 = logic.productDisplay("Headphone", "AudezeLCD");
	while(productview_rs4.next())
	{		
		String[] description_short = productview_rs4.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs4.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs4.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs4.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs4.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs4.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs4.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs4.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs4.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs4.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs4.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs4.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	

<!-- Audio Council -->
<%
	ResultSet productview_rs5 = logic.productDisplay("Headphone", "AudioCouncil");
	while(productview_rs5.next())
	{		
		String[] description_short = productview_rs5.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs5.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs5.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs5.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs5.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs5.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs5.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs5.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs5.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs5.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs5.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs5.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	

	
<!-- Focal Stellia -->
<%
	ResultSet productview_rs6 = logic.productDisplay("Headphone", "FocalStellia");
	while(productview_rs6.next())
	{		
		String[] description_short = productview_rs6.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs6.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs6.getString("Image_1") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs6.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs6.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs6.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs6.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs6.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs6.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs6.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs6.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs6.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- Laptops -->
<!-- MacBook Pro -->
<%
	ResultSet productview_rs7 = logic.productDisplay("Laptop", "MacBookPro");
	while(productview_rs7.next())
	{		
		String[] description_short = productview_rs7.getString("Description_Short").split("#",2);
				
%>
<!-- iPhone XS Max -->
	<div class="modal video-modal fade" id="<%=productview_rs7.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs7.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs7.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs7.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>
							<p>Size Name : <span style="color:black; font-weight:bold"><%=productview_rs7.getString("Size") %></span></p>
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs7.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs7.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs7.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs7.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs7.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs7.getString("Color_1") %>"><span></span></a></li>																		
									<li><a href="#" class="<%=productview_rs7.getString("Color_2") %>"><span></span></a></li>
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- MacBook Air -->
<%
	ResultSet productview_rs8 = logic.productDisplay("Laptop", "MacBookAir");
	while(productview_rs8.next())
	{		
		String[] description_short = productview_rs8.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs8.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs8.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs8.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs8.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>
							<p>Size Name : <span style="color:black; font-weight:bold"><%=productview_rs8.getString("Size") %></span></p>
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs8.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs8.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs8.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs8.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs8.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs8.getString("Color_1") %>"><span></span></a></li>																											
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- MSI -->
<%
	ResultSet productview_rs9 = logic.productDisplay("Laptop", "MSI");
	while(productview_rs9.next())
	{		
		String[] description_short = productview_rs9.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs9.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs9.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs9.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs9.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>
							<p>Size Name : <span style="color:black; font-weight:bold"><%=productview_rs9.getString("Size") %></span></p>
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs9.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs9.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs9.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs9.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs9.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs9.getString("Color_1") %>"><span></span></a></li>																											
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
		
<!-- TV -->
<!-- Hisense -->
<%
	ResultSet productview_rs10 = logic.productDisplay("TV", "Hisense");
	while(productview_rs10.next())
	{		
		String[] description_short = productview_rs10.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs10.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs10.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs10.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs10.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs10.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs10.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs10.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs10.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs10.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs10.getString("Color_1") %>"><span></span></a></li>																											
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- LG -->
<%
	ResultSet productview_rs11 = logic.productDisplay("TV", "LG");
	while(productview_rs11.next())
	{		
		String[] description_short = productview_rs11.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs11.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs11.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs11.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs11.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs11.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs11.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs11.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs11.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs11.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs11.getString("Color_1") %>"><span></span></a></li>																											
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- Sharp -->
<%
	ResultSet productview_rs12 = logic.productDisplay("TV", "Sharp");
	while(productview_rs12.next())
	{		
		String[] description_short = productview_rs12.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs12.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs12.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs12.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs12.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs12.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs12.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs12.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs12.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs12.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>							
							<h5>Color</h5>
							<div class="color-quality">
								<ul>
									<li><a href="#" class="<%=productview_rs12.getString("Color_1") %>"><span></span></a></li>																											
								</ul>
							</div>
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- Watches -->
<!-- Audemars Piguet -->
<%
	ResultSet productview_rs13 = logic.productDisplay("Watch", "AudemarsPiguet");
	while(productview_rs13.next())
	{		
		String[] description_short = productview_rs13.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs13.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs13.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs13.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs13.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs13.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs13.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs13.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs13.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs13.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>														
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	

<!-- Patek Phillipe -->
<%
	ResultSet productview_rs14 = logic.productDisplay("Watch", "PatekPhillipe");
	while(productview_rs14.next())
	{		
		String[] description_short = productview_rs14.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs14.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs14.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs14.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs14.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs14.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs14.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs14.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs14.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs14.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>														
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	
<!-- Richard Mille -->
<%
	ResultSet productview_rs15 = logic.productDisplay("Watch", "RichardMille");
	while(productview_rs15.next())
	{		
		String[] description_short = productview_rs15.getString("Description_Short").split("#",2);
				
%>
	<div class="modal video-modal fade" id="<%=productview_rs15.getString("ID") %>" tabindex="-1"
		role="dialog" aria-labelledby="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<section>
					<div class="modal-body" >
						<div class="col-md-5 modal_body_left">
							<img src="<%=productview_rs15.getString("Image_Display") %>" alt=" " class="img-responsive" />
						</div>
						<div class="col-md-7 modal_body_right">
							<span style="font-family:Aleo; font-size:30px; color:#0066c0"><%=productview_rs15.getString("Name") %></span>													
							<p style="margin-top: -15px;">by <span style="color:#0066c0"><%=productview_rs15.getString("Manufacturer") %><span style="color:#008a00; font-weight:bold; margin-left: 10px">In Stock</span></p>
							<div class="rating" style="margin-top: -20px">
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star-.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="rating-left">
									<img src="images/star.png" alt=" " class="img-responsive" />
								</div>
								<div class="clearfix"></div>
							</div>							
							
							<ul>								
								<li style="font-family: Aleo"><%=description_short[0] %></li>
								<li style="font-family: Aleo"><%=description_short[1] %></li>
							</ul>
							
							<a href="<%=productview_rs15.getString("Page") %>"><span style="font-family: Aleo; color:##0066c0">See more product details</span></a>
													
							<div class="modal_body_right_cart simpleCart_shelfItem">
								<p>
									<span>$<%=productview_rs15.getString("Original_Price") %></span> <i class="item_price" style="color:#B12704">$<%=productview_rs15.getString("Discounted_Price")%></i>
								</p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart"> <input
										type="hidden" name="add" value="1"> <input
										type="hidden" name="w3ls_item" value="<%=productview_rs15.getString("Short_Name") %>">
									<input type="hidden" name="amount" value="<%=productview_rs15.getString("Discounted_Price") %>">
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form>
							</div>														
						</div>
						<div class="clearfix"></div>
					</div>
				</section>
			</div>
		</div>
	</div>
<%
	}
%>	
	<!-- //modal-video -->
	<!-- banner-bottom1 -->
	<div class="banner-bottom1">
		<div class="agileinfo_banner_bottom1_grids">
			<div class="col-md-7 agileinfo_banner_bottom1_grid_left">
				<h3>
					Grand Opening Event With flat<span>20% <i>Discount</i></span>
				</h3>
				<a href="index.jsp">Shop Now</a>
			</div>
			<div class="col-md-5 agileinfo_banner_bottom1_grid_right">
				<h4>hot deal</h4>
				<div class="timer_wrap">
					<div id="counter"></div>
				</div>
				<script src="js/jquery.countdown.js"></script>
				<script src="js/script.js"></script>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- //banner-bottom1 -->
	<!-- special-deals -->
	<div class="special-deals">
		<div class="container">
			<h2>Special Deals</h2>
			<div class="w3agile_special_deals_grids">
				<div class="col-md-7 w3agile_special_deals_grid_left">
					<div class="w3agile_special_deals_grid_left_grid">
						<img src="images/21.jpg" alt=" " class="img-responsive" />
						<div class="w3agile_special_deals_grid_left_grid_pos1">
							<h5>
								30%<span>Off/-</span>
							</h5>
						</div>
						<div class="w3agile_special_deals_grid_left_grid_pos">
							<h4>
								We Offer <span>Best Products</span>
							</h4>
						</div>
					</div>
					<div class="wmuSlider example1">
						<div class="wmuSliderWrapper">
							<article style="position: absolute; width: 100%; opacity: 0;">
								<div class="banner-wrap">
									<div class="w3agile_special_deals_grid_left_grid1">
										<img src="images/t1.png" alt=" " class="img-responsive" />
										<p>MJ Store is an ultimate pit stop for technology
											frenzy people. It offers medley of products at unimaginably
											discounted price!</p>
										<h4>Laura</h4>
									</div>
								</div>
							</article>
							<article style="position: absolute; width: 100%; opacity: 0;">
								<div class="banner-wrap">
									<div class="w3agile_special_deals_grid_left_grid1">
										<img src="images/t2.png" alt=" " class="img-responsive" />
										<p>The most trusted and highly rated online Electronics
											portal. I highly recommend this to everyone who seeks to
											purchase online.</p>
										<h4>Michael</h4>
									</div>
								</div>
							</article>
							<article style="position: absolute; width: 100%; opacity: 0;">
								<div class="banner-wrap">
									<div class="w3agile_special_deals_grid_left_grid1">
										<img src="images/t3.png" alt=" " class="img-responsive" />
										<p>The MJ Store provides me offers which are
											inevitable to pass on and not available elsewhere. It is, and
											always will be my preffered choice for Electronics purchase.</p>
										<h4>Rosy</h4>
									</div>
								</div>
							</article>
						</div>
					</div>
					<script src="js/jquery.wmuSlider.js"></script>
					<script>
						$('.example1').wmuSlider();
					</script>
				</div>
				<div class="col-md-5 w3agile_special_deals_grid_right">
					<img src="images/20.jpg" alt=" " class="img-responsive" />
					<div class="w3agile_special_deals_grid_right_pos">
						<h4>
							Men's <span>Special</span>
						</h4>
						<h5>
							save up <span>to</span> 30%
						</h5>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<!-- //special-deals -->
	<!-- top-brands -->
	<div class="top-brands">
		<div class="container">
			<h3>Top Brands</h3>
			<div class="sliderfig">
				<ul id="flexiselDemo1">
					<li><img src="images/tb1.jpg" alt=" " class="img-responsive" />
					</li>
					<li><img src="images/tb2.jpg" alt=" " class="img-responsive" />
					</li>
					<li><img src="images/tb3.jpg" alt=" " class="img-responsive" />
					</li>
					<li><img src="images/tb4.jpg" alt=" " class="img-responsive" />
					</li>
					<li><img src="images/tb5.jpg" alt=" " class="img-responsive" />
					</li>
				</ul>
			</div>
			<script type="text/javascript">
				$(window).load(function() {
					$("#flexiselDemo1").flexisel({
						visibleItems : 4,
						animationSpeed : 1000,
						autoPlay : true,
						autoPlaySpeed : 3000,
						pauseOnHover : true,
						enableResponsiveBreakpoints : true,
						responsiveBreakpoints : {
							portrait : {
								changePoint : 480,
								visibleItems : 1
							},
							landscape : {
								changePoint : 640,
								visibleItems : 2
							},
							tablet : {
								changePoint : 768,
								visibleItems : 3
							}
						}
					});

				});
			</script>
			<script type="text/javascript" src="js/jquery.flexisel.js"></script>
		</div>
	</div>
	<!-- //top-brands -->
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
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- //newsletter -->
	<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="w3_footer_grids">
				<div class="col-md-3 w3_footer_grid">
					<h3>Contact</h3>
					<p>For further information, get in touch with us :</p>
					<ul class="address">
						<li><i class="glyphicon glyphicon-map-marker"
							aria-hidden="true"></i>AU -1, Grandcity Plaza, <span>Ludhiana.</span></li>
						<li><i class="glyphicon glyphicon-envelope"
							aria-hidden="true"></i><a href="mailto:jainmahaan@gmail.com">jainmahaan@gmail.com</a></li>
						<li><i class="glyphicon glyphicon-earphone"
							aria-hidden="true"></i>+91 - 87250 73002</li>
					</ul>
				</div>
				<div class="col-md-3 w3_footer_grid">
					<h3>Information</h3>
					<ul class="info">
						<li><a href="about.jsp">About Us</a></li>
						<li><a href="mail.jsp">Contact Us</a></li>
						<li><a href="faq.jsp">FAQ's</a></li>
						<li><a href="products_tv.jsp">Special Products</a></li>
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
				<div class="clearfix"></div>
			</div>
		</div>
		<div class="footer-copy">
			<div class="footer-copy1">
				<div class="footer-copy-pos">
					<a href="#home1" class="scroll"><img src="images/arrow.png"
						alt=" " class="img-responsive" /></a>
				</div>
			</div>
			<div class="container">
				<p>&copy; MJ Store. All rights reserved | Designed by
					Mahaan Jain</p>
			</div>
		</div>
	</div>
	<!-- //footer -->
	<!-- cart-js -->
	<script src="js/minicart.js"></script>
	<script>
		w3ls.render();

		w3ls.cart.on('w3sb_checkout', function(evt) {
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