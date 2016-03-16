
#This migration is just to rename a field name I wrote wrongly in Authors Table
class ChangeAuthorFieldName < ActiveRecord::Migration
  def change
    rename_column :authors, :name, :authName
  end
end
