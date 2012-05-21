3DStxt
======

What it is:
-----------

3DStxt is similar to bit.ly and pastebin. It enables users to generate a page with a custom message and commenting functionality. The site auto-generates a unique, short URL for anonymous users. If users are logged in, they can choose their own custom URL (providing it is unique in the database).

3DStxt is made for Nintendo 3DS owners. When two Nintendo 3DS units pass within bluetooth range, they exchange a user-supplied 16 character "greeting" and gameplay data - this is known as a "streetpass". 3DStxt generates a URL 16 characters in length which can be used instead of a greeting.

This app is currently running at http://www.3dstxt.com
See an example user page at: http://www.3dstxt.com/scott


### Usage Example:
>Instead of transmitting this simple message with a 3DS...
>____________
>Hello there!
>____________
>
>... users exchange a URL similar to this one:
>_________________
>3dstxt.com/scott
>_________________

When a 3DS user receives a 3dstxt.com URL as a message, hopefully they'll fire up their web browser and enter your URL. On your page, visitors have an opportunity to see your Nintendo 3DS Friend Code, your favorite games and perhaps an extended personal greeting.


## Gems
____________________________________________________________
3DStxt makes use of these gems:

+ amazon_product: Amazon Product Advertising API gem lets users customize their pages with images and links to their favorite Nintendo DS and 3DS games.

+ sanitize: Sanitizes user input

+ paperclip: Enables profile image uploads

+ rmagick: Resizes image uploads

+ aws-s3: Amazon S3 storage

+ impressionist: Logs unique impressions for users to track page visits on their account

+ twitter-bootstrap-rails: Twitter Bootstrap
____________________________________________________________

## Customizing 3DStxt

Rename config.yml.example and s3.yml.example to config.yml and s3.yml respectively.

AMAZON ASSOCIATES ACCOUNT & PRODUCT ADVERTISING API
You will need an [Amazon Associates account](https://affiliate-program.amazon.com/), and you need to [sign up for access to the Amazon Product Advertising API](https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html). Once you have an Amazon Associate account and API access, add your Amazon account and API info to config.yml in the designated places -- *Do not enclose your information in quotes*.


