class CreateContextualizables < ActiveRecord::Migration
  def up
    create_table :contextualizables do |t|
      t.references :contextualizer, :polymorphic => true
      t.references :contextualized, :polymorphic => true
      t.timestamps
    end
    add_index :contextualizables, [:contextualizer_id, :contextualizer_type], { :name => "contextualizer_index"}
    add_index :contextualizables, [:contextualized_id, :contextualized_type], { :name => "contextualized_index"}
    add_index :contextualizables, [:contextualizer_id, :contextualizer_type, :contextualized_id, :contextualized_type], { :name => "contextualizer_contextualized_index"}
  end

  def down
    drop_table :contextualizables
  end
end
