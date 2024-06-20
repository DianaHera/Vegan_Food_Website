window.addEventListener("DOMContentLoaded", function () {
    document.getElementById("tema_toggle").addEventListener("change", function () {
        document.body.classList.toggle("dark");
        if (document.body.classList.contains("dark")) {
            localStorage.setItem("tema", "dark");
        } else {
            localStorage.removeItem("tema");
        }
    });
  
    // Check local storage for theme preference on page load
    let tema = localStorage.getItem("tema");
    if (tema === "dark") {
        document.body.classList.add("dark");
    }
  });











/*

if(localStorage.getItem("tema")){
    document.body.classList.add("dark")
}
else{
    document.body.classList.remove("dark")
}


window.addEventListener(DOMContentLoaded, function(){
    this.document.getElementById("schimba_tema").onclick=function(){
        if(document.body.classList.contains("dark")){
            document.body.classList.remove("dark")
            localStorage.removeItem("tema")
        }
        else {
            document.body.classList.add("dark")
            localStorage.setItem("tema","dark")
        }
    }
})*/