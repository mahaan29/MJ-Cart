<%@ page import="java.sql.*"%>
<%@ page import="model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Product - The MJ Store</title>
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
<!-- web fonts --> 
<link href='//fonts.googleapis.com/css?family=Glegoo:400,700' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Bree+Serif" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Rubik" rel="stylesheet">
<!-- //web fonts --> 
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
	<!-- header modal -->
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
	<div class="banner banner10">
		<div class="container">			
		</div>
		
<%
	ResultSet productdisplay_rs = logic.productDisplay("Headphone","FocalStellia");
	while(productdisplay_rs.next())
	{
		String[] description = productdisplay_rs.getString("Description").split("#");
		
%>
	</div>
	<!-- //banner -->   
	<!-- breadcrumbs -->
	<div class="breadcrumb_dress">
		<div class="container">
			<ul>
				<li><a href="index.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> Home</a> <i>/</i></li>
				<li><%=productdisplay_rs.getString("Short_Name") %></li>
			</ul>
		</div>
	</div>
	<!-- //breadcrumbs -->  
	<!-- single -->
	<style>
		.img1
		{
			width : 342px !important;		
			height: auto !important;				
		}
	</style>
	<style>
		.flex-control-nav > li >.thumbnails
		{
			width : 10px !important;
			height : auto !important;
			
		}
		.flex-control-thumbs img 
		{
    		width: 100% !important;
    		height: auto !important;
    	}
   	</style>
	<div class="single">
		<div class="container">
			<div class="col-md-4 single-left">
				<div class="flexslider">
					<ul class="slides">
						<li data-thumb="<%=productdisplay_rs.getString("Image_1") %>">						
							<div class="thumb-image"> <img src="<%=productdisplay_rs.getString("Image_1") %>" data-imagezoom="true" class="img-responsive img1" alt=""></div>
						</li>
						<li data-thumb="<%=productdisplay_rs.getString("Image_2") %>">
							 <div class="thumb-image"> <img src="<%=productdisplay_rs.getString("Image_2") %>" data-imagezoom="true" class="img-responsive img1" alt=""> </div>
						</li>
						<li data-thumb="<%=productdisplay_rs.getString("Image_3") %>">
						   <div class="thumb-image"> <img src="<%=productdisplay_rs.getString("Image_3") %>" data-imagezoom="true" class="img-responsive img1" alt=""> </div>
						</li> 
					</ul>
				</div>
				<!-- flexslider -->
					<script defer src="js/jquery.flexslider.js"></script>
					<link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
					<script>
					// Can also be used with $(document).ready()
					$(window).load(function() {
					  $('.flexslider').flexslider({
						animation: "slide",
						controlNav: "thumbnails"
					  });
					});
					</script>
				<!-- flexslider -->
				<!-- zooming-effect -->
					<script src="js/imagezoom.js"></script>
				<!-- //zooming-effect -->
			</div>
			<div class="col-md-8 single-right">
			<style>
				.font
				{
					font-family: Bree Serif;			
				}
			</style>
				<h4 class="font"><%=productdisplay_rs.getString("Name") %></h4>
				<span >by<span style="color: #0066c0"> <%=productdisplay_rs.getString("Manufacturer") %></span></span>
				<div class="rating1">
					<span class="starRating">
						<input id="rating5" type="radio" name="rating" value="5">
						<label for="rating5">5</label>
						<input id="rating4" type="radio" name="rating" value="4">
						<label for="rating4">4</label>
						<input id="rating3" type="radio" name="rating" value="3" checked>
						<label for="rating3">3</label>
						<input id="rating2" type="radio" name="rating" value="2">
						<label for="rating2">2</label>
						<input id="rating1" type="radio" name="rating" value="1">
						<label for="rating1">1</label>
					</span>
				</div>
				<hr style="border-top:1px solid; color:#CCC; margin-top:-15px">
				<span style="color:#008a00; font-weight: 600!important">In Stock.</span>
				<br>
				<span style="color:#0066c0"><b>FREE</b> Delivery in <%=productdisplay_rs.getString("Delivery_Time") %> business days.</span>
				<div class="description">
					<h5><i>Description</i></h5>
					<ul style="font-size:15px; margin-left:15px; margin-top: 5px">
					<%
						for(int i=0; i<=description.length-1; i++)
						{
													
					%>
					<li><%=description[i] %></li>			
					<%
						}
					%>
					</ul>
				</div>
				<div class="color-quality">
					<div class="color-quality-left">
						<h5>Color : </h5>
						<ul>														
							<li><a href="#" class="<%=productdisplay_rs.getString("Color_1") %>"><span></span></a></li>							
						</ul>
					</div>					
						</div>
						<!--quantity-->
								<script>
								$('.value-plus1').on('click', function(){
									var divUpd = $(this).parent().find('.value1'), newVal = parseInt(divUpd.text(), 10)+1;
									divUpd.text(newVal);
								});

								$('.value-minus1').on('click', function(){
									var divUpd = $(this).parent().find('.value1'), newVal = parseInt(divUpd.text(), 10)-1;
									if(newVal>=1) divUpd.text(newVal);
								});
								</script>
							<!--quantity-->

					</div>
					<div class="clearfix"> </div>
				</div>
				<div class="occasional" style="margin-left: 540px; margin-top: 0px">										
					<div class="clearfix"> </div>
				</div>				 
				<div class="simpleCart_shelfItem" style="margin-left: 540px; margin-top: 0px">
					<p><span>$<%=productdisplay_rs.getString("Original_Price") %></span> <b class="item_price" style="color:#B12704">$<%=productdisplay_rs.getString("Discounted_Price") %></b></p>
					<form action="#" method="post">
						<input type="hidden" name="cmd" value="_cart">
						<input type="hidden" name="add" value="1"> 
						<input type="hidden" name="w3ls_item" value="<%=productdisplay_rs.getString("Short_Name") %>"> 
						<input type="hidden" name="amount" value="<%=productdisplay_rs.getString("Discounted_Price") %>">   
						<button type="submit" class="w3ls-cart">Add to cart</button>
					</form>
				</div> 
			</div>
			<div class="clearfix"> </div>
		</div>
	</div> 
	<div class="additional_info">
		<div class="container">
			<div class="sap_tabs">	
				<div id="horizontalTab1" style="display: block; width: 100%; margin: 0px;">
					<ul>
						<li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>Product Information</span></li>
						<li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>Reviews</span></li>
					</ul>		
					<div class="tab-1 resp-tab-content additional_info_grid" aria-labelledby="tab_item-0">
						<h3 style="font-family: Rubik"><%=productdisplay_rs.getString("Short_Name") %></h3>
						<p>
						<ul>
						<%
							String[] product_info = productdisplay_rs.getString("Product_Info").split("#");
						
							for(int x=0; x<=product_info.length-1; x++)
							{
															
						%>
							<li><%=product_info[x] %></li>
						<%
							}
						%>
						</ul>
					</div>	
<%
	}
