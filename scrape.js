var url ='https://www.wunderground.com/history/daily/us/FL/Miami/date/2018-7-31';
var page = new WebPage()
var fs = require('fs');


page.open(url, function (status) {
        just_wait();
});

function just_wait() {
    setTimeout(function() {
               fs.write('1.html', page.content, 'w');
            phantom.exit();
    }, 3000);
}
