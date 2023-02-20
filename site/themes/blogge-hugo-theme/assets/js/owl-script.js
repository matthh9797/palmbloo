$(".owl-carousel").owlCarousel({
    autoplay: true,
    autoplayhoverpause: true,
    autoplaytimeout: 100,
    items: 2,
    nav: true,
    loop: true,
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
