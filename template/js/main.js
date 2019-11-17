window.onload = function(){
    more = document.getElementsByClassName('comment__more');
    for(mor of more){
        mor.addEventListener('click', function(e){
            e.preventDefault();
        })
    }
   
}


new Vue({
    el: '.superwrapper',
    data:{
        modalVis: false
    },
    components: {
        'carousel': VueCarousel.Carousel,
        'slide': VueCarousel.Slide
    }
})