%>
					<div class="tab-2 resp-tab-content additional_info_grid" aria-labelledby="tab_item-1">
						<h4>(2) Reviews</h4>
						<div class="additional_info_sub_grids">
							<div class="col-xs-2 additional_info_sub_grid_left">
								<img src="images/t1.png" alt=" " class="img-responsive" />
							</div>
							<div class="col-xs-10 additional_info_sub_grid_right">
								<div class="additional_info_sub_grid_rightl">
									Laura
									<h5>Oct 06, 2016.</h5>
									<p>Quis autem vel eum iure reprehenderit qui in ea voluptate 
										velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat 
										quo voluptas nulla pariatur.</p>
								</div>
								<div class="additional_info_sub_grid_rightr">
									<div class="rating">
										<div class="rating-left">
											<img src="images/star-.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star-.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star-.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star.png" alt=" " class="img-responsive">
										</div>
										<div class="clearfix"> </div>
									</div>
								</div>
								<div class="clearfix"> </div>
							</div>
							<div class="clearfix"> </div>
						</div>
						<div class="additional_info_sub_grids">
							<div class="col-xs-2 additional_info_sub_grid_left">
								<img src="images/t2.png" alt=" " class="img-responsive" />
							</div>
							<div class="col-xs-10 additional_info_sub_grid_right">
								<div class="additional_info_sub_grid_rightl">
									Michael
									<h5>Oct 04, 2016.</h5>
									<p>Quis autem vel eum iure reprehenderit qui in ea voluptate 
										velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat 
										quo voluptas nulla pariatur.</p>
								</div>
								<div class="additional_info_sub_grid_rightr">
									<div class="rating">
										<div class="rating-left">
											<img src="images/star-.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star-.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star.png" alt=" " class="img-responsive">
										</div>
										<div class="rating-left">
											<img src="images/star.png" alt=" " class="img-responsive">
										</div>
										<div class="clearfix"> </div>
									</div>
								</div>
								<div class="clearfix"> </div>
							</div>
							<div class="clearfix"> </div>
						</div>
						<div class="review_grids">
							<h5>Add A Review</h5>
							<form action="#" method="post">
								<input type="text" name="Name" value="Name" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Name';}" required="">
								<input type="email" name="Email" placeholder="Email" required="">
								<input type="text" name="Telephone" value="Telephone" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Telephone';}" required="">
								<textarea name="Review" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Add Your Review';}" required="">Add Your Review</textarea>
								<input type="submit" value="Submit" >
							</form>
						</div>
					</div> 			        					            	      
				</div>	
			</div>
			<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
			<script type="text/javascript">
				$(document).ready(function () {
					$('#horizontalTab1').easyResponsiveTabs({
						type: 'default', //Types: default, vertical, accordion           
						width: 'auto', //auto or any width like 600px
						fit: true   // 100% fit in a container
					});
				});
			</script>
		</div>
	</div>
