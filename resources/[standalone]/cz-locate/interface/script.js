let labels = [".", "..", "..."], index = 0;

function Loading() {
    return new Promise(res => {
        let c = 0, el = $(".loading");
        let handle = setInterval(() => {
            if(c >= 5) return res(clearInterval(handle));
            console.log(c)
            index = (index == 2) ? (0) : (index+1);
            el.html("Locating" + (labels[index]));
            c++;
        }, 1000)
    })
}

let loading = false;
$(document).on('click', '.save-btn', function(event) {
    if(!loading) {
        loading = true;
        let phone = $("input[type=number]").val();
        Loading().then(() => {
            $.post(`https://cz-locate/locate`, JSON.stringify({phone}));
            loading = false;
            console.log(phone)
        });
    }
});

window.addEventListener("message", ({data}) => {
    switch (data.action) {
        case "locate":
            $(".loading").html("<span style='color: green;'>Located<span/>")
            $("#container").hide();
            break
        case "error":
            $(".loading").html("<span style='color: red;'>Failed To Locate<span/>")
            break
        case "open":
            $("#container").css("display", "flex");
            break
    }
})