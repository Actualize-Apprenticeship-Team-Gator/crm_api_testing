FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event_#{n}" }
    lead
  end


  factory :lead do
    trait :next_lead do 
      old_lead false
      exclude_from_calling false
      contacted false
      bad_number false
      enrolled_date nil
      phone '1234567890'
    end
    
    first_name 'Bob'
    last_name 'Smith'
    email 'email@email.com'
    phone '5551234567'
    ip '1.1.1'
    city 'Chicago'
    state 'IL'
    zip '60046'
    contacted true    
    appointment_date {Time.now}
    notes 'Noted'
    connected false
    bad_number false  
    advisor 'Peter'
    location 'IL'
    standard_phone '5551231234'
    exclude_from_calling false
    process_time {Time.now}
    hot true
    first_appointment_set {Time.now}
    first_appointment_actual {Time.now}
    first_appointment_format 'phone'
    second_appointment_set {Time.now}
    second_appointment_actual {Time.now}
    second_appointment_format 'phone'
    enrolled_date {Time.now}
    deposit_date {Time.now}
    sales 1
    collected 1
    status 'Leaded'
    next_step 'email them'
    rep_notes 'called them'
    number_of_dials 5      
    old_lead false
    meeting_type 'In-person'
    meeting_format 'Talking'
    ip_state 'IL'
    online false            
  end

  factory :admin do
    first_name 'Bob'
    last_name "Smith"
    role 'Worker'
    sequence(:email) { |n| "bob#{n}@email.com" }
    password 'password'
  end

  factory :outreach do
    text 'Sample'
    lead
  end

  factory :setting do
   admin
   auto_text_content 'text'
  end
end