<!-- Related Products -->
<div class="w3l_related_products">
		<div class="container">
			<h3>Related Products</h3>
			<ul id="flexiselDemo2">
			
<!-- Audio Council -->				
<%
	ResultSet product_rs1 = logic.productDisplay("Headphone", "AudioCouncil");
	while(product_rs1.next())
	{
			
%>
				<li>
					<div class="w3l_related_products_grid">
						<div class="agile_ecommerce_tab_left mobiles_grid">
							<div class="hs-wrapper hs-wrapper3" style="height: 255px !important">
								<img src="<%=product_rs1.getString("Image_Display") %>" alt=" " class="img-responsive" height="255px"/>
								<img src="<%=product_rs1.getString("Image_Display") %>" alt=" " class="img-responsive" height="255px"/>																															
								<div class="w3_hs_bottom">
									<div class="flex_ecommerce">
										<a href="#" data-toggle="modal" data-target="#<%=product_rs1.getString("ID") %>"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
									</div>
								</div>
							</div>
							<h5><a href="<%=product_rs1.getString("Page") %>"><%=product_rs1.getString("Short_Name") %></a></h5>
							<div class="simpleCart_shelfItem"> 
								<p class="flexisel_ecommerce_cart"><span>$<%=product_rs1.getString("Original_Price") %></span> <i class="item_price">$<%=product_rs1.getString("Discounted_Price") %></i></p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart">
									<input type="hidden" name="add" value="1"> 
									<input type="hidden" name="w3ls_item" value="<%=product_rs1.getString("ID") %>"> 
									<input type="hidden" name="amount" value="<%=product_rs1.getString("Discounted_Price") %>">   
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form> 
							</div>
						</div>
					</div>					
				</li>	
<%
	}
