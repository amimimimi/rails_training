module ApplicationHelper

  def menu_class(controller_name, action_name = '')
    menu_class = ""
    if controller.controller_name == controller_name
      if action_name.blank?
        menu_class = "active"
      else
        menu_class = "active" if controller.action_name == action_name
      end
    end
    menu_class
  end

  def user_image(user, size = 100)
    disp_text = truncate(user.name, length: 3, omission: '')
    dummy = "http://placehold.jp/#{(size*0.3).to_i}/ffb6c1/f0f8ff/#{size}x#{size}.png?text=#{disp_text}"
    begin
      eval("user.image.thumb#{size}.url") || dummy
    rescue => e
      dummy
    end
  end

  def article_image(article, size = 100)
    disp_text = truncate(article.title, length: 3, omission: '')
    dummy = "http://placehold.jp/#{(size*0.3).to_i}/f0f8ff/ffb6c1/#{size}x#{size}.png?text=#{disp_text}"
    begin
      eval("article.image.thumb#{size}.url") || dummy
    rescue => e
      dummy
    end
  end
end
