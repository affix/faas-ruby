OpenFaaS Ruby Funcions
=======================

Functions written for OpenFaaS in Ruby

### fass-ruby-jwt

A ruby based JWT Validation plugin, Will return a decoded JWT Token.

please set the public_key environment variable to match your public key. Failure
to do so will result in failed JWT validation.

the public_key environment variable should be a base64 encoded representation of
your RSA public key.
