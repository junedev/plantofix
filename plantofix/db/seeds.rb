Task.destroy_all
List.destroy_all
Board.destroy_all
User.destroy_all
Team.destroy_all

@position = 10;

def new_position
  @position+=1
end

u1 = User.create!(username: "Franziska", email: "franziska@gmail.com", password: "franziska", password_confirmation: "franziska")
u2 = User.create!(username: "Alex", email: "alex@gmail.com", password: "alex", password_confirmation: "alex")
u3 = User.create!(username: "Hassan", email: "hassan@gmail.com", password: "hassan", password_confirmation: "hassan")
u4 = User.create!(username: "Rane", email: "rane@gmail.com", password: "rane", password_confirmation: "rane")

t1 = u1.teams.create!(name:"Private board")
u2.teams.create!(name:"Private board")
u3.teams.create!(name:"Private board")
u4.teams.create!(name:"Private board")

b1 = t1.boards.create!(name: "Shopping list")
b2 = t1.boards.create!(name: "Project ideas")

l1 = b1.lists.create!(name:"Groceries")
l2 = b1.lists.create!(name:"Drug store")
l3 = b1.lists.create!(name:"Next week")

l4 = b1.lists.create!(name:"Initial ideas")
l5 = b1.lists.create!(name:"Might be good")
l6 = b1.lists.create!(name:"Rubbish")

l1.tasks.create!(name:"Watermelon", color: "white", position: new_position, assignee_id: u1.id)
l1.tasks.create!(name:"Apples", color: "white", position: new_position, assignee_id: u1.id)
l1.tasks.create!(name:"Toast", color: "white", position: new_position, assignee_id: u1.id)

l2.tasks.create!(name:"Shampoo", color: "white", position: new_position, assignee_id: u1.id)
l2.tasks.create!(name:"Tooth brush", color: "white", position: new_position, assignee_id: u1.id)
l2.tasks.create!(name:"Vitamins", color: "white", position: new_position, assignee_id: u1.id)