Documentation for the Fablabs.io platform

# Requisites

The documentation uses Mkdocs and swagger-codegen to produce the API Reference and Guide.

For convenience you can find in the main root a Makefile that simplifies the build.

You only need to install docker as a dependency.


# Building

Simply run make in the root folder

```
$ make
```

In the dist/ folder you can then find the built documentation

# Mkdocs serve

You can preview in realtime changes using the following command

```
$ make dev
```

Then point your browser to http://localhost:8000


# Deployment

Run in the root folder the following commands:

## Using ZEIT now


```
$ make deploy
```

## Using GH-Pages


```
$ make ghpages
```



