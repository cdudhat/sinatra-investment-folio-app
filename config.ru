require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use SessionsController
use UsersController
use StocksController
use FundsController
use ProductsController
use PropertysController
run ApplicationController
