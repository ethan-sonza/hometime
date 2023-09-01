require 'json-schema'

class ReservationProcessor < ReservationMappers
  def initialize(payload)
    @payload = payload
  end

  def process
    payload_type = get_payload_type
    raise ActionController::MethodNotAllowed unless self.respond_to?(payload_type)
    reservation_params, guest_params = self.send(payload_type, @payload)
    process_payload(reservation_params, guest_params)
  end

  private

  def process_payload reservation_params, guest_params
    reservation = nil
    ActiveRecord::Base.transaction do
      begin
        guest = upsert_record(Guest, guest_params, :email)
        reservation = upsert_record(Reservation, reservation_params, :reservation_code)
        reservation.update(guest: guest)
      rescue
        raise ActiveRecord::RecordNotSaved
      end
    end
    return reservation
  end

  def upsert_record model, params, unique_fields
    result = model.upsert(params, unique_by: unique_fields) # returns {id: n}
    model.find_by result.first
  end

  def get_payload_type
    schema_dir = Rails.root.join('app', 'schemas')
    schema_files = Dir.glob(File.join(schema_dir, '*.json'))

    schema_files.each do |schema_file|
      schema = File.read(schema_file)
      if JSON::Validator.validate(schema, @payload)
        return File.basename(schema_file, '.json') # filename
      end
    end

    raise ActionController::UnknownFormat
  end

end