class CreateTokenTable < ActiveRecord::Migration[6.0]
  def change
    create_table :participation_tokens do |t|
      t.datetime 'expires_at', null: false
      t.string 'token', null: false
      t.string 'participation_id', null: false
    end
  end
end
