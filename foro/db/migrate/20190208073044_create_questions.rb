class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.boolean :status, default: :false
      t.integer :answer_id
      t.timestamps
    end
  end
end
