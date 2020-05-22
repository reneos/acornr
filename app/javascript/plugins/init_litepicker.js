
const calculate_price = (date1, date2) => {
  const price = parseInt(document.querySelector('.bookings-form').dataset.price, 10);
  const days = (date2.getTime() - date1.getTime()) / (1000 * 3600 * 24);
  const totalPriceBox = document.querySelector('#total_price');
  const counter = days == 1 ? "day" : "days";
  const content = `<span class="emphasize">Total:</span> ¥${price * days} for ${days} ${counter}`;
  totalPriceBox.innerHTML = content;
  totalPriceBox.style.display = "block"
}


const init_litepicker = () => {
  const startDateInput = document.querySelector('#booking_start_date');
  const endDateInput = document.querySelector('#booking_end_date');
  if(startDateInput){
    const unavailableDates = JSON.parse(document.querySelector('.bookings-form').dataset.unavailable)
    let today = new Date();
    let picker = new Litepicker({
      element: startDateInput,
      elementEnd: endDateInput,
      minDate: today,
      autoRefresh: true,
      hotelMode: true,
      singleMode: false,
      lockDays: unavailableDates,
      disallowLockDaysInRange: true,
      onSelect: calculate_price,
    });
  }
}

export { init_litepicker };
