3DStxt
======

What it is:
-----------

3DStxt is similar to bit.ly and pastebin. It enables users to generate a page with a custom message and commenting functionality. The site auto-generates a unique, short URL for anonymous users. If users are logged in, they can choose their own custom URL (providing it is unique in the database).

3DStxt is made for Nintendo 3DS owners. When two Nintendo 3DS units pass within bluetooth range, they exchange a user-supplied 16 character "greeting" and gameplay data - this is known as a "streetpass". 3DStxt generates a URL 16 characters in length which can be used instead of a greeting.

This app is currently running at http://www.3dstxt.com

See an example user page at http://www.3dstxt.com/scott


### Usage Example:
>Instead of transmitting this simple message with a 3DS...
>Hello there!
>
>... users exchange a URL similar to this one:
>3dstxt.com/scott


When a 3DS user receives a 3dstxt.com URL as a message, hopefully they'll fire up their web browser and enter your URL. On your page, visitors have an opportunity to see your Nintendo 3DS Friend Code, your favorite games and perhaps an extended personal greeting.


## Gems
3DStxt makes use of these gems:

+ amazon_product: Ruby interface to the Amazon Product Advertising API. 3DStxt uses the Product Advertising API for allowing users to customize their page with images and links to their favorite Nintendo DS and 3DS games. The app's database follows Amazon's usage guidelines, storing only the ASIN for each game that is added.

+ sanitize: Sanitizes user input

+ paperclip: Enables profile image uploads with S3 integration

+ rmagick: a nice Ruby wrapper for ImageMagick. ImageMagick must be installed on your remote server! Heroku supports this. ImageMagick is used to resize image uploads.

+ aws-s3: Amazon S3 storage for profile images

+ impressionist: Logs unique impressions for users to track page visits on their account

+ twitter-bootstrap-rails: Twitter Bootstrap!

## Customizing 3DStxt
Rename example.env to .env
Rename s3.yml.example to s3.yml

.env Variables Explained
------------------------
### Email Account Info
For password reset and email notifications, you will need to provide a Gmail account which will be used for sending auto-generated emails from the User Mailer.

### Secret Token
Supply a secret token. Rails auto-generates this in *config/initializers/secret_token.rb* when a new app is created. Ideally, it's a random string of characters, recommended to be at least 30 characters long.

### Amazon Associates Account & Product Advertising API Settings
You will need an [Amazon Associates account](https://affiliate-program.amazon.com/), and you need to [sign up for access to the Amazon Product Advertising API](https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html). Once you have an Amazon Associate account and API access, add the following to the config.yml file:
+ Amazon Key
+ Amazon Secret
+ Amazon Associate Tag/ID

### Amazon S3 (for user profile image uploads)
Get an [Amazon S3 account](http://aws.amazon.com/s3/). It's free as long as you're not pushing too much data!
Create a unique bucket on S3 and add your bucket name to the config.yml file.

### Host Name
This is the domain name that will serve as the 'from' name in email alerts and notifications that the app generates

## S3.YML
Using the same S3 Account from above, enter your Access Key ID and Secret Access Key from your S3 Account in the s3.yml file.

Feel free to email me with any questions *scottmosch [at] gmail [d0t] com*