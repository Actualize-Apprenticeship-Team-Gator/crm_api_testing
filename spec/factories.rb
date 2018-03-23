FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Event_#{n}" }
    lead
  end

  factory :lead do
    # t.string   "first_name"
    # t.string   "last_name"
    # t.string   "email"
    # t.string   "phone"
    # t.string   "ip"
    # t.string   "city"
    # t.string   "state"
    # t.string   "zip"
    # t.boolean  "contacted",                 default: false
    # t.datetime "appointment_date"
    # t.datetime "created_at",                                null: false
    # t.datetime "updated_at",                                null: false
    # t.text     "notes"
    # t.boolean  "connected",                 default: false
    # t.boolean  "bad_number",                default: false
    # t.string   "advisor"
    # t.string   "location"
    # t.string   "standard_phone"
    # t.boolean  "exclude_from_calling",      default: false
    # t.datetime "process_time"
    # t.boolean  "hot",                       default: true
    # t.date     "first_appointment_set"
    # t.date     "first_appointment_actual"
    # t.string   "first_appointment_format"
    # t.date     "second_appointment_set"
    # t.date     "second_appointment_actual"
    # t.string   "second_appointment_format"
    # t.date     "enrolled_date"
    # t.date     "deposit_date"
    # t.integer  "sales"
    # t.integer  "collected"
    # t.string   "status"
    # t.string   "next_step"
    # t.text     "rep_notes"
    # t.integer  "number_of_dials",           default: 0
    # t.boolean  "old_lead",                  default: false
    # t.string   "meeting_type"
    # t.string   "meeting_format"
    # t.string   "ip_state"
    # t.boolean  "online",                    default: false
  end
end

