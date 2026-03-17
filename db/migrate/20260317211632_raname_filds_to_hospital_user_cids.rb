class RenameFieldsInHospitalUserCids < ActiveRecord::Migration[8.1]
  def change
    rename_column :hospital_user_cids, :treatement_start_at, :tratament_start_at
    rename_column :hospital_user_cids, :treatment_end_at, :tratament_end_at
  end
end
