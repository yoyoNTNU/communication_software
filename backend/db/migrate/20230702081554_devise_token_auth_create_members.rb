class DeviseTokenAuthCreateMembers < ActiveRecord::Migration[7.0]
    def change
        
        create_table(:members) do |t|
        ## Required
        t.string :provider, :null => false, :default => "email"
        t.string :uid, :null => false, :default => ""

        ## Database authenticatable
        t.string :encrypted_password, :null => false, :default => ""

        ## Recoverable
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
        t.boolean  :allow_password_change, :default => false

        ## Rememberable
        t.datetime :remember_created_at

        ## Confirmable
        t.string   :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string   :unconfirmed_email # Only if using reconfirmable
        
        ## Trackable
        t.integer  :sign_in_count, default: 0, null: false
        t.datetime :current_sign_in_at
        t.datetime :last_sign_in_at
        t.string   :current_sign_in_ip
        t.string   :last_sign_in_ip

        ## Lockable
        # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
        # t.string   :unlock_token # Only if unlock strategy is :email or :both
        # t.datetime :locked_at

        ## User Info
        t.string :user_id
        t.string :email
        t.string :photo
        t.string :background #個人檔案背景
        t.date :birthday
        t.string :introduction
        t.string :name
        t.string :phone
        t.boolean :is_login_mail ,default:true

        ## Tokens
        t.text :tokens

        t.timestamps
        end

        add_index :members, :email,                unique: true
        add_index :members, [:uid, :provider],     unique: true
        add_index :members, :reset_password_token, unique: true
        add_index :members, :confirmation_token,   unique: true
        # add_index :members, :unlock_token,         unique: true
    end
end
