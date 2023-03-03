module ApplicationHelper
  def user_avatar(user)
    if user.photo.attached?
      cl_image_path user.photo.key
    else
      image_url 'default_avatar.jpg'
    end
  end
end
