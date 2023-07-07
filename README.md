> The example repository is maintained from a [monorepo](https://github.com/nextauthjs/next-auth/tree/main/apps/examples/nextjs). Pull Requests should be opened against [`nextauthjs/next-auth`](https://github.com/nextauthjs/next-auth).

<p align="center">
   <br/>
   <a href="https://authjs.dev" target="_blank">
   <img height="64" src="https://authjs.dev/img/logo/logo-sm.png" />
   </a>
   <a href="https://nextjs.org" target="_blank">
   <img height="64" src="https://nextjs.org/static/favicon/android-chrome-192x192.png" />
   </a>
   <h3 align="center"><b>NextAuth.js</b> - Example App</h3>
   <p align="center">
   Open Source. Full Stack. Own Your Data.
   </p>
   <p align="center" style="align: center;">
      <a href="https://npm.im/next-auth">
        <img alt="npm" src="https://img.shields.io/npm/v/next-auth?color=green&label=next-auth&style=flat-square">
      </a>
      <a href="https://bundlephobia.com/result?p=next-auth-example">
        <img src="https://img.shields.io/bundlephobia/minzip/next-auth?label=size&style=flat-square" alt="Bundle Size"/>
      </a>
      <a href="https://www.npmtrends.com/next-auth">
        <img src="https://img.shields.io/npm/dm/next-auth?label=downloads&style=flat-square" alt="Downloads" />
      </a>
      <a href="https://npm.im/next-auth">
        <img src="https://img.shields.io/badge/TypeScript-blue?style=flat-square" alt="TypeScript" />
      </a>
   </p>
</p>

## Overview

This is a project for reproducing an issue where deleting session fails when using the [@auth/dynamodb-adapter](https://authjs.dev/reference/adapter/dynamodb) in Next Auth.

## Steps to reproduce the issue

### 1. Install and setup a local DynamoDB instance.

You may follow the instructions [here](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html) to get DynamoDB running locally.

Once it is running, create a table that following the [schema](https://authjs.dev/reference/adapter/dynamodb#default-schema) provided in the documentation, but with a custom partition key and sort key attribute name.

You may use the Shell script in this repository to create this table:

```sh
./create-table.sh
```

### 2. Clone the repository and install dependencies

```sh
git clone https://github.com/arvl130/nextauth-bug-repro-dynamodb-delete-session
cd nextauth-bug-repro-dynamodb-delete-session
pnpm install
```

### 3. Configure your local environment

Copy the .env.local.example file in this directory to .env.local:

```
cp .env.local.example .env.local
```

Add details for one or more providers (e.g. GitHub, Google, Twitter, etc).

### 4. Start the application

To run your site, use:

```
npm run dev
```

### 5. Login with any of the providers configured.

### 6. Sign out and observe the output on the terminal.

A sign out error will be printed about a validation error that occured.

You may run the following command to verify that sessions where not properly deleted:

```sh
aws dynamodb --endpoint-url http://localhost:8000 delete-table --table-name <table_name>
```
