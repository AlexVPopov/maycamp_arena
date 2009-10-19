class Admin::BaseController < ApplicationController
  before_filter :login_required
  layout 'main'
  
  protected
    def authorized?
      super && current_user.admin?
    end
    
    def set_locale
      I18n.locale = :en
    end
end
