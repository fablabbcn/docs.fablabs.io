# Fablabs.io Developer Guide




# Getting started



## Authentication

The API uses [OAuth2](https://oauth.net/2/) for authentication and authorization.

The typical workflow is the following:

- You register an Application in your fablabs.io account, the system will create for you an Application Identifier and a shared Secret.

- Your application redirects the user to obtain an Authorization Code from the API, passing the Application Identifier, a callback URL, and optionally an unique identifier which represents the user in your app. The shared secret is used for signing the request, so the API knows that it's really your app.

- Once authenticated, the user is redirected to the callback URL specified before, passing a `code` parameter containing the Authorization Code.

- Using the Authorization Code your app can request an Access Token from the API, which allows to call it on behalf of the logged in user

- Finally you specify the Access Token in your API Requests via the query `access_token` param or the `Authorization` HTTP Header, using the `Bearer <token>` syntax


```
     +----------+
     | resource |
     |   owner  |
     |          |
     +----------+
          ^
          |
         (B)
     +----|-----+          Client Identifier      +---------------+
     |         -+----(A)-- & Redirection URI ---->|               |
     |  User-   |                                 | Authorization |
     |  Agent  -+----(B)-- User authenticates --->|     Server    |
     |          |                                 |               |
     |         -+----(C)-- Authorization Code ---<|               |
     +-|----|---+                                 +---------------+
       |    |                                         ^      v
      (A)  (C)                                        |      |
       |    |                                         |      |
       ^    v                                         |      |
     +---------+                                      |      |
     |         |>---(D)-- Authorization Code ---------'      |
     |  Client |          & Redirection URI                  |
     |         |                                             |
     |         |<---(E)----- Access Token -------------------'
     +---------+       (w/ Optional Refresh Token)


     OAuth Authorization Code Flow (source draft-ietf-oauth-v2-22)
```



There are a few client libraries for most programming languages that simplify the OAuth process, please see
the [OAuth client and server implementations](https://oauth.net/code/) list.


## API Reference

Check the [API reference](./swagger/index.html), based on swagger definition, to try out the API
from your browser.



# Contributing


## Setting up the development environment


### Using Docker & Docker-composer
 
Clone the official repository

```
git clone https://github.com/fablabbcn/fablabs.io.git
```

Start the project:  

```
docker-compose up web app
```

Create database (only the first time):  
 
```
 docker-compose exec app rake db:setup
 docker-compose exec app /usr/local/bin/bower install
```
 
Add the following lines to your `/etc/hosts`:

```
     127.0.0.1   www.fablabs.local
     127.0.0.1   api.fablabs.local
```

### Using Ubuntu




