<%@ page contentType="text/html;charset=UTF-8"%>
 
<!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
 <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__close">+</div>
        <ul class="offcanvas__widget">
            <li><span class="icon_search search-switch"></span></li>
            <li><a href="#"><span class="icon_heart_alt"></span>
                <div class="tip">2</div>
            </a></li>
            <li><a href="#"><span class="icon_bag_alt"></span>
                <div class="tip">2</div>
            </a></li>
        </ul>
        <div class="offcanvas__logo">
            <a href="./index.html"><img src="/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="#">Login</a>
            <a href="#">Register</a>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="./index.html"><img src="/resources/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>	
                        	<li></li>
                            <li class="active"><a href="/admin">Home</a></li>
                            <li><a href="#">상품</a>
                                <ul class="dropdown">
                                    <li><a href="/admin/product/list">목록</a></li>
                                    <li><a href="/admin/product/registform">등록</a></li>
                                     <li><a href="#">수정</a></li>
                                </ul>
                            </li>
                            <li><a href="#">회원</a>
                                <ul class="dropdown">
                                    <li><a href=/admin/member/list>목록</a></li>
                                </ul>
                            </li>
                            <li><a href="#">결제</a>
                                <ul class="dropdown">
                                    <li><a href="#">목록</a></li>
                                </ul>
                            </li>
                            
                            <li><a href="./blog.html">Blog</a></li>
                            <li><a href="/admin/contact">Contact</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
                        	<a href="/">Shop Main</a>
                      		<a href="#">Login</a>
                            <a href="#">Logout</a>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->