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



