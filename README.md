Quotes Tweeter
==============

Quotes Tweeter does just that. It tweets quotes.

Oh. And it also posts to a Facebook page.

Configuration
=============

An example configuration YAML file:

    general:
      file: nietzsche.txt
      suffix: Friedrich Nietzsche
      random_seed: 1844
    twitter:
      consumer_key: [your_consumer_key]
      consumer_secret: [your_consumer_secret]
      oauth_token: [oauth_token]
      oauth_token_secret: [oauth_token_secret]
    facebook:
      access_token: [access_token]

The general section of this configuration defines from which file to read
the quotes, the suffix (author) of the quotes and optionally a random seed,
which make the randomization of the tweeter predictable.

Twitter
-------

The twitter section of the configuration file contains the twitter keys and
secrets. You can obtain these at https://dev.twitter.com/apps.

Facebook
--------

To post to Facebook, you need to get a long-lived access token to the page
you want to post to.

To get an access token for your page:

1) Ask the user (probably yourself) for access to pages:

    https://www.facebook.com/dialog/oauth?
      client_id=APP_ID
     &client_secret=APP_SEECRET
     &redirect_uri=APP_URI
     &scope=publish_stream,manage_pages
     &response_type=token

2) Use the short-lived token in the redirected url to get a long-lived token:

    https://graph.facebook.com/oauth/access_token?
      client_id=APP_ID
     &client_secret=APP_SECRET
     &redirect_uri=APP_URI
     &grant_type=fb_exchange_token
     &fb_exchange_token=SHORT_LIVED_ACCESS_TOKEN

3) Use the new token to get the page's access token:

    https://www.facebook.com/[USERID]/accounts?access_token=LONG_LIVED_ACCESS_TOKEN

These page tokens should not expire.. (?)

(See: https://developers.facebook.com/roadmap/offline-access-removal/)

Neil Young
==========

This small library was created by Roel van Dijk for @neilyounglyrics

A file with example quotes has been included in the data folder.

