OpenFaaS Ruby Funcions
=======================

### fass-ruby-jwt

A ruby based JWT Validation plugin, Will return a decoded JWT Token.

please set the public_key environment variable to match your public key. Failure
to do so will result in failed JWT validation.

the public_key environment variable should be a base64 encoded representation of
your RSA public key.

### faas-ruby-register

Thus function uses a pure ruby mySQL gem to register users to a database, The schema
for this function is located in microblog/schemas. To register a user send a json Payload

Example Payload :

```json
{
  "username": "auser",
  "password": "TestPassword",
  "email": "auser@test.email",
  "first_name": "Test",
  "last_name": "User"
}
```


### faas-ruby-login

A pure ruby based mysql login function. Will return a JWT Token. Built using pure
ruby based mysql gem. This means we can keep our function container small and make
no modifications to the function template from [OpenFaas](https://github.com/openfaas/templates).

As we return a valid JWT Token feel free to test it on [jwt.io](https://jwt.io) or
use the faas-ruby-jwt function.

At the moment this is just an example and should not be used in a production environment
passwords are only hashed with SHA2 and has no salting.

The schema for this function is located in miroblog/schemas

Login Payload:

```json
{"username": "affix", "password": "***************"}
```

Example decoded Token:

```json
{
  "nbf": 1526456031,
  "iat": 1526456031,
  "exp": 1526470441,
  "user": {
    "email": "hidden@hidden.test",
    "first_name": "Keiran",
    "last_name": "Smith",
    "username": "affix"
  }
}
```
