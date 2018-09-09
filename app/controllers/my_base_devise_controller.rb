class MyBaseDeviseController < ApplicationController
  layout :layout_by_resource

  private
    def layout_by_resource
      if resource_name == :admin
        "admin"
      end
    end

    def after_sign_up_path_for(resource)
      logger.debug resource
      if resource == Admin
        logger.debug "admin sign up"
        admins_root_path
      else
        root_path
      end
    end

    # サインイン後のリダイレクト先
    def after_sign_in_path_for(resource)
      logger.debug resource
      if resource == Admin
        logger.debug "admin sign in"
        admins_root_path
      else
        root_path
      end
    end

    # ログアウト後のリダイレクト先
    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :admin
        new_admin_session_path
      else
        new_user_session_path
      end
    end

end