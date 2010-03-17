class RemoveActsAsTaggableOn < ActiveRecord::Migration
  def self.up
    drop_table :taggings
    
    create_table :expenses_tags, :id => false do |t|
      t.integer :expense_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :expenses_tags
  end
end
