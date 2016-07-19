class ChangeVotesNameinLink < ActiveRecord::Migration
  def change
    rename_column :links, :votes, :score
  end
end
