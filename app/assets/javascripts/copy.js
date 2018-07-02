
function copyToClipboard() {
    var $temp = $("<input>");
    $("body").append($temp);
    a = document.getElementById('message');
    $temp.val(/http(.*)/.exec(a.childNodes[1].data)[0]).select();
    document.execCommand("copy");
    $temp.remove();
}
