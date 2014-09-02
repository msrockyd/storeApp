class AddFirstNameAndLastNameAndSignupForNewsLatterToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false,default: ""
    add_column :users, :signup_for_news_latter, :boolean, default: true
  end
end
