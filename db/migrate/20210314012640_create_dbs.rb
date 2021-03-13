class CreateDbs < ActiveRecord::Migration[4.2]
  def up
    create_table "apartments" do |t|
      t.text "name", null: false
      t.integer "price"
      t.integer "rating"
      t.text "image"
      t.text "description"
      t.text "address"
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end

    create_table "comments", force: :cascade do |t|
      t.integer "apartment_id"
      t.integer "user_id"
      t.text "comments"
      t.timestamps
    end

    create_table "users", force: :cascade do |t|
      t.text "username", null: false
      t.text "password", null: false
      t.timestamps
    end

    add_foreign_key "comments", "apartments"
    add_foreign_key "comments", "users"
  end

  def down
    drop_table "apartments"
    drop_table "comments"
    drop_table "users"
  end
end
