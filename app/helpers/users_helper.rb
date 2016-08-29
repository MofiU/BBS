module UsersHelper
  include LetterAvatar::AvatarHelper

  def user_photo(user, class_name)
    if user.photo.present?
      image_tag user.photo.url(:thumb), class: class_name
    else
      content_tag :img, nil, src: letter_avatar_url(user.username), class: class_name, alt: user.username
    end
  end


end
