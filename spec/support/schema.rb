# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  validates :email, presence: true
end

class Order < ActiveRecord::Base
  validates :num, numericality: { greater_than: -1000, less_than: 1000 }

  belongs_to :user, optional: false
  has_many :order_lines, dependent: :destroy
end

class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
end

class Product < ActiveRecord::Base
  has_many :order_lines, dependent: :destroy

  validates :name, :price, presence: true
end

module Schema
  def self.create
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do
      create_table :users, force: true do |t|
        t.string "email", null: false
      end

      create_table :orders, force: true do |t|
        t.belongs_to :user, foreign_key: true, null: false
        t.decimal :num, scale: 2, precision: 5
        t.decimal :num_2, scale: 2, precision: 5
      end

      create_table :order_lines, force: true do |t|
        t.belongs_to :order, foreign_key: true, null: false
        t.belongs_to :product, foreign_key: true, null: false
        t.integer "quantity", null: false
      end

      create_table :products, force: true do |t|
        t.string "name", null: false
        t.integer "price", null: false
      end
    end
  end
end
