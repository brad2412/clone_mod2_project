<a name="top"></a>
# LittleEstyShop

Welcome to LittleEstyShop! This project is a web application that serves as a platform for merchants to manage their items and invoices. It also provides admins with tools to monitor merchant performance and handle invoices. The application consumes the Unsplash API to display images, including the app logo, item images, merchant images, and random photos on the merchant's dashboard.

## Work Completed
The project implements various features for merchants and admins, as well as API consumption for images. Here is a summary of the work completed:

## Table of Contents

- [Merchant Dashboard](#section-1)
- [Merchant Items](#section-2)
- [Mercahnt Invoices](#section-3)
- [Admin Dashboard](#section-4)
- [Admin Merchants](#section-5)
- [Admin Invoices](#section-6)
- [API Consumption](#section-7)
- [Future Refactoring](#section-8)
- [Project Links](#section-9)
- [Team Members](#section-10)
- [Project Requirements/setup/phases](#section-11)

## Merchant Dashboard
<a name="section-1"></a>
Displays the name of the merchant.
Provides links to the merchant's item index and invoice index pages.
Shows the top 5 customers with the most successful transactions and the number of transactions for each customer.
Lists items ready to ship, displaying item names, corresponding invoice IDs, and links to invoice show pages.
Orders items by the date of creation in the "Items Ready to Ship" section.

## Merchant Items
<a name="section-2"></a>
Shows a list of the merchant's items and restricts visibility to items owned by the merchant.
Displays item details (name, description, and current selling price) on the item show page.
Allows merchants to update item information and shows a flash message upon successful update.
Enables merchants to disable or enable their items.
Groups items by status (enabled or disabled).
Allows merchants to create new items with a default status of disabled.
Lists the top 5 most popular items based on total revenue, with links to the item show page and total revenue for each item.
Displays the top selling date for each of the 5 most popular items.

## Merchant Invoices
<a name="section-3"></a>
Displays invoices that include at least one of the merchant's items.
Shows invoice details, including ID, status, created date, and customer's first and last name.
Lists items on the invoice with item name, quantity, price, and item status.
Shows the total revenue generated from all items on the invoice.
Allows merchants to update the status of invoice items.

## Admin Dashboard
<a name="section-4"></a>
Shows a header indicating that the user is on the admin dashboard.
Provides links to the admin merchants index and admin invoices index.
Lists the top 5 customers based on the number of successful transactions.
Displays invoices with items that have not yet been shipped, sorted by creation date.

## Admin Merchants
<a name="section-5"></a>
Lists all merchants in the system.
Allows admins to view merchant details on the merchant show page.
Enables admins to update merchant information.
Allows admins to enable or disable merchants.
Groups merchants by status (enabled or disabled).
Allows admins to create new merchants with a default status of disabled.
Lists the top 5 merchants based on total revenue, with links to the merchant show page and total revenue for each merchant.
Displays the top selling date for each of the 5 top-earning merchants.

## Admin Invoices
<a name="section-6"></a>
Lists all invoices in the system, linking each ID to the admin invoice show page.
Shows invoice details, including ID, status, created date, and customer's first and last name.
Lists items on the invoice with item name, quantity, price, and item status.
Displays the total revenue generated from the invoice.
Allows admins to update the status of invoices.

## API Consumption
<a name="section-7"></a>
Uses the Unsplash API to display a logo image at the top of every page.
Fetches images related to item names on the Merchant Item Show page.
Shows random photos near the name of the Merchant on the Merchant's Dashboard, with the image refreshing on each page refresh.
Displays the number of likes for the app logo image.
Potential Contributions and Refactoring


### While the current implementation covers the specified features, there is always room for improvement and contributions from the community. Here are some potential areas for future contributions and refactoring:
<a name="section-8"></a>
Enhance the user interface and user experience for both merchants and admins.

Additional Features: Add more features such as advanced search, item categories, or shipping tracking for merchants.

Testing: More sad path testing.By exploring various exceptional and error-prone situations, we can identify vulnerabilities, 
corner cases, and potential points of failure. This will help us uncover potential issues, ensuring a stable and reliable 
application in real-world usage.

Code Refactoring: Improve code organization, readability, and maintainability for better long-term scalability.

Error Handling: Implement robust error handling and feedback mechanisms for a better user experience.

Performance Optimization: Optimize database queries and API requests to improve application performance.

Accessibility: Ensure the application meets accessibility standards for all users.

## Links for this project
<a name="section-9"></a>
Project's render site: [Little Shop of Horrors](https://little-shop-7-yuoe.onrender.com)

Diagram site: [Miro Borad](https://miro.com/app/board/uXjVMz5suwQ=/)

Group DTR: [DTR](https://docs.google.com/document/d/1rITzHzPoXYcNLyEDX3FQwvB98AbPXOpPaZ0PCDH7Foo/edit)

## This project's team members
<a name="section-10"></a>
### [Artemy Gibson](https://github.com/algibson1)

### [Christopher Cullinane](https://github.com/topher-nullset)

### [Paul Bennett](https://github.com/pcbennett108)

### [Bradley Milton](https://github.com/brad2412)

## Requirements
<a name="section-11"></a>
- Must use Rails 7.0.x, Ruby 3.2.2
- Must use PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- Must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- Must include a thorough README to describe the project
- README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- Must deploy completed code to the internet (using Heroku or Render)
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
- Any gems added to the project must be approved by an instructor
  - Pre-approved gems are `capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, launchy`

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)


[Return to top](#top)
