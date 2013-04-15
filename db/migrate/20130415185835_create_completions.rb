class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.integer :user_id
      t.integer :task_id
      t.text :description

      t.timestamps
    end
  end
end
