window.onload = function(){
    // Отмена перехода по ссылке чтобы при открытии полного комментария
    // не возвращаться в начало страницы
    more = document.getElementsByClassName('comment__title');
    for(mor of more){
        mor.addEventListener('click', function(e){
            e.preventDefault();
        })
    }
   
}


new Vue({
    el: '.superwrapper',
    data:{
        modalVis: false,
    },
    components: {
        'carousel': VueCarousel.Carousel,
        'slide': VueCarousel.Slide
    }
})


