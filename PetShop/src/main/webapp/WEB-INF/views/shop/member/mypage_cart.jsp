<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
  <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body>
<%@ include file="./../../inc/shop_navi.jsp"%>
	<!-- 사이트 이동경로 시작 -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="/shop/member/mypage_cart"><i class="fa fa-home"></i> Mypage</a>
                        <span>Home</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 사이트 이동경로 종료 -->


    <!-- Blog Details Section Begin -->
    <section class="blog-details spad">
        <div class="container">
            <div class="row">
            <div class="col-lg-2 col-md-2">
                    <div class="blog__sidebar">
                        <div class="blog__sidebar__item">
                            <div class="section-title">
                                <h4>My Page</h4>
                            </div>
                            <ul>
                                <li><a href="/shop/member/mypage_cart">장바구니 </a></li>
                                <li><a href="#">주문내역 </a></li>
                                <li><a href="/shop/member/mypage_management">계정관리 </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            
                <div class="col-lg-9 col-md-9">
                    <div class="blog__details__content">
                        <div class="blog__details__item">
                            <img src="img/blog/details/blog-details.jpg" alt="">
                            <div class="blog__details__item__title">
                                <span class="tip">Street style</span>
                                <h4>Being seen: how is age diversity effecting change in fashion and beauty?</h4>
                                <ul>
                                    <li>by <span>Ema Timahe</span></li>
                                    <li>Seb 17, 2019</li>
                                    <li>39 Comments</li>
                                </ul>
                            </div>
                        </div>
                        <div class="blog__details__desc">
                            <p>Afashion season can be defined as much by the people on the catwalk as it can by the
                                clothes they are wearing. This time around, a key moment came at the end of Marc Jacobsâ
                                New York show, when an almost makeup-free Christy Turlington made a rare return to the
                                catwalk, aged 50 (she also stars, with the designer himself, in the labelâs AW ad
                            campaign), where the average catwalk model is around 18.</p>
                            <p>A few days later, Simone Rocha arguably upped the ante. The 32-year-oldâs show â in part
                                inspired by Louise Bourgeois, who lived until she was 98 â featured models in their 30s
                            and 40s, including cult favourite Jeny Howorth and actor ChloÃ« Sevigny.</p>
                        </div>
                        <div class="blog__details__quote">
                            <div class="icon"><i class="fa fa-quote-left"></i></div>
                            <p>Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore dolore magna
                                aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                            aliquip ex ea commodo consequat.</p>
                        </div>
                        <div class="blog__details__desc">
                            <p>Occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
                                laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                                exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
                            dolor in reprehenderit in voluptate.</p>
                        </div>
                        <div class="blog__details__tags">
                            <a href="#">Fashion</a>
                            <a href="#">Street style</a>
                            <a href="#">Diversity</a>
                            <a href="#">Beauty</a>
                        </div>
                        <div class="blog__details__btns">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="blog__details__btn__item">
                                        <h6><a href="#"><i class="fa fa-angle-left"></i> Previous posts</a></h6>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="blog__details__btn__item blog__details__btn__item--next">
                                        <h6><a href="#">Next posts <i class="fa fa-angle-right"></i></a></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->
	
<%@ include file="../shopFooter.jsp"%>
<%@ include file="./../../inc/footer.jsp"%>
</body>

</html>