FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event_#{n}" }
    lead
  end

  factory :lead do
    first_name
    last_name
    email
    phone
    ip
    city
    state
    zip
    contacted     
    appointment_date 
    notes
    connected     
    bad_number       
    advisor
    location
    standard_phone
    exclude_from_calling
    process_time
    hot               
    first_appointment_set
    first_appointment_actual
    first_appointment_format
    second_appointment_set
    second_appointment_actual
    second_appointment_format
    enrolled_date
    deposit_date
    sales
    collected
    status
    next_step
    rep_notes
    number_of_dials         
    old_lead             
    meeting_type
    meeting_format
    ip_state
    online                
  end

  factory :admin do
    admins #needs to be unique
    email
    encrypted_password
    reset_password_token #needs to be unique
    reset_password_sent_at
    remember_created_at
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
    first_name
    last_name
    role
  end

  factory :outreaches do
    outreaches
    text
    lead_id
    created_at
    updated_at
  end

  factory :settings do
   settings
   admin_id
   auto_text_content
   created_at
   updated_at
  end

end

