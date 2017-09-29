class CreateAuthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_tokens, id: :uuid do |t|
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
