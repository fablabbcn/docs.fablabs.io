# Fablabs.io Developer Guide




# Getting started


## Registering your application

In order to be able to use the Fablabs.io API you must first register your application in the [Fablabs.io Developer Console].

Once logged-in on Fablabs.io, you can access the Console, by clicking your username on the upper right of the screen, and selecting **Developer Console** from the dropdown.



## OAuth Authentication

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

> The documentation uses the [JSON API standard](http://jsonapi.org), which defines a number of conventions
concerning status codes, response format, pagination and so on. Many software libraries allow to interact with
the JSON-API compliant APIs  in a seamless way. The following page contains a [list of all JSON-API clients](http://jsonapi.org/implementations/).


# Contributing

The Fablabs.io platform is open for contributions from the community.

You can contribute in several ways:

- Opening issues about bugs and feature requests

- Contributing fixes for issues and new features, by submitting pull requests

- Extending and enhancing this documentation


## Issue tracker

The Fablabs.io issue tracker is the right place to flag issues and to propose new features. 

When reporting a bug make sure you follow these basic guidelines, including the following information:

- Title: Using a clear title for the issue makes it easier to find it
- Environment: your OS, browser version and any other information that might be useful
- Steps to reproduce
- Expected Result
- Actual Result
- Visual Proof (screenshots, videos, text)

## Pull requests

Pull requests are welcome, all the pull requests are tested using [Travis-CI](https://travis-ci.org/fablabbcn/fablabs.io).

To send a pull request, you need to Fork the project, add some changes and use the Github interface to start the process:

- On GitHub, navigate to the main page of the  (forked) repository.
- In the "Branch" menu, choose the branch that contains your commits.
- To the right of the Branch menu, click New pull request.

Always make sure the test suite is passing locally before sending a pull request.

## Improve the documentation

This documentation is open-source as well, so you can send pull requests for enhancing it or fixing any error.

Similar to the above, fork the [Github docs.fablabs.io](https://github.com/fablabbcn/docs.fablabs.io) repository and follow the instructions in the [README](https://github.com/fablabbcn/docs.fablabs.io/blob/master/README.md) on how to build the documentation.

# Setting up the development environment

In order to be able to edit the code and contribute, you first need to setup your development environment replicating the production version of Fablabs.io.

This will allow to run tests and develop new features with ease.

The development environment is now fully ported to docker, which is the recommended way, taking only few minutes.

## Using Docker & Docker-composer

You will need the latest version of [Docker](http://docker.com) and [Docker compose](https://docs.docker.com/compose/) installed on your machine. Docker runs on most modern OSes.
 
1. Step one
 
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

You can also add some seed data, instead of starting with an empty db:

```
docker-compose exec app rake db:seed
```

Run tests with
 
   
```
docker-compose exec app rake spec
```

The code is mounted from the local filesystem, so any change you make to it, will be reflected immediately in the app when started in development mode.

If you make changes to the config, rebuild the app and deploy the new image

```
docker-compose build
docker-compose up -d
```


## Using Ubuntu 16.04 LTS

You can also install Fablabs.io on a clean Ubuntu 16.04 LTS system.


#### Dependencies

Start installing all dependencies:

```
sudo apt-get update -qq

sudo apt-get install -y \
  build-essential \
  libpq-dev \
  libqt4-dev \
  libqtwebkit-dev \
  postgresql-client \
  nodejs \
  imagemagick \
  npm \
  git

sudo apt-get install -y \
  ruby ruby-dev \
  memcached \
  postgresql \
  redis-server
  
sudo apt-get install -y \
  qt5-default libqt5webkit5-dev \
  gstreamer1.0-plugins-base gstreamer1.0-tools \
  gstreamer1.0-x xvfb
  
  

```

#### Setup postgres and access control 

Edit pg_hba.conf and change the local connections from md5 to trust

Restart postgresql

```
sudo /etc/init.d/postgresql restart
```

#### Clone the repository and install gems

```
git clone https://github.com/fablabbcn/fablabs.io.git
cd fablabs.io

sudo gem install bundler

export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

bundle config git.allow_insecure true

bundle update kgio raindrops

bundle install

```
> If this command complains
> change Gemfile ruby version to 2.3.1 or the one indicated

```
sudo npm install -g bower
sudo ln -sf `which nodejs` /usr/bin/node

bower install
```


#### Create and setup databases


```
bundle exec rake db:setup
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rake db:seed RAILS_ENV=development
```

#### Setup host aliases

Edit the  `/etc/hosts` file and append the following lines, defining aliases for localhost. This way you will be able to access the web frontend and the main web interface.


```
127.0.0.1  www.fablabs.local
127.0.0.1  api.fablabs.local
```

#### Ready to start

Check everything is working by running the test suite.

```bundle exec rake```

If tests fail, check you followed all the instructions or open an issue.

Finally you can start the dev server:

```bundle exec rails s```

Browse to [http://www.fablabs.local:3000](http://www.fablabs.local:3000)

The API is available at [http://api.fablabs.local:3000](http://api.fablabs.local:3000)