%>		
<!-- Audeze LCD -->
<%
	ResultSet product_rs2 = logic.productDisplay("Headphone", "AudezeLCD");
	while(product_rs2.next())
	{
			
%>
				<li>
					<div class="w3l_related_products_grid">
						<div class="agile_ecommerce_tab_left mobiles_grid">
							<div class="hs-wrapper hs-wrapper3" style="height: 255px !important">
								<img src="<%=product_rs2.getString("Image_1") %>" alt=" " class="img-responsive" height="255px"/>
								<img src="<%=product_rs2.getString("Image_1") %>" alt=" " class="img-responsive" height="255px"/>																															
								<div class="w3_hs_bottom">
									<div class="flex_ecommerce">
										<a href="#" data-toggle="modal" data-target="#<%=product_rs2.getString("ID") %>"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
									</div>
								</div>
							</div>
							<h5><a href="<%=product_rs2.getString("Page") %>"><%=product_rs2.getString("Short_Name") %></a></h5>
							<div class="simpleCart_shelfItem"> 
								<p class="flexisel_ecommerce_cart"><span>$<%=product_rs2.getString("Original_Price") %></span> <i class="item_price">$<%=product_rs2.getString("Discounted_Price") %></i></p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart">
									<input type="hidden" name="add" value="1"> 
									<input type="hidden" name="w3ls_item" value="<%=product_rs2.getString("ID") %>"> 
									<input type="hidden" name="amount" value="<%=product_rs2.getString("Discounted_Price") %>">   
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form> 
							</div>
						</div>
					</div>					
				</li>	
<%
	}
%>		
<!-- HIFIMAN -->
<%
	ResultSet product_rs3 = logic.productDisplay("Headphone", "HIFIMAN");
	while(product_rs3.next())
	{
			
%>
				<li>
					<div class="w3l_related_products_grid">
						<div class="agile_ecommerce_tab_left mobiles_grid">
							<div class="hs-wrapper hs-wrapper3" style="height: 255px !important">
								<img src="<%=product_rs3.getString("Image_Display") %>" alt=" " class="img-responsive" height="255px"/>
								<img src="<%=product_rs3.getString("Image_Display") %>" alt=" " class="img-responsive" height="255px"/>																															
								<div class="w3_hs_bottom">
									<div class="flex_ecommerce">
										<a href="#" data-toggle="modal" data-target="#<%=product_rs3.getString("ID") %>"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
									</div>
								</div>
							</div>
							<h5><a href="<%=product_rs3.getString("Page") %>"><%=product_rs3.getString("Short_Name") %></a></h5>
							<div class="simpleCart_shelfItem"> 
								<p class="flexisel_ecommerce_cart"><span>$<%=product_rs3.getString("Original_Price") %></span> <i class="item_price">$<%=product_rs3.getString("Discounted_Price") %></i></p>
								<form action="#" method="post">
									<input type="hidden" name="cmd" value="_cart">
									<input type="hidden" name="add" value="1"> 
									<input type="hidden" name="w3ls_item" value="<%=product_rs3.getString("ID") %>"> 
									<input type="hidden" name="amount" value="<%=product_rs3.getString("Discounted_Price") %>">   
									<button type="submit" class="w3ls-cart">Add to cart</button>
								</form> 
							</div>
						</div>
					</div>					
				</li>	
<%
	}
%>		
				<script type="text/javascript">
					$(window).load(function() {
						$("#flexiselDemo2").flexisel({
							visibleItems:3,
							animationSpeed: 1000,
							autoPlay: true,
							autoPlaySpeed: 3000,    		
							pauseOnHover: true,
							enableResponsiveBreakpoints: true,
							responsiveBreakpoints: { 
								portrait: { 
									changePoint:480,
									visibleItems: 1
								}, 
								landscape: { 
									changePoint:640,
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
		</div>
	</div>
	
<!-- Audio Council -->
<%
	ResultSet productview_rs1 = logic.productDisplay("Headphone", "AudioCouncil");
	while(productview_rs1.next())
	{		
		String[] description_short = productview_rs1.getString("Description_Short").split("#",2);
				
%>
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
	
<!-- Audeze LCD -->
<%
	ResultSet productview_rs2 = logic.productDisplay("Headphone", "AudezeLCD");
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
	
<!-- HIFIMAN -->
<%
	ResultSet productview_rs3 = logic.productDisplay("Headphone", "HIFIMAN");
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
	<!-- //single -->
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
						<li><a href="products_headphones.jsp">Special Products</a></li>
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