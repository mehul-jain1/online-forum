module CommentsHelper
  def get_flash_notice
    return "Your comment was successfully posted" if @commentable.class == Question
    return "Your Comment Reply was successfully posted" if @commentable.class == Comment 
  end
end