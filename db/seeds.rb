User.destroy_all
user1 = User.create(email: 'user@mail.com', password: 'password', name: 'John Doe', nickname: 'John', city: 'Stockholm', country: 'Sweden', role: 'subscriber')
user1 = User.create(email: 'user1@mail.com', password: 'password', name: 'John Doe', nickname: 'John', city: 'Stockholm', country: 'Sweden', role: 'visitor')
user2 = User.create(email: 'user2@mail.com', password: 'password', name: 'Molly Weasley', nickname: 'Molly', city: 'Stockholm', country: 'Sweden', role: 'journalist')