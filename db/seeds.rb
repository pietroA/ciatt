# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.each do |user|
    unless user.online_status
        user.online_status = OnlineStatus.find_by(user_id: user.id)
        unless user.online_status				
            user.online_status = OnlineStatus.create!(user_id: user.id, online: false)
        end
    end

end