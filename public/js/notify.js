function notify(sender, message, iconUrl, onclick) {
    if (!Notification) {
        alert(message);
        return;
    }

    if (Notification.permission !== "granted")
        Notification.requestPermission();

    var notification = new Notification('', {
        icon: iconUrl,
        body: sender + ': ' + message,
        title: 'You have new message',
    });

    notification.onclick = function(){
        onclick();
        $("body").addClass("page-quick-sidebar-open");
        notification.close();
    };
}