<%@ page contentType="text/html;charset=UTF-8"%>
<!-- Page Preloder -->

 <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__close">+</div>
        <ul class="offcanvas__widget">
            <li><span class="icon_search search-switch"></span></li>
            <li><a href="#"><span class="icon_heart_alt"></span>
                <div class="tip">2</div>
            </a></li>
            <li><a href="/shop/cart/list"><span class="icon_bag_alt"></span>
                <div class="tip">2</div>
            </a></li>
        </ul>
        <div class="offcanvas__logo">
            <a href="/"><img src="/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="/shop/member/loginForm">Login</a>
            <a href="/shop/member/registForm">Register</a>
          
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="/"><img src="/resources/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                        	<li></li>
                            <li class="active"><a href="/">Home</a></li>
                            <li><a href="/shop/product/listAll">옷</a>
                                <ul class="dropdown">
                                    <li><a href="/shop/product/list?subcategory_id=1">패딩</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=2">나시</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=3">점프수트</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=4">원피스</a></li>
                                </ul>
                            </li>
                            <li><a href="/shop/product/listAll">사료</a>
                                <ul class="dropdown">
                                    <li><a href="/shop/product/list?subcategory_id=5">연어</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=6">소고기</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=7">양고기</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=8">닭고기</a></li>
                                </ul>
                            </li>
                            <li><a href="/shop/product/listAll">간식</a>
                                <ul class="dropdown">
                                    <li><a href="/shop/product/list?subcategory_id=9">츄잉껌</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=10">츄르</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=11">소시지</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=12">육포말이</a></li>
                                </ul>
                            </li>
                            <li><a href="/shop/product/listAll">악세서리</a>
                                <ul class="dropdown">
                                    <li><a href="/shop/product/list?subcategory_id=13">모자</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=14">목걸이</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=15">펫스텝</a></li>
                                    <li><a href="/shop/product/list?subcategory_id=16">철망</a></li>
                                </ul>
                            </li>
                            <!-- <li><a href="/">Shop</a></li> -->
                            <li><a href="/shop/cart/list">Cart</a>
                               <!--  <ul class="dropdown">
                                    <li><a href="./product-details.html">Product Details</a></li>
                                     <li><a href="/shop/cart/list">Cart</a></li>
                                    <li><a href="./checkout.html">Checkout</a></li>
                                    <li><a href="./blog-details.html">Blog Details</a></li>
                            <li><a href="./blog.html">Blog</a></li>
                            <li><a href="./contact.html">Contact</a></li>
                                </ul> -->
                            </li>
                        </ul>
                    </nav>
                </div>
                 <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
                            <%if(session.getAttribute("member")==null){ %>
            					<a href="/shop/member/loginForm">Login</a>
                            	<a href="/shop/member/registForm">Register</a>
            				<%}else{ %>
            					<a href="/shop/member/logout">LogOut</a>
            					<a href="/shop/member/mypage_order">MyPage</a>
        					<%} %>
                        </div>
                        <ul class="header__right__widget">
                            <li><span class="icon_search search-switch"></span></li>
                            <li><a href="#"><span class="icon_heart_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                            <li><a href="#"><span class="icon_bag_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->