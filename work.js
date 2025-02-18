for (var i = 2; i < 4; i++) {
    setTimeout(function () {
        console.log(i);
    }, 1000);
}
console.log((i & "T"))
let a = parseInt('A')
console.log(a)

function converter() {
    var i,cats = new Array();
    cats[0] = "jag";
    cats[1] = 'cougar'
    cats[2] = 'puma'
    cats[3] = 'panther'
    for (i in cats) {
        switch(i) {
            case 'puma':
                i = 'Lynx'
                break;
            case 'Lynx':
                i = "pinto";
                break;
            default: 
                i = "stingray"
        }
    }
    console.log(cats)
}
converter()