App.web_notifications = App.cable.subscriptions.create("WebNotificationsChannel", {
  received: function(data) {
    switch(data.notification_type){
      case 'request':
        this.updateRequests(data.html)
      case 'comment':
        this.updateComments(data.html, data.resource_id)
    }
  },
  updateRequests: function(html_content) {
    $('.posts').first().html(html_content)
  },
  updateComments: function(html_content, resource_id) {
    comments = $('.comments').first()
    question_id = comments.data('questionid')
    if(question_id == resource_id){
      $('.comments').first().html(html_content)
    }
  }  
});