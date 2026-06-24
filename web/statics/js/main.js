let li = $("li");
let section = $("section");
for(let j = 0;j<li.length;j++){
    section[j].style.display = "none";
}
section[0].style.display = "block";
for(let i = 0;i<li.length;i++){
    li[i].setAttribute('index',i);
    li[i].onclick=function(){
        let index = this.getAttribute("index");
        for(let j = 0;j<li.length;j++){
            section[j].style.display = "none";
        }
        section[index].style.display = "block";
    }
}