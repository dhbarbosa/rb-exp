class CreateHospitalUserCids < ActiveRecord::Migration[8.1]
  def change
    create_table :hospital_user_cids do |t|
      t.references :user_cid, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true
      t.datetime :treatement_start_at
      t.datetime :treatment_end_at

      t.timestamps
    end
  end
end
