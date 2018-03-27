class AddAttachmentAvatarToPatients < ActiveRecord::Migration
  def self.up
    change_table :patients do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :patients, :avatar
  end
end
