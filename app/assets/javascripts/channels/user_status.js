App.messages = App.cable.subscriptions.create('UserStatusChannel', {  
  received: function(user) {
    this.setUserStatus(user);
    return true;
  },

  setUserStatus: function(user){
    var element = document.getElementById('logon-'+user.name);
    if (element) {
      if(user.online_status.online) {
        if(!element.classList.contains('online')) {
          element.classList.add('online');
        }
      } else {
        element.classList.remove('online');
      }
    }
    return true;
  }

});

