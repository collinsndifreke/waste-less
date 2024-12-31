# WasteLess Protocol

A decentralized protocol connecting restaurants with food banks to reduce food waste, built on the Stacks blockchain.

## Overview

WasteLess enables restaurants to create food donation listings that can be claimed by verified food banks. The protocol tracks donation history and maintains a reputation system for participating restaurants.

## Core Features

- Create food donation listings with detailed information
- Claim available donations
- Track restaurant donation statistics
- Built-in reputation system
- Automated expiry management

## Smart Contract Functions

### Public Functions

- `create-food-listing`: Create a new food donation listing
- `claim-food-listing`: Claim an available food listing

### Read-Only Functions

- `get-listing`: Retrieve details about a specific listing
- `get-restaurant-stats`: Get statistics for a restaurant

## Development

Built with Clarity for the Stacks blockchain. Requires Clarinet for local development and testing.

## Security

- Built-in authorization checks
- Data validation
- Protected state transitions

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request