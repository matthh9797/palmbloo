$(".owl-one").owlCarousel({
    autoplay: true,
    autoplayHoverPause: true,
    autoplayTimeout: 9000,
    items: 2,
    nav: true,
    loop: true,
    lazyLoad: true,
    responsive: {
        0: {
            items: 1,
            dots: false,
        },
        728: {
            items: 2,
            dots: true
        },
        1200: {
            items: 3,
            dots: true
        }
    }
});
$(".owl-two").owlCarousel({
    autoplay: true,
    autoplayHoverPause: true,
    autoplayTimeout: 7000,
    items: 1,
    nav: true,
    loop: true,
    lazyLoad: true
});
$(".owl-blog-slider").owlCarousel({
    autoplay: true,
    autoplayHoverPause: true,
    autoplayTimeout: 12000,
    items: 1,
    nav: true,
    loop: true,
    lazyLoad: true
});

