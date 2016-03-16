class CreateThumb < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.string :vote
      t.integer :author_id
      t.integer :article_id
      t.timestamps
    end
  end
end
