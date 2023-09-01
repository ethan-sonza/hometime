class ReservationMappers
  def reservation_type_1 params
    guest = params["guest"]

    reservation_params = {
      reservation_code: params["reservation_code"],
      start_date: params["start_date"],
      end_date: params["end_date"],
      nights: params["nights"],
      guests: params["guests"],
      adults: params["adults"],
      children: params["children"],
      infants: params["infants"],
      status: params["status"],
      currency: params["currency"],
      payout_price: params["payout_price"],
      security_price: params["security_price"],
      total_price: params["total_price"],
    }

    guest_params = {
      first_name: guest["first_name"],
      last_name: guest["last_name"],
      phone: guest["phone"],
      email: guest["email"],
    }

    return reservation_params, guest_params
  end

  def reservation_type_2 params
    reservation = params["reservation"]
    adults, children, infants = reservation["guest_details"].values_at("number_of_adults", "number_of_children", "number_of_infants")

    reservation_params = {
      reservation_code: reservation["code"],
      start_date: reservation["start_date"],
      end_date: reservation["end_date"],
      nights: reservation["nights"],
      guests: reservation["number_of_guests"],
      adults: adults,
      children: children,
      infants: infants,
      status: reservation["status_type"],
      currency: reservation["host_currency"],
      payout_price: reservation["expected_payout_amount"],
      security_price: reservation["listing_security_price_accurate"],
      total_price: reservation["total_paid_amount_accurate"]
    }

    guest_params = {
      first_name: reservation["guest_first_name"],
      last_name: reservation["guest_last_name"],
      phone: reservation["guest_phone_numbers"].first() || "",
      email: reservation["guest_email"],
    }

    return reservation_params, guest_params
  end
end
