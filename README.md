# Papa
This application is API based using Absinthe for GraphQL queries.
There are a total of 5 queries that you can make to fulfill the requirements of the challenge
  * getUser
  * createUser
  * createVisit
  * getVisit
  * fulfillVisit

The easiest way to hit the endpoints is using an API explorer like Insomnia or Postman.
Here is an example of creating a user:

```
POST http://localhost:4000

mutation createUser($email: String, $firstName: String, $lastName: String, $member: Boolean, $pal: Boolean) {
	createUser(email: $email, firstName:  $firstName, lastName: $lastName, member: $member, pal: $pal) {
		id
	}
}

variables: {
	"email": "test@testing.com",
	"firstName": "Testy",
	"lastName": "McTesterson",
	"member": true,
	"pal": true
}
```

## Design Decisions

* Decided to use Absinthe for GraphQL as it would allow the user interface to only request what it needs. Also don't need to create a new route for every mutation/query
* Had a transaction belong to all 3 of members, pals, and visits because they are able to exist without a transaction, but a transaction cannot exist without those 3.
* Used a SQL transaction for the making of our transaction to ensure that credits were properly deducted/added to the involved users, so that we aren't on the hook for the extra/lost credits.

## Assumptions

1. All users will start with 100 credits total. Because no currency was mentioned, the credits are the currency in this application.
2. A user's credits must be greater than the minutes of the visit they are requesting.
3. There can only be one transaction per visit. Because the transfer of credits occurs when the transaction is created, we can assume the visit was completed.
4. A user cannot fulfill their own visit


## To start the server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

To run tests run `mix test`
