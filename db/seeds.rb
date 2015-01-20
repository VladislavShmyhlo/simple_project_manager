# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[Project, Task, Comment, Attachment, User].each &:delete_all

User.create [
                {email: 'aion.stu@gmail.com', password: 'password', password_confirmation: 'password'},
                {email: 'test@gmail.com', password: 'testtest', password_confirmation: 'testtest'},
            ]

id = User.last.id

5.times {
  p = Project.create(name: (%w{awesome random cool large complex}.shuffle! << 'project').join(' '), user_id: id)
  5.times {|i|
    t = p.tasks.build(description: "Task ##{i+1}", position: i, completed: i % 2 == 0 ? true : false)
      3.times {|k|
        t.comments.build(body: "comment number #{i+1}")
      }
    p.save!
  }
}