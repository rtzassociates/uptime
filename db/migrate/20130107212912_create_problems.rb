class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.datetime :started_at
      t.string :description

      t.timestamps
    end
  end
end
