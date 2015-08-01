User.destroy_all
Board.destroy_all
Team.destroy_all

u1 = User.create!(username: "User1", email: "user1@gmail.com", password: "user1", password_confirmation: "user1")
u2 = User.create!(username: "User2", email: "user2@gmail.com", password: "user2", password_confirmation: "user2")

t1 = u1.teams.create!(name:"Team1 with 2 users")
t1.users << u2

t2 = u1.teams.create!(name:"single_person1")
t3 = u2.teams.create!(name:"single_person2")

b1 = t2.boards.create!(name: "Team board")
b2 = t2.boards.create(name: "Private board for user1")
b3 = t3.boards.create(name: "Private board for user2")