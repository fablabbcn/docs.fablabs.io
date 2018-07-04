# Examples

We provide a number of examples for implmenting the Fablabs.io auth and integrating the API into your website.

## Javascript

- [Vue.js](https://github.com/fablabbcn/examples.fablabs.io/vuejs/README.md) with zeit micro local auth server
- [Express](https://github.com/fablabbcn/examples.fablabs.io/express/README.md)

## Python

- [Flask](https://github.com/fablabbcn/examples.fablabs.io/flask/README.md)


Checkout the full examples repository on Github:

[https://github.com/fablabbcn/examples.fablabs.io](https://github.com/fablabbcn/examples.fablabs.io)

## Trying out the examples

In order to use any of these examples you need an Application ID and Secret as described in the [Developer Guide](./index.md).

All examples run on port 3001, so make sure to specify **http://localhost:3001/auth/callback** as the redirect URL.

Once you have the credentials, you should set the following environment variables before running the examples
```
export FABLABS_IO_API_KEY='your key'
export FABLABS_IO_API_SECRET='your secret'
```
If you use a **local server**:
```
export FABLABS_IO_API_HOST='http://api.fablabs.local:3000'
```
If you use the **staging server**
```
export FABLABS_IO_API_HOST='http://api.staging.fablabs.io:3000'
```
If you use the **production server**
```
export FABLABS_IO_API_HOST='https://api.fablabs.io'
```
