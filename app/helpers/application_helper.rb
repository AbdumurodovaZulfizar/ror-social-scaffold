# rubocop:disable Style/RedundantAssignment
module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('👎', post_like_path(id: like.id, post_id: post.id), method: :delete, class: 'none red')
    else
      link_to('👍', post_likes_path(post_id: post.id), method: :post, class: 'none red')
    end
  end

  def friends?(user)
    friend = Friendship.find_by(user_id: current_user.id, friend_id: user.id, confirmed: true) || Friendship.find_by(
      user_id: user.id, friend_id: current_user.id, confirmed: true
    )
    friend
  end

  def request_sent?(user)
    request = Friendship.find_by(user_id: user.id, friend_id: current_user.id, confirmed: false)
    request
  end

  def send_or_recall_friend_request(user)
    show_friend_request_btns(user) unless current_user == user || friends?(user) || request_sent?(user)
  end

  def show_friend_request_btns(user)
    request = Friendship.find_by(user_id: current_user.id, friend_id: user.id, confirmed: false)
    if request
      link_to(
        'Recall Request',
        user_friendship_path(id: request.id, user_id: current_user.id, friend_id: user.id),
        method: :delete, class: 'btn btn-dark p-1'
      )
    else
      link_to(
        'Send Request',
        user_friendships_path(user_id: current_user.id, friend_id: user.id, confirmed: false),
        method: :post, class: 'btn btn-dark p-1'
      )
    end
  end

  def connections
    link_to(
      'Connections', user_friendships_path(user_id: current_user.id, confirmed: false),
      method: :get, class: 'btn btn-outline-light'
    )
  end

  def connections_array(friend_id_array)
    pending_users = []
    friend_id_array.each do |e|
      pending_users.push(User.find(e.friend_id))
    end
    pending_users
  end

  def pending_array(friend_id_array)
    pending_users = []
    friend_id_array.each do |e|
      pending_users.push(User.find(e.user_id))
    end
    pending_users
  end

  def accept_friend_request(user)
    request = Friendship.find_by(user: user, friend: current_user)
    link_to(
      'Accept', user_friendship_path(id: request.id, user_id: current_user.id, friend_id: user.id),
      method: :patch, class: 'btn btn-dark p-1'
    )
  end

  def reject_friend_request(user)
    request = Friendship.find_by(user_id: user.id, friend_id: current_user.id, confirmed: false)
    link_to(
      'Ignore',
      user_friendship_path(id: request.id, user_id: user.id, friend_id: current_user.id),
      method: :delete, class: 'btn btn-dark p-1'
    )
  end
end
# rubocop:enable Style/RedundantAssignment
