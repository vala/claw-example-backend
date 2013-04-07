# Claw example backend

This is an ExpressJS app exposing a simple API to allow [Claw's JSDaw](https://github.com/gabriel-cardoso/jsdaw/) to save projects and authenticate users.

It is only provided as an example backend implementation, to allow running Claw for personal use, but isn't production ready for public deployment.

## Installation

Just clone the repo and install dependencies :

```bash
git clone git@github.com:vala/claw-example-backend.git
cd claw-example-backend
npm install
```

## Running the server

You'll first need to create database and seed it data :

```bash
cake db:create
cake db:seed
```

Then just run the server with :

```bash
cake run:dev
```

## Development

This project is under development and can't be used for now ...