def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def set_admin_user(user=nil)
  session[:user_id] = (user || Fabricate(:user, admin: true)).id
end