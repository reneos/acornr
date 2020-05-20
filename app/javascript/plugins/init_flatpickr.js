
const init_flatpickr = () => {
  const dateRangeInput = document.querySelector('#booking_start_date');
  const endDateInput = document.querySelector('#booking_end_date');

  // Check that the query selector id matches the one you put around your form.
  if (dateRangeInput) {
    const unavailableDates = JSON.parse(document.querySelector('.bookings-form').dataset.unavailable)

    flatpickr(dateRangeInput, {
      minDate: "today",
      disable: unavailableDates,
      mode: "range",

    });
  };
}

export { init_flatpickr };
