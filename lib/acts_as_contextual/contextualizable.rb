class Contextualizable < ActiveRecord::Base
  belongs_to :contextualizer, :polymorphic => true
  belongs_to :contextualized, :polymorphic => true
  validates :contextualized_id, :presence => true
  validates :contextualized_type, :presence => true
  validates :contextualizer_id, :presence => true
  validates :contextualizer_type, :presence => true
end
