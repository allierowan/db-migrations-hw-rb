require 'active_record'
require 'sqlite3'
require 'pry'

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'dev.sqlite3'

  })

class InitialMigration < ActiveRecord::Migration[5.0]

  def up

    create_table :groups do |t|
      t.string :name
    end

    create_table :developers do |t|
      t.string :name
      t.string :email
      t.date :start_date
    end

    create_join_table :groups, :developers

    create_table :projects do |t|
      t.string :name
      t.integer :client_id
    end

    create_join_table :projects, :developers

    create_table :tasks do |t|
      t.integer :project_id
      t.integer :parent_id
      t.string :description
    end

    create_table :time_entries do |t|
      t.integer :developer_id
      t.integer :task_id
      t.date :date
      t.integer :hours_spent
    end

    create_table :client_info do |t|
      t.integer :client_id
      t.integer :developer_id
      t.string :type
      t.string :value
    end

    create_table :clients do |t|
      t.integer :industry_id
      t.string :name
    end

    create_table :industries do |t|
      t.string :name
    end

    create_table :comments do |t|
      t.integer :commenter_id
      t.integer :commentee_id
      t.string :commentee_type
    end
  end

  def down
    drop_table :groups
    drop_table :developers
    drop_join_table :groups, :developers
    drop_table :projects
    drop_join_table :projects, :developers
    drop_table :tasks
    drop_table :time_entries
    drop_table :client_info
    drop_table :clients
    drop_table :industries
    drop_table :comments
  end

end

begin
  InitialMigration.migrate(:down)
rescue

end

InitialMigration.migrate(:up)
