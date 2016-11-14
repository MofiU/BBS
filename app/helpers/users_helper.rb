module UsersHelper
  include LetterAvatar::AvatarHelper

  def user_photo(user, class_name)
    if user.photo.present?
      image_tag user.photo.url(:thumb), class: class_name
    else
      content_tag :img, nil, src: letter_avatar_url(user.username), class: class_name, alt: user.username
    end
  end

  def render_user_operation(current_user, user)
    if current_user != user
      if user.has_role? :admin
        link_to '降级为会员', users_grant_user_path(user), method: :post
      else
        link_to '提升为管理员', users_grant_admin_path(user), method: :post
      end
    end
  end

end
