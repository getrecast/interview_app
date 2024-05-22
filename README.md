# README


## About 
Goal of this application is to save and process spend forecasts and their budgets.

### Current state of the app
User is able to:
* Create and persist spend forecast object. Forecast object can persist budget and budgets constraints, like `start_date`, `end_date`. Budget is uploaded as a csv in the form.
* When a spend forecast object is being created, even if it contains errors, it is persisted. If it doesn't contain error's it is
* Download spend forecast budget csv's and csv template.
* View forecast objects.

See `data/budget.csv` for a budget template. In body first col is date and other rows are spend, which
is expected to be a decimal representing dollars.

### What this app needs to do.
* When user uploads csv, it needs to be formatted according to these constraints:
1. Only rows, which have date, which is between start_date and end_date should be persisted.
2. Only columns, which exactly match any of `channels` persisted on `User` should be persisted.
3. Allow spend to go up to a certain limit per channel in a day.

### Requirements
* Ruby 3.2.2
* bundler
