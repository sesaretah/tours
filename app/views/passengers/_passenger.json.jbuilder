json.extract! passenger, :id, :name, :surename, :business_id, :sex, :tel, :birthdate, :ssn, :place_of_birth, :passport_no, :nation_id, :created_at, :updated_at
json.url passenger_url(passenger, format: :json)
