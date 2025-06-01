# Luxury Marketplace

A Ruby on Rails marketplace for luxury items with authentication, secure payments, and a sleek user interface.

## Features

- User authentication with bcrypt (native Rails)
- Listing and browsing luxury items
- Item authentication system
- Secure payments with Stripe
- Reviews system
- Background jobs with GoodJob
- SQLite-based caching
- Responsive design with Tailwind CSS

## Technology Stack

- Ruby 3.2.x
- Ruby on Rails 8.0.1
- SQLite 2.1+
- GoodJob for background job processing
- Stripe for payment processing
- Tailwind CSS for styling
- Turbo & Hotwire for real-time updates
- Propshaft for asset management

## Installation

### Prerequisites

- Ruby 3.2.x
- Node.js 18+
- Yarn 1.22+
- SQLite 3

### Setup

1. Clone the repository

```bash
git clone <repository-url>
cd luxury-marketplace
```

2. Install dependencies

```bash
bundle install
yarn install
```

3. Set up the database

```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Configure environment variables

Create a `.env` file in the root of the project and add your Stripe API keys:

```
STRIPE_PUBLISHABLE_KEY=your_publishable_key
STRIPE_SECRET_KEY=your_secret_key
```

Alternatively, you can use Rails credentials:

```bash
rails credentials:edit
```

Add the following to your credentials file:

```yaml
stripe:
  publishable_key: your_publishable_key
  secret_key: your_secret_key
```

5. Start the development server

```bash
bin/dev
```

This will start the Rails server, CSS watcher, JS watcher, and GoodJob processor using the Procfile.dev configuration.

## Usage

### Demo Accounts

The seed data provides several accounts for testing:

- Admin: admin@example.com / password123
- Authenticator: authenticator@example.com / password123
- Seller: jane@example.com / password123
- Buyer: alice@example.com / password123

### Workflow

1. **Browsing items**: View all available luxury items on the home page.
2. **Selling an item**: Sign up as a seller, click "List New Item," and fill out the form.
3. **Buying an item**: Sign up as a buyer, browse items, click "Purchase Now," and complete the checkout process.
4. **Authentication**: After purchase, items are authenticated by our experts (simulated in the demo).
5. **Reviews**: After receiving an item, buyers can leave reviews.

## Development

### Running Tests

```bash
rails test
```

### Background Jobs

The app uses GoodJob for background processing. The worker process is started automatically with the `bin/dev` command through the Procfile.dev configuration.

To run the jobs manually:

```bash
bundle exec good_job start
```

### Database Structure

The application uses these main models:

- `User`: Handles authentication and user profiles
- `Item`: Represents luxury items for sale
- `Image`: Stores images associated with items
- `Authentication`: Tracks authenticity verification of items
- `Transaction`: Records purchases between buyers and sellers
- `Review`: Stores buyer reviews of purchases
- `CacheEntry`: Handles SQLite-based caching

## Deployment

### Production Setup

1. Configure your production environment

```bash
rails credentials:edit --environment production
```

2. Set up the database

```bash
RAILS_ENV=production rails db:migrate
```

3. Precompile assets

```bash
RAILS_ENV=production rails assets:precompile
```

4. Configure GoodJob for production

Add to your Procfile:

```
web: bundle exec puma -C config/puma.rb
worker: bundle exec good_job start
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
