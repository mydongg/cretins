window.onload = function(){
    reg = document.getElementById('register');
    reg.addEventListener('click', function(e){
        e.preventDefault();
    })
}


new Vue({
    el: '.fullscreenWrapper',
    data:{
        regModalVis: false
    }
})