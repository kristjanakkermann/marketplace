# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear all existing data
puts "Cleaning database..."
User.destroy_all
Item.destroy_all
Image.destroy_all
Authentication.destroy_all
Transaction.destroy_all
Review.destroy_all

# Create users
puts "Creating users..."

# Admin
admin = User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "password123",
  user_type: "admin"
)

# Authenticator
authenticator = User.create!(
  name: "Expert Authenticator",
  email: "authenticator@example.com",
  password: "password123",
  user_type: "authenticator"
)

# Sellers
seller1 = User.create!(
  name: "Jane Smith",
  email: "jane@example.com",
  password: "password123",
  user_type: "seller"
)

seller2 = User.create!(
  name: "John Doe",
  email: "john@example.com",
  password: "password123",
  user_type: "seller"
)

# Buyers
buyer1 = User.create!(
  name: "Alice Johnson",
  email: "alice@example.com",
  password: "password123",
  user_type: "buyer"
)

buyer2 = User.create!(
  name: "Bob Williams",
  email: "bob@example.com",
  password: "password123",
  user_type: "buyer"
)

# Create luxury items
puts "Creating items..."

# Seller 1's items
item1 = Item.create!(
  title: "Louis Vuitton Neverfull MM",
  description: "Classic Louis Vuitton Neverfull MM in Damier Ebene canvas. Used but in excellent condition with minimal wear. Includes dust bag and original receipt.",
  brand: "Louis Vuitton",
  condition: "Excellent",
  original_price: 1540.00,
  listed_price: 1100.00,
  seller: seller1,
  authentication_status: "verified"
)

item1.images.create!([
  { image_url: "lv_neverfull_1.jpg", position: 0 },
  { image_url: "lv_neverfull_2.jpg", position: 1 },
  { image_url: "lv_neverfull_3.jpg", position: 2 }
])

item2 = Item.create!(
  title: "Rolex Datejust 36mm",
  description: "Rolex Datejust 36mm with jubilee bracelet and fluted bezel. Silver dial. Purchased in 2019, includes box and papers.",
  brand: "Rolex",
  condition: "Excellent",
  original_price: 8000.00,
  listed_price: 7200.00,
  seller: seller1,
  authentication_status: "verified"
)

item2.images.create!([
  { image_url: "rolex_datejust_1.jpg", position: 0 },
  { image_url: "rolex_datejust_2.jpg", position: 1 }
])

# Seller 2's items
item3 = Item.create!(
  title: "Hermès Birkin 30",
  description: "Hermès Birkin 30 in Black Togo leather with gold hardware. Purchased in 2021, excellent condition with minimal wear. Includes dust bag, box, and receipt.",
  brand: "Hermès",
  condition: "Excellent",
  original_price: 12000.00,
  listed_price: 15000.00, # Increased in value
  seller: seller2,
  authentication_status: "verified"
)

item3.images.create!([
  { image_url: "hermes_birkin_1.jpg", position: 0 },
  { image_url: "hermes_birkin_2.jpg", position: 1 },
  { image_url: "hermes_birkin_3.jpg", position: 2 }
])

item4 = Item.create!(
  title: "Chanel Classic Flap Bag Medium",
  description: "Chanel Classic Flap Bag in Medium size with caviar leather and gold hardware. Purchased in 2020, includes authenticity card, dust bag, and box.",
  brand: "Chanel",
  condition: "Good",
  original_price: 7000.00,
  listed_price: 5800.00,
  seller: seller2,
  authentication_status: "pending"
)

item4.images.create!([
  { image_url: "chanel_flap_1.jpg", position: 0 },
  { image_url: "chanel_flap_2.jpg", position: 1 }
])

item5 = Item.create!(
  title: "Cartier Love Bracelet",
  description: "Cartier Love Bracelet in 18k Yellow Gold. Size 17. Purchased in 2019, includes screwdriver, box, and certificate of authenticity.",
  brand: "Cartier",
  condition: "Excellent",
  original_price: 6550.00,
  listed_price: 5500.00,
  seller: seller1,
  authentication_status: "verified"
)

item5.images.create!([
  { image_url: "cartier_love_1.jpg", position: 0 },
  { image_url: "cartier_love_2.jpg", position: 1 }
])

# Create authentications
puts "Creating authentications..."

Authentication.create!(
  item: item1,
  authenticator: authenticator,
  verified: true,
  notes: "Authentic Louis Vuitton Neverfull. Date code and stitching verified.",
  verified_at: 2.days.ago
)

Authentication.create!(
  item: item2,
  authenticator: authenticator,
  verified: true,
  notes: "Authentic Rolex Datejust. Serial number verified with Rolex database.",
  verified_at: 3.days.ago
)

Authentication.create!(
  item: item3,
  authenticator: authenticator,
  verified: true,
  notes: "Authentic Hermès Birkin. Craftsman stamp and hardware verified.",
  verified_at: 1.day.ago
)

Authentication.create!(
  item: item5,
  authenticator: authenticator,
  verified: true,
  notes: "Authentic Cartier Love Bracelet. Serial number and engravings match.",
  verified_at: 4.days.ago
)

# Create a completed transaction
puts "Creating transactions..."

transaction1 = Transaction.create!(
  item: item1,
  buyer: buyer1,
  seller: seller1,
  amount: item1.listed_price,
  status: "completed"
)

# Create a review
puts "Creating reviews..."

Review.create!(
  transaction: transaction1,
  reviewer: buyer1,
  rating: 5,
  content: "Excellent item, exactly as described. Fast shipping and the bag is in perfect condition!"
)

puts "Seed data created successfully!"
