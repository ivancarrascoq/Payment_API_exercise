# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

## How it works

`LoansController#index` will show all performed payments, including date, loan balance, amount of the payment for each register. (i.e. http://localhost:3000/loans/1)

`LoansController#show` will show the initial amount of the loan, the outstanding balance and the total number of payments made. (i.e. http://localhost:3000/loans)

## set the environment

cd ~/.rbenv/plugins/ruby-build && git pull && cd -
rbenv install 2.5.3
gem install rails
gem install rspec
gem install bundler
gem i bundler -v 1.17.3
rails db:migrate

## run the server
rails s

## check the sqlite databases
sqlite3 db/development.sqlite3
.schema payments
.schema loans

SELECT * FROM loans;
SELECT * FROM payments;

.quit

# make a payment with Postman
POST http://localhost:3000/loans
* Headers
Key: Content-Type
Value: application/json

* Body
raw JSON (application/json)

{
    "amount": 100
}
