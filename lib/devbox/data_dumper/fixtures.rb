puts "Creating default devbox admin user"
u = WordUser.where(login: "devbox").first_or_create
u.password = "devbox"
u.save

AdminUser.where(word_user_id: u.id).first_or_create