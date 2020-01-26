window.onload = function(){
    del = document.getElementById('deletePost');
    del.addEventListener('click', function(e){
        e.preventDefault();
    })
}


new Vue({
    el: '.superwrapper',
    data:{
        postModalVis: false
    }
})