Task.destroy_all
List.destroy_all
Board.destroy_all
User.destroy_all
Team.destroy_all

@position = 10;

def new_position
  @position+=1
end

u1 = User.create!(username: "User1", email: "user1@gmail.com", password: "user1", password_confirmation: "user1")
u2 = User.create!(username: "User2", email: "user2@gmail.com", password: "user2", password_confirmation: "user2")

t1 = u1.teams.create!(name:"Team1 with 2 users")
t1.users << u2

t2 = u1.teams.create!(name:"Private board")
t3 = u2.teams.create!(name:"Private board")

b1 = t1.boards.create!(name: "Team board")
b2 = t2.boards.create!(name: "Private board for user1")
b3 = t3.boards.create!(name: "Private board for user2")

l1 = b1.lists.create!(name:"First list on teamboard")
l2 = b1.lists.create!(name:"Second list on teamboard")
l3 = b2.lists.create!(name:"First list on private board for User1")
l4 = b2.lists.create!(name:"Second list on private board for User1")
l5 = b3.lists.create!(name:"First list on private board for user2")

task1 = l1.tasks.create!(name:"Task 1 on first team list for user1", color: "white", position: new_position)
task1.assignee = u1
task1.save

task2 = l1.tasks.create!(name:"Task 2 on first team list for user2", color: "white", position: new_position)
task2.assignee = u2
task2.save

task3 = l3.tasks.create!(name:"Task 1 on first private list for user1", color: "white", position: new_position)
task3.assignee = u1
task3.save

task4 = l3.tasks.create!(name:"Another task 5", color: "white",position: new_position)
task4.assignee = u1
task4.save

task4 = l4.tasks.create!(name:"Another task 6", color: "white", position: new_position)
task4.assignee = u1
task4.save

task4 = l5.tasks.create!(name:"Another task 7", color: "white", position: new_position)
task4.assignee = u2
task4.save

task4 = l5.tasks.create!(name:"Another task 8", color: "white", position: new_position)
task4.assignee = u2
task4.save

task4 = l5.tasks.create!(name:"Another task 9", color: "white", position: new_position)
task4.assignee = u2
task4